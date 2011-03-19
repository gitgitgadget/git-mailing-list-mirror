From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] git-init.txt: move description section up
Date: Sat, 19 Mar 2011 16:55:56 +0100
Message-ID: <vpqbp17hzoz.fsf@bauges.imag.fr>
References: <1300547816-4768-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 16:59:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0yYc-0005oN-Ks
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 16:59:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756084Ab1CSP7J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Mar 2011 11:59:09 -0400
Received: from imag.imag.fr ([129.88.30.1]:34204 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755888Ab1CSP7I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Mar 2011 11:59:08 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id p2JFtvmL020457
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 19 Mar 2011 16:55:57 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Q0yVR-0002Gf-C4; Sat, 19 Mar 2011 16:55:57 +0100
In-Reply-To: <1300547816-4768-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 19
 Mar 2011 22:16:55 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sat, 19 Mar 2011 16:55:57 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169442>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

>  - The text mentioning git-init-db is dropped. init-db is
>    deprecated, no need to confuse new users

Shouldn't we add something like this then?

=46rom 86b8daa4bf4c7cd376335570e5f1663c6d6cde01 Mon Sep 17 00:00:00 200=
1
=46rom: Matthieu Moy <Matthieu.Moy@imag.fr>
Date: Sat, 19 Mar 2011 16:54:43 +0100
Subject: [PATCH] shorten git-init-db.txt to only point to git-init.txt

---
 Documentation/git-init-db.txt |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-db.=
txt
index 2c4c716..b2b959e 100644
--- a/Documentation/git-init-db.txt
+++ b/Documentation/git-init-db.txt
@@ -3,13 +3,7 @@ git-init-db(1)
=20
 NAME
 ----
-git-init-db - Creates an empty git repository
-
-
-SYNOPSIS
---------
-'git init-db' [-q | --quiet] [--bare] [--template=3D<template_director=
y>] [--shared[=3D<permissions>]]
-
+git-init-db - Deprecated alias for linkgit:git-init[1]
=20
 DESCRIPTION
 -----------
--=20
1.7.4.1.293.g8414b



--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
