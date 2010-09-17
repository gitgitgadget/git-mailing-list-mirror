From: Michael Scholl <michael@sch0ll.de>
Subject: Question about svn:externals, submodules...
Date: Fri, 17 Sep 2010 23:19:55 +0200
Message-ID: <34843501-F376-4CF0-A367-46F3FF089A25@sch0ll.de>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 17 23:20:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwiLz-0004g3-4c
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 23:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754434Ab0IQVUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Sep 2010 17:20:05 -0400
Received: from post.eye-motion.net ([94.23.163.123]:47307 "EHLO
	post.eye-motion.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754381Ab0IQVT6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Sep 2010 17:19:58 -0400
Received: from [10.36.3.42] (unknown [85.183.55.17])
	by post.eye-motion.net (Postfix) with ESMTPSA id 882C3399C54
	for <git@vger.kernel.org>; Fri, 17 Sep 2010 21:13:43 +0000 (UTC)
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156415>

hi there, 

I try to change my svn setting to git and got the most things up running. But one thing I didnt understand how to handle with it, are my svn:external definitions. 

1. I used svn:externals to include other frameworks or libraries in a vendors folder. I got these cases covered with the git submodules, no problem so far.

2. But I used svn:externals to fill up a working copy with checkout specific files. Imagine a web project with public folder, and subfolders for css and js files. Inside these folders there was a "projects" folder with svn:externals for this specific project. All this project specific files are stored in a separate repository with complex structure for storing all the project related files, like:

project1
 - js
 - css
 - img
project2
 - js
 - css
 - img

So, while getting into git I didn't find any solution, that would help me to get my setting working nice with git. Submodules do not work for this case, it would need many different reps to build submodules from, because I cannot fetch any specific file path of some repository.

Any ideas, how to find a solution, for keeping main project AND project related files under version control with git? 
(I thought of symlinks and git ignore definitions, but perhaps there is a better way)?


Cheers

MS