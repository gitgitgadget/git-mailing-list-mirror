From: Todd Wells <ttopwells@gmail.com>
Subject: fatal: ambiguous argument 'HEAD^': unknown revision or path not in the working tree.
Date: Thu, 28 Oct 2010 13:09:08 +0000 (UTC)
Message-ID: <loom.20101028T150254-457@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 28 15:20:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBSP0-0007q8-BE
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 15:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758690Ab0J1NUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 09:20:15 -0400
Received: from lo.gmane.org ([80.91.229.12]:59166 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758665Ab0J1NUN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 09:20:13 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PBSOi-0007ga-JN
	for git@vger.kernel.org; Thu, 28 Oct 2010 15:20:04 +0200
Received: from c-67-183-84-98.hsd1.wa.comcast.net ([67.183.84.98])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 15:20:04 +0200
Received: from ttopwells by c-67-183-84-98.hsd1.wa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 15:20:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 67.183.84.98 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_4; en-US) AppleWebKit/534.7 (KHTML, like Gecko) Chrome/7.0.517.41 Safari/534.7)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160174>

I was using GitX to prepare a commit. Something happened -- I don't 
know what --  and suddenly my branch only had a single commit 
in it that appears to contain all  the files in my tree. So I went to the 
command line and did this:

$ git reset --soft HEAD^ 
fatal: ambiguous argument 'HEAD^': unknown revision or path not 
in the working tree.

When I do 'git log' in this branch, there's only one commit. Now, I 
had many commits in this branch a few minutes ago. I really, 
really, don't want to lose this.

What steps should I take to attempt to recover?
