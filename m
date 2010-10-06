From: Stephen Bash <bash@genarts.com>
Subject: Re: Trac+Git: rev-list with pathspec performance?
Date: Wed, 6 Oct 2010 11:26:44 -0400 (EDT)
Message-ID: <17750617.441668.1286378804923.JavaMail.root@mail.hq.genarts.com>
References: <m3r5g5fnth.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 06 17:27:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3VtV-0006S5-O5
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 17:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757940Ab0JFP0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 11:26:53 -0400
Received: from hq.genarts.com ([173.9.65.1]:24481 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756426Ab0JFP0w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 11:26:52 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 345191E26330;
	Wed,  6 Oct 2010 11:26:51 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ifXBZie+-w8e; Wed,  6 Oct 2010 11:26:45 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 013691E26300;
	Wed,  6 Oct 2010 11:26:45 -0400 (EDT)
In-Reply-To: <m3r5g5fnth.fsf@localhost.localdomain>
X-Mailer: Zimbra 6.0.7_GA_2473.UBUNTU8 (ZimbraWebClient - SAF3 (Mac)/6.0.7_GA_2473.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158292>

> Note that there is proof of concept
> "tree blame" (in Perl) which generates such 'last change to file'
> information, I think faster than running 'git rev-list -1 <file>' for
> each file. Even better would be to encode used algorithm in C.
> 
> http://thread.gmane.org/gmane.comp.version-control.git/150063/focus=150183

My early experiments with your script are good for speed, but for some reason I'm always getting the first commit for a file rather than the most recent.  I'll do some experimenting to see if I can uncover the issue.

(I had seen the script earlier, but I didn't realize the fix for diff-tree had made it into a release already) 

Thanks,
Stephen
