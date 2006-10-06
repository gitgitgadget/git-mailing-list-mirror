From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] ref-log: allow ref@{count} syntax.
Date: Fri, 6 Oct 2006 12:05:21 -0400
Message-ID: <20061006160521.GA20024@spearce.org>
References: <7vsli20y1c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 06 18:05:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVsCj-0001mz-Et
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 18:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbWJFQFa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 12:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422688AbWJFQF3
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 12:05:29 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:53211 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751543AbWJFQF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Oct 2006 12:05:27 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GVsCN-0001DL-Bn; Fri, 06 Oct 2006 12:05:19 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CE07420E490; Fri,  6 Oct 2006 12:05:21 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vsli20y1c.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28412>

Junio C Hamano <junkio@cox.net> wrote:
> Often I find myself wanting to say 'tip of "next" before I
> merged the last three topics'.  Now I can say that with:
> 
> 	git log next@{3}..next
> 
> Since small integers alone are invalid input strings to
> approxidate, there is no fear of confusion.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> ---
> 
>  * The implementation is rather hacky but I think this is
>    mildly useful.  Likes, dislikes?

Ack'd.

Its a useful feature. Something I've been wanting myself for
some time.  I usually just guess with '@{5.minutes.ago}' or some
nonsense until I find the right time.  But since I know it was X
operations ago, '@{X}' will be very handy.  Thanks!

-- 
Shawn.
