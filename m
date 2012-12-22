From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: Change in cvsps maintainership, abd a --fast-export option
Date: Sat, 22 Dec 2012 04:47:51 +0100
Message-ID: <20121222034751.GA11635@book-mint>
References: <20121220215638.E54BC44119@snark.thyrsus.com>
 <50D4199C.6000002@alum.mit.edu>
 <20121221104437.GA5244@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Sat Dec 22 04:48:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmG4K-0001SH-QG
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 04:48:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417Ab2LVDrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 22:47:55 -0500
Received: from smtprelay02.ispgateway.de ([80.67.31.36]:34314 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab2LVDry (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 22:47:54 -0500
Received: from [77.21.76.22] (helo=localhost)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1TmG3z-0006ZV-Hb; Sat, 22 Dec 2012 04:47:51 +0100
Content-Disposition: inline
In-Reply-To: <20121221104437.GA5244@thyrsus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212024>

Hi,

On Fri, Dec 21, 2012 at 05:44:37AM -0500, Eric S. Raymond wrote:
> Michael Haggerty <mhagger@alum.mit.edu>:
> > In 2009 I added tests demonstrating some of the erroneous behavior of
> > git-cvsimport.  The failing tests in t9601-t9603 are concrete examples
> > of the problems mentioned in the manpage.
> 
> Thanks, that will be extremely useful. One of the things I'm putting effort
> into is building a good test suite for the tool; I may well be able to adapt
> your tests directly.

Back then when I was converting some repositories to git and I also
wrote a quick testsuite for cvsps in an attempt to fix the bugs but gave
up. That was the point when I wrote about cvsimports limitations in the
documentation.

My commits can be found here:

	http://repo.or.cz/w/cvsps-hv.git

I just quickly checked and it seems that it does not run cleanly on a
modern Linux anymore. If it is of interest to you I can try to get it
running again.

Cheers Heiko
