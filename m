From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git building is borked
Date: Thu, 8 Mar 2007 10:13:02 -0500
Message-ID: <20070308151302.GC30674@spearce.org>
References: <4BBB354C-B000-4EF7-B3FF-7B2A4D6DE538@cam.ac.uk> <F0177878-0A2B-43B0-9838-E032FB3A0A58@cam.ac.uk> <20070308145532.GA30674@spearce.org> <C5E8BD06-1404-403B-88D0-F24F386A14AF@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anton Altaparmakov <aia21@cam.ac.uk>
X-From: git-owner@vger.kernel.org Thu Mar 08 16:13:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPKIr-0000cD-5E
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 16:13:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbXCHPNJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 10:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752083AbXCHPNI
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 10:13:08 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:50005 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077AbXCHPNH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 10:13:07 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HPKIc-0001BX-Od; Thu, 08 Mar 2007 10:12:58 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 961EB20FBAE; Thu,  8 Mar 2007 10:13:02 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <C5E8BD06-1404-403B-88D0-F24F386A14AF@cam.ac.uk>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41749>

Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> On 8 Mar 2007, at 14:55, Shawn O. Pearce wrote:
> >What version of Git specifically are you building with?  How did
> >you obtain these source files?
> 
> On my old workstation (Linux) which has the git git tree on it I  
> tarred up the files in the git directory (not including the .git  
> directory), then scp-ed the tar ball to my new workstation (OSX),  
> untarred it there and tried to build git to boot strap...

Since you solved your problem, this is more for the list archives
than anything:

Use `make dist` instead.  It uses your currently installed Git
to generate a tarball from the revision in HEAD, then appends in
the 4 critical files.  I use this all of the time (almost daily,
or close to it) to do builds of Git on Cygwin and Solaris 9.
In both cases I am building without `git` (or .git) available,
and am relying on just the output of `make dist`.
 
-- 
Shawn.
