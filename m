From: "Samy Louis" <Samy.seif@go-eknowledge.com>
Subject: RE: duplicated Working tree
Date: Wed, 23 Mar 2011 16:00:45 +0200
Message-ID: <002801cbe962$b4d313f0$1e793bd0$@go-eknowledge.com>
References: <002701cbe949$e957f050$bc07d0f0$@go-eknowledge.com> <4D89F7C5.6000900@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Michael J Gruber'" <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Mar 23 14:57:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2OZC-0006Hx-4D
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 14:57:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756199Ab1CWN5h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 09:57:37 -0400
Received: from out6.tedata.net.eg ([213.158.162.171]:43253 "EHLO
	out.tedata.net.eg" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756103Ab1CWN5g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 09:57:36 -0400
Received: (qmail 30173 invoked from network); 23 Mar 2011 13:57:34 -0000
Received: by simscan 1.4.0 ppid: 30145, pid: 30148, t: 5.4534s
         scanners: regex: 1.4.0 clamav: 0.96/m:52/d:11148 spam: 3.2.3
X-Spam-TE-Data-out-Scanned: Yes
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on SMTP-Out6
X-Spam-Status: No, score=3.2 required=10.0 tests=AWL,DNS_FROM_OPENWHOIS,
	RDNS_DYNAMIC autolearn=no version=3.2.3
Received: from host-213.158.171.58.tedata.net (HELO sls) (technology.know@[213.158.171.58])
          (envelope-sender <Samy.seif@go-eknowledge.com>)
          by out6.tedata.net.eg (qmail-ldap-1.03) with SMTP
          for <git@drmicha.warpmail.net>; 23 Mar 2011 13:57:28 -0000
In-Reply-To: <4D89F7C5.6000900@drmicha.warpmail.net>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQLgdPRB4e9CkqcAh/RmwWDiSUkwlAH27A0VkgIja7A=
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169832>

Yes I created it in local machine before I clone it to the remote machine ,
but  the issue appears   when I clone the remote repo to another machine to
different path.
Samy

-----Original Message-----
From: Michael J Gruber [mailto:git@drmicha.warpmail.net] 
Sent: Wednesday, March 23, 2011 3:38 PM
To: Samy Louis
Cc: git@vger.kernel.org
Subject: Re: duplicated Working tree

Samy Louis venit, vidit, dixit 23.03.2011 12:03:
> 
> Hi,
> 
> I have a strange problem and need your support if possible.
> 
> When I clone a  remote GIT repository (LAN)  to  local machine,  I get 
> two working  folder one at the GIT local folder (normal) and the other 
> in  original path of where the remote repository had been created 
> before it was cloned  to remote network.
> 
> How can I overcome this issue to only have one local working folder.
> 
> 
> Step to  reproduce it:
> 
> 1- Create a local GIT repo.  (D:\repositoies\projectname)
> 2- Clone the GIT repo. to network path ( \\server\GIT\ projectname) 
> use a bare flag.
> 3- Clone the remote repo ( \\server\GIT\ projectname) to other machine 
> in path (C:\GIT\projectname) and create working tree
> 4- We will fine two working tree one at C:\GIT\projectname and the 
> other at D:\repositoies\projectname.
> 
> Thanks in advance .

Didn't you create a working tree at D:\repositoies\projectname in step 1
already?

Michael
