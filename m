Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD0071F462
	for <e@80x24.org>; Wed, 19 Jun 2019 20:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfFSUYY (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 16:24:24 -0400
Received: from mout.gmx.net ([212.227.17.21]:36141 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbfFSUYY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 16:24:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560975857;
        bh=AfC+SlNTTkhN7BDGcZakIJHz9Q7flm7ox0PpRcLtZO0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NGmObdsW9xGO+SV+xu+CUz74Wg82fRP9/yHFV1voRrTwgrTBGcUfmFq2IoI/k61Sf
         ZiSfqIIC0iLNIbljtDWlvbvcNvrnN6Bztj5Gv4q/MZHytsQdR4blEv/mxdnqpGifZa
         IxZMczSGSfjyDma9PGj3mJaPk2fV5JJa2jPSB23A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MzhnN-1iZ4ts1Bi5-00vhdD; Wed, 19
 Jun 2019 22:24:17 +0200
Date:   Wed, 19 Jun 2019 22:24:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] t0001: fix on case-insensitive filesystems
In-Reply-To: <CAN0heSrQ-AVui0OzpL7WGBzmdU4ignUsFxYqeXDtgR+CsDXbJw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906192223560.44@tvgsbejvaqbjf.bet>
References: <pull.151.git.gitgitgadget@gmail.com> <1dd56d034efb6ff251bdac8d099052175f4777a0.1560005022.git.gitgitgadget@gmail.com> <CAN0heSrQ-AVui0OzpL7WGBzmdU4ignUsFxYqeXDtgR+CsDXbJw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-784249478-1560975872=:44"
X-Provags-ID: V03:K1:Ti4iEPRDuU0E5IK4Rs/bJ42g0jcVN0QigQFMTHHa8Fbsgu1m3Tz
 tStzMrieMuSA+FcdsYkjKaeZhJbGvNq5o9muV0bAHrlMOp5uEaqRqL8+E1+Hdt6KeHey2RK
 rdJ/dkIo5dzdsw0lnm3Y6jGGAkuGnkIOhk+IVBXFt5+IQg4335tNiM63/9TCPq+huXdBRI5
 jmAk+4BujE88g/mYnpEOQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3wGelOFH9iw=:iKlWYa87Ap4hiHlcIMjlPI
 ynPzBfHNBDHCj2IDN6prkofykeIqOTSh/rFEj8omcDg9ASSnLiYvddVrZK5LQC+E7eMr+MzWK
 SqfZ6ib8TBAlT+XodYkdzuh7uGXPPW8YZclFY/YC8vTXXXc0/TKc2YQgT1oF/6gbwSgkynTO5
 fhsx6+1CZtraJGAcP3VoC+yVJoWGlxWZnfvxnky3HswO0m1XBSXMTBhneYmGKjTe+kPc3Nrwv
 rT1nLmkf5T/Ba+N7uDQEihbDcjrYKKsDiVr/4EZDuE5pZm1BQ+mtTrpwnJI2ivadA57HoTStm
 Y7YfoM1CClx0cC0QlLYznVUJ87pwERSru4zJKBQ7jg/kw/U/XGF5nUqjvc1GSrv9T4G/fehkY
 uhIDCiGj1GOXreUcYeEJBPw3pwoD/EF8VYWTBoIyNDkm/TF59OD9ZDmURG0PDdSzwL0WFJ+0S
 7LqglgjNKwfESETYziQ/hCephsXG3MLlMlZdOIbcfucLXExdIoVNUAQ8CW5C+zpJiyIK4BYD9
 PBVVxdOKjrTOLojhTaFQ7bsUSaXo0AaEm3TgZrTTqQrbH7RWZP4Hck92UBy5niCWW8GnEQb91
 gXE1X5ZLLJGtxfDVja1T0ZQ8uJYdIBd4XO97Pvx4vm0w3WWo/VyOjC+IljXKnKz9RiBrC/ke4
 yrqMsz0DYSaLcMmLKsgCcMlZkXZlUGLUw1WJEMi1xoz38jHgFt9jFKWMN43gBU4GNnw3hsN40
 szUCBTkAI52NXn2E7e8N2fPCuvAAxq7WguW9uGmeb5QEAPVTtdHS7syqMGlWWf4t/0fE9JRI9
 cAjWjrYaKKg8/QRhTvJP4i1MnnOvivI3PX9jw/nFcpcA0g8EYPyh4OO7Hb5D0Ms+/1a36LIUp
 C8Gnog66qZuFI+nIhgAhEfz4rNcEGK3pgYXNj59NYqMYfK6tUOqlhSfM4CNyEScsxYi+HYVR7
 doSQgvpKaNQw9XPZLz0L08LzZk/QDYlydPgc200XYGoCcCHfq4F/j
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-784249478-1560975872=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On Sun, 9 Jun 2019, Martin =C3=85gren wrote:

> On Sat, 8 Jun 2019 at 16:45, Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > On a case-insensitive filesystem, such as HFS+ or NTFS, it is possible
> > that the idea Bash has of the current directory differs in case from
> > what Git thinks it is. That's totally okay, though, and we should not
> > expect otherwise.
>
> > +downcase_on_case_insensitive_fs () {
> > +       test false =3D "$(git config --get core.filemode)" || return 0
>
> I think it would be worthwhile to add `--type=3Dbool` to this git-config
> call. See, e.g., the FILEMODE prereq in t/test-lib.sh. From my
> understanding, this check would regress if someone did s/false/no/ in
> builtin/init-db.c, so this check is perhaps not as robust as it could
> be. (Now, as for *why* someone would do such a change...)
>
> I do wonder if this is the right way to check for a case-insensitive
> filesystem. According to git-config(1), this variable tells whether "the
> executable bit of files in the working tree is to be honored". I can see
> how this property could correlate with the filesystem being
> case-insensitive, but from git-config(1), I would have expected
> core.ignoreCase to be queried instead.

Oh my, you're right. I do not know how the filemode slipped in...

Thanks!
Dscho

> You're no doubt a lot more familiar with filesystem case-insensitivity a=
nd
> how it interacts with Git than I am. Any light you could shed on this
> would be much appreciated.
>
> > +       for f
> > +       do
> > +               tr A-Z a-z <"$f" >"$f".downcased &&
> > +               mv -f "$f".downcased "$f" || return 1
>
> Makes sense. Good error-handling.
>
> > +       done
> > +}
>
> Cheers
> Martin
>

--8323328-784249478-1560975872=:44--
