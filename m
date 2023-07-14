Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96300EB64DC
	for <git@archiver.kernel.org>; Fri, 14 Jul 2023 14:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235661AbjGNOPa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jul 2023 10:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234555AbjGNOP3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2023 10:15:29 -0400
X-Greylist: delayed 453 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 14 Jul 2023 07:15:27 PDT
Received: from mail.mrvanes.com (mail.mrvanes.com [104.248.86.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9042D51
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 07:15:27 -0700 (PDT)
Received: from authenticated-user (mail.mrvanes.com [104.248.86.249])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mrvanes.com (Postfix) with ESMTPSA id EA21BFD199
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 16:07:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mrvanes.com; s=mail;
        t=1689343671; bh=t0iaULeDgY34JawEW24S8rSySgSrbTfLy/XjQ58Ygqc=;
        h=From:To:Subject:Date:From;
        b=f1ZWhg+czXsim7Xu50+KggGSG3u2Sz6vjeQ3z8iBQf1so7FYmLJ/26zPrVlqVZQZ8
         Qw1jBK7sLXE0LpWg826LYcItjrY4dsmlCKPKrUf2JfGbm1LO9xoOwu0bjm6WwFGC5M
         RGIHDb+xbaiNKPtgNaY699rUpkQGZA/VxQrigCVpk7/xRuSHQOapW9250XIeWA8ubc
         tKCxAqep/WY1YWPPDdTVMHeZhe4tTR2lF6U7UEhW/DIaAdbFVIacu6tTJSaCTsaXnP
         dUcg5ZyJZ7bAzP5zi81jWX1h4j+5cpRZbwPOJAuWT+PQE5IzOY7R2tVhC/z/3qfKUe
         Ymorhrw61iKaQ==
From:   Martin van Es <martin@mrvanes.com>
To:     git@vger.kernel.org
Subject: git gui locks-up system when invoked under wayland session (sometimes)
Date:   Fri, 14 Jul 2023 16:07:49 +0200
Message-ID: <12246559.O9o76ZdvQC@minivanes>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)
Use Wayland
start "git gui"

What did you expect to happen? (Expected behavior)
The Graphical Git user interface 

What happened instead? (Actual behavior)
System completely locks up

What's different between what you expected and what actually happened?
The locked up system

Anything else you want to add:
The problem is intermittant, but when it happens, it's a really bad lock-up 
that can only be resolved with a cold reset

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version 2.39.2
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.4.0 #1 SMP Mon Jun 26 22:05:37 CEST 2023 x86_64
compiler info: gnuc: 12.2
libc info: glibc: 2.37
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
not run from a git repository - no hooks to show



