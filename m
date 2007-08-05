From: Miles Bader <miles@gnu.org>
Subject: way to automatically add untracked files?
Date: Sun, 05 Aug 2007 12:31:42 +0900
Message-ID: <873ayymzc1.fsf@catnip.gol.com>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 05:50:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHX8T-0003yF-E4
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 05:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760583AbXHEDuW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 23:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757631AbXHEDuW
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 23:50:22 -0400
Received: from smtp02.dentaku.gol.com ([203.216.5.72]:59764 "EHLO
	smtp02.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938AbXHEDuV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 23:50:21 -0400
Received: from 203-216-96-074.dsl.gol.ne.jp ([203.216.96.74] helo=catnip.gol.com)
	by smtp02.dentaku.gol.com with esmtpa (Dentaku)
	id 1IHWpw-0007Ar-HP; Sun, 05 Aug 2007 12:31:24 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 78735300F; Sun,  5 Aug 2007 12:31:41 +0900 (JST)
System-Type: i686-pc-linux-gnu
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54928>

One thing I often want to do is git-add all untracked files, and also
automatically git-rm all "disappeared" files (I keep my .gitignore files
well maintained, so the list of adding/missing files shown by git status
is almost always correct).  At the same time, I usually want to do "git
add -u" to git-add modified files.

One way to do this seems to be just "git add .", but I'm always slightly
nervous using it because it sits there and churns the disk for an awful
long time (whereas "git status" is instantaneous).  Is this the right
thing to do?  Is there something funny causing the churning?

Thanks,

-Miles

-- 
Saa, shall we dance?  (from a dance-class advertisement)
