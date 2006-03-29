From: Mark Wooding <mdw@distorted.org.uk>
Subject: Re: [PATCH] xdiff: Show function names in hunk headers.
Date: Wed, 29 Mar 2006 09:57:47 +0000 (UTC)
Organization: Straylight/Edgeware development
Message-ID: <slrne2kmgq.s3g.mdw@metalzone.distorted.org.uk>
References: <11435126113456-git-send-email-mdw@distorted.org.uk> <7vfyl3m7vy.fsf@assigned-by-dhcp.cox.net> <slrne2ik1i.s3g.mdw@metalzone.distorted.org.uk> <7v4q1ihzio.fsf@assigned-by-dhcp.cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 29 11:58:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOXR3-0000xB-5N
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 11:57:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbWC2J5t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Mar 2006 04:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWC2J5t
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Mar 2006 04:57:49 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:25445 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1751029AbWC2J5t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Mar 2006 04:57:49 -0500
Received: (qmail 30757 invoked by uid 110); 29 Mar 2006 09:57:47 -0000
To: git@vger.kernel.org
Received: (qmail 30744 invoked by uid 9); 29 Mar 2006 09:57:47 -0000
Path: not-for-mail
Newsgroups: mail.vger.git
NNTP-Posting-Host: metalzone.distorted.org.uk
X-Trace: metalzone.distorted.org.uk 1143626267 30742 172.29.199.2 (29 Mar 2006 09:57:47 GMT)
X-Complaints-To: usenet@distorted.org.uk
NNTP-Posting-Date: Wed, 29 Mar 2006 09:57:47 +0000 (UTC)
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18163>

Junio C Hamano <junkio@cox.net> wrote:

> Asciidoc?
>
>         . enumerated one
>           this is one item

I thought about this, and decided that missing these was a good thing,
because item heads are probably too low-level.  I'd rather go for
section or subsection headings.

> It's just a heuristic, so there are only two things we could
> sensibly do.  Either we keep it absolutely stupid to save our
> code and sanity, or we give full configurability via -F regexp
> to the end users.

I'm already thinking about that...

-- [mdw]
