From: Wolfgang Rohdewald <wolfgang@rohdewald.de>
Subject: Re: german translation bug
Date: Wed, 25 Dec 2013 23:28:32 +0100
Message-ID: <6038171.4XUs8Nu1vH@i5>
References: <1573480.3a5WD62Cc4@i5> <1513689.dimJgKglhA@i5> <CAM9Z-n=MF+MibS3ziHkixX+iTNAvB+D0+naKkzS8rb5ZSvgEzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ralf Thielow <ralf.thielow@gmail.com>, git <git@vger.kernel.org>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 25 23:28:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vvwwa-0002C2-QF
	for gcvg-git-2@plane.gmane.org; Wed, 25 Dec 2013 23:28:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359Ab3LYW2Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Dec 2013 17:28:25 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:30425 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752294Ab3LYW2Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Dec 2013 17:28:24 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1388010502; l=2765;
	s=domk; d=rohdewald.de;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH;
	bh=SrQVgsc1djsLy8wOuZQPzuoSzl0=;
	b=lIq9lz+t7jawBh74CybY5PAoasLkbvi6O6QZ/tz2eNKXC/+5ggI2/zJvV0Js4xhjpVo
	HIVdruDpETTFEGoWrFeIgCU8s7SbBatDkgyks1h+sPqWea36lxc9/5wa00k8EFuBZoa0C
	IP3CiV0G3/er/EqV3EZMEkN5hQ8Itq3PNl4=
X-RZG-AUTH: :O2MIc0epdfgAjoV+frHI3UhxNCLBO5P+YS73lHhJYRD2uAuzaM+5N8MTpvX1LBI=
X-RZG-CLASS-ID: mo00
Received: from i5.rohdewald.de (p5B3E3307.dip0.t-ipconnect.de [91.62.51.7])
	by smtp.strato.de (RZmta 32.17 DYNA|AUTH)
	with (SSLv3:DHE-RSA-AES256-SHA encrypted) ESMTPSA id z04772pBPMSMMVR ;
	Wed, 25 Dec 2013 23:28:22 +0100 (CET)
Received: from i5.localnet (localhost.localdomain [127.0.0.1])
	by i5.rohdewald.de (Postfix) with ESMTP id 39CE65E037D;
	Wed, 25 Dec 2013 23:28:33 +0100 (CET)
User-Agent: KMail/4.12 (Linux/3.11.0-14-generic; KDE/4.12.0; x86_64; ; )
In-Reply-To: <CAM9Z-n=MF+MibS3ziHkixX+iTNAvB+D0+naKkzS8rb5ZSvgEzw@mail.gmail.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY,
	URIBL_BLOCKED shortcircuit=no autolearn=ham version=3.3.2
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on i5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239682>

Am Mittwoch, 25. Dezember 2013, 17:14:31 schrieb Drew Northup:
> Git does not use KDE's language packs.

Sorry, I meant ubuntu. I believe I heard before that they tend to repla=
ce
upstream translations but I never actually experienced a problem with t=
hat.

> What does dpkg report for info about the installed git package (if yo=
u
> are using the packaged version)?

Yes, I am using the packaged version. This package does not contain
any translations.

root@s5:/var/cache/apt/archives# dpkg --info git_1%3a1.8.3.2-1_amd64.de=
b
 neues Debian-Paket, Version 2.0.
 Gr=F6=DFe 8034840 Byte: control-Archiv=3D 15063 Byte.
      34 Byte,     1 Zeilen      conffiles           =20
    1741 Byte,    30 Zeilen      control             =20
   32344 Byte,   427 Zeilen      md5sums             =20
    1570 Byte,    45 Zeilen   *  postinst             #!/bin/sh
    1080 Byte,    35 Zeilen   *  postrm               #!/bin/sh
    2359 Byte,    68 Zeilen   *  preinst              #!/bin/sh
     478 Byte,    12 Zeilen   *  prerm                #!/bin/sh
 Package: git
 Version: 1:1.8.3.2-1
 Architecture: amd64
 Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
 Original-Maintainer: Gerrit Pape <pape@smarden.org>
 Installed-Size: 17972
 Depends: libc6 (>=3D 2.16), libcurl3-gnutls (>=3D 7.16.2), libexpat1 (=
>=3D 2.0.1), libpcre3 (>=3D 8.10), zlib1g (>=3D 1:1.2.0), perl-modules,=
 liberror-perl, git-man (>> 1:1.8.3.2), git-man (<< 1:1.8.3.2-.)
 Recommends: patch, less, rsync, ssh-client
 Suggests: gettext-base, git-daemon-run | git-daemon-sysvinit, git-doc,=
 git-el, git-email, git-gui, gitk, gitweb, git-arch, git-bzr, git-cvs, =
git-svn
 Breaks: bash-completion (<< 1:1.90-1), cogito (<=3D 0.18.2+), git-core=
 (<< 1:1.7.0.4-1.), gitosis (<< 0.2+20090917-7), gitpkg (<< 0.15), gitw=
eb (<< 1:1.7.4~rc1), guilt (<< 0.33), stgit (<< 0.15), stgit-contrib (<=
< 0.15)
 Replaces: git-core (<< 1:1.7.0.4-1.), gitweb (<< 1:1.7.4~rc1)
 Provides: git-completion, git-core
 Section: vcs
 Priority: optional
 Multi-Arch: foreign
 Homepage: http://git-scm.com/
 Description: fast, scalable, distributed revision control system
  Git is popular version control system designed to handle very large
  projects with speed and efficiency; it is used for many high profile
  open source projects, most notably the Linux kernel.
  .
  Git falls in the category of distributed source code management tools=
=2E
  Every Git working directory is a full-fledged repository with full
  revision tracking capabilities, not dependent on network access or a
  central server.
  .
  This package provides the git main components with minimal dependenci=
es.
  Additional functionality, e.g. a graphical user interface and revisio=
n
  tree visualizer, tools for interoperating with other VCS's, or a web
  interface, is provided as separate git* packages.

--=20
Wolfgang
