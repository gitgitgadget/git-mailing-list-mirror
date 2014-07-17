From: Yue Lin Ho <yuelinho777@gmail.com>
Subject: Re: git update-index not delete lock file when using different
 worktree
Date: Thu, 17 Jul 2014 01:27:08 -0700 (PDT)
Message-ID: <1405585628972-7615306.post@n2.nabble.com>
References: <1405567125455-7615300.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 10:27:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7h22-0002EE-Tw
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 10:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755285AbaGQI1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2014 04:27:11 -0400
Received: from sam.nabble.com ([216.139.236.26]:46673 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754585AbaGQI1J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2014 04:27:09 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <yuelinho777@gmail.com>)
	id 1X7h1w-0006pM-VZ
	for git@vger.kernel.org; Thu, 17 Jul 2014 01:27:08 -0700
In-Reply-To: <1405567125455-7615300.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253725>

I see that refresh() of update_index.c calls setup_work_tree() to change dir
to working tree.
And the dir is not changed back to git dir before commit_lock_file() or
rollback_lock_file() is called.

So, commit_lock_file() rename file failed.
or rollback_lock_file() delete file failed.



--
View this message in context: http://git.661346.n2.nabble.com/git-update-index-not-delete-lock-file-when-using-different-worktree-tp7615300p7615306.html
Sent from the git mailing list archive at Nabble.com.
