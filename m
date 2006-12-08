X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Allow building GIT in a different directory from the source directory
Date: Fri, 08 Dec 2006 18:44:03 +0100
Organization: At home
Message-ID: <elc84p$4cs$1@sea.gmane.org>
References: <elc6j2$vej$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 8 Dec 2006 17:42:12 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 41
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33713>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gsjjd-0002MT-FX for gcvg-git@gmane.org; Fri, 08 Dec
 2006 18:42:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1426051AbWLHRmG convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006 12:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760782AbWLHRmG
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 12:42:06 -0500
Received: from main.gmane.org ([80.91.229.2]:60110 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1758219AbWLHRmD
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 12:42:03 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GsjjR-0005Jw-Dt for git@vger.kernel.org; Fri, 08 Dec 2006 18:41:57 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 08 Dec 2006 18:41:57 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 08 Dec 2006
 18:41:57 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Han-Wen Nienhuys wrote:

> From 105d331aee95c0cf3610ac0d2fd4aa7688bd5211 Mon Sep 17 00:00:00 200=
1

This line is not needed.

> From: Han-Wen Nienhuys <hanwen@xs4all.nl>
> Date: Fri, 8 Dec 2006 18:07:56 +0100
>=20
> GIT can now be built in a separate builddirectory. This is done as
> follows:
>=20
> =A0 mkdir build
> =A0 cd build
> =A0 $my_git_dir/configure
> =A0 make

Perhaps we should add this to INSTALL file, or to comments in either
Makefile, or configure.ac?

> In this case, configure creates an empty directory tree based on the
> source directory, and wraps Makefiles from source directory in the
> build directory. =A0The rest of the functionality is delivered with t=
he
> VPATH feature of Make.
>=20
> To make this work the Makefile should not mention ./ explicitly in
> rules, but rather use $< and $^ to automatically look in the source
> dir too.
>=20
> perl/Makefile and perl/Makefile.PL need special massaging because per=
l
> is not VPATH aware.
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@xs4all.nl>

Very nicely written commit message. Good work.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

