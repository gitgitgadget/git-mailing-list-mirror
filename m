From: jhapk <pradeep.kumar.jha@gmail.com>
Subject: Git branch
Date: Tue, 13 Jul 2010 15:50:52 -0700 (PDT)
Message-ID: <1279061452603-5290193.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 14 00:51:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYoJZ-0003l1-7m
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 00:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755323Ab0GMWu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 18:50:56 -0400
Received: from kuber.nabble.com ([216.139.236.158]:45373 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988Ab0GMWuz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 18:50:55 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <pradeep.kumar.jha@gmail.com>)
	id 1OYoJQ-00026M-Jk
	for git@vger.kernel.org; Tue, 13 Jul 2010 15:50:52 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150935>


Hi,

I have a central bare repository B and two non-bare repositories A1 and A2.
Both A1 and A2 have B as the origin. The way I do it is that every time I
create a branch in A1, say branchA, I manually enter the following lines in
the .git/config files of A1 and A2
[branch "branchA"]
    remote = origin
    merge = refs/heads/branchA

Then I create a branch in the bare repository B called branchA. Once this is
done, all the push and pull works smoothly between the two repositories. 

Just wondering, is there a better way to do this? :)
-- 
View this message in context: http://git.661346.n2.nabble.com/Git-branch-tp5290193p5290193.html
Sent from the git mailing list archive at Nabble.com.
