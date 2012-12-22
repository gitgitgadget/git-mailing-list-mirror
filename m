From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: Re: Change in cvsps maintainership, abd a --fast-export
 option
Date: Sat, 22 Dec 2012 14:04:52 +0100
Message-ID: <20121222130452.GB13549@book-mint>
References: <20121220215638.E54BC44119@snark.thyrsus.com>
 <50D4199C.6000002@alum.mit.edu>
 <20121221104437.GA5244@thyrsus.com>
 <20121222034751.GA11635@book-mint>
 <20121222062118.GA31331@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Sat Dec 22 14:05:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmOlP-0004LG-N4
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 14:05:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168Ab2LVNE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2012 08:04:58 -0500
Received: from smtprelay05.ispgateway.de ([80.67.31.99]:37936 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091Ab2LVNE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2012 08:04:57 -0500
Received: from [77.21.76.22] (helo=localhost)
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1TmOl3-0002qg-5w; Sat, 22 Dec 2012 14:04:53 +0100
Content-Disposition: inline
In-Reply-To: <20121222062118.GA31331@thyrsus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212047>

Hi,

On Sat, Dec 22, 2012 at 01:21:18AM -0500, Eric S. Raymond wrote:
> Heiko Voigt <hvoigt@hvoigt.net>:
> > Back then when I was converting some repositories to git and I also
> > wrote a quick testsuite for cvsps in an attempt to fix the bugs but gave
> > up. That was the point when I wrote about cvsimports limitations in the
> > documentation.
> > 
> > My commits can be found here:
> > 
> > 	http://repo.or.cz/w/cvsps-hv.git
> > 
> > I just quickly checked and it seems that it does not run cleanly on a
> > modern Linux anymore. If it is of interest to you I can try to get it
> > running again.
> 
> That would be helpful.  Please give it some effort.

Here you go. I have pushed my changes on the master branch there.

You should now be able to run my tests with

	make test

from the root directory of the repository. The expected and actual
output can be found in the t[0-9]{4}... directories underneath t/.

Cheers Heiko
