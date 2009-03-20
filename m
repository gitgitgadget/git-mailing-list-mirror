From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: Status of GIT for Fedora 10 + gitweb's look
Date: Fri, 20 Mar 2009 09:21:52 -0700
Message-ID: <49C3C2A0.2030402@eaglescrag.net>
References: <B041B86F1FF246ACBD68051753788FBE@HPLAPTOP>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Aaron Gray <aaronngray.lists@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 18:14:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkiHx-0004Ro-Je
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 18:13:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757642AbZCTRMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 13:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757834AbZCTRMN
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 13:12:13 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:51894 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757106AbZCTRMM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 13:12:12 -0400
X-Greylist: delayed 3015 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Mar 2009 13:12:12 EDT
Received: from [172.19.0.11] (c-67-164-31-53.hsd1.ca.comcast.net [67.164.31.53])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.14.1) with ESMTP id n2KGLqda027651
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 20 Mar 2009 09:21:52 -0700
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <B041B86F1FF246ACBD68051753788FBE@HPLAPTOP>
X-Virus-Scanned: ClamAV 0.88.7/9145/Fri Mar 20 07:59:16 2009 on shards.monkeyblade.net
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.1.1 (shards.monkeyblade.net [198.137.202.13]); Fri, 20 Mar 2009 09:21:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113982>

If your on Fedora 10 to get gitweb installed all you should have to do is:

yum install gitweb

and you will be off and running.

- John 'Warthog9' Hawley

Aaron Gray wrote:
> I tried installing Git on F10 and got the following :-
> 
> [root@localhost ~]# rpm -Uvh git-1.6.2.1-1.fc9.i386.rpm
> error: Failed dependencies:
>        perl-Git = 1.6.2.1-1.fc9 is needed by git-1.6.2.1-1.fc9.i386
>        git = 1.6.0.6-3.fc10 is needed by (installed) 
> perl-Git-1.6.0.6-3.fc10.i386
>        git = 1.6.0.6-3.fc10 is needed by (installed) 
> git-svn-1.6.0.6-3.fc10.i386
>        git = 1.6.0.6-3.fc10 is needed by (installed) 
> git-daemon-1.6.0.6-3.fc10.i386
>        git = 1.6.0.6-3.fc10 is needed by (installed) 
> gitweb-1.6.0.6-3.fc10.i386
> 
> 
> Can I install from source I could only find F9 SRPMS.
> 
> What I am really after knowing is gitweb on the latest version 1.6.2.1 
> anything like the nice HTML layout on http://git.kernel.org/ or do I 
> have to do the html formatting myself in the perl code ?
> 
> Many thanks in advance,
> 
> Aaron
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
