From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] gitweb: Show trailing slash when listing tree entry in tree listing
Date: Tue, 10 Oct 2006 11:15:22 +0200
Organization: At home
Message-ID: <egfo99$lg6$2@sea.gmane.org>
References: <7vy7ro7o3g.fsf@assigned-by-dhcp.cox.net> <20061010053841.42852.qmail@web31815.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Oct 10 11:17:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXDj6-0008Ic-Va
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 11:16:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965124AbWJJJQ3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 05:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965127AbWJJJQ2
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 05:16:28 -0400
Received: from main.gmane.org ([80.91.229.2]:25824 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965125AbWJJJQ1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Oct 2006 05:16:27 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GXDhY-0007vK-Ci
	for git@vger.kernel.org; Tue, 10 Oct 2006 11:15:04 +0200
Received: from host-81-190-27-91.torun.mm.pl ([81.190.27.91])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Oct 2006 11:15:04 +0200
Received: from jnareb by host-81-190-27-91.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Oct 2006 11:15:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-27-91.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28621>

Luben Tuikov wrote:

>> It probably is wise to resurrect those "redundant" links.
> 
> If someone does this, can they also remove the now "other"
> redundant link? (the link at the pathname itself) A simple
> code analyzer would show the duplicate code in gitweb.

Easy, easy now.


I'd rather add some more "hidden" links, but for each hidden
link (which are convenience only, to have larger are to click,
or to have closer area to click) I'd like to have clearly marked
link (marked as a link, i.e. using default link style; and with link text
denoting _kind_ of link) which leads to the same contents. 

For example on project list page I would made also project description
(and not only project name) clickable, leading tp project summary.
Making project name direct link wouldn't work for sites like kernel.org
with long (hierarchical) project names like
  linux/kernel/git/wim/linux-2.6-watchdog-experimental.git
And for other sites project name is/can be bit on the short side.

But we agreed (I guess) to disagree on the whole redundancy in user
interface issue (although I agree on the issue of reducing clutter).
BTW. we can reduce redundancy in the code without need for removing
"alternate entry points" in interface, I think.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
