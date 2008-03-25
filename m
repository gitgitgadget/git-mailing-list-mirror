From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-merge adds test to a message -- bug?
Date: Tue, 25 Mar 2008 21:04:33 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803252102140.10660@wbgn129.biozentrum.uni-wuerzburg.de>
References: <slrnfudp0q.19k.joerg@alea.gnuu.de> <7vabko3dm2.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803241208400.4353@racer.site> <7viqzcvznm.fsf@gitster.siamese.dyndns.org> <20080325001247.GB26905@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148944103-419282944-1206475478=:10660"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-15?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Tue Mar 25 21:06:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeFOf-0001Pl-Fr
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 21:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046AbYCYUEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 16:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751960AbYCYUEo
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 16:04:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:56625 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751444AbYCYUEn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 16:04:43 -0400
Received: (qmail invoked by alias); 25 Mar 2008 20:04:38 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp048) with SMTP; 25 Mar 2008 21:04:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX180jNp4LYk0OKREEoGhJt2JpSjI+b6dEFoNjkBfKq
	hzHvmfua1dhiWv
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <20080325001247.GB26905@alea.gnuu.de>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78218>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148944103-419282944-1206475478=:10660
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 25 Mar 2008, Jörg Sommer wrote:

> Junio C Hamano schrieb am Mon 24. Mar, 09:45 (-0700):
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > > On Sun, 23 Mar 2008, Junio C Hamano wrote:
> > >
> > >> I unfortunately do not recall why _prepend_, and not _replace_, had 
> > >> to be the right behaviour.
> > >
> > > http://article.gmane.org/gmane.comp.version-control.git/31896/match=git+merge+make+usable
> > >
> > > Hth,
> > 
> > Ok, it helped.
> > 
> > So it was "my suspicion that people who would want to pass -m would 
> > want it to behave this way".
> > 
> > I do not care deeply either way myself, as I never have found use for 
> > -m to the merge command, but I think it could have been argued either 
> > way.
> 
> I would like to argue for the replace way. :) Take git rebase -p as an 
> example. If a merge is included in the rebase, it's redone with git 
> merge -m. Because git rebase works with detached heads you get merge 
> messages like this: [...]

That only means that the original author of rebase -p was a lazy bastard 
and did not use the proper way to call git-merge, namely

	git <msg> HEAD <the-other-branch>

Now, let's try git log -S to find out who that inexcusably lazy bum was.

Ciao,
Dscho
---1148944103-419282944-1206475478=:10660--
