From: Andreas Ericsson <ae@op5.se>
Subject: Re: 'git commit' ignoring args?
Date: Tue, 29 Nov 2005 00:02:04 +0100
Message-ID: <438B8C6C.8030407@op5.se>
References: <438B2F40.6070801@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 29 00:05:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Egs0s-0000iE-7Z
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 00:02:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbVK1XCI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 18:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbVK1XCI
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 18:02:08 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:53420 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932304AbVK1XCG
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2005 18:02:06 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id E64426BCBE; Tue, 29 Nov 2005 00:02:04 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <438B2F40.6070801@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12909>

Jeff Garzik wrote:
> 
> With the latest git as of this writing, executing
> 
>     git commit Makefile stylesheet.xsl
> 
> results in an attempt to commit the above files, and also another file 
> book.xml.  book.xml is modified, but I do not wish to check it in at 
> this time, so I did not list it as an argument to 'git commit'.
> 

The index has been updated to match the file on disk somehow (perhaps 
you did 'git add book.xml'?). You can un-mark it with

	git reset HEAD

which is equivalent to

	git read-tree --reset HEAD

so long as you're operating on HEAD.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
