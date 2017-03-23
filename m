Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DB8320958
	for <e@80x24.org>; Thu, 23 Mar 2017 20:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932136AbdCWUAi (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 16:00:38 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38053 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751336AbdCWUAh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 16:00:37 -0400
Received: by mail-wm0-f42.google.com with SMTP id t189so5481655wmt.1
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 13:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bb0bqE4fTmdGAMhPZwXPDnD3fofb3gIMpSXsC2XyfdM=;
        b=f+rfGKeW/DYAcVCIv90bETnLzPzbv6KTOmHuvTy/y7SKrXbTfqaWLvZ26UBwQFwUSQ
         sQJJxuAMfyj0RuLG9mKAvn0P95wMAm/EsuUyqtRpVJvO+5QodrOK/CX64byH3rtwFSjk
         TFGkENpLbRdcH0NtJxIXp6a7a/EwpfjLwGi8n0YkdoDBQJ/7CE/psX1jb5aFcIebzCcX
         GyE9TuuiyeXa2Jwo+Gp1zOV9RQuzcVSchClX0iMD9fA39V3hpJ81484ukvqHHvaPnDC+
         TdOxiJkE5Sdjl1ApQtm6HOETrubPCAN1dNNaVysQbh8PtH9M+3eWfPLAfayPYQJaJmoF
         OSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bb0bqE4fTmdGAMhPZwXPDnD3fofb3gIMpSXsC2XyfdM=;
        b=HeR9EVG0O17K849A9AmeVFuLjhMyjuAv8x1njJEdTG0TnhjxFV5bM1JBZjgsjESWRD
         Sg56OoeBrsBpv5UFEyTnCb5TTMXL/4C8I1mE5irsB9v26wKfbGwLh4X2KJD5IV2/CaIH
         wpH5cWJ89PLQxQSO2Xd0B1wNXp6fK/IoziCMs49yvGQyjy+Reu7n/nC/OLu3RflyVfNJ
         Smmt1EgytjFXq1tIDfASw9sBl9E8JY/8zOfGw4ZLRYCtAcUEyNPsGwQtjojlskocX14f
         nOTDbaH3CR/pvfiyxfvYwJiQ0h83/ZZGsCWO8XQVvf7M452uZ6lQbeya7k9BCWRZVi1o
         HZmA==
X-Gm-Message-State: AFeK/H3HdnJQCFUnTAc0cn5OIanON41KSECyt2/Bjg7wlJ2lQU2wPTCikJOjlfF3s0/1fQ==
X-Received: by 10.28.203.197 with SMTP id b188mr4979897wmg.110.1490299235603;
        Thu, 23 Mar 2017 13:00:35 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB47D6.dip0.t-ipconnect.de. [93.219.71.214])
        by smtp.gmail.com with ESMTPSA id 65sm29921wri.68.2017.03.23.13.00.34
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 13:00:34 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1] travis-ci: build and test Git on Windows
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170323193823.gxodwqv4eshgtqbc@sigill.intra.peff.net>
Date:   Thu, 23 Mar 2017 21:00:33 +0100
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3CC8E237-86EA-4F35-A03E-15BED5869403@gmail.com>
References: <20170322065612.18797-1-larsxschneider@gmail.com> <xmqqwpbhjej6.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1703231716320.3767@virtualbox> <20170323180134.geoyvq7qbm5vujo6@sigill.intra.peff.net> <xmqqbmsrdcz4.fsf@gitster.mtv.corp.google.com> <20170323191721.7r5vrixtnx3cngdc@sigill.intra.peff.net> <FE4A3F88-0B86-4069-B141-2DFB9C4E269E@gmail.com> <20170323193823.gxodwqv4eshgtqbc@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 23 Mar 2017, at 20:38, Jeff King <peff@peff.net> wrote:
>=20
> On Thu, Mar 23, 2017 at 08:26:15PM +0100, Lars Schneider wrote:
>=20
>>> I think we do build against PRs now. E.g.:
>>>=20
>>> https://travis-ci.org/git/git/builds/213896051
>>>=20
>>> But it looks like we can turn that off.
>>=20
>> When we add a secret variable, then TravisCI will not build Pull =
Requests
>> for git/git anymore:
>>=20
>> "[...] we do not provide these values to untrusted builds,=20
>> triggered by pull requests from another repository."
>>=20
>> See: =
https://docs.travis-ci.com/user/environment-variables/#Defining-Variables-=
in-Repository-Settings
>=20
> Ah, OK, that makes sense. So we would only have to worry about our =
_own_
> code accidentally disclosing it. But that should be easy to look for =
by
> grepping the log (did somebody do that?).

This is how a successful Windows build would look like:
https://travis-ci.org/larsxschneider/git/jobs/214391822

Dscho's token is not in the log.


>> However, I don't think that is a big deal because git/git doesn't
>> support Pull Requests anyways. Plus, if a contributor is interested
>> in TravisCI results, then the contributor can setup TravisCI for
>> their own fork easily.
>=20
> Yeah, agreed. It's not like we are blocking the merge button with a
> failing status.
>=20
>>> Hrm, it does mean that people have no way to test on Windows until =
the
>>> branch hits pu. Which is not ideal.
>>=20
>> I agree it's not ideal. But I think it is an improvement to check
>> pu/next/master/maint continuously :-)
>=20
> Oh, I agree this is a step forward from the status quo. I just =
wondered
> if we could do even better.
>=20
> As a side note, I've started having travis run on all of the topic
> branches in peff/git, with the idea to get early feedback on OS X
> problems (and now hopefully Windows ones). My two issues so far are:
>=20
>  - I have a lot of work-in-progress branches. I put "-wip" at the end
>    of the branch name for my own scripts. It looks like I can put "[ci
>    skip]" in the commit subject to convince Travis to skip them, but
>    that's a little annoying. Is there any way to skip based on just =
the
>    branch name? I couldn't find one.

We can blacklist these branches with a regex in the travis.yml:
=
https://docs.travis-ci.com/user/customizing-the-build#Building-Specific-Br=
anches


>  - The OS X builds seem to regularly time out. That at least marks a
>    "!" in the build status screen instead of an "X", but it's a lot of
>    noise (and it misses the point for me, which is testing on OS X; I
>    already build regularly on Linux).

Well, I guess the reason is that OSX is a bit harder to virtualize=20
compared to Linux. In general on git/git the OSX builds are OK.

I build a little stats page to visualize the results over time:
https://larsxschneider.github.io/git-ci-stats/

We have 2 OSX jobs and 2 Linux jobs per build. I am usually only
digging into issues if both jobs are red.

Maybe TravisCI throttles your usage somehow as you push a lot of =
commits?

Keep in mind, all the TravisCI compute hours are free... considering
that I think it is quite OK :-)

- Lars=
