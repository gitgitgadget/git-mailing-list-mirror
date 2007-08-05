From: Miles Bader <miles@gnu.org>
Subject: git-diff new files (without using index)
Date: Sun, 05 Aug 2007 12:42:02 +0900
Message-ID: <87wswalkad.fsf@catnip.gol.com>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 05:42:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHX0C-0002pV-Qw
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 05:42:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760583AbXHEDlr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 23:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757631AbXHEDlq
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 23:41:46 -0400
Received: from smtp02.dentaku.gol.com ([203.216.5.72]:37693 "EHLO
	smtp02.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756106AbXHEDlq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 23:41:46 -0400
X-Greylist: delayed 619 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 Aug 2007 23:41:45 EDT
Received: from 203-216-96-074.dsl.gol.ne.jp ([203.216.96.74] helo=catnip.gol.com)
	by smtp02.dentaku.gol.com with esmtpa (Dentaku)
	id 1IHWzw-00080t-Az; Sun, 05 Aug 2007 12:41:44 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id B3170300F; Sun,  5 Aug 2007 12:42:02 +0900 (JST)
System-Type: i686-pc-linux-gnu
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54927>

One thing I often want to do is generate a complete diff of all changes,
including new/removed files.

If I add things to the index, I can use "git-diff --cached" to do it;
however I'd actually like to be able to do this _without_ updating the
index; in other words, any un-added new file as a change.  As it is, the
"non-indexed" state seems kind of a second-class citizen, as you can
never have new files there (or rather, git will never really see them).

Is there anyway to do this currently?  If not, maybe something like a
"git-diff -N" (mirroring diff's -N/--new-file option) option could be
added to do this?

Thanks,

-Miles
-- 
=====
(^o^;
(()))
*This is the cute octopus virus, please copy it into your sig so it can spread.
