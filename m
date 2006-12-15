X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Add --add option to git-repo-config
Date: Fri, 15 Dec 2006 06:44:42 -0500
Message-ID: <A2C282DE-30E3-401C-AE46-777F3DDDFA86@silverinsanity.com>
References: <75CF19E7-7953-4C0A-B4CE-E9BB6822E062@silverinsanity.com> <eltno8$vos$1@sea.gmane.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 15 Dec 2006 11:45:18 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <eltno8$vos$1@sea.gmane.org>
X-Mailer: Apple Mail (2.752.3)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34497>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvBV3-0004n7-3U for gcvg-git@gmane.org; Fri, 15 Dec
 2006 12:45:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751992AbWLOLoq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 06:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751989AbWLOLoq
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 06:44:46 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:41491 "EHLO
 silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1751992AbWLOLop (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 06:44:45 -0500
Received: from [IPv6???1] (localhost [127.0.0.1]) (using TLSv1 with cipher
 AES128-SHA (128/128 bits)) (No client certificate requested) by
 silverinsanity.com (Postfix) with ESMTP id 8DBF81FFC02B; Fri, 15 Dec 2006
 11:44:44 +0000 (UTC)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org


On Dec 15, 2006, at 3:54 AM, Jakub Narebski wrote:

> Brian Gernhardt wrote:
>
>>   'git-repo-config' [--global] [type] name [value [value_regex]]
>> +'git-repo-config' [--global] [type] --add name value
>
> In few places it seems that original has one space at beginning of  
> line,
> and added value lacks this space.
>
> Otherwise, very nice patch. Thanks!

None of the originals have spaces at the beginning of the lines in my  
repo.  I think that's an artifact of Mail.app mangling whitespace at  
the beginning of the line when copy/pasting patches.  I thought it  
only happened in a couple places and tried to fix it by hand.   
Apparently that didn't work, and I need to install mutt or something  
to send things from the command line.  In the meantime, I can re-send  
the patch as an attachment, if that'll help.

