Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1DEC433EF
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 07:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 235CA60E78
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 07:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhJaHOl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Oct 2021 03:14:41 -0400
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:50111 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhJaHOk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Oct 2021 03:14:40 -0400
Received: from gandalf-1.home ([109.208.174.31])
        by smtp.orange.fr with ESMTPA
        id h50fmGDzW3ptZh50fmog3n; Sun, 31 Oct 2021 08:12:06 +0100
X-ME-Helo: gandalf-1.home
X-ME-Auth: ZDI0YmViZGZiZGFkNzM3ZTdjNic5MDM3NiUzZiU2MiE3M2EzNzA0ZmY1MzNkMzc5MDE=
X-ME-Date: Sun, 31 Oct 2021 08:12:06 +0100
X-ME-IP: 109.208.174.31
Message-ID: <f3b42a0bdf5b910a65b1d55cb8375a6d284815d0.camel@orange.fr>
Subject: Double parent after a merge seems to block the pull from another
 person
From:   Olivier Paillat <paillat.olivier@orange.fr>
To:     git@vger.kernel.org
Date:   Sun, 31 Oct 2021 08:12:05 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello

I have a question : 
We are two persons working on the same remote repository
My collegue update the remote repository with his ast changes
Meanwhil I have done a git flow feature that I have finished then I
pulled his last version from the remote repository (git pull origin
develop)
I had a few merge conflicts that I solved
Then I did another flow feature and I finally closed this feature and
push it to origin develop
My collegue then try to get the new remote repository but he told me
that because there were a double parent in my merge commit (but the
very last commit is single parent) he could not get the last version.
I manage git with comitin QtCreator and git bash command when my
collegue use Visual Studio to manage git.

Is it true that a double parent is a problem to get a the last commit
on the remote origin develop ? and in this case how to avoid double
parent ? or is there something else going on ?

Best regards

Olivier Paillat

