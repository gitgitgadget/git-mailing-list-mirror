From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 27 Nov 2007 17:29:13 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711271728540.27959@racer.site>
References: <200711270622.lAR6MFXQ010010@mi0.bluebottle.com>
 <Pine.LNX.4.64.0711271109130.27959@racer.site> <7vbq9fd2mp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-1619833724-1196184553=:27959"
Cc: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	Andreas Ericsson <ae@op5.se>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 18:29:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix4Fh-0004F2-TK
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 18:29:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757568AbXK0R3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 12:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757603AbXK0R3V
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 12:29:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:45719 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757130AbXK0R3U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 12:29:20 -0500
Received: (qmail invoked by alias); 27 Nov 2007 17:29:18 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp018) with SMTP; 27 Nov 2007 18:29:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/UDGVSJUfUGAJwGDeOVlg4UBXQSuNxVUzcRoBXYv
	BD9g2a5borLp9T
X-X-Sender: gene099@racer.site
In-Reply-To: <7vbq9fd2mp.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66246>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-1619833724-1196184553=:27959
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 27 Nov 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Tue, 27 Nov 2007, しらいしななこ wrote:
> >
> >> Quoting Andreas Ericsson <ae@op5.se>:
> >> 
> >> > "git pull --rebase" already has an implementation. Dscho cooked one up
> >> > which I've been using since then. It works nicely.
> >> 
> >> What is the reason that the option was not added to the official git?  
> >> Was it coded poorly, buggy or were there some other issues?
> >
> > It is very well possible that it was coded poorly ;-)
> >
> > The main reason, I believe, was that some old-timers who know the 
> > implications said that it would encourage a wrong workflow.  One thing 
> > that could go possibly wrong, for example, is to rebase commits that you 
> > already published.
> >
> > So AFAICT it was deemed not only giving people rope, but making that rope 
> > look like a necklace to them.
> 
> Hmph, that is different from how I remember, and the "workflow" argument
> would not be something I would make if we were having that discussion
> today.
> 
> I think what happened was that we took a misguided detour to make this
> an option to "git merge" (which was _my_ mistake IIRC, sorry), which did
> not pan out well (because rebase is not "a different form of merge").
> After that for some reason we failed to follow-up on the topic.  We
> could have gone back to the original "a pull is integrating following a
> fetch, and the integration does not have to be merge" approach to see if
> it was workable, but we didn't.
> 
> If people find it useful, I do not think of a huge reason to object to
> the inclusion.  "Give them rope" is good ;-)

FWIW the my last reply in that thread was 
http://thread.gmane.org/gmane.comp.version-control.git/62382/focus=62405

Ciao,
Dscho

---1463811741-1619833724-1196184553=:27959--
