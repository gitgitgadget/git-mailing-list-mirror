Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C393E1F731
	for <e@80x24.org>; Wed,  7 Aug 2019 19:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388822AbfHGTlz (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 15:41:55 -0400
Received: from mout.gmx.net ([212.227.15.18]:35505 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388369AbfHGTlz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 15:41:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565206907;
        bh=mIDryV7C6QrbZX5si6Ed8ZPVmJTOzdHDGtX14DHcj0M=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CvPM0eVU0Vj4VI/kdiXvpJUxoR8rvSzBROKJoGse/bybTU5jYLPXaHKPiFSTuQJ/w
         PYcr4OsOYZ/ztDoILlyDUP8IKn2Vjxa09Cw0kwyzKVmBx9XIdAZ4DxjORq4KlZs88H
         K0nKBCUT7wy3Yj2Z6TjaK1LEcJ1Z+TBtvO1ZnPPY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB ([188.174.40.47]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LtIdP-1iIzAW0QhP-012sfx; Wed, 07
 Aug 2019 21:41:47 +0200
Date:   Wed, 7 Aug 2019 21:41:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
cc:     Junio <gitster@pobox.com>, GIT Mailing List <git@vger.kernel.org>,
        Thomas <t.gummerer@gmail.com>, Elijah <newren@gmail.com>,
        Phillip <phillip.wood123@gmail.com>,
        Martin <martin.agren@gmail.com>
Subject: Re: [GSoC][PATCHl 5/6] rebase -i: support --ignore-date
In-Reply-To: <20190806173638.17510-6-rohit.ashiwal265@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1908072139190.46@tvgsbejvaqbjf.bet>
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com> <20190806173638.17510-6-rohit.ashiwal265@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7ytjimCHWqjx6kRwGDqPlDA/kJWX/z7SMflAbmSmys9FtSRjLRL
 TxU1Swp2w3W16nDFxkumrY4vDM2e0LGTH8R4cdhsZuhFmos6xEHrkYBfULVLfc5c4WTmh7a
 Zye+VusxBNnvp13bYeuSufXQ4ajfZynIHq06qHgZuJ6PQd/iBCxx7ZhJC46Sa9C+ysJnAyX
 y03tLboWfM37g8zPnTt/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xLRR8XWDHEg=:2cLegLvGaaml1Lu9+P9rJs
 zWsziBiQRdfn20lnp/FGpJKFPHzoj7X8qcOtXks917wfgdEOF21ZwPpNM13nuiAOalQyr8GBx
 HjUEfX8FannlDzIqTTK+7H4+M2qUZ0z9ZoPZW7VqpQJOG9CpCSgYQqTr5LcVUvb3ltBbk6ksn
 7gW4bp1cCzJSycKHAnoWraqFHfPegs5vJEoQEC/Sa5LDdrhBpzhijhOxqEw+WZU7Gj7DJ/gYA
 wB52y9bUFKwrmz2SsSKjY/ToLXWvRKNa0zGTw8XVNZT8NgJIkv6QJ+Xf2tNGqoNN/DkvbemCv
 PmAiBpbU8KDQfGYWWYS7/Nuhq5biE8HoL0chgYug4ULjflZOulYvlTEIvNoGgqvWc6xIGEdt3
 KJUwmGLh4ka6NNesH+XfJc28dOWmwAOckkA8IPGnIh7kntSvc99gBFdzma4S4tWr1GvI2cclw
 b895H8o+V7bUEnLCLZNsb9sb8kfssqkzpx2ixlITiXH7JDTZ6EEPRgUFaBItCvHWhqbXj11to
 ZJPPyFUUT/J4K5TvMzdlZCujjJPAI0EXHwqzvUYg0sLzQfQ1O89sAuwzWgpWSV7MWiSLOeHP1
 TUicJOndWG4HiYdHyTLvXMP3/PiwmHj5mca9+7rgwONgI8EfH5TKZ2wAGfO2nMbA2KsxS8iNJ
 I9nEMDBkbRp3Eb/c8kutfcC+ikM0vwSH1JbHfs72r8vev7Uez026/a1jYkmozq//ppXvQue9a
 gtzlHtkV3YTI/4MjtKYT2OCIqa3I/bDQxG//bvJx7bjv1+eH/Lijwny6ThAAP4oaTb0Ow8pQ4
 de+1DoWlSfBlmlEMIssG8C7dRZfdfZwSYoIw0HWJye0b44bxiBLqDvMOyHEnQVnHBdmRQiVHb
 UvHNg9NhWiNVoacN+j0ZQgsFb1mJZnKP1+X0L8+li8L3dN33gMEVHWq7yWXU/HoMarsdRHH2T
 XdnNW9VHchA9pT8xNWdTkpnF3+EWQ1CbnHB3kEebIoYaU45RRnx2gpA1UiFZeKCMdEhau5Vvw
 pw7sLRyM1GdIsKLaYzxuAFHca5kd71qdbs4iRuzA1ovdu+lwOO0tMT/lWnCj+OtFBjewCLmQs
 A/q3UVXxzXnymrwbB1wxG2jLCFnqPTQnbh3zMJxfyVmFocI0dXCoFG25XGuO8OTAxJvbfK4WH
 GRHTc=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rohit,

On Tue, 6 Aug 2019, Rohit Ashiwal wrote:

> @@ -1046,6 +1066,8 @@ static int run_git_commit(struct repository *r,
>  		argv_array_push(&cmd.args, "--amend");
>  	if (opts->gpg_sign)
>  		argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
> +	if (opts->ignore_date)
> +		argv_array_pushf(&cmd.args, "--date=3D%ld", time(NULL));
>  	if (defmsg)
>  		argv_array_pushl(&cmd.args, "-F", defmsg, NULL);
>  	else if (!(flags & EDIT_MSG))

I need this patch to make the code _at least_ compile on Windows again
(I don't know whether it breaks the test suite yet):

=2D- snipsnap --
Subject: [PATCH] fixup! rebase -i: support --ignore-date

It is a mistake to believe that the return value of `time()` is always
an `unsigned long`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 sequencer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 539c0ef601b..a4c932d3407 100644
=2D-- a/sequencer.c
+++ b/sequencer.c
@@ -1070,7 +1070,8 @@ static int run_git_commit(struct repository *r,
 	if (opts->gpg_sign)
 		argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
 	if (opts->ignore_date)
-		argv_array_pushf(&cmd.args, "--date=3D%ld", time(NULL));
+		argv_array_pushf(&cmd.args, "--date=3D%"PRIuMAX,
+				 (uintmax_t)time(NULL));
 	if (defmsg)
 		argv_array_pushl(&cmd.args, "-F", defmsg, NULL);
 	else if (!(flags & EDIT_MSG))
@@ -3642,7 +3643,8 @@ static int do_merge(struct repository *r,
 			argv_array_push(&cmd.args, opts->gpg_sign);
 		if (opts->ignore_date)
 			argv_array_pushf(&cmd.args,
-					 "GIT_AUTHOR_DATE=3D%ld", time(NULL));
+					 "GIT_AUTHOR_DATE=3D%"PRIuMAX,
+					 (uintmax_t)time(NULL));

 		/* Add the tips to be merged */
 		for (j =3D to_merge; j; j =3D j->next)
=2D-
2.22.0.windows.1.6.g271c090e89

