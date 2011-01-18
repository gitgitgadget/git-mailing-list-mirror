From: Sebastian Hahn <mail@sebastianhahn.net>
Subject: gitk "find commit adding/removing string"/possible pickaxe bug?
Date: Tue, 18 Jan 2011 17:16:18 +0100
Message-ID: <514EB3AA-CD31-4BDB-B777-B7AAEEDF5663@sebastianhahn.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 18 17:26:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfEOT-0003m8-4y
	for gcvg-git-2@lo.gmane.org; Tue, 18 Jan 2011 17:26:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428Ab1ARQ0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jan 2011 11:26:48 -0500
Received: from sebastianhahn.net ([78.47.18.109]:41036 "EHLO sebastianhahn.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752326Ab1ARQ0r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jan 2011 11:26:47 -0500
X-Greylist: delayed 627 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Jan 2011 11:26:47 EST
Received: from [192.168.178.27] (port-92-194-203-88.dynamic.qsc.de [92.194.203.88])
	by sebastianhahn.net (Postfix) with ESMTPSA id 0BD9714E4004
	for <git@vger.kernel.org>; Tue, 18 Jan 2011 17:16:19 +0100 (CET)
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165205>

Hi,

I quite like gitk and am a fan of the ability to easily locate commits
where a specific string was added/removed. If the string in question
was added in a merge commit as part of a conflicted/otherwise
changed merge, gitk doesn't display it.

(If you want to reproduce, the repository is git://git.torproject.org/ 
tor,
the string I'm looking for is "< DIGEST" and the first commit I hope to
find is ed87738ede789fb).

I presented the issue to #git, and it was suggested that it is probably
a pickaxe bug in that it doesn't display changes in merge commits if
they add strings that neither of their parents has.

Do you agree that this is a bug, or am I missing anything here?

Thanks for you consideration!

Sebastian
