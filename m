From: Jeff Garzik <jgarzik@pobox.com>
Subject: 'git commit' ignoring args?
Date: Mon, 28 Nov 2005 11:24:32 -0500
Message-ID: <438B2F40.6070801@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Nov 28 17:24:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eglo3-0002on-RF
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 17:24:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbVK1QYk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 11:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbVK1QYk
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 11:24:40 -0500
Received: from mail.dvmed.net ([216.237.124.58]:58784 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751278AbVK1QYj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Nov 2005 11:24:39 -0500
Received: from cpe-069-134-188-146.nc.res.rr.com ([69.134.188.146] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.52 #1 (Red Hat Linux))
	id 1Eglnx-0004mA-OJ
	for git@vger.kernel.org; Mon, 28 Nov 2005 16:24:39 +0000
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  With the latest git as of this writing, executing git
	commit Makefile stylesheet.xsl results in an attempt to commit the
	above files, and also another file book.xml. book.xml is modified, but
	I do not wish to check it in at this time, so I did not list it as an
	argument to 'git commit'. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12891>


With the latest git as of this writing, executing

	git commit Makefile stylesheet.xsl

results in an attempt to commit the above files, and also another file 
book.xml.  book.xml is modified, but I do not wish to check it in at 
this time, so I did not list it as an argument to 'git commit'.

The only commit in the repository is the initial commit.

#
# Updated but not checked in:
#   (will commit)
#
#       modified: Makefile
#       modified: book.xml
#       new file: stylesheet.xsl
#
#
# Untracked files:
#   (use "git add" to add to commit)
#
#       book.pdf

Expected behavior is that Makefile and stylesheet.xsl would be checked 
in, but not book.xml.

	Jeff
