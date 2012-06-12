From: rohit sood <rohit.s@lycos.com>
Subject: (unknown)
Date: Tue, 12 Jun 2012 21:12:46 +0000 (GMT)
Message-ID: <395382583.32740.1339535566411.JavaMail.mail@webmail16>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 12 23:13:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeYOR-0007ma-Lx
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 23:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753476Ab2FLVMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 17:12:48 -0400
Received: from smtprelay0177.b.hostedemail.com ([64.98.42.177]:37516 "EHLO
	smtprelay.b.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752110Ab2FLVMr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jun 2012 17:12:47 -0400
Received: from filter.hostedemail.com (b-bigip1 [10.5.19.254])
	by smtprelay04.b.hostedemail.com (Postfix) with SMTP id 91B4C71381
	for <git@vger.kernel.org>; Tue, 12 Jun 2012 21:12:46 +0000 (UTC)
X-Panda: scanned!
X-Session-Marker: 726F6869742E73406C79636F732E636F6D
X-Filterd-Recvd-Size: 1666
Received: from webmail16 (imap-ext [64.98.36.5])
	(Authenticated sender: rohit.s@lycos.com)
	by omf04.b.hostedemail.com (Postfix) with ESMTP
	for <git@vger.kernel.org>; Tue, 12 Jun 2012 21:12:46 +0000 (UTC)
Received: from 192.234.2.90 ([192.234.2.90]) by webmail16 (Webmail) with HTTP; Tue, 12 Jun 2012 21:12:46 +0000 (GMT)
Subject: 
X-Originating-IP: [192.234.2.90]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199855>


Hi,
   When trying a remote install of the git client using winrm on a Windows 2003 box, I get the following error :

2012-06-12 14:59:05.476   Line 852: Creating symbolic link "E:\apps\prod\Git\libexec/git-core/git-whatchanged.exe" failed, will try a hard link.
2012-06-12 14:59:05.523   Line 852: Creating symbolic link "E:\apps\prod\Git\libexec/git-core/git-write-tree.exe" failed, will try a hard link.
2012-06-12 14:59:05.570   Line 852: Creating symbolic link "E:\apps\prod\Git\libexec/git-core/git.exe" failed, will try a hard link.
2012-06-12 14:59:05.679   Message box (OK):
                          Unable to configure the line ending conversion: core.autocrlf true

I use the Git-1.7.10-preview20120409.exe executable .
I am attempting to script an unattended silent install of the executable with the following options using Opscode Chef :

options "/DIR=\"#{node['GIT']['HOME']}\" /VERYSILENT /SUPPRESSMSGBOXES /LOG=\"#{ENV['TEMP']}\\GIT_INSTALL.LOG\""

Please advise

thanks,
Rohit
