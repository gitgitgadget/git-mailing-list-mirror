Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1C2C433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 10:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbiBVK61 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 05:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbiBVK60 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 05:58:26 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE77A652B
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 02:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645527476;
        bh=vWuN1RIu2Xn+YDW5NpD7FU+Tr6CrLPSsbTE5z/BMkqk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EGJjBVUhLAJHBAVOCqp5Unz469XQKR1rgN1eOhcH/7t2lJFSS22RZGK4sadd4YN34
         0cr71dtyUBeT6k9BB24zG2l9pAZJB7ENAS33LNA3UsUg1M1f4ElbzP67Nx6vPncgML
         yWHwCWX651iWNU0piR8doX3QwkN0fkhOM2ycHY7s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtOKc-1oEigH46WM-00uscy; Tue, 22
 Feb 2022 11:57:56 +0100
Date:   Tue, 22 Feb 2022 11:57:54 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Julia Lawall <julia.lawall@lip6.fr>
cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH] add usage-strings ci check and amend remaining usage
 strings
In-Reply-To: <20220221173357.8622-1-chakrabortyabhradeep79@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202221152230.11118@tvgsbejvaqbjf.bet>
References: <220221.86tucsb4oy.gmgdl@evledraar.gmail.com> <20220221173357.8622-1-chakrabortyabhradeep79@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-291903977-1645527476=:11118"
X-Provags-ID: V03:K1:J5HBZ3HnBNy1Hs7qzbe9LGMgMxultPPIkI8S/6fH/bQPPfIRmbT
 O6XtXTh+QggBQG9NYjd27BmM3q2cjwAe+k4OXeQP8+XlOFjm2TiJDYLGlMOFwpO+K4ZGDn/
 xGoD5ACybNbkldTeY9UT0F7yWq0TqaANklm/+dvFzmNUycypik9MMLWwVsGt2UuKlpyKoZu
 gOpBrouPa4bJClH7axTkA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hekJ4KTZqb4=:plxnH7pWefbhZZHgnS8Bp+
 dNBFmBhT/NOJCE+psZBYuxbO6xQxKS7SmEDB+dBu4h1kPM/m3sMKfeKrV8nvRpZadrhnPhf+D
 er9um4jyksRqnOwnPmA2pbWrmY97RjvlU6I0P7QP1T7SYfkh2p+4T63eTdr4nZmQNNT0eAUkg
 M5WI0p4NJj54hMrv6CIz75Lv+oxF9ZGWl0LohttazOw0gMScVWKDdn8Le8a/gUn8+3tZW18SJ
 NGikx8wnnPFc5PesKAXWbuR0pflDsiao1kLxJuwonQkiXjQFVoUie+MmZbeZ1KmBDnBqOx6Y4
 Gvs0xH6h+pFm/v1jl7QU+aS9pS3fECy18CUKP9GrtaThe1ni7WEWKl0PZ6FPR2SYWDpzdVWzR
 zEugBA8H/xyvmUtohpPv+9de9FvTK4MGfeBlao3ELFOT1K0jEnxEYmO1tXlRe3YG2ABHPIiRe
 cWldx6tShDg7/aNT93wngHskfDoiBgeI6EBz5Bxb7JJ5HMCnZM4MYEcoZRch6kfRQIGylqtSk
 i3Tdi2P9AUyTp68rxJnIKpaUJAitl0RGEgflr7B87azvWo4ZgpNRlOea/w+WQCX6SKvepUlXy
 2jvQ8b9boypzgin8dp8bcWVHEUaWiY3QfE1H+MoMpEPKz+yodB6hkG8fF9FHJ8eIGcYQ6PMNb
 hFc6CWFVAMPCmv5kjlRuHrHU1U/4X08tcmzWA2t3W/jGTbRLDBMWZLibCTUvBgi4Xe5CXaVqc
 Gk6V8AE3HCM8R4FRA5WiPQfAz/jwnFMzDn6AMCdEimWcUNzQxwy/hqsmoz+lDpWQTKgmuApnF
 F9pQgS2ZEaGVSKvb0Ic+saj8pDzvssiys47Ex1nlR4+kAP6I19iaR9lwzI+WhxukRROIehw6V
 XQQX+6yqWPczpfS0oKnO3vwIksjdq6bQ9xNLChnHu+HAFIzjGi3BebhdHP10DwCApnZQh9Fmj
 pOZ+CUFDlIsCLQjj2BivgMpsTDyat/SZ+Jw6XY87aAAvht/A4zZ48xOsUnbAqkV5pr40ICAoU
 NoLGb0d2FBe03QBOd6aV/jVZWERz3oyPLZK7pYjEOYovZ4bn9E+Q2s+ujiYcdEeYs/iK5JQ2V
 zFd9XGFZF7FV7g=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-291903977-1645527476=:11118
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Julia,

I would like to loop you in here because you have helped us with
Coccinelle questions in the past.

On Mon, 21 Feb 2022, Abhradeep Chakraborty wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> wrote:
>
> > That should be fairly easy to do though, and if not we could always
> > just dump these to stderr or something if a
> > git_env_bool("GIT_TEST_PARSE_OPTIONS_DUMP_FIELD_HELP", 0) was true,
> > and do the testing itself in t0012-help.sh.
>
> Okay but if the logic can't be implented in the `parse-options.c` file
> (most probably I will be able to implement the logic), would you allow
> me to try the `coccinelle script` method you mentioned?

The task at hand is to identify calls to the macro `OPT_CMDMODE()` (and
other, similar macros) that get a fourth argument of the form

	N_("<some string>")

The problem is to identify `<some string>` that ends in a `.` (which we
want to avoid) or that starts with some prefix and a colon but follows
with an upper-case character.

In other words, we want to suggest replacing

	N_("log: Use something")

or

	N_("log: use something.")

by

	N_("log: use something")

=C3=86var suggested that Coccinelle can do that. Could you give us a hand =
how
this would be possible using `spatch`?

Thank you,
Johannes

--8323328-291903977-1645527476=:11118--
