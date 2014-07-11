From: Bill Door <duanemurphy@mac.com>
Subject: Re: git p4 diff-tree ambiguous argument error
Date: Fri, 11 Jul 2014 10:40:49 -0700 (PDT)
Message-ID: <1405100449405-7614882.post@n2.nabble.com>
References: <1405013428825-7614774.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 11 19:40:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5eoY-0003Hg-7a
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 19:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754673AbaGKRku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 13:40:50 -0400
Received: from sam.nabble.com ([216.139.236.26]:53787 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754670AbaGKRkt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 13:40:49 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <duanemurphy@mac.com>)
	id 1X5eoT-0001Zh-DO
	for git@vger.kernel.org; Fri, 11 Jul 2014 10:40:49 -0700
In-Reply-To: <1405013428825-7614774.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253301>

More data points. I have reproduced the problem on

$ git --version
git version 1.8.5.2 (Apple Git-48)
$ python --version
Python 2.7.5
$ uname -a
Darwin Kernel Version 13.3.0: Tue Jun  3 21:27:35 PDT 2014;
root:xnu-2422.110.17~1/RELEASE_X86_64 x86_64

However, it the command is used on a new empty repository, there is no
failure. Running a second time causes the failure. 

Thanks for any help you can offer in tracking down this problem!



--
View this message in context: http://git.661346.n2.nabble.com/git-p4-diff-tree-ambiguous-argument-error-tp7614774p7614882.html
Sent from the git mailing list archive at Nabble.com.
