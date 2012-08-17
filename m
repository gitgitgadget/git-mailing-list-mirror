From: Stephen Bash <bash@genarts.com>
Subject: "Temporary merge branch 2" Conflicts
Date: Fri, 17 Aug 2012 09:48:45 -0400 (EDT)
Message-ID: <1972858401.161319.1345211324976.JavaMail.root@genarts.com>
References: <73388252.160741.1345208957127.JavaMail.root@genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 17 15:56:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2N2M-0002pc-4O
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 15:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240Ab2HQN4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 09:56:25 -0400
Received: from hq.genarts.com ([173.9.65.1]:39678 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755315Ab2HQN4X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 09:56:23 -0400
X-Greylist: delayed 452 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Aug 2012 09:56:23 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 8A29ABE1283
	for <git@vger.kernel.org>; Fri, 17 Aug 2012 09:48:50 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MrDGmh3LN3p3 for <git@vger.kernel.org>;
	Fri, 17 Aug 2012 09:48:45 -0400 (EDT)
Received: from mail.hq.genarts.com (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 09A23BE127D
	for <git@vger.kernel.org>; Fri, 17 Aug 2012 09:48:45 -0400 (EDT)
In-Reply-To: <73388252.160741.1345208957127.JavaMail.root@genarts.com>
X-Mailer: Zimbra 7.2.0_GA_2669 (ZimbraWebClient - GC21 (Mac)/7.2.0_GA_2669)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203614>

Hi all-

Given this branch history:

 ---------M------M---M-------> dev
     \   /      /   /
      --------------           v1-maint
            \   \   \
             ----M---M-------> v1.5-maint

I am attempting to merge v1.5-maint into dev.  There are some expected conflicts, but when I start mergetool (kdiff3) there are also a lot of conflict markers in the base that look like this

<<<<<<< Temporary merge branch 1
    ... code here ...
=======
    ... more code here ...
>>>>>>> Temporary merge branch 2

which confuse kdiff3.  Googling around I found a few mentions of these temporary merge branches, e.g. $gmane/157591, but I don't think we have any criss-cross merges.  Can anyone provide some advice?

Any suggestions are greatly appreciated!

Thanks,
Stephen
