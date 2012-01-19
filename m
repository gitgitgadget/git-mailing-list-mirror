From: Mathieu CLAVEL <math.clavel@gmail.com>
Subject: [BUG ?] completion of stash name with git stash
Date: Thu, 19 Jan 2012 13:21:53 +0000 (UTC)
Message-ID: <loom.20120119T141601-606@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 19 14:25:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rnrzf-0002AH-4z
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 14:25:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756747Ab2ASNZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jan 2012 08:25:13 -0500
Received: from lo.gmane.org ([80.91.229.12]:43233 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752081Ab2ASNZM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2012 08:25:12 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RnrzL-00023w-Ba
	for git@vger.kernel.org; Thu, 19 Jan 2012 14:25:11 +0100
Received: from 249-137-167-83.reverse.alphalink.fr ([83.167.137.249])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Jan 2012 14:25:11 +0100
Received: from math.clavel by 249-137-167-83.reverse.alphalink.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Jan 2012 14:25:11 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 83.167.137.249 (Mozilla/5.0 (Windows NT 5.1; rv:9.0.1) Gecko/20100101 Firefox/9.0.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188810>

Hello,

I first posted that message on the group for msysgit [1].

====

I'm using mysgit 1.7.8 on XP.

I think the stash name completion has a problem.
I don't know if it's a problem from my system, mysgit or git.

Here are the steps to reproduce (you need to have at least 2 stashed commits).
'+ tab =>' means using the tab to autocomplete the current command. Left part is
before completion, right tab is after completion.

$ git stash list
stash@{0}: WIP on feature/preservation_offres: 7f2c9a8 import.cmd : import par
lot de 10.000 contrats
stash@{1}: WIP on feature/echeancier: ddb7bb0 Mockito : 1.8.5 -> 1.9.0

$ git stash drop '+ tab =>' $ git stash drop stash@{

$ git stash drop stash@{0 '+ tab =>' $ git stash drop stashstash@{0}

I don't know if it's relevant, but I also have 'git flow' and 'git flow
completion' installed, and as said in a previous thread, 'git flow completion'
isn't working with alias [2].

====

Regards,

Mathieu CLAVEL

[1] https://groups.google.com/d/topic/msysgit/AgGY7wl8IJQ/discussion
[2] https://groups.google.com/d/msg/msysgit/UnBHlY9eAK0/JfdH7q2hcsAJ
