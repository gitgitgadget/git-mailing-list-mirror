From: pcm2a <cameron@ree-yees.com>
Subject: Error pushing to remote with git
Date: Mon, 28 Nov 2011 06:15:30 -0800 (PST)
Message-ID: <1322489730833-7038870.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 15:15:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RV1zi-00082R-QV
	for gcvg-git-2@lo.gmane.org; Mon, 28 Nov 2011 15:15:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753928Ab1K1OPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Nov 2011 09:15:36 -0500
Received: from sam.nabble.com ([216.139.236.26]:46400 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753042Ab1K1OPf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2011 09:15:35 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <cameron@ree-yees.com>)
	id 1RV1zW-00060f-Re
	for git@vger.kernel.org; Mon, 28 Nov 2011 06:15:30 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186016>

I have a fresh Centos 6 server stood up and I have installed git version
1.7.1. I am using the smart http method through apache for access.

When I try to push to the remote server this is what I get:

$ git push origin master
Password:
Counting objects: 6, done.
Compressing objects: 100% (3/3), done.
Writing objects: 100% (6/6), 436 bytes, done.
Total 6 (delta 0), reused 0 (delta 0)
error: unpack failed: index-pack abnormal exit

I have tried these things which made no difference:
* chown -R apache:apache /path/to/git/repository (httpd runs as apache)
* chown -R apache:users /path/to/git/repository
* chmod -R 777 /path/to/git/repository (obviously not secure but wanted to
eliminate this being a file permission problem)

What can I try to get pushing to work?

--
View this message in context: http://git.661346.n2.nabble.com/Error-pushing-to-remote-with-git-tp7038870p7038870.html
Sent from the git mailing list archive at Nabble.com.
