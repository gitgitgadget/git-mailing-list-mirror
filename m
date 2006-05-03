From: Andreas Ericsson <ae@op5.se>
Subject: Re: Problem using GIT CVS-server
Date: Wed, 03 May 2006 10:17:14 +0200
Message-ID: <4458670A.4080205@op5.se>
References: <445865A5.5030700@lumumba.uhasselt.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 10:17:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbCXv-0000qI-PH
	for gcvg-git@gmane.org; Wed, 03 May 2006 10:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965116AbWECIRR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 04:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965119AbWECIRR
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 04:17:17 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:33249 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S965116AbWECIRQ
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 3 May 2006 04:17:16 -0400
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 272C96BD38; Wed,  3 May 2006 10:17:15 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Panagiotis Issaris <takis@lumumba.uhasselt.be>
In-Reply-To: <445865A5.5030700@lumumba.uhasselt.be>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19458>

Panagiotis Issaris wrote:
> Hi,
> 
> I've tried using git-cvsserver, but keep running into problems:
> When doing a checkout, it only checks out a small subset of
> the total amount of files in the repository and reports a warning/error.
> When doing a subsequent update, it doesn't seem to do anything,
> but reports two error messages/warnings.
> 

...

> takis@issaris:/tmp/a/b$ cd project-master/
> takis@issaris:/tmp/a/b/project-master$ cvs -z3 update -PAd
> takis@localhost's password:
> server doesn't support gzip-file-contents


Drop -z3 from command-line. git-cvsserver has no compression support.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
