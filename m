From: redhat1981 <redhat1981@gmail.com>
Subject: Folder level Acces in git
Date: Wed, 2 Nov 2011 23:10:55 -0700 (PDT)
Message-ID: <1320300655224-6958047.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 03 07:11:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLqVx-0003DF-Dv
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 07:11:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247Ab1KCGK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Nov 2011 02:10:56 -0400
Received: from sam.nabble.com ([216.139.236.26]:54397 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751255Ab1KCGKz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2011 02:10:55 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <redhat1981@gmail.com>)
	id 1RLqVr-0000RO-7n
	for git@vger.kernel.org; Wed, 02 Nov 2011 23:10:55 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184706>

Hi,

I am using Gitosis, Adding the gitosis conf file

[group testabc]
writable = testabc
members =   shrii Abhijeet premkumar
add cgit = yes
gitweb = yes


[group testabc-readonly]
readonly = testabc
members =  Ganesh Shweta
add cgit = yes
gitweb = yes

Inside the repository, testabc let us say there are folders folder1, folder
2 etc, I want some users to have read/write, read or no access to the
folder1 or folder2, Is this possible in Git, I have done it in SVN, Please
help!!

redhat1981@gmail.com


--
View this message in context: http://git.661346.n2.nabble.com/Folder-level-Acces-in-git-tp6958047p6958047.html
Sent from the git mailing list archive at Nabble.com.
