Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54BB320282
	for <e@80x24.org>; Tue, 13 Jun 2017 07:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751851AbdFMHs7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 03:48:59 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35759 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751753AbdFMHs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 03:48:58 -0400
Received: by mail-wr0-f193.google.com with SMTP id g76so27317222wrd.2
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 00:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:mime-version:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=B1Q6CnzgJr5KgGS8VKz2/KI9e0jSWc4kqC2KyhGHmKE=;
        b=GsscQh1vpfupGAynCqpLRgqtlBkScNdghm3AhIZ0ijfgkgnJ9JpblY77DATs2FdywR
         PNWV9oabBupKvxVz1Cq47Dijf3b16Z9fIANk4YCN+zDV2SuQaD1pz1vaPPQmjI/RJD8+
         CpaUSCqyOL2UVMwAeUYxtrG0ST+sEAp63es4JdkAZfOiao8femmF8ZGY++MeEfN++CTt
         nz2Do21LaGzXfy7ML9iem/3IHkoD9ILGuTHhowDqv+VtGr0aKGlziv2S0ECt1PLMomHV
         +QNFBWgR7yS71gHzdlCx+XALFy34Ua2I9ACO+JQWRMppDqrNNlLb7TCp+cvMLODTY/tq
         R3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:mime-version:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=B1Q6CnzgJr5KgGS8VKz2/KI9e0jSWc4kqC2KyhGHmKE=;
        b=OdJljASYv8qJW+Huesa6FPYsnPqEjdKwragNQBEhNwkhhDB15RxxuJB9UShRW3VFo1
         L54KWLQVi0dbmtszvFUCfxkohkcHH934cUm+WhMRR0MfmB4fDO8Ria7PXyWK+dtLtl/o
         d+x4CO4CMWiLg1Kxf7ot49mHqimQJ6VoDg13vN+AbtyD9RnL3iP2Uwqt8ZrpjRCm5uK8
         8a4cMhdxOFPdx3yzSRLnPI3ls8/Ls4ojRcFU8ggaAWk2RpPET54132UmD+1oucAeeDr/
         K9pNAsJT40XhR1DE2Gt4zRmpKmuwj0rp3IZ6ogw0bnnielveOssCugG3NBm7K/dtqtdW
         p2XQ==
X-Gm-Message-State: AKS2vOwB+ZoaMox91fDX34gpa4RxeU4u5Lz+3oia598vgS0aJhhbSKHr
        v87BxYGiAjwTqV8Z0R4=
X-Received: by 10.28.174.131 with SMTP id x125mr1647478wme.47.1497340136874;
        Tue, 13 Jun 2017 00:48:56 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB4C1A.dip0.t-ipconnect.de. [93.219.76.26])
        by smtp.gmail.com with ESMTPSA id f8sm3050614wme.26.2017.06.13.00.48.55
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 00:48:56 -0700 (PDT)
Subject: Re: [PATCH v1] Configure Git contribution guidelines for github.com
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=iso-8859-1
From:   Lars Schneider <larsxschneider@gmail.com>
X-Priority: 3
In-Reply-To: <31A456B20D984421AA958A39B2FCD29D@PhilipOakley>
Date:   Tue, 13 Jun 2017 09:48:55 +0200
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <A712386E-0C4B-4A6C-B231-EA52FA285F34@gmail.com>
References: <20170609142151.94811-1-larsxschneider@gmail.com> <31A456B20D984421AA958A39B2FCD29D@PhilipOakley>
To:     Philip Oakley <philipoakley@iee.org>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 10 Jun 2017, at 14:48, Philip Oakley <philipoakley@iee.org> wrote:
>=20
> From: "Lars Schneider" <larsxschneider@gmail.com>
>> Many open source projects use github.com for their contribution =
process.
>> Although we mirror the Git core repository to github.com [1] we do =
not
>> use any other github.com service. This is unknown/unexpected to a
>> number of (potential) contributors and consequently they create Pull
>> Requests against our mirror with their contributions. These Pull
>> Requests become stall [2]. This is frustrating to them as they think =
we
>> ignore them and it is also unsatisfactory for us as we miss potential
>> code improvements and/or new contributors.
>>=20
>> GitHub offers a way to notify Pull Request contributors about the
>> contribution guidelines for a project [3]. Let's make use of this!
>>=20
>> [1] https://github.com/git/git
>> [2] https://github.com/git/git/pulls
>> [3] =
https://help.github.com/articles/creating-a-pull-request-template-for-your=
-repository/
>>=20
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>=20
> I see there are currently 84 open PRs (13 in the last 14 days), so it =
is real.
>=20
> I also see that the Issues page for git.git appears to be disabled, =
and will redirect to the pulls page.
>=20
> Maybe the instructions should also be part of an Issues template which =
could reduce the potential number of PRs being created (but could create =
its own problems)

I don't think that is necessary as Issues are disabled for this repo.

>> ...

>> +Thanks for taking the time to contribute to Git! Please be advised, =
that the Git community does not use github.com for their contributions. =
Instead, we use a [mailing list](http://public-inbox.org/git/) for code =
submissions, code reviews, and bug reports.
>=20
> Isn't the mailing list git@vger.kernel.org, with an archive at =
http://public-inbox.org/git/ ?

Agreed!

>=20
>> +
>> +Please [read the maintainer =
notes](http://repo.or.cz/w/git.git?a=3Dblob_plain;f=3DMaintNotes;hb=3Dtodo=
) to learn how the Git
>=20
> Is using the repo.or.cz address deliberate as a way of highlighting =
that Github isn't the centre of the universe when accessing a DVCS repo?

Haha, partly yes. Plus, I wasn't able to figure out quickly how to =
access the todo blob on GitHub.=20


> Maybe the kernel.org repo should be first, or at least the alt-git.git =
repo at repo.or.cz listed in those same notes.

Agreed!


> It's still a good idea though.

Thanks :)


- Lars=
