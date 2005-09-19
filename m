From: Pavel Roskin <proski@gnu.org>
Subject: Joining cg-*-id
Date: Mon, 19 Sep 2005 17:40:49 -0400
Message-ID: <1127166049.26772.26.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Sep 19 23:42:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHTO6-0005vv-7w
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 23:41:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932658AbVISVk6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 17:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932659AbVISVk6
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 17:40:58 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:60631 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932658AbVISVk5
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 17:40:57 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EHTNf-0001Tc-Vx
	for git@vger.kernel.org; Mon, 19 Sep 2005 17:40:56 -0400
Received: from proski by dv.roinet.com with local (Exim 4.52)
	id 1EHTNZ-0000f9-9e; Mon, 19 Sep 2005 17:40:49 -0400
To: Petr Baudis <pasky@suse.cz>, git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8912>

Hello!

I believe Cogito should keep the command list short.  When the *-id
utilities got the cg-prefix, the list became longer by 3 commands.

What if we join cg-commit-id, cg-parent-id and cg-tree-id into one cg-id
(or cg-admin-id) utility?  It would work like cg-commit-id in absence of
switches, -p would make it work like cg-parent-id, and -t would make it
cg-tree-id.

Alternatively, this functionality should go to git.  It's low-level
enough to be there.

-- 
Regards,
Pavel Roskin
