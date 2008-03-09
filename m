From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [jgit] index v2 pull request
Date: Sat, 8 Mar 2008 19:51:53 -0500
Message-ID: <20080309005153.GB8410@spearce.org>
References: <20080308025027.GZ8410@spearce.org> <fqtl2e$rvc$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 09 01:53:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY9mg-0003Rn-5G
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 01:53:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752017AbYCIAv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 19:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752014AbYCIAv5
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 19:51:57 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58230 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbYCIAv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 19:51:56 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JY9lQ-0002Il-Nh; Sat, 08 Mar 2008 19:51:44 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 89ED120FBAE; Sat,  8 Mar 2008 19:51:53 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <fqtl2e$rvc$1@ger.gmane.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76628>

Jakub Narebski <jnareb@gmail.com> wrote:
> Shawn O. Pearce wrote:
> 
> > Unfortunately the overall series diffstat doesn't show it
> > that way, but I think its now easier to follow how the control flows.
> 
> Isn't it the place then to put --dirstat instead of --diffstat?

Hmm.  Well, jgit is basically all in one directory right now,
so --dirstat wouldn't have shown a nice neat organization the
way you think it would.

I've started to create a new directory in jgit that contains
revision walking machinary.  So once that is complete then
yea, --dirstat may show the two different parts nicely, but
even then it still isn't very useful on this project.

-- 
Shawn.
