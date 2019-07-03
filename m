Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B1041F461
	for <e@80x24.org>; Wed,  3 Jul 2019 10:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfGCKZU (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 06:25:20 -0400
Received: from mout.gmx.net ([212.227.17.21]:35545 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfGCKZU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 06:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562149500;
        bh=p70idFqc9T8vrJPadpwtDwObBThNBMg7mInfqWQUTVA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=C0jH57S0sHcDo+UKCzaj6Vtjl9mNiTFYDpEapiBZh26K6PqZ7egH0mt3rBgC9XYEJ
         eKFqnIi/ic5OUHVn0LW7mqzJpvqSwyxgQAxO/7fsVIsOS3kXG/SsfuawoPDuph8O25
         pwpPW0LHdLFVemHXntSzzwQCRhHhoRhHYX2n14Ns=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOiHf-1htROG44h5-00Q9HS; Wed, 03
 Jul 2019 12:25:00 +0200
Date:   Wed, 3 Jul 2019 12:25:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, git-packagers@googlegroups.com,
        gitgitgadget@gmail.com, gitster@pobox.com, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com
Subject: Re: [PATCH v3 00/10] grep: move from kwset to optional PCRE v2
In-Reply-To: <nycvar.QRO.7.76.6.1907021417050.48@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1907031213220.44@tvgsbejvaqbjf.bet>
References: <20190627233912.7117-1-avarab@gmail.com> <20190701212100.27850-1-avarab@gmail.com> <nycvar.QRO.7.76.6.1907021417050.48@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-542317010-1562149529=:44"
X-Provags-ID: V03:K1:M1LVLegBsOBxUQgf+ytOWxIMlDeg828VZS3DMEReWSCzHwUbCad
 MRss5JxGFLPC3/th3SYiQSne+FFxzEgEQKXE9a15WV4wk7DN6eqv2mB1X7SggQi8cE8ScPv
 UYa7U6COwxHVFV+4OeIfq2eygkHLYP4HRyeBuFjLpd+oJIBJ/IK8epqYR0F3faTM+c5OW65
 3nRGj7BK0JUQdp7TTfqPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Xkzf1jFFxjE=:imDARxsg2wLEKnKeDc4yMe
 ho/CBNTGduQVPu3L8iglslBZaY8Os6rEG6kJZuTlzdqvDEo7XwOlrPvvdUgSTDHrIUp9RI5QQ
 R1KxvKBqp2EvUntC2Mi/8E9sNSMle3rLzPfbM9dhB8nB8YYXBP4adC/5zW8xs5l9IGeKQsjfo
 Ttrd0DQrDiYFXM8TZjk5YnWZpbeWoIOBjwnOmiH1Y45A1KY4zXH7y+KfQPN2R1UD3SBRIB19T
 HxdDXXYYTbqdnuZogqV8m6EKb/OSM6uOCvM1AyI1j+41x3KyYny7zhferXHrF/lOT9xU2rZDE
 3ZS48vcPgDmxr+Y+QfjyQiGpEYmbAoi+kMgFAx2IGjcLPebHFGQ4dmju6746tIQCggYPXZay0
 FpPz1E6ebVk5SeWKRCprBQ4B8DG8dZ5W2NQzOj0tAwopCgUS5nPAtHlD57c686PGWDN3KoOHQ
 jArCXu8onIcpeXzM6nBTsfWLN30FKXK/qg+IAuan9g6Syx0lGxkfhjTYq5DF6IuXYwdExnxUN
 1pzDcfvfb6tYNlBP0AsrgPtU66Sv0csNeirF3FmnM1UwFOGNu8E1PBY+wtRAi3/wi7PG6eRjZ
 bozi+thtW0ZVlu/m7wogBn3b7PE1puhv/acze8ayWrXNWVLZ9mWF/VK516Cz1/ETP8k5b5PRA
 5JThjFcAohoNcg3Gnzurz61mY36OBVbTHx+9nwFaSGYHxMQqYCFby2FmRjEV+BXDU6szWNkLK
 MfgJjbEBNLZ+s8QwRVbePXXmHHAOuFVVzQ1OcGf+wCFvaMEnRNRc58azOPYh4NdnwZ5wuJX3U
 k7r5vJpi63KW6cUgaZJiVf/jJkxJ1coQ83fhEaA428sOd5hbQ6n1kJzlUGWmyk4Th4hFRjO3T
 9ZU8pOPiKZSRf16vrpa5cwHqyyUUQMaFTer6wCDfOCrWm/VUZ07Wh/XB8rpmUWjkJG39Ulc7K
 mAomxIsyqZi6GVrZqF77NrLXOhbOSsDSFcvxWc5d6elkTs1Dz9IVL0DBm6neVtUPkRn7HRUkB
 hzVzH43VY6pP20h3ouXDtpObtbYmmPY8EtASJQIegrJmUqeiy6lA+jp9K7AxaVgekd+g+Upw8
 pMst1QIqci9lptJ2OWqZgk4OPRjaqd0FZGr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-542317010-1562149529=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 2 Jul 2019, Johannes Schindelin wrote:

> [...] I probably failed to mention another breakage, though...:
>
> not ok 54 - LC_ALL=3D'C' git grep -P -f f -i '=C3=86<NUL>[=C3=90]' a
>
>  expecting success:
> 			>stderr &&
> 			printf '=C3=86Q[=C3=90]' | q_to_nul >f &&
> 			test_must_fail env LC_ALL=3D"C" git grep -P -f f -i a 2>stderr &&
> 			test_i18ngrep ! 'This is only supported with -P under PCRE v2' stderr
>
> ++ printf '=C3=86Q[=C3=90]'
> ++ q_to_nul
> ++ perl -pe 'y/Q/\000/'
> ++ command /usr/bin/perl -pe 'y/Q/\000/'
> ++ /usr/bin/perl -pe 'y/Q/\000/'
> ++ test_must_fail env LC_ALL=3DC git grep -P -f f -i a
> ++ case "$1" in
> ++ _test_ok=3D
> ++ env LC_ALL=3DC git grep -P -f f -i a
> Binary file a matches
> ++ exit_code=3D0
> ++ test 0 -eq 0
> ++ list_contains '' success
> ++ case ",$1," in
> ++ return 1
> ++ echo 'test_must_fail: command succeeded: env LC_ALL=3DC git grep -P -=
f f -i a'
> test_must_fail: command succeeded: env LC_ALL=3DC git grep -P -f f -i a
> ++ return 1
> error: last command exited with $?=3D1
>
> There are three more test cases in that test script that fail similarly.=
 See
> https://dev.azure.com/Git-for-Windows/git/_build/results?buildId=3D38852=
&view=3Dms.vss-test-web.build-test-results-tab&runId=3D1019770&resultId=3D=
101368&paneView=3Ddebug
>
> I ran out of time to look into this in more detail :-(

I figured it out. It does not happen with your `ab/no-kwset` patch series
in isolation, it's only when it is merged into `pu`, and the culprit is
the bad interaction with the `js/mingw-use-utf8` branch.

To fix it, I have a tentative patch:
https://github.com/git-for-windows/git/commit/e561446d

So I'll head over to that patch series and add more information there.

Ciao,
Dscho

--8323328-542317010-1562149529=:44--
