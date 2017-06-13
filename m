Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC36220282
	for <e@80x24.org>; Tue, 13 Jun 2017 07:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752004AbdFMHph (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 03:45:37 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33657 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751953AbdFMHpg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 03:45:36 -0400
Received: by mail-wr0-f194.google.com with SMTP id v104so27201020wrb.0
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 00:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=StIfiCaYGgXrysrA59hUnm60+n/yGmt3I+nMLZBwL+8=;
        b=vhMdHo0KGBnVeZ5EQQU/y4gmM8v5QNvTwlG0V+fnnVce7ExtE3Fbr+nww5GmOScKHY
         thygBARtHV1Z6gPKVzvD8Fp0UR8qPj2Gs5ETVeM1q9DLVTxS2pDxPDUhR6KW29zCsEiq
         voVKuugXtgecLWXYMy2hHUcxVmUmlzzvthhE75eLS6O3KwRJ7T8/tJdNrU67Pv4PxnJM
         qHsXCG1PtxCYa6tJbMBHnDotAV6NNniT+IAUMa764mjd4Mqlq1jfujhFq7ajWebSLLwO
         jIB9GkbXJKgwNCtMc16VxCbY0Kbwj1J5Y2JqEeFTmenI27LNJKfR6TVSPzm8XlqWVs2m
         puuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=StIfiCaYGgXrysrA59hUnm60+n/yGmt3I+nMLZBwL+8=;
        b=P0TeIsV74WDRVWsAtY/eEZcjIdANyAjmpdi0Iz9X+izI9HSz/zEqbeRht+FGrYGg+A
         AQRxgKcGkzrQrADHA21DRW3oSxErbDgugSm5Qc62M4eeCXULE6WJKig4Diq/z/wBFd3k
         swMfgZH4G+p+q7jAKKs+745VC3NIdWq8SlHbvtWHEkJkuBenyCJUEIAuPyx9rGUF7BP3
         1tKyORK87VxDWlBM29pEgvVRNzS2Wicv3X5zV8cYkFPBMEAs+K5DZXKPzohE+r/TYKIQ
         qnPaw2Cv4abeRqWjhsMOthmIGyNX3SA4pVjK1pZwWP1mruZh2c7Refy0ly8JFDgcJG6i
         TeaQ==
X-Gm-Message-State: AKS2vOyCfL2zTF5xVbECGlfueIPk+CynAFqQ4WpHPC7IwhnXhgYVAikZ
        iJXCSa4gmdo5xg==
X-Received: by 10.223.162.156 with SMTP id s28mr1990968wra.97.1497339934269;
        Tue, 13 Jun 2017 00:45:34 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB4C1A.dip0.t-ipconnect.de. [93.219.76.26])
        by smtp.gmail.com with ESMTPSA id f47sm18774216wra.1.2017.06.13.00.45.33
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 00:45:33 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1] Configure Git contribution guidelines for github.com
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqlgoxp5ig.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 13 Jun 2017 09:45:32 +0200
Cc:     Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org,
        peff@peff.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <04B48EAE-E709-4A2A-A9C2-3473896B2F1E@gmail.com>
References: <20170609142151.94811-1-larsxschneider@gmail.com> <31A456B20D984421AA958A39B2FCD29D@PhilipOakley> <xmqqlgoxp5ig.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Roberto Tyley <roberto.tyley@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 12 Jun 2017, at 17:52, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> "Philip Oakley" <philipoakley@iee.org> writes:
>=20
>> From: "Lars Schneider" <larsxschneider@gmail.com>
>>> Many open source projects use github.com for their contribution =
process.
>>> Although we mirror the Git core repository to github.com [1] we do =
not
>>> use any other github.com service. This is unknown/unexpected to a
>>> number of (potential) contributors and consequently they create Pull
>>> Requests against our mirror with their contributions. These Pull
>>> Requests become stall [2]. This is frustrating to them as they think =
we
>>> ignore them and it is also unsatisfactory for us as we miss =
potential
>>> code improvements and/or new contributors.
>>>=20
>>> GitHub offers a way to notify Pull Request contributors about the
>>> contribution guidelines for a project [3]. Let's make use of this!
>>>=20
>>> [1] https://github.com/git/git
>>> [2] https://github.com/git/git/pulls
>>> [3]
>>> =
https://help.github.com/articles/creating-a-pull-request-template-for-your=
-repository/
>>>=20
>>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>>> ---
>>=20
>> I see there are currently 84 open PRs (13 in the last 14 days), so it
>> is real.
>=20
> Not so insignificant fraction of these are done purely for the
> purpose of using submitgit, though.  In other words, if submitgit
> were improved not to require a pull request against [1] (instead, it
> could be pointed at a branch in a contributor's repository and do
> the fromatting), these numbers will go down.

As an alternative, could SubmitGit close the Pull Request automatically
after the mails have been send successfully?


>>> +Thanks for taking the time to contribute to Git! Please be advised,
>>> that the Git community does not use github.com for their
>>> contributions. Instead, we use a [mailing
>>> list](http://public-inbox.org/git/) for code submissions, code
>>> reviews, and bug reports.
>>=20
>> Isn't the mailing list git@vger.kernel.org, with an archive at
>> http://public-inbox.org/git/ ?
>>=20
>=20
> I agree that I found the URL of the archive somewhat misleading for
> those who want to contribute.  Giving the mailing list address makes
> a lot more sense.  As suggested by =C3=86var in the thread, it would =
also
> be good to suggest submitgit, given that the target audience of this
> message was already prepared to throw a pull request at us.

OK, will fix!


>>> +Please [read the maintainer
>>> =
notes](http://repo.or.cz/w/git.git?a=3Dblob_plain;f=3DMaintNotes;hb=3Dtodo=
)
>>> to learn how the Git
>=20
> Two minor issues here.
>=20
> 1. push the "read" outside [], i.e.
>=20
> 	Please read [<human readable name of the thing>](<URL for
> 	the thing>) to learn...
>=20
>   as what is inside [] and what is inside () ought to be the moral
>   equivalents.
>=20
> 2. the thing is not called "the maintainer notes"; it is called "A
>   note from the maintainer".=20

OK, will fix!


>> Is using the repo.or.cz address deliberate as a way of highlighting
>> that Github isn't the centre of the universe when accessing a DVCS
>> repo?
>>=20
>> Maybe the kernel.org repo should be first, or at least the =
alt-git.git
>> repo at repo.or.cz listed in those same notes.
>=20
> I'd prefer [the k.org =
address](https://git.kernel.org/pub/scm/git/git.git/plain/MaintNotes?h=3Dt=
odo).

OK, will fix!


>=20
>>> +project is managed, and how you can work with it. In addition, we
>>> highly recommend you to [read our submission
>>> guidelines](../Documentation/SubmittingPatches).
>=20
> Again, push "read our" outside [].

OK, will fix!

Thanks,
Lars=
