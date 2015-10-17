From: =?utf-8?b?S2jhuqNp?= <hvksmr1996@gmail.com>
Subject: Git bug report: git doesn't change working directory
Date: Sat, 17 Oct 2015 01:43:45 +0000 (UTC)
Message-ID: <loom.20151017T034154-956@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 17 03:50:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZnGdf-0001ZS-8G
	for gcvg-git-2@plane.gmane.org; Sat, 17 Oct 2015 03:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752308AbbJQBuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 21:50:23 -0400
Received: from plane.gmane.org ([80.91.229.3]:34558 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751968AbbJQBuW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 21:50:22 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZnGdH-00017U-W0
	for git@vger.kernel.org; Sat, 17 Oct 2015 03:50:14 +0200
Received: from 42.119.173.152 ([42.119.173.152])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 17 Oct 2015 03:50:03 +0200
Received: from hvksmr1996 by 42.119.173.152 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 17 Oct 2015 03:50:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 42.119.173.152 (Mozilla/5.0 (Windows NT 10.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.71 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279778>

I'm using Windows 10. Before I install git 2.6.1.windows.1, I have 
installed git 1.9.5.github.0 (by installing GitHub Desktop), it works just 
fine.
But when I installed git 2.6.1.windows.1 (from git-scm.com), I'm not able 
to use git anymore:
 - The powershell console displayed [(unknown)] instead of [master], even 
when I changed working directory to my project, it still display 
[(unknown)]
 - When I "git add" (or "git commit", "git push"), It told me an error: 
"fatal: Not a git repository: 'C:\Program Files\Git'"
After that, I returned to the old version of git - git 1.9.5.github.0, but 
the fault still there.
I think git didn't change its working directory, I have no idea.
Now, I'm not able to work with git.
Please response me as soon as possible, thanks.
