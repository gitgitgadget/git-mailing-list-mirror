From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 1/2] Avoid using the git wrapper in git-rebase.sh.
Date: Fri, 14 Jul 2006 19:28:41 -0400
Message-ID: <20060714232841.GA30169@spearce.org>
References: <20060714044655.GA1982@spearce.org> <7vpsg8qhj9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 15 01:28:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1X5U-00076b-OP
	for gcvg-git@gmane.org; Sat, 15 Jul 2006 01:28:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945912AbWGNX2p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Jul 2006 19:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945914AbWGNX2p
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 19:28:45 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:3233 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1945912AbWGNX2p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jul 2006 19:28:45 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G1X5F-0000bW-QE; Fri, 14 Jul 2006 19:28:33 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8E6AD20E462; Fri, 14 Jul 2006 19:28:41 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vpsg8qhj9.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23916>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > Ideally 'shipped' commands (e.g. git-rebase) should avoid calling
> > the git wrapper when executing other commands to prevent the user
> > from shadowing those commands with aliases and causing the shipped
> > command behavior to differ unexpectedly.
> 
> In order to avoid confusion, we made aliases not to shadow real
> commands, so this is not an argument to support this patch.

Doh.  I must have missed the emails which decided that...  For some
reason I remember only the emails discussing shadowing happening
but that internal stuff should use 'git-am' to prevent the shadowing
from occuring.  Thanks for the correction.

-- 
Shawn.
