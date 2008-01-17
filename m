From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 00:57:20 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801170054280.17650@racer.site>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201> <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org> <200801162251.54219.jnareb@gmail.com> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org>
 <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org> <alpine.LFD.1.00.0801161619420.2806@woody.linux-foundation.org> <alpine.LSU.1.00.0801170032230.17650@racer.site>
 <16C3D0BC-3A70-441C-89D9-71B5F0DA0790@simplicidade.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Ballard <kevin@sb.org>,
	Jakub Narebski <jnareb@gmail.com>, Mark Junker <mjscod@web.de>,
	git@vger.kernel.org
To: Pedro Melo <melo@simplicidade.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 01:57:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFJ4s-0003kj-Vd
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 01:57:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbYAQA50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 19:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbYAQA50
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 19:57:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:40901 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750908AbYAQA5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 19:57:25 -0500
Received: (qmail invoked by alias); 17 Jan 2008 00:57:23 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp010) with SMTP; 17 Jan 2008 01:57:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/et7B9rlreg7vqsj7VtZWRBJhYjt1o7RIwhnnIgA
	boGQuJfanivpec
X-X-Sender: gene099@racer.site
In-Reply-To: <16C3D0BC-3A70-441C-89D9-71B5F0DA0790@simplicidade.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70793>

Hi,

On Thu, 17 Jan 2008, Pedro Melo wrote:

> On Jan 17, 2008, at 12:33 AM, Johannes Schindelin wrote:
> 
> > On Wed, 16 Jan 2008, Linus Torvalds wrote:
> > 
> > > So if you are a case-insensitive filesystem, then normalization is 
> > > sane.
> > 
> > Actually, no.  Even an case-challenged filesystem should keep the 
> > _original_ name around, if only for the exact same argument you used 
> > earlier: if the user chooses to capitalise some letters, but not 
> > others, it is not the filesystem's place to "correct" that.
> 
> For the record, HFS+ is case-insensitive but case-preserving so I 
> believe they keep the original filename around.

For the record, that's only the default setting.  AFAIK you can configure 
it to care about case, too.

Also for the record, the whole thread was about HFS+ _not_ keeping the 
original filename around, but _only_ a normalised version of it.

> But I think that focusing on HFS+ is loosing sight of the real problem. 
> It's not about encoding at the filesystem, but encoding inside the git 
> structures.

So far I have not seen anyone talking _seriously_ about this issue.  Only 
a few shouts "you should support", and a few shouts back "I don't care 
about insane filesystems".

Therefore, I fully agree with you that we're losing sight of the real 
problem.

Ciao,
Dscho
