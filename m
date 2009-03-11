From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Generalised bisection
Date: Wed, 11 Mar 2009 14:04:08 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903111358260.10498@intel-tinevez-2-302>
References: <efe2b6d70903081840v18e77aa7w2dac2bed553d0d6a@mail.gmail.com>  <200903100808.15875.chriscool@tuxfamily.org>  <efe2b6d70903110159h78de744yc141effaf5aa0821@mail.gmail.com>  <43d8ce650903110235q5e2a59f6t201d5e65a4937476@mail.gmail.com> 
 <alpine.DEB.1.00.0903111304520.10279@pacific.mpi-cbg.de> <43d8ce650903110508o3d12f32m8202fae750d215a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-191531962-1236776649=:10498"
Cc: Ealdwulf Wuffinga <ealdwulf@googlemail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Git List <git@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 14:06:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhO85-00074U-Rw
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 14:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754030AbZCKNEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 09:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753900AbZCKNEM
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 09:04:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:39047 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752271AbZCKNEM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 09:04:12 -0400
Received: (qmail invoked by alias); 11 Mar 2009 13:04:09 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp039) with SMTP; 11 Mar 2009 14:04:09 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19IcAVW/P9IcILMBstmdzstxME2XtpVObVEXvfak+
	10N/ZKGvoPCLsX
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <43d8ce650903110508o3d12f32m8202fae750d215a@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112925>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-191531962-1236776649=:10498
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 11 Mar 2009, John Tapsell wrote:

> 2009/3/11 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>
> > On Wed, 11 Mar 2009, John Tapsell wrote:
> >
> >> There used to be a dependency on python.  git-merge-recursive for 
> >> example, before it was converted to C.
> >
> > Not "for example".  It was the only dependency of git.git on Python, 
> > and the rewrite of merge-recursive was only done to break that 
> > dependency, as I had a platform where I could not install Python.
> 
> But installing perl was no problem?  (Just curious)

Perl was installed, albeit in an ancient version, and compiling Perl 
modules written in C was out.  It just did not work.

But the good part was: after converting rerere to be a builtin, there 
were no Perl scripts left that I wanted/needed to use.

These days, we only have these Perl scripts left: add--interactive, 
archimport, cvsexportcommit, cvsimport, cvsserver, relink, send-email and 
svn.

Ignoring the scripts to interact with other SCMs (which I can do on 
another computer), that leaves add--interactive, relink (which could be 
moved to contrib/ AFAIAC) and send-email.

I use "add -e" instead of "add -i", and stay away from send-email...

Ciao,
Dscho

--8323329-191531962-1236776649=:10498--
