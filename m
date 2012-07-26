From: Defcon0 <patzer.dennis@googlemail.com>
Subject: Question concerning merge behavior
Date: Thu, 26 Jul 2012 04:30:34 -0700 (PDT)
Message-ID: <1343302234333-7563780.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 13:30:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuMHA-0007E6-1f
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 13:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113Ab2GZLaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 07:30:35 -0400
Received: from sam.nabble.com ([216.139.236.26]:49968 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750766Ab2GZLae (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 07:30:34 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <patzer.dennis@googlemail.com>)
	id 1SuMH4-0000IE-B3
	for git@vger.kernel.org; Thu, 26 Jul 2012 04:30:34 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202254>

Hello,

I'm quite new to git and have the following situation:

I have a master- and a productive-branch. The productive-branch lives on a
server (productive environment) and the master is for the devs to play
around ;-) Hot fixes and patches are primarily done in the productive
branch. New features are done in the master branch.

Now the question is, let's say, I did a stability fix in the
productive-branch and want that one also in the master branch (which
contains several new features). Will I have conflicts then with files
modified in the master- but not in productive-branch? Or will only the
modified files from the productive branch be compared with the master branch
(and not the modified ones in master)?

And do you think my branching in all makes sense (master for features,
branch for production environment)?

Big thanks in advance for any help!!

Bye Defcon0



--
View this message in context: http://git.661346.n2.nabble.com/Question-concerning-merge-behavior-tp7563780.html
Sent from the git mailing list archive at Nabble.com.
