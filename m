From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Fri, 18 Jan 2008 20:50:35 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801182042360.5731@racer.site>
References: <478E1FED.5010801@web.de> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org> <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org>
 <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org> <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org> <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org> <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com>
 <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org> <478F99E7.1050503@web.de> <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org> <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org>
 <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <7vr6gedgk9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 21:51:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFyBc-0000IZ-FJ
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 21:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762123AbYARUuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 15:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760029AbYARUun
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 15:50:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:35538 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760838AbYARUum (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 15:50:42 -0500
Received: (qmail invoked by alias); 18 Jan 2008 20:50:40 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp009) with SMTP; 18 Jan 2008 21:50:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/IpcMrf8PIJXhfvXpW6yYoAIv/N2yHid5jIKnaZT
	5dQJcYxDE4PbWj
X-X-Sender: gene099@racer.site
In-Reply-To: <7vr6gedgk9.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71061>

Hi,

On Fri, 18 Jan 2008, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > On Fri, 18 Jan 2008, Peter Karlsson wrote:
> >> 
> >> But they are not different strings, they are canonically equivalent as
> >> far as Unicode is concerned.
> >
> > Fuck me with a spoon.
> >
> > Why the hell cannot people see that "equivalent" and "same" are two 
> > totally different meanings.
> 
> Could people _please_ stop this already?

Welcome, voice of reason.

> I think the sane people see the difference between equivalence
> and sameness, and we established that a filesystem that mangles
> the filenames behind user's back is a bad design.  Anybody who
> followed the thread and still does not agree with you is, eh,
> "ugly-and-stupid", as you might say ;-).  You cannot educate
> them all.

Actually, I see some value in calling them names, see 
http://video.google.nl/videoplay?docid=-4216011961522818645 for why.

> The thing is, even if you mange to educate them all, that broken 
> filesystem, and other filesystems with similar brokenness, do not go 
> away.

I was almost starting with hacking on this, but then the discussion 
annoyed me too much, and I asked myself for who I think I'd do this.

IMHO those people should ask "how could I begin to work on this".

Instead, they started a useless flamewar.

Now, back to the issue: Robin posted a link to his UTF-8 work.  While it 
is way too intrusive, and not limited to filenames at all, I think it has 
a few good pointers.

Ciao,
Dscho "who needs to calm down now"
