From: iani <zannos@gmail.com>
Subject: pushing to a remote branch that one does not own
Date: Wed, 19 Jan 2011 10:16:51 -0800 (PST)
Message-ID: <1295461011273-5940751.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 19 19:16:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfcaY-0001RW-8o
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 19:16:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123Ab1ASSQx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 13:16:53 -0500
Received: from sam.nabble.com ([216.139.236.26]:33552 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751471Ab1ASSQw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 13:16:52 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.69)
	(envelope-from <zannos@gmail.com>)
	id 1PfcaR-00077U-9V
	for git@vger.kernel.org; Wed, 19 Jan 2011 10:16:51 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165273>


Hello, 
I want to contribute via "push" to a branch which I have previously cloned
from a remote repository. There is a problem: 

If i create a new commit on branch "master", which coincides with
origin/master, then I can push this commit simply with
    git push
However, if i switch to a different branch of the repository which was
cloned, for example by doing:
    git checkout origin/lilt 
Then I get the message: 
"You are in 'detached HEAD' state. You can look around, make experimental
... (etc)"
So I HAVE to create my own new branch based on the one downloaded in order
to start committing and pushing changes. My question is therefore: 

Am I strictly limited to committing only on the master / origin/master
branched, and forced to make a new branch for every branch that I cloned
from the remote repo, or is there a way of making the heads of the remote
branches visible as local too? 

Thanks, 

Iannis Zannos


-- 
View this message in context: http://git.661346.n2.nabble.com/pushing-to-a-remote-branch-that-one-does-not-own-tp5940751p5940751.html
Sent from the git mailing list archive at Nabble.com.
