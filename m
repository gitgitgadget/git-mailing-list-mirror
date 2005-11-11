From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Change 'cache' to 'index' in the docs
Date: Fri, 11 Nov 2005 12:49:58 +0100
Message-ID: <43748566.2070204@op5.se>
References: <4373EFFB.6060802@etek.chalmers.se> <7voe4svufi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Nov 11 12:51:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaXQ3-0005dn-5Z
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 12:50:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbVKKLuA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 06:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbVKKLuA
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 06:50:00 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:62380 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750712AbVKKLt7
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 06:49:59 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 8715B6BD0D
	for <git@vger.kernel.org>; Fri, 11 Nov 2005 12:49:58 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <7voe4svufi.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11590>

Junio C Hamano wrote:
> Lukas Sandstr.ANvm <lukass@etek.chalmers.se> writes:
> 
> 
>>git-update-index.txt says:
>>"Modifies the index or directory cache."
>>
>>I thought the index was the directory cache.
>>Is git-update-index.txt badly worded or is there something
>>I'm missing?
> 
> 
> Nothing.  Just 'cache' is so ingrained to the brain of some/many
> of us that we let it go unnoticed, with an excuse that somewhere
> we say "index aka cache".
> 

This had me puzzled for quite some time. Some notice to the tutorial 
about what's meant when it says "tree-ish" or "commit-ish" would be nice 
(I still haven't been able to figure it out).

The wording in git-diff-index.txt isn't exactly stellar either. The 
git(7) man-page mentions that it's nice to read git-diff-index before 
doing anything else, but it was just yesterday before I figured out that 
it can be used to produce a diff between an updated index and the 
checked out working tree (which has led me to some fairly obscure 
juggling with patches and source-files to remember just what the hell it 
was I changed).

Oh well. Perhaps I checked in all the wrong places.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
