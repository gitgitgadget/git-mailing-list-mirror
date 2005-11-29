From: Andreas Ericsson <ae@op5.se>
Subject: Re: 'git commit' ignoring args?
Date: Tue, 29 Nov 2005 11:38:45 +0100
Message-ID: <438C2FB5.5050605@op5.se>
References: <438B2F40.6070801@pobox.com> <438B8C6C.8030407@op5.se> <loom.20051129T003332-60@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 29 14:26:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eh2sz-000483-4B
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 11:38:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbVK2Kir (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 05:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbVK2Kir
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 05:38:47 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:45998 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751134AbVK2Kir
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2005 05:38:47 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id F1D716BCBE; Tue, 29 Nov 2005 11:38:45 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@twinsun.com>
In-Reply-To: <loom.20051129T003332-60@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12938>

Junio C Hamano wrote:
> Andreas Ericsson <ae <at> op5.se> writes:
> 
> 
>>The index has been updated to match the file on disk somehow (perhaps 
>>you did 'git add book.xml'?).
> 
> 
> book.xml is known to the index file at this point.  "git add book.xml" will
> *not* run update-index on that path, so that is not it.
> 

At this point, yes, but if it was just added it wouldn't have been 
before it was git-add'ed.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
