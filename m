From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Proposed git mv behavioral change
Date: Thu, 18 Oct 2007 23:19:59 -0400
Message-ID: <20071019031959.GE14735@spearce.org>
References: <c594999b2337.2337c594999b@nyroc.rr.com> <20071019015419.GV14735@spearce.org> <A2C1BF08-4CC8-4F98-9CA8-B81B2FBFE9E4@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Fri Oct 19 05:20:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiiPH-0007aw-6X
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 05:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758320AbXJSDUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 23:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757604AbXJSDUE
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 23:20:04 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44598 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205AbXJSDUD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 23:20:03 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IiiOn-0001l3-Tu; Thu, 18 Oct 2007 23:19:45 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1144320FBAE; Thu, 18 Oct 2007 23:20:00 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <A2C1BF08-4CC8-4F98-9CA8-B81B2FBFE9E4@mit.edu>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61627>

Michael Witten <mfwitten@MIT.EDU> wrote:
> 
> On 18 Oct 2007, at 9:54:19 PM, Shawn O. Pearce wrote:
> 
> >Elsewhere in git we use the --cached command line option to mean
> >"only make the change in the index".
> 
> It seems like --cached should be phased out in favor of --index/ed

No, --index is something else.

But I was originally *way* wrong to propose --cached for this usage
in git-mv.  --cached means "apply *ONLY* to the index" and "do *NOT*
touch the working tree".  Here we want to touch the working tree
in the sense of moving the file.  So --cached is not the correct
option name.

--index is used in Git for places were we update *both* the index
and the working directory (git-apply --index).  So actually I should
have suggested "git-mv --index".  Whoops.

-- 
Shawn.
