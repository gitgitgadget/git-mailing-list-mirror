From: Uri Moszkowicz <uri@4refs.com>
Subject: Sparse checkouts
Date: Sun, 7 Nov 2010 02:04:06 +0000 (UTC)
Message-ID: <loom.20101107T030122-536@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 07 03:10:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEui1-0002bY-1q
	for gcvg-git-2@lo.gmane.org; Sun, 07 Nov 2010 03:10:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159Ab0KGCKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Nov 2010 22:10:06 -0400
Received: from lo.gmane.org ([80.91.229.12]:37607 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751453Ab0KGCKF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Nov 2010 22:10:05 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PEuho-0002Ul-Hg
	for git@vger.kernel.org; Sun, 07 Nov 2010 03:10:04 +0100
Received: from c-24-147-64-86.hsd1.ma.comcast.net ([24.147.64.86])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 07 Nov 2010 03:10:04 +0100
Received: from uri by c-24-147-64-86.hsd1.ma.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 07 Nov 2010 03:10:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 24.147.64.86 (Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.7 (KHTML, like Gecko) Chrome/7.0.517.44 Safari/534.7)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160864>

Hi,
I'm working with a repository with a very large number of files and Git is 
appealing because it officially supports sparse checkouts unlike the other 
DVCS tools. However, all of the usage examples that I've come across have 
you checkout the full repository and then prune the undesired files as such:

  git clone <dir>
  git config core.sparsecheckout true
  echo "<dir>/" > .git/info/sparse-checkout
  git read-tree -m -u HEAD

I tried adding "-n" to the clone command but then none of the missing 
directories are checked out by read-tree. I can manually check them out 
and everything seems to work fine but I can also manually check out a bunch 
of other directories and read-tree, reset, etc all seem to ignore the extra 
directory even though they aren't specified in the sparse-checkout file. Is 
this use mode just not well supported by git yet or am I missing something? 
I'm new to Git so I don't expect to be able to figure it out easily and I 
haven't been able to find the answer elsewhere.

Thanks,
Uri
