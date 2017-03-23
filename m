Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E4C620958
	for <e@80x24.org>; Thu, 23 Mar 2017 20:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935295AbdCWUjS (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 16:39:18 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35916 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933577AbdCWUjR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 16:39:17 -0400
Received: by mail-wm0-f49.google.com with SMTP id n11so71095343wma.1
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 13:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kgw84gQ394CtdebZw+qjK/SeAsppqmKFuAhXVKF2Iqc=;
        b=Jqe7D2V03adbHU8N0YJACqUCtA5vJZirHX5bqQ2N50Oz6jFjGHIPUgOT7/eFOSZ321
         KUzFhInqz3Ka5eyCG5HaILOjMISeWam1UK+6VYt4MnQ50W+ajtRs7WS2lbHFKrnQ0Cka
         jmeSQ7Ozku9utX90uC4y39jxFN9exj7stV+2Ac5I2aabRKgZ1dPoKwC87wUwz9eQ25j3
         7GhtRh+GamS0zXO63MnW7Pe127I535p+LsJnLjjK6PtzqUelNiYB8DcmqZvub1t7NtE2
         1WuE6F41ej9W0f7BeoFXYxPToZHTBB/2BAOl+xt5Myp2az4KvF6AfYKua+ovmhJVi2G0
         xbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kgw84gQ394CtdebZw+qjK/SeAsppqmKFuAhXVKF2Iqc=;
        b=bKiDzA88PCjcHHH1dA4eKp7SbLOg5OJfXA+G676dxHJeAZwwOMdxuzwxvBzOEPXfbE
         Sa+WUC2WU3bdiOGbeG6/7yBysF1QhSxtBi1ug2LzpH2e1oG77SH8ysEzPOnCO7OFUQHU
         CdOoKQ8CEtyFF/y3r+VLT/7CNo8ZQL9ZWRvgDCygkN+ne+NXfT9ofsUgQvdLXX5RE7mI
         Z/gIi50RDEsRKSIAFxIK3rW18FXeRF1lLgswZ8a84F5XGTRMiAufDUeAL1U+Uv3wgmjf
         j/zHsN8590sTV9fHbKeIZjuDZsJOpQU4wtC8mSKDLqCBgMTL9qX9vAGSqY5imerxqLnw
         jywA==
X-Gm-Message-State: AFeK/H0H+kjfiKgabiIXEoz0OCPMT4lpyHyvXU/CbyZXtQb8v49HHjP33XTd8HvbadY8Ag==
X-Received: by 10.28.100.196 with SMTP id y187mr14477437wmb.129.1490301555841;
        Thu, 23 Mar 2017 13:39:15 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB47D6.dip0.t-ipconnect.de. [93.219.71.214])
        by smtp.gmail.com with ESMTPSA id t85sm156150wmt.23.2017.03.23.13.39.14
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 13:39:15 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1] travis-ci: build and test Git on Windows
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170323202002.lfpuglqawz4ooruw@sigill.intra.peff.net>
Date:   Thu, 23 Mar 2017 21:39:14 +0100
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CEE52E60-F31F-4BA9-BA79-7526EE6C5397@gmail.com>
References: <20170322065612.18797-1-larsxschneider@gmail.com> <xmqqwpbhjej6.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1703231716320.3767@virtualbox> <20170323180134.geoyvq7qbm5vujo6@sigill.intra.peff.net> <xmqqbmsrdcz4.fsf@gitster.mtv.corp.google.com> <20170323191721.7r5vrixtnx3cngdc@sigill.intra.peff.net> <FE4A3F88-0B86-4069-B141-2DFB9C4E269E@gmail.com> <20170323193823.gxodwqv4eshgtqbc@sigill.intra.peff.net> <3CC8E237-86EA-4F35-A03E-15BED5869403@gmail.com> <20170323202002.lfpuglqawz4ooruw@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 23 Mar 2017, at 21:20, Jeff King <peff@peff.net> wrote:
>=20
> On Thu, Mar 23, 2017 at 09:00:33PM +0100, Lars Schneider wrote:
>=20
>>> Ah, OK, that makes sense. So we would only have to worry about our =
_own_
>>> code accidentally disclosing it. But that should be easy to look for =
by
>>> grepping the log (did somebody do that?).
>>=20
>> This is how a successful Windows build would look like:
>> https://travis-ci.org/larsxschneider/git/jobs/214391822
>>=20
>> Dscho's token is not in the log.
>=20
> Great, thank you for double-checking.

I can see that one could think that this variables leaks, though.=20
I think in v2 I won't pass the token as parameter. The token=20
variable is an environment variable anyways and I can just use
it in the script.


>>> - I have a lot of work-in-progress branches. I put "-wip" at the end
>>>   of the branch name for my own scripts. It looks like I can put =
"[ci
>>>   skip]" in the commit subject to convince Travis to skip them, but
>>>   that's a little annoying. Is there any way to skip based on just =
the
>>>   branch name? I couldn't find one.
>>=20
>> We can blacklist these branches with a regex in the travis.yml:
>> =
https://docs.travis-ci.com/user/customizing-the-build#Building-Specific-Br=
anches
>=20
> I had a feeling it might be something like that. So we would all need =
to
> agree on the convention for WIP branch names. If other people like the
> idea, I'm happy to make a patch, but I don't want to impose my own =
weird
> conventions on everyone else.

This makes sense to me. If someone complains with a good argument then
we can still revert it.


>> Maybe TravisCI throttles your usage somehow as you push a lot of =
commits?
>=20
> Could be. Looking at:
>=20
>  https://travis-ci.org/peff/git/branches
>=20
> It seems to timeout on over half the branches (in fact, there are only =
a
> few that passed all of the tests). My pattern is particularly spiky =
from
> Travis's perspective, because once a day I rebase everything on top of
> master and push them the whole thing in a bunch. So they 75 branches,
> all at once. That seems like it would be ripe for throttling (though I
> would much rather they just queue the builds and do them one at a =
time).

Could you try to set this to 7 or less in your TravisCI?
=
https://docs.travis-ci.com/user/customizing-the-build#Limiting-Concurrent-=
Builds

I am curious if this improves the situation.

- Lars=
