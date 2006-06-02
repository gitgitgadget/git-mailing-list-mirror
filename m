From: Shawn Pearce <spearce@spearce.org>
Subject: Re: What's in git.git (part #2)
Date: Thu, 1 Jun 2006 22:35:45 -0400
Message-ID: <20060602023545.GA5039@spearce.org>
References: <7v64jli66m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 02 04:36:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlzW9-0006d1-An
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 04:36:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWFBCfv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Jun 2006 22:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWFBCfv
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jun 2006 22:35:51 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:22731 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751148AbWFBCft (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jun 2006 22:35:49 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FlzVg-00019s-Co; Thu, 01 Jun 2006 22:35:36 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EC2F020E445; Thu,  1 Jun 2006 22:35:45 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v64jli66m.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21135>

Junio C Hamano <junkio@cox.net> wrote:
>  - reflog from Shawn.  Do people find this useful?  I've enabled
>    reflog on "next" branch in my development repository to see
>    how useful it would be for myself a few days ago, and also in
>    a linux-2.6 repository I use for testing (I do not hack on
>    kernel myself).  

I find it useful to track what I've sent to you just in case I
screw up some ref somewhere.  I like knowing that if I perform a
bad update-ref call (which I'm prone to do sometimes) that I can
recover quickly as the log exists.

Not having that prior ref value was about the only area of `possible
data loss' that I've every really noticed with GIT.  Well, that and
only having one repository holding all of your important files and
you rm -rf the dang directory by accident one day...  but that's
just foolishness on the user's part.  :-)

>  - using ~/.gitrc to give a fall-back default when
>    $GIT_DIR/config does not have values.
> 
>  - command aliases and possibly default arguments via the
>    configuration file.

I'm certainly interested in these two - and I don't think I'm alone
when I say that.  :-)

-- 
Shawn.
