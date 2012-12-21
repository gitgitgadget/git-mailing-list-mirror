From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Change in cvsps maintainership, abd a --fast-export option
Date: Fri, 21 Dec 2012 05:44:37 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121221104437.GA5244@thyrsus.com>
References: <20121220215638.E54BC44119@snark.thyrsus.com>
 <50D4199C.6000002@alum.mit.edu>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Dec 21 11:45:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm06Q-00010B-BD
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 11:45:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011Ab2LUKpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 05:45:00 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:42749
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594Ab2LUKo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 05:44:58 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 576894411A; Fri, 21 Dec 2012 05:44:37 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <50D4199C.6000002@alum.mit.edu>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211963>

Michael Haggerty <mhagger@alum.mit.edu>:
> In 2009 I added tests demonstrating some of the erroneous behavior of
> git-cvsimport.  The failing tests in t9601-t9603 are concrete examples
> of the problems mentioned in the manpage.

Thanks, that will be extremely useful. One of the things I'm putting effort
into is building a good test suite for the tool; I may well be able to adapt
your tests directly.
>
> If you haven't yet seen it, there is a writeup of the algorithm used by
> cvs2git to infer the history of a CVS repository [1].  If your goal is
> to make cvsps more robust, you might want to consider the ideas
> described there.

I shall do so.  Their design ideas may well be interesting, even though I
don't trust their code.  I've seem cvs2svn drop far too many weird artifacts 
and just plain broken commits in the back history of Subversion repositories.
I don't know if this is due to design problems, implementation bugs, or both.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
