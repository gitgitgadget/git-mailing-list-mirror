From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Tue, 11 Dec 2012 22:30:43 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121212033043.GA24937@thyrsus.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
 <CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
 <50B1F684.5020805@alum.mit.edu>
 <CACsJy8BgOpWdxgCfwBwZ=abAEDr+sbj3hnmKY2EYCFeBPRUT7w@mail.gmail.com>
 <CACh33FrGPhaeNzZ2Tj5OxScecOPN13idw8TwU8Mf6o0KsAOB9A@mail.gmail.com>
 <CAMK1S_hy8U0rVY=-u-QCqXjhn-6jwz5ofj_q_mbokVn8CGCMtw@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Patrick Donnelly <batrick@batbytes.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 04:31:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tid2I-0007s1-72
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 04:31:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754127Ab2LLDat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2012 22:30:49 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:60452
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853Ab2LLDas (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2012 22:30:48 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id D995944029; Tue, 11 Dec 2012 22:30:43 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAMK1S_hy8U0rVY=-u-QCqXjhn-6jwz5ofj_q_mbokVn8CGCMtw@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211324>

Sitaram Chamarty <sitaramc@gmail.com>:
> [snipping the rest; all valid points no doubt]

I meant to respond to Patrick's post earlier.

I haven't actually written any code in lua yet, but I've read the book;
I think I get it.  I've seen the effects of lua integration on another
large project, Battle for Wesnoth.

I'm not, despite conclusions some people here might have jumped to,
religiously attached to Python.  So I can say this: I think lua as a
language is an *excellent* design.  It is clever, economical,
minimalist, and (other than the one ugly detail of 1-origin indexing)
shows consistent good taste.

It might be a good fit for extending git; I wouldn't be very surprised if
that worked. However, I do have concerns about the "Oh, we'll just
lash together a binding to C" attitude common among lua programmers; I
foresee maintainability problems and the possibility of slow death by
low-level details as that strategy tries to scale up.

And, of course, one problem with calling back into C a lot is that
you walk back into C's resource-management issues.

My sense is that git's use cases are better served by a glue language
in the Python/Perl/Ruby class rather than an extension langage. But
my mind is open on this issue.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
