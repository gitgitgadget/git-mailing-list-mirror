From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: Compiling git on Solaris. Recipe included.
Date: Wed, 09 May 2012 13:58:46 -0400
Message-ID: <1336586103-sup-4584@pinkfloyd.chass.utoronto.ca>
References: <CADmdEsnSt5Do+EuJHzfGxNY6aCnGA6AF6fbEETAGpoL6p7Nuwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>
To: Mark Ashley <mark@ibiblio.org>
X-From: git-owner@vger.kernel.org Wed May 09 19:58:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSBA4-0006Bn-RI
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 19:58:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756685Ab2EIR6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 May 2012 13:58:48 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:35358 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754027Ab2EIR6r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 13:58:47 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:54761 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SSB9y-0003Ox-QB; Wed, 09 May 2012 13:58:46 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SSB9y-0006vV-P8; Wed, 09 May 2012 13:58:46 -0400
In-reply-to: <CADmdEsnSt5Do+EuJHzfGxNY6aCnGA6AF6fbEETAGpoL6p7Nuwg@mail.gmail.com>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197486>

Excerpts from Mark Ashley's message of Tue May 08 23:11:30 -0400 2012:

Hi Mark,

> I'm compiling git on Solaris 10 and 11 SPARC and X86 using the Sun
> Studio 12.x compilers.

I'm building for solaris 9+ at OpenCSW with the studio compilers.

> git doesn't compile out of the box, there are (see below) lots of
> tweaks to have it use open source stuff in /usr/local/* and also to
> pass some of the configure tests for inet_ntop and -lintl.

I use the following patch for -lintl:
https://gar.svn.sourceforge.net/svnroot/gar/csw/mgar/pkg/git/trunk/files/0007-on-solaris-we-need-to-use-lintl-to-allow-the-new-i18.patch

(For some reason, I didn't get around to generalizing it for
submission yet.)

The build recipe I'm using (for our build system GAR) is here:
https://gar.svn.sourceforge.net/svnroot/gar/csw/mgar/pkg/git/trunk/Makefile

(There is some baggage in the recipe that needs cleanup, such as old
patches that are merged or no longer required, but it builds a nice
clean package that passes the test suite.)

Hope that helps.

Thanks
-Ben
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
