From: Ed Avis <eda@waniasset.com>
Subject: Feature: git stash pop --always-drop
Date: Mon, 10 Aug 2015 10:42:30 +0000 (UTC)
Message-ID: <loom.20150810T124037-407@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 12:42:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOkXa-0004dA-2a
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 12:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935236AbbHJKmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 06:42:42 -0400
Received: from plane.gmane.org ([80.91.229.3]:54411 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933793AbbHJKmj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 06:42:39 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZOkXN-0004Wv-H7
	for git@vger.kernel.org; Mon, 10 Aug 2015 12:42:37 +0200
Received: from 80.169.169.174 ([80.169.169.174])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 10 Aug 2015 12:42:37 +0200
Received: from eda by 80.169.169.174 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 10 Aug 2015 12:42:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 80.169.169.174 (Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:39.0) Gecko/20100101 Firefox/39.0 Cyberfox/39.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275607>

I would find it useful to ask 'git stash pop' to always drop the stash after
applying it to the working tree, even if there were conflicts.  (Only if there
was some hard error, such as an I/O error updating some of the files, should
the stash be left on the stack.)

Would a patch for such an --always-drop flag be accepted?

-- 
Ed Avis <eda@waniasset.com>
