From: Andrey Hsiao <andreyhsiao@gmail.com>
Subject: Git merge commit message issue
Date: Mon, 6 Jul 2015 15:41:18 +0000 (UTC)
Message-ID: <loom.20150706T173729-880@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 17:45:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZC8ab-0008Tv-Q1
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 17:45:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755606AbbGFPpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 11:45:14 -0400
Received: from plane.gmane.org ([80.91.229.3]:37764 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753706AbbGFPpI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 11:45:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZC8Zs-00081d-UK
	for git@vger.kernel.org; Mon, 06 Jul 2015 17:45:05 +0200
Received: from 67.229.234.204.static.krypt.com ([67.229.234.204.static.krypt.com])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 17:45:04 +0200
Received: from andreyhsiao by 67.229.234.204.static.krypt.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 17:45:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 67.229.234.204 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.130 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273390>

Dear list:

In the past, when we do the merge in git, if conflicts occurred, 
when we commit, the conflict list will be appended to 
the default commit message automatically.

eg:
Conflicts:
....a.java
....b.java

Today, after using Git 2.3.0 for a merge, it seems now the conflict list
 was commented out by default.

I just searched a bit in the release notes, 
don't know whether below item has to do with this change.

----
"git interpret-trailers" learned to properly handle the "Conflicts:" 
block at the end.
----

We quite rely on the default generated conflict list 
to reminder us about the "history".

Is this the default behavior now (conflict list commented out)?

Thanks
Best Regards
