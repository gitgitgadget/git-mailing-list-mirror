From: cl@qgenuity.com
Subject: Cloning or pushing only files that have been updated
Date: Sun, 26 Apr 2015 06:17:09 +0900
Message-ID: <054116d47b69ca56f3369369df9fb4d8.squirrel@www.qgenuity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 25 23:23:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ym7Xq-0005Az-8L
	for gcvg-git-2@plane.gmane.org; Sat, 25 Apr 2015 23:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbbDYVXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2015 17:23:13 -0400
Received: from vps-1015933-8657.cp.tsukaeru.ne.jp ([175.45.136.198]:41546 "EHLO
	vps-1015933-8657.cp.tsukaeru.ne.jp" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750727AbbDYVXM (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Apr 2015 17:23:12 -0400
X-Greylist: delayed 361 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Apr 2015 17:23:12 EDT
Received: from www.qgenuity.com (localhost [IPv6:::1])
	by vps-1015933-8657.cp.tsukaeru.ne.jp (Postfix) with ESMTPA id AEE5E29E0034
	for <git@vger.kernel.org>; Sun, 26 Apr 2015 06:17:09 +0900 (JST)
Received: from 175.45.136.198
        (SquirrelMail authenticated user cl@qgenuity.com)
        by www.qgenuity.com with HTTP;
        Sun, 26 Apr 2015 06:17:09 +0900
User-Agent: SquirrelMail/1.4.22-4.el6
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267800>

Hi,

I have two sets of files.

A_Old is a large unversioned directory tree containing many files.

A_Updated is a git repository containing the files from A_Old, some of
which have been modified. A_Updated also contains new files.

I am looking for a way of cloning only the new or modified files from
A_Updated to A_Old. I would like A_Old to become a clone of A_Updated,
however I don't want to download the entire archive because of access
speed issues.

Timestamps on all files are accurate.

Any ideas?

- J
