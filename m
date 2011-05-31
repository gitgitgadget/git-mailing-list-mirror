From: DCWoods <dwoodsnz@gmail.com>
Subject: [JGIT] Problem using API to create a repository in Amazon S3
Date: Tue, 31 May 2011 02:14:50 -0700 (PDT)
Message-ID: <1306833290555-6421952.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 31 11:14:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRL2O-0007VS-Ms
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 11:14:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757008Ab1EaJOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 05:14:52 -0400
Received: from sam.nabble.com ([216.139.236.26]:36095 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751956Ab1EaJOv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 05:14:51 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <dwoodsnz@gmail.com>)
	id 1QRL2I-0005dj-Iy
	for git@vger.kernel.org; Tue, 31 May 2011 02:14:50 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174799>

I'm not sure that what I'm trying to do is possible using JGit - I've spent
days trying to figure this out!

I am writing an application that I want to be able to control git using
Amazon S3 for the storage.  I want the application to be able to create a
new git repository in S3, commit files that are created dynamically by the
application, and then later update and retrieve them.  

At the moment I'm stuck trying to create the repository using the JGit API. 
All the examples I've found show pushing from a local repository to an S3
remote repository using a command line client.

1. Is this even possible using the JGit API?
2. Are there any examples showing how to do this?
3. Can anyone give me any tips on the method or how to achieve this?

Thanks for your time.

David

--
View this message in context: http://git.661346.n2.nabble.com/JGIT-Problem-using-API-to-create-a-repository-in-Amazon-S3-tp6421952p6421952.html
Sent from the git mailing list archive at Nabble.com.
