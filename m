From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: webgit highlightes mem adresses as git versions
Date: Tue, 3 Feb 2009 13:31:44 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902031327340.6573@intel-tinevez-2-302>
References: <200902022204.46651.toralf.foerster@gmx.de> <m3ljsowisv.fsf@localhost.localdomain> <200902031204.21435.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-656757664-1233664305=:6573"
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 03 13:33:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUKSo-0007if-32
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 13:33:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407AbZBCMbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 07:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752006AbZBCMbr
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 07:31:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:38243 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751572AbZBCMbr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 07:31:47 -0500
Received: (qmail invoked by alias); 03 Feb 2009 12:31:45 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp069) with SMTP; 03 Feb 2009 13:31:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19BlzhVhJNBG6cZUV41jm/G/AyEI/p6YfE6jizOW4
	EHRTR+5s0Apkdn
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <200902031204.21435.toralf.foerster@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108180>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-656757664-1233664305=:6573
Content-Type: TEXT/PLAIN; charset=iso-8859-14
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 3 Feb 2009, Toralf Förster wrote:

> At Monday 02 February 2009 23:54:20 Jakub Narebski wrote :
> > Toralf Förster <toralf.foerster@gmx.de> writes:
> > > As seen here
> > > http://git.kernel.org/?p=linux/kernel/git/stable/linux-2.6.27.y.git;a=com
> > >mit;h=8ca2918f99b5861359de1805f27b08023c82abd2 the strings [<c043d0f3>]
> > > and firends shouldn't be recognized as git hashes, isn't it ?
> >
> > Gitweb, not webgit.  And gitweb considers ([0-9a-fA-F]{8,40}) i.e.
> > from 8 to 40 hexadecimal characters to be (shortened) SHA-1.  It
> > simply cannot afford checking if such object exists when displaying
> > commit message (for example in 'log' view).
> 
> Ah - ok, what's about expecting spaces around such SHA-1 keys ?

Won't fly: there was a recommendation at some point that you should refer 
to commits in such a form:

	2819075(Merge branch 'maint-1.6.0' into maint)

However, gitweb being written in Perl, I think a lookbehind like (?<!0x), 
i.e. that a 0x in front of the hexadecimal characters means it is no 
SHA-1.

Even better would be using word boundaries, I guess, but all that fails 
when you have a hexdump in the commit message.

Ciao,
Dscho

--8323329-656757664-1233664305=:6573--
