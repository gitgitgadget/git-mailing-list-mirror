From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: fatal: serious inflate inconsistency
Date: Fri, 8 Jun 2007 21:33:19 +0200
Message-ID: <20070608193319.GS2335@cip.informatik.uni-erlangen.de>
References: <20070608110536.GD2335@cip.informatik.uni-erlangen.de> <alpine.LFD.0.99.0706080931330.12885@xanadu.home> <20070608135054.GK2335@cip.informatik.uni-erlangen.de> <20070608153722.GL2335@cip.informatik.uni-erlangen.de> <alpine.LFD.0.98.0706080959570.4205@woody.linux-foundation.org> <20070608182412.GQ2335@cip.informatik.uni-erlangen.de> <alpine.LFD.0.98.0706081136480.4205@woody.linux-foundation.org> <alpine.LFD.0.98.0706081202580.4205@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, GIT <git@vger.kernel.org>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jun 08 21:34:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwkDq-0006EL-DZ
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 21:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030563AbXFHTdZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 15:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967008AbXFHTdX
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 15:33:23 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:49302 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S970268AbXFHTdW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2007 15:33:22 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 5EC703F41F; Fri,  8 Jun 2007 21:33:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0706081202580.4205@woody.linux-foundation.org>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49495>

Hello Linus,

> It passes smaller clones fine with ElectricFence (and bigger ones fail 
> because EF uses *so* much memory for its checking that you cannot actually 
> complete them), so I don't think this is a git bug. Sounds like either the 
> hw problems are real, or there is some zlib (or other library) issue..

        (mailrelay) [/var/tmp] git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
        Initialized empty Git repository in /var/tmp/linux-2.6/.git/
        remote: Generating pack...
        remote: Done counting 496911 objects.
        remote: Deltifying 496911 objects...
        remote:  100% (496911/496911) done
        Indexing 496911 objects...
        remote: Total 496911 (delta 401539), reused 493712 (delta 398653)
        100% (496911/496911) done
        Resolving 401539 deltas...
        100% (401539/401539) done
        Checking 22413 files out...
        100% (22413/22413) done

I have a very similar machine. For this one it works. It has 32 bit kernel and
userland. Debian etch again. v2.6.20.

Does someone know a command for debian that checks the checksums for every
installed packages and the file that are included in that package?
I know there is one for rpm so there must be one for debian, too.

        Thomas
