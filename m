From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: [PATCH] Detect renames in diff family.
Date: Thu, 19 May 2005 10:46:06 -0700
Message-ID: <20050519174606.GF22946@ca-server1.us.oracle.com>
References: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 19:49:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYp7g-0001HT-Gj
	for gcvg-git@gmane.org; Thu, 19 May 2005 19:47:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVESRsX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 13:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVESRsX
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 13:48:23 -0400
Received: from rgminet01.oracle.com ([148.87.122.30]:14425 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S261195AbVESRqX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2005 13:46:23 -0400
Received: from rgmgw1.us.oracle.com (rgmgw1.us.oracle.com [138.1.191.10])
	by rgminet01.oracle.com (Switch-3.1.6/Switch-3.1.6) with ESMTP id j4JHk7Yw015375;
	Thu, 19 May 2005 11:46:07 -0600
Received: from rgmgw1.us.oracle.com (localhost [127.0.0.1])
	by rgmgw1.us.oracle.com (Switch-3.1.4/Switch-3.1.0) with ESMTP id j4JHk7nU026625;
	Thu, 19 May 2005 11:46:07 -0600
Received: from ca-server1.us.oracle.com (ca-server1.us.oracle.com [139.185.118.41])
	by rgmgw1.us.oracle.com (Switch-3.1.4/Switch-3.1.0) with ESMTP id j4JHk63u026612;
	Thu, 19 May 2005 11:46:07 -0600
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.50)
	id 1DYp5y-0001P6-NW; Thu, 19 May 2005 10:46:06 -0700
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, May 19, 2005 at 09:19:28AM -0700, Linus Torvalds wrote:
> In other words, let's say that we create a new architecture or a new 
> filesystem, and we have tons of _new_ files, but not a lot of removed 
> files. It would literally be very cool to see that the new files are based 
> on contents of old files, and that it would thus potentially be very 
> interesting to see a diff like

	Subversion encourages exactly this with the 'svn cp' command.
Just as knowing when a file was renamed allows you to track the history
past its first appearance under the current name, 'cp' allows you to
follow the history even if the original name still exists.  I have found
this useful more than once.
	Now, whether you track this up front with an expensive commit or
use tools to discover the relationship at query time (ala your
why-rename-tracking-isnt-needed argument) is a different question.  As
we all know, most tools ask the user to explicitly declare the
relationship at the time it happens with 'svn rename' and 'svn cp' or
the analog.  But git could do the comparisons, with appropriate
heuristics, at the time someone asks.

Joel

-- 

Life's Little Instruction Book #335

	"Every so often, push your luck."

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
