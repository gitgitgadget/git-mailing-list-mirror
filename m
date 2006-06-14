From: Andreas Ericsson <ae@op5.se>
Subject: Re: Porcelain specific metadata under .git?
Date: Wed, 14 Jun 2006 15:07:59 +0200
Message-ID: <44900A2F.7050704@op5.se>
References: <20060614062240.GA13886@spearce.org> <448FEED7.30701@op5.se> <e6os3v$r5g$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 14 15:08:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqV6M-0003Fl-PI
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 15:08:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbWFNNID (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 09:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbWFNNID
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 09:08:03 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:65259 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S964906AbWFNNIB
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jun 2006 09:08:01 -0400
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 060296BCE9; Wed, 14 Jun 2006 15:08:00 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e6os3v$r5g$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21843>

Jakub Narebski wrote:
> Andreas Ericsson wrote:
> 
> 
>>Shawn Pearce wrote:
>>
>>>I already assume/know that refs/heads and refs/tags are completely
>>>off-limits as they are for user refs only.
>>>
>>>I also think the core GIT tools already assume that anything
>>>directly under .git which is strictly a file and which is named
>>>entirely with uppercase letters (aside from "HEAD") is strictly a
>>>temporary/short-lived state type item (e.g. COMMIT_MSG) used by a
>>>Porcelain.
>>>
>>>But is saying ".git/refs/eclipse-workspaces" is probably able to
>>>be used for this purpose safe?  :-)
>>>
>>
>>.git/eclipse/whatever-you-like
>>
>>would probably be better. Heads can be stored directly under .git/refs 
>>too. Most likely, nothing will ever be stored under ./git/eclipse by 
>>either core git or the current (other) porcelains though.
> 
> 
> I think if it is a ref, which one wants to be visible to git-fsck (and
> git-prune), it should be under .git/refs.
> 

Yes, but I understood him to mean "it's a tree-sha" instead of a 
branch/head thing, which would mean it doesn't fit the .git/refs 
definition of ref.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
