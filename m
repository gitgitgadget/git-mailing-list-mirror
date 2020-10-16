Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B295C433DF
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 22:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20C012065D
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 22:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="UyMlgWxB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388993AbgJPWKJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 18:10:09 -0400
Received: from mail-41103.protonmail.ch ([185.70.41.103]:45480 "EHLO
        mail-41103.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388807AbgJPWKI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 18:10:08 -0400
Received: from mail-02.mail-europe.com (mail-02.mail-europe.com [51.89.119.103])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-41103.protonmail.ch (Postfix) with ESMTPS id 249E52001712
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 22:10:06 +0000 (UTC)
Authentication-Results: mail-41103.protonmail.ch;
        dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="UyMlgWxB"
Date:   Fri, 16 Oct 2020 22:09:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1602886202;
        bh=ftZNIAQNj9S2olXIar6VnSkYQjZbPs2UMsCksGrXHbs=;
        h=Date:To:From:Reply-To:Subject:From;
        b=UyMlgWxB/KId9mybVsPwWxZ77ycm2qx6MTSXCvKWd9N5nVoxem+WZDsDV8Pz2NP67
         72GERMNLvpqDAtw0m2r7u/S5Fa+oPzzczug6ZhrmkCx2KHakikIEvh+IKtdknrK/BA
         Z41EhER7eXiFmjx2olRpDQh43ew+HhcjXLDABVWM=
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Joey S <jgsal@protonmail.com>
Reply-To: Joey S <jgsal@protonmail.com>
Subject: [Outreachy] Introduction
Message-ID: <HiG3ctHji8hdGWXWEwWgeoa6eDDHkUbhfa0x0xYr9EHWD7FqXqZsQt3fHMZ4Vle0jo2QPCW8rjRviw_aGKqxUIFtvX2igp1aUnx9p6YCL0Y=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Message previously sent as rich text to both git@vger.kernel.org and wires=
hark-dev@wireshark.org, re-sending to the git ml as plain text from a diffe=
rent account, apologies for the inconvenience]


Hi everyone,

I'm Joey Salazar, an Outreachy 2020 applicant certified in CCNA and Linux+,=
 with some experience in C for both private and open source repositories (B=
IND at gitlab.isc.org/Joey), community code reviews, and automated tests in=
 bash. I'd like to contribute to the "Add Git protocol support to Wireshark=
" project and improve my skills, yet remain open to a different project if =
that'd be preferable.

I have installed and built git, followed git.github.io/General-Microproject=
-Information and checked the sample email thread [1], as well as the tutori=
al git-scm.com/docs/MyFirstContribution and created the psuh command files =
here [2].

After following the git.github.io/Outreachy-21-Microprojects page I'd like =
to work on the 'Use test_path_is_* functions in test scripts', and given th=
at Charvi Mendiratta might be working on tests t7101,t7102 and t7201 as per=
 this ml thread [3], I'd like to check with the group if working on tests t=
7006 and t7300 would be ok.

In parallel, I'm following gitlab.com/wireshark/wireshark/-/wikis/Developme=
nt as suggested through the #git-devel IRC channel and will follow that up =
with the overview of Git's HTTP protocol in the Pro Git book [4].

All guidance much appreciated, I'm very looking forward to working together=
!

Joey

[1] public-inbox.org/git/1386590745-4412-1-git-send-email-t.gummerer@gmail.=
com/T/#u
[2] github.com/j-sal/git/tree/psuh
[3] public-inbox.org/git/CAP8UFD1m2zXUm1PXmJKW2MxA9XZVUOkBFA62jLP7jx6_DCYZG=
w@mail.gmail.com
[4] git-scm.com/book/en/v2/Git-Internals-Transfer-Protocols


