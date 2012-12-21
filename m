From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Change in cvsps maintainership, abd a --fast-export option
Date: Fri, 21 Dec 2012 16:43:11 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121221214311.GA29147@thyrsus.com>
References: <20121220215638.E54BC44119@snark.thyrsus.com>
 <50D4199C.6000002@alum.mit.edu>
 <20121221104437.GA5244@thyrsus.com>
 <50D4B639.9000807@alum.mit.edu>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Dec 21 22:43:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmANk-0001Qz-2v
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 22:43:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794Ab2LUVnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 16:43:35 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:49207
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468Ab2LUVnd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 16:43:33 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 279C54411B; Fri, 21 Dec 2012 16:43:11 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <50D4B639.9000807@alum.mit.edu>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212012>

Michael Haggerty <mhagger@alum.mit.edu>:
> Perhaps your experience is with an older version of cvs2svn? 

Well, it has been at least four years since I ran it on anything.
Maybe that counts as old. 

I'm willing to believe it's working better now, but I've had to deal
with geological strata of nastiness older versions produced in various
Subversion repositories (cleaning up that crud was a major motivation
for reposurgeon) and I'm fairly sure I haven't seen the last such
fossils.  Every sufficiently old Subversion repository seems to have
few.

>                                                             If not,
> please be specific rather than just making complaints that are too vague
> to be rebutted or fixed (whichever is appropriate).  I put a *lot* of
> effort into getting cvs2svn to run correctly, and I take bug reports
> very seriously.

I can't be specific now, but that may change shortly.  I'm putting
together a test suite for cvsps with the specific intention of
capturing as many odd corner cases as I can.  (I just finished writing
a small Python framework for expressing interleaved CVS command
sequences on multiple checkouts in a way that can be easily run.)

It wouldn't be difficult for me to test whether these break cvs2svn. 
You've established that someone over there is paying attention, so
I'll do that, I guess.

I'm willing to share my test suite as well.  Do you have your own zoo
of odd cases I could test on?
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
