From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: how to determine version of binary
Date: Sat, 05 May 2012 02:12:44 -0500
Message-ID: <jo2jtd$m6c$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 05 09:13:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQZBT-0005Ok-Tb
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 09:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753043Ab2EEHM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 May 2012 03:12:59 -0400
Received: from plane.gmane.org ([80.91.229.3]:51891 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751153Ab2EEHM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2012 03:12:59 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SQZAm-0004xq-8P
	for git@vger.kernel.org; Sat, 05 May 2012 09:12:56 +0200
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 May 2012 09:12:56 +0200
Received: from nkreitzinger by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 May 2012 09:12:56 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197098>

Scenario:  I detect a binary file that is 'dirty'.  I don't know how it 
got there.  However, I know it came from a git repo.  So I calculate the 
sha1 of the binary.  What is the git command to determine which commit 
that binary version first appeared in?  And the last commit that binary 
appeared in?

Why:  we have people ftp'ing binaries around.  I want to see the commit 
message and source change of that commit to see what the binary version is.

v/r,
neal
