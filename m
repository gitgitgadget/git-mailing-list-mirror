From: Adam Doeler <adam@releod.com>
Subject: git-svn show-ignore error
Date: Thu, 19 Jun 2008 23:27:51 -0400
Message-ID: <C277E555-5732-46FC-BB37-FD01FC0AA25C@releod.com>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 06:27:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9YDd-0000y8-2g
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 06:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbYFTE0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 00:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbYFTE0O
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 00:26:14 -0400
Received: from cl32.gs01.gridserver.com ([64.13.192.41]:56499 "EHLO
	cl32.gs01.gridserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbYFTE0N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 00:26:13 -0400
X-Greylist: delayed 3495 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Jun 2008 00:26:13 EDT
Received: from cpe0016cbc4bda4-cm001ac31586e8.cpe.net.cable.rogers.com ([72.141.5.82]:41781 helo=[192.168.1.196])
	by cl40.gs01.gridserver.com with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA:16)
	(Exim 4.63)
	(envelope-from <adam@releod.com>)
	id 1K9XI2-0001F6-WT
	for git@vger.kernel.org; Thu, 19 Jun 2008 20:27:54 -0700
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85595>

Hello - can anyone help me figure out what is causing the error below,  
and how to get past it..

I started by running:

% git-svn clone -s svn+ssh://path/to/repo local_dir
% cd local_dir
% git-svn show-ignore
Filesystem has no item: File not found: revision 175, path '/build'  
at /opt/local/bin/git-svn line 1879

The repository layout in the trunk is:
/build
/website

build has another directory, which has files, and directories, etc.
website the application files, framework, more directories, files, etc.

Any help with this would be awesome, I have not done anything beyond  
the commands listed above.
-Adam
