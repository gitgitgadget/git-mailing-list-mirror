From: Tim Mazid <timmazid@hotmail.com>
Subject: RE: git & patterns
Date: Thu, 19 May 2011 16:40:34 +1000
Message-ID: <SNT124-w95A0758AAE98C128DB9A2C48E0@phx.gbl>
References: <4DD3A402.3040802@hupie.com>
 <7vsjsbbx7h.fsf@alter.siamese.dyndns.org>,<4DD4B772.2050404@hupie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: <mailings@hupie.com>, <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 19 08:40:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMwuX-0006yH-2P
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 08:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463Ab1ESGkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 02:40:36 -0400
Received: from snt0-omc2-s9.snt0.hotmail.com ([65.55.90.84]:49111 "EHLO
	snt0-omc2-s9.snt0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932304Ab1ESGkg convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 02:40:36 -0400
Received: from SNT124-W9 ([65.55.90.73]) by snt0-omc2-s9.snt0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 18 May 2011 23:40:35 -0700
X-Originating-IP: [27.32.25.138]
Importance: Normal
In-Reply-To: <4DD4B772.2050404@hupie.com>
X-OriginalArrivalTime: 19 May 2011 06:40:35.0240 (UTC) FILETIME=[A854D280:01CC15EF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173933>


Sorry; just thought I'd chime in as a "regular" git user; one who
actually has to read the documentation to figure things out instead just
knowing it because they helped code it.


> >> - could the manual page be update to make this explicit please? (plus
> >> other manual pages talking about (shell) patterns)
> >
> > The general design guideline we have is to use glob for things that look
> > like pathnames. Refs, refspecs, ignore and attribute rules are the
> > examples of this rule.
> >
>
> Well, to me tags do not look like pathnames at all, they're just
> 'random' strings. As are branches.
> Technically they may be like pathnames because they're projected on to
> the filesystem that way, but principally they're not IMHO: it's an
> implementation detail.

I must agree here. As a non-git-developer, I did not think of tags or 
branches as pathnames.


> > We may be lacking this info in our documentation. A patch to add it
> > somewhere is very welcome.
>
> Yesterday I already did a quick grep on pattern and glob in the
> documentation directory and found that:
> - usually patterns are just patterns, without specifying what kind
> - when a pattern type is specified it most of the time is a glob pattern
> - but sometimes it is called a shell pattern
> - and a few cases speak of a wildcard pattern (I think)
>
> What should it be?
> From your comments I gather it should be a glob pattern.
> Isn't glob too 'tech speak' or is it acceptable?
> If not acceptable, then what? Shell wildcard pattern?


I would not say that glod is too tech speak, as long is it was clearly 
explained somewhere easily accessible. If it's never explained, or 
buried deep within the manpage for some random command, then it 
certainly should not be assumed that the reader knows what it is.

Speaking of which, I'm still not too sure what a glob is.

Is there a "concepts" or "glossary" man page or similar somewhere that 
explains all the terms used in git that an "outsider" (somebody who does
not develop git and just began to use it) might not be aware of?

If there is not, might I suggest it be a good idea to include one as 
well references to it so that a rookie will know they should look there
for explanations of terms?


Tim.

() ascii ribbon campaign - against html e-mail
/\ www.asciiribbon.org - against proprietary attachments
 		 	   		  