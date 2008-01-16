From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 16 Jan 2008 16:32:32 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801161629580.17650@racer.site>
References: <478E1FED.5010801@web.de> <alpine.LSU.1.00.0801161531030.17650@racer.site> <427BE4FD-6534-4CB2-91F8-F9014DC82B54@sb.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-179803630-1200501153=:17650"
Cc: Mark Junker <mjscod@web.de>, git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 17:33:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFBCK-0002xu-PX
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 17:33:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbYAPQcg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 11:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbYAPQcg
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 11:32:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:46393 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750912AbYAPQcf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 11:32:35 -0500
Received: (qmail invoked by alias); 16 Jan 2008 16:32:34 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp032) with SMTP; 16 Jan 2008 17:32:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18aN25/aTca51vJDraZPAkTZlRk+gbl7QxBYrJc8B
	7e+fOgoUzpL9S3
X-X-Sender: gene099@racer.site
In-Reply-To: <427BE4FD-6534-4CB2-91F8-F9014DC82B54@sb.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70698>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-179803630-1200501153=:17650
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 16 Jan 2008, Kevin Ballard wrote:

> On Jan 16, 2008, at 10:34 AM, Johannes Schindelin wrote:
> 
> > On Wed, 16 Jan 2008, Mark Junker wrote:
> > 
> > > I have some files like "Lüftung.txt" in my repository. The strange 
> > > thing is that I can pull / add / commit / push those files without 
> > > problem but git-status always complains that thoes files are 
> > > untraced (but not missing).
> > 
> > This is a known problem.  Unfortunately, noone has implemented a fix, 
> > although if you're serious about it, I can point you to threads where 
> > it has been hinted how to solve the issue.
> > 
> > FWIW the issue is that Mac OS X decides that it knows better how to 
> > encode your filename than you could yourself.
> 
> More like, Mac OS X has standardized on Unicode and the rest of the 
> world hasn't caught up yet. Git is the only tool I've ever heard of that 
> has a problem with OS X using Unicode.

No.  That's not at all the problem.  Mac OS X insists on storing _another_ 
encoding of your filename.  Both are UTF-8.  Both encode the _same_ 
string.  Yet they are different, bytewise.  For no good reason.

Stop spreading FUD.  Git can handle Unicode just fine.  In fact, Git does 
not _care_ how the filename is encoded, it _respects_ the user's choice, 
not only of the encoding _type_, but the _encoding_, too.

Okay?

Hth,
Dscho

---1463811741-179803630-1200501153=:17650--
