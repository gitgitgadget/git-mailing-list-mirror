From: Avi Kivity <avi@qumranet.com>
Subject: Re: git merge and merge message
Date: Sun, 11 Mar 2007 22:31:15 +0200
Message-ID: <45F46713.6030702@qumranet.com>
References: <200703111505.l2BF54Kq006625@localhost.localdomain>
 <20070311160424.GA629@fieldses.org>
 <200703111815.l2BIFHbq010315@localhost.localdomain>
 <Pine.LNX.4.64.0703111309410.9690@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: Xavier Maillard <zedek@gnu.org>,
	"J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Mar 11 21:31:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQUhP-0007av-A0
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 21:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbXCKUbS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 16:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbXCKUbS
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 16:31:18 -0400
Received: from mtaout4.012.net.il ([84.95.2.10]:11025 "EHLO mtaout4.012.net.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751048AbXCKUbR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 16:31:17 -0400
Received: from firebolt.argo.co.il ([80.178.147.45])
 by i_mtaout4.012.net.il (HyperSendmail v2004.12)
 with ESMTP id <0JER001EEAPJBM31@i_mtaout4.012.net.il> for git@vger.kernel.org;
 Sun, 11 Mar 2007 22:39:20 +0200 (IST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by firebolt.argo.co.il (Postfix) with ESMTP id 4136DC0329; Sun,
 11 Mar 2007 22:31:15 +0200 (IST)
In-reply-to: <Pine.LNX.4.64.0703111309410.9690@woody.linux-foundation.org>
X-Greylist: Sender IP whitelisted,
 not delayed by milter-greylist-2.1.12 (firebolt.argo.co.il [0.0.0.0]); Sun,
 11 Mar 2007 22:31:15 +0200 (IST)
User-Agent: Thunderbird 1.5.0.9 (X11/20070212)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41976>

Linus Torvalds wrote:
> Comments? Do people think it would be a good idea to do
>
> 	git merge --no-fast-forward -m "Merge feature Xyz" xyz-branch
>
> as an option?
>
>   

Actually there's at least one tree where this should be activated -- 
yours.  If you perform a fast-forward merge, there's no record of the 
merge, no record of which tree was pulled, and no sign-off from you.  
The commits just appear there.  It partially defeats the sign-off system.

This feature would be good for top-level trees and for major subsystem 
trees IMO.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.
