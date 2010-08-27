From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: git pull --rebase differs in behavior from git fetch + git rebase
Date: Thu, 26 Aug 2010 20:59:13 -0600
Message-ID: <4C772A01.5030207@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 27 04:59:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OopA6-0005Wc-KR
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 04:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201Ab0H0C7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 22:59:14 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:54727 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774Ab0H0C7N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 22:59:13 -0400
Received: (qmail 31983 invoked by uid 399); 26 Aug 2010 20:59:12 -0600
Received: from unknown (HELO ?192.168.1.100?) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAM; 26 Aug 2010 20:59:12 -0600
X-Originating-IP: 76.27.116.215
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.8) Gecko/20100802 Lightning/1.0b2 Thunderbird/3.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154576>

  I have a case where 'git pull --rebase' does not do the Right Thing 
(according to me).

If I run 'git rebase origin/master', that rebase does the right thing, 
perfectly reapplying my *single* commit on top of the upstream.

'git pull --rebase' ends up reapplying a bunch of much earlier commits 
and ends up with a conflict.

The documentation for git pull --rebase states: "Instead of a merge, 
perform a rebase after fetching. If there is a remote ref for the 
upstream branch, and this branch was rebased since last fetched, the 
rebase uses that information to avoid rebasing non-local changes."  I do 
not understand

I'm studying the git-pull script right now, but I have to admit this is 
beyond me.  I'm sure if I stare hard enough, I'll get it.

I mistakenly have assumed 'git pull' = 'git fetch; git merge' and that 
'git pull --rebase' = 'git fetch; git rebase'.  Does anyone want to 
clarify what is really going on?  Unfortunately, I can't publish the 
repository in question.

Thanks!

Josh
