From: "Art Haas" <ahaas@airmail.net>
Subject: Re: Problems importing SVN repo via git-svnimport
Date: Sat, 26 May 2007 10:10:46 -0500
Message-ID: <20070526151046.GA2239@artsapartment.org>
References: <20070526125553.GC10324@artsapartment.org> <20070526130643.GA2674@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Sat May 26 17:11:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hrxv4-0004TH-63
	for gcvg-git@gmane.org; Sat, 26 May 2007 17:11:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875AbXEZPK4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 11:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754050AbXEZPK4
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 11:10:56 -0400
Received: from ms-smtp-05.texas.rr.com ([24.93.47.44]:58503 "EHLO
	ms-smtp-05.texas.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875AbXEZPK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 11:10:56 -0400
Received: from pcdebian (cpe-68-201-223-150.houston.res.rr.com [68.201.223.150])
	by ms-smtp-05.texas.rr.com (8.13.6/8.13.6) with ESMTP id l4QFAqKm029236
	for <git@vger.kernel.org>; Sat, 26 May 2007 10:10:54 -0500 (CDT)
Received: (qmail 24904 invoked by uid 1000); 26 May 2007 15:10:47 -0000
Content-Disposition: inline
In-Reply-To: <20070526130643.GA2674@planck.djpig.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48475>

On Sat, May 26, 2007 at 03:06:43PM +0200, Frank Lichtenheld wrote:
> On Sat, May 26, 2007 at 07:55:53AM -0500, Art Haas wrote:
> > I'm happy to dive into the perl code in svnimport and make changes to
> > help debug this problem, if there is actually a problem and not user
> > error on my part. Any help from 'svnimport' experts will be greatly
> > appreciated. The public repo listed above has the same contents as my
> > local repo, so feel free to poke around it to see how things are
> > structured.
> 
> You might want to try git-svn instead. It should support everything you
> can do with git-svnimport and much more. Plus it is actively maintained
> which I wouldn't say about git-svnimport.

Hi.

The git-svn docs say that it serves as a bi-directionaly gateway
between git and svn, but that the main repo is a Subversion repository.
My goal with the PythonCAD repo is to convert it so that the main
repository is in git, and then I'm going to try to use git-svn to
push my changes into the now-secondary Subversion repo. This way, I can
make a distributed git repo available to developers wanting to
contribute to PythonCAD, plus keep the developers currently using
Subversion from having to make any changes if they either don't want to
or are unable to (i.e. windows developers/users).

Is git-svnimport maintenence on the wane?

Art Haas

Offtopic P.S.: Anyone know of a git mirror of the GCC repo, or do people
use git-svn to access that code via git?
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
