From: Maaartin <grajcar1@seznam.cz>
Subject: Commiting automatically
Date: Fri, 24 Sep 2010 20:43:12 +0000 (UTC)
Message-ID: <loom.20100924T224155-693@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 24 22:43:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzF7D-00053n-LM
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 22:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755775Ab0IXUnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 16:43:23 -0400
Received: from lo.gmane.org ([80.91.229.12]:37690 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754990Ab0IXUnW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 16:43:22 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OzF72-0004wM-DK
	for git@vger.kernel.org; Fri, 24 Sep 2010 22:43:20 +0200
Received: from 188-120-198-113.luckynet.cz ([188-120-198-113.luckynet.cz])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 22:43:20 +0200
Received: from grajcar1 by 188-120-198-113.luckynet.cz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 22:43:20 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 188.120.198.113 (Opera/9.80 (Windows NT 5.2; U; en) Presto/2.6.30 Version/10.61)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157056>

I'm going to run periodically a process which uses the current working tree and 
I'd like to protocol what happens. As a part of the protocol I need the exact 
state of the working tree and that's what is git good for, right? But it must 
neither disturb my normal workflow nor interfere with my ordinal commits. I 
could probably use something like

GIT_DIR=a_special_git_dir
git reset --soft a_special_branch
git add -A
git commit -m "automatic"
git push

where the push would go to my ordinary external repository (used as a backup 
here). I'm quite a beginner and unsure what problem should I expect here.

Even if there were no problems, it's not very nice. It uses an additional 
repository which is quite strange. Moreover, there's no way to find out how the 
saved working tree snapshot is related to existing ordinal commits.


PS: I don't want to post separate "thank you" messages, so let me thank to 
everybody now. I've already had three questions and got three times a very 
helpful answer in a very short time, just fantastic.
