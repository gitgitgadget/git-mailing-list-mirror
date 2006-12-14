X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: What's in git.git (stable)
Date: Thu, 14 Dec 2006 09:28:57 +0100
Message-ID: <45810B49.2000706@op5.se>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>	<200612132237.10051.andyparkins@gmail.com> <7vk60vbcfz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 08:29:08 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <7vk60vbcfz.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34286>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gulxg-0008Iu-Er for gcvg-git@gmane.org; Thu, 14 Dec
 2006 09:29:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751824AbWLNI3A (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 03:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751828AbWLNI3A
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 03:29:00 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:57350 "EHLO
 smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1751824AbWLNI3A (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 03:29:00 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 292976BCC6; Thu, 14 Dec 2006 09:28:58 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Andy Parkins <andyparkins@gmail.com> writes:
> 
>>  * git-add has no output, whether it works or not
> 
> "git add no-such-file" complains, and I think that is adequate.
> Now with Nico's 'add means adding contents, not path' change is
> in, we _might_ want to differentiate adding a path that was
> untracked before and updating the contents, but I think this
> again falls into "doing exactly as told" category.
> 

Well, it should really let the user know if it fails. I for one would 
like to know that. I wasn't aware of the fact that it was silent even in 
those situations (perhaps because I've never run across it).

The errors that need to be reported are, afaics:
Content in 'path/to/file' is ignored according to path/to/.gitignore.
System error X happened while attempting Y.
Hash collisions.

Hash collisions wouldn't be too bad to check for in git add, because it 
only has to compare a single object, although I agree that it probably 
isn't necessary.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
