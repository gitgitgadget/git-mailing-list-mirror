From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 0/5] misc cleanups to path functions
Date: Tue, 04 Sep 2012 18:25:21 +0100
Message-ID: <50463981.2020701@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 21:07:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8ySo-0001QU-53
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 21:07:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932592Ab2IDTG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 15:06:59 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:40905 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932540Ab2IDTG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 15:06:58 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 2C31E128077;
	Tue,  4 Sep 2012 20:06:56 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 8AE9F128075;	Tue,  4 Sep 2012 20:06:55 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta009.tch.inty.net (Postfix) with ESMTP;	Tue,  4 Sep 2012 20:06:54 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204767>


Hi Junio,

These patches are from another unfinished branch. However, this
time I can't remember why it's unfinished! ;-)

ATB,
Ramsay Jones

Ramsay Jones (5):
  path.c: Remove the 'git_' prefix from a file scope function
  path.c: Don't discard the return value of vsnpath()
  path.c: Use vsnpath() in the implementation of git_path()
  Call git_pathdup() rather than xstrdup(git_path("..."))
  Call mkpathdup() rather than xstrdup(mkpath(...))

 bisect.c          |  2 +-
 builtin/add.c     |  3 ++-
 builtin/branch.c  |  2 +-
 builtin/clone.c   |  4 ++--
 builtin/prune.c   |  2 +-
 merge-recursive.c | 13 +++++++------
 path.c            | 28 ++++++++++------------------
 7 files changed, 24 insertions(+), 30 deletions(-)

-- 
1.7.12
