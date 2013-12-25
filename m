From: Wolfgang Rohdewald <wolfgang@rohdewald.de>
Subject: Re: german translation bug
Date: Wed, 25 Dec 2013 22:53:29 +0100
Message-ID: <1513689.dimJgKglhA@i5>
References: <1573480.3a5WD62Cc4@i5> <CAN0XMOJf=H__eFmbcBs-S50ASun94ASL9FiL1zM6eeTheYpxTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: git <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 25 22:53:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VvwOf-0004LX-5j
	for gcvg-git-2@plane.gmane.org; Wed, 25 Dec 2013 22:53:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492Ab3LYVxh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Dec 2013 16:53:37 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:43250 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482Ab3LYVxX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Dec 2013 16:53:23 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1388008399; l=2015;
	s=domk; d=rohdewald.de;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH;
	bh=gUtSDSSkyv5aqZ9tYfTCyUWvhG0=;
	b=kI2uoFmQooZYB4JYjMFgQ5Z1ZKoIhno4Zk2Y9dHC4dqqsN1TnsgM46si9GGi5tjHPHq
	IuQijfnpm+4I6KtdVg1Zx1jVBP4LQS/sgytIOHNsFmyuSiShMw6bm3ovHOcNtuD+NVbd0
	rUX2ieOFxfgRAvNjmme749hbT0hdp1jjaB4=
X-RZG-AUTH: :O2MIc0epdfgAjoV+frHI3UhxNCLBO5P+YS73lHhJYRD2uAuzaM+5N8MTpvX1LBI=
X-RZG-CLASS-ID: mo00
Received: from i5.rohdewald.de (p5B3E3307.dip0.t-ipconnect.de [91.62.51.7])
	by smtp.strato.de (RZmta 32.17 DYNA|AUTH)
	with (SSLv3:DHE-RSA-AES256-SHA encrypted) ESMTPSA id j01b34pBPLrJJ4q ;
	Wed, 25 Dec 2013 22:53:19 +0100 (CET)
Received: from i5.localnet (localhost.localdomain [127.0.0.1])
	by i5.rohdewald.de (Postfix) with ESMTP id 19C605E0190;
	Wed, 25 Dec 2013 22:53:30 +0100 (CET)
User-Agent: KMail/4.12 (Linux/3.11.0-14-generic; KDE/4.12.0; x86_64; ; )
In-Reply-To: <CAN0XMOJf=H__eFmbcBs-S50ASun94ASL9FiL1zM6eeTheYpxTg@mail.gmail.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY,
	URIBL_BLOCKED shortcircuit=no autolearn=ham version=3.3.2
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on i5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239678>

Am Mittwoch, 25. Dezember 2013, 21:59:10 schrieb Ralf Thielow:
> What version of Git do you use? What distro in what version do you use?

freshly installed kubuntu 13.10. The package language-pack-de mentioned
at the end of this mail is installed.

I suppose I should open a KDE bug report?

i5:~ ((unknown)) git --version
git version 1.8.3.2

wr@s5:~/kajongg/src$ grep -a 'Nichts zum Einreichen' /usr/share/locale-langpack/de/LC_MESSAGES/git.mo 
Nichts zum Einreichen
Nichts zum Einreichen, Arbeitsverzeichnis leer

root@s5:~/kajongg/src# apt-file search /de/ | grep /git.mo
language-pack-de-base: /usr/share/locale-langpack/de/LC_MESSAGES/git.mo

root@s5:~/kajongg/src# LANG=C dpkg --info /var/cache/apt/archives/language-pack-de-base_1%3a13.10+20131012_all.deb
 new debian package, version 2.0.
 size 3346634 bytes: control archive=7323 bytes.
     955 bytes,    19 lines      control              
   20278 bytes,   231 lines      md5sums              
     125 bytes,     9 lines   *  postinst             #!/bin/sh
     121 bytes,     9 lines   *  postrm               #!/bin/sh
 Package: language-pack-de-base
 Version: 1:13.10+20131012
 Architecture: all
 Maintainer: Language pack maintainers <language-packs@ubuntu.com>
 Installed-Size: 11247
 Pre-Depends: dpkg (>= 1.10.27ubuntu1)
 Depends: locales (>= 2.3.6), language-pack-de (>= 1:13.10+20131012)
 Recommends: firefox-locale-de
 Conflicts: language-pack-de (<< 1:13.10+20131012)
 Replaces: language-pack-de (<< 1:13.10+20131012), language-pack-de-base (<< 1:13.10+20131012), language-pack-gnome-de (<< 1:13.10+20131012), language-pack-gnome-de-base (<< 1:13.10+20131012), language-pack-kde-de (<< 1:13.10+20131012), language-pack-kde-de-base (<< 1:13.10+20131012)
 Section: translations
 Priority: optional
 Description: translations for language German
  Translation data for all supported packages for:
  German
  .
  This package provides the bulk of translation data and is updated
  only seldom. language-pack-de provides frequent
  translation updates, so you should install this as well.

-- 
Wolfgang
