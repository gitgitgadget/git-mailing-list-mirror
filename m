From: Andreas Ericsson <ae@op5.se>
Subject: Re: Can't use gitk.
Date: Mon, 14 Nov 2005 12:10:39 +0100
Message-ID: <437870AF.8060607@op5.se>
References: <cda58cb80511140253s92f28e2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 14 12:12:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbcEr-00083P-0K
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 12:11:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbVKNLKn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 06:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbVKNLKn
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 06:10:43 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:3521 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S1750907AbVKNLKn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Nov 2005 06:10:43 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 620226BCBE; Mon, 14 Nov 2005 12:10:40 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Franck <vagabon.xyz@gmail.com>
In-Reply-To: <cda58cb80511140253s92f28e2g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11788>

Franck wrote:
> Hi,
> 
> I'm trying to use gitk --all command but it fails like this:
> 
> """
> Error executing git-rev-list: couldn't execute "git-rev-list": no such
> file or directory
> """
> 

Is git-rev-list in your $PATH?
Did you compile (and/or install) with

	make NO_OPENSSL=YesPlease
	make NO_OPENSSL=YesPlease install

Do other git commands work?

> I'm running git on a fedora core 3. Can anybody give me some help ?
> 

Trying to, but a bit more verbosity in the error report wouldn't hurt.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
