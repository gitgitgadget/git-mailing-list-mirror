From: Joel McGahen <vin4bacchus@me.com>
Subject: New User Question
Date: Mon, 17 Jun 2013 11:39:44 -0400
Message-ID: <F201B6D6-7A69-4DD6-BDF5-5AE12E3A176C@me.com>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 17 18:40:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UocTU-0000HS-2e
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 18:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752350Ab3FQQkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 12:40:05 -0400
Received: from st11p02mm-asmtp005.mac.com ([17.172.220.240]:62551 "EHLO
	st11p02mm-asmtp005.mac.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751486Ab3FQQkE convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 12:40:04 -0400
X-Greylist: delayed 3609 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Jun 2013 12:40:04 EDT
Received: from [192.168.1.211]
 (c-66-176-70-142.hsd1.fl.comcast.net [66.176.70.142])
 by st11p02mm-asmtp005.mac.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Jan
  3 2012)) with ESMTPSA id <0MOJ009B1NIDSE70@st11p02mm-asmtp005.mac.com> for
 git@vger.kernel.org; Mon, 17 Jun 2013 15:39:50 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=fsecure
 engine=2.50.10432:5.10.8794,1.0.431,0.0.0000
 definitions=2013-06-17_03:2013-06-17,2013-06-17,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 ipscore=0 suspectscore=1 phishscore=0 bulkscore=0 adultscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=6.0.2-1305010000
 definitions=main-1306170119
X-Mailer: Apple Mail (2.1508)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228082>

I have a question about GIT remote repos. Here is my scenario.

1. Work client has a repo (origin, branch of master).
2. Due to contractual issues I need to host a remote copy of this repo that my developers can utilize while we get the contractual issues resolved as development must continue. 
3. I have a virtual machine from the client which already has a remote of origin setup. 
4. I have created a bare repo on a server my developer's have access to. 
5. I have added that remote to my copy of the client VM local repo and pushed its contents to my newly created bare repo.

What I need to understand is how to
a) Connect my developer's VM local repos to the new remote repo I created so they can continue to work.
b) Once the contractual issues are resolved reconnect the developer's local repos back to the original orgin/master repo and merge all their changes.

I'm fairly new to GIT but have worked with version control for a long time (CVS, PVCS, Subversion etc).

Any help would be greatly appreciated!
