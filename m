From: Alexander Skwar <listen@alexander.skwar.name>
Subject: Managing /etc with git: Store ownership and time in git?
Date: Thu, 1 Nov 2007 12:55:57 +0000 (UTC)
Message-ID: <loom.20071101T123817-247@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 01 14:05:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InZjo-0004zw-Pz
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 14:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756794AbXKANFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 09:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753749AbXKANFR
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 09:05:17 -0400
Received: from main.gmane.org ([80.91.229.2]:33875 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756794AbXKANFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 09:05:16 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1InZjK-0004Dj-7r
	for git@vger.kernel.org; Thu, 01 Nov 2007 13:05:02 +0000
Received: from zy-rieter.cyberlink.ch ([212.55.215.153])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Nov 2007 13:05:02 +0000
Received: from listen by zy-rieter.cyberlink.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Nov 2007 13:05:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 212.55.215.153 (Mozilla/5.0 (X11; U; Linux i686; de; rv:1.8.1.8) Gecko/20071023 Firefox/2.0.0.8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62951>

Hello.

I'd like to use git to manage the /etc directories of some servers.
What's quite nice with git (in comparison to svn) is, that it
out-of-the-box stores the permissions of a file. But it doesn't seem
like it stores the ownership (ie. user/group) of tracked content.
Does anyone know how to cope with that "problem"?

Oh, and it also seems that Git doesn't store the time information of
files, does it? For tracking /etc, this would be very useful. Would
anyone have a solution for this as well?

What I'm thinking about right now is, to write a "hook" script which
"dumps" the stats of the to-be added files in some "index" file. But
that seems like a rather clumsy soltion...

It would be great of someone could maybe share his solution!

Thanks a lot,
Alexander
