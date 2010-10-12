From: Christian Halstrick <christian.halstrick@gmail.com>
Subject: Can I checkout a single file without altering index?
Date: Tue, 12 Oct 2010 10:03:17 +0000 (UTC)
Message-ID: <loom.20101012T114900-532@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 12 12:10:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5boK-0007YL-Gv
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 12:10:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109Ab0JLKKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 06:10:06 -0400
Received: from lo.gmane.org ([80.91.229.12]:48231 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756995Ab0JLKKG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 06:10:06 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1P5bo3-0007T8-TX
	for git@vger.kernel.org; Tue, 12 Oct 2010 12:10:03 +0200
Received: from 155.56.68.215 ([155.56.68.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 12:10:03 +0200
Received: from christian.halstrick by 155.56.68.215 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 12:10:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 155.56.68.215 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/534.3 (KHTML, like Gecko) Chrome/6.0.472.63 Safari/534.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158828>

Can I checkout a certain file to a specific revision without also adding this 
content to the index? I only want to alter the working-tree - no modification of 
index or HEAD needed.

Here is why I need that: I see a bug in git controlled sources. I fix one source
file and also add one unit test in a separate file. I checked that the test
succeeds with my fix. The index now contains what I want to commit.
Now I want to see whether my test fails without my fix. I want to checkout HEAD
for the source file without destroying my index. In the end, after I saw that my
test fails without my fix, I just want to say "git commit" without having to.
