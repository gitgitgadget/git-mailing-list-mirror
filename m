From: Ankit Jain <ankitgr8@gmail.com>
Subject: email sender plugin in stash
Date: Tue, 22 Sep 2015 05:35:07 +0000 (UTC)
Message-ID: <loom.20150922T073021-705@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 22 07:40:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeGJi-0002kE-Ji
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 07:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbbIVFkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 01:40:07 -0400
Received: from plane.gmane.org ([80.91.229.3]:52482 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750757AbbIVFkG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 01:40:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZeGJ9-00020R-Vj
	for git@vger.kernel.org; Tue, 22 Sep 2015 07:40:04 +0200
Received: from 199.43.186.25 ([199.43.186.25])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 07:40:03 +0200
Received: from ankitgr8 by 199.43.186.25 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 07:40:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 199.43.186.25 (Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.93 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278376>

HI

I need to modify the notifyemail.vm plugin to show only those changes in the 
email which i committed as a part of pull request. I do not want to see all the 
commits which happen  again and again during the review process.

We actually squash all the commits and the reviewer always see the diff with 
respect to the master branch,.. but when the mail is send it shows the actual 
merge commit and also the parent commits. 

We do not want to show the parent commit only show the merge commit.

What changes we need to do in "notifyemail.vm" to achieve the same

https://bitbucket.org/slyoldfox/notifier/src/b160edc865961baed7861b1b7dc5b1bfe1
587fb5/src/main/resources/templates/notifyemail.vm?fileviewer=file-view-default
