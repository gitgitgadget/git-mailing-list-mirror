From: Toralf =?iso-8859-14?q?F=F6rster?= <toralf.foerster@gmx.de>
Subject: Re: webgit highlightes mem adresses as git versions
Date: Tue, 3 Feb 2009 12:04:21 +0100
Message-ID: <200902031204.21435.toralf.foerster@gmx.de>
References: <200902022204.46651.toralf.foerster@gmx.de> <m3ljsowisv.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-14
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 12:06:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUJ6F-0002ci-Ln
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 12:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081AbZBCLEZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Feb 2009 06:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752068AbZBCLEZ
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 06:04:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:46108 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752031AbZBCLEY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Feb 2009 06:04:24 -0500
Received: (qmail invoked by alias); 03 Feb 2009 11:04:22 -0000
Received: from e177121149.adsl.alicedsl.de (EHLO e177121149.adsl.alicedsl.de) [85.177.121.149]
  by mail.gmx.net (mp037) with SMTP; 03 Feb 2009 12:04:22 +0100
X-Authenticated: #5108953
X-Provags-ID: V01U2FsdGVkX18Z0LdOjcQZjClYXHpR2+m8Nu298L6AN1j+TCMi+c
	q9/Fx5+V6wmW0P
User-Agent: KMail/1.9.10
In-Reply-To: <m3ljsowisv.fsf@localhost.localdomain>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108177>

At Monday 02 February 2009 23:54:20 Jakub Narebski wrote :
> Toralf F=F6rster <toralf.foerster@gmx.de> writes:
> > As seen here
> > http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-2.6.27.y.g=
it;a=3Dcom
> >mit;h=3D8ca2918f99b5861359de1805f27b08023c82abd2 the strings [<c043d=
0f3>]
> > and firends shouldn't be recognized as git hashes, isn't it ?
>
> Gitweb, not webgit.  And gitweb considers ([0-9a-fA-F]{8,40}) i.e.
> from 8 to 40 hexadecimal characters to be (shortened) SHA-1.  It
> simply cannot afford checking if such object exists when displaying
> commit message (for example in 'log' view).

Ah - ok, what's about expecting spaces around such SHA-1 keys ?

--=20
MfG/Sincerely

Toralf F=F6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
