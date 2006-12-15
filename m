X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] make commit message a little more consistent and conforting
Date: Fri, 15 Dec 2006 16:50:26 +0100
Message-ID: <4582C442.5050704@op5.se>
References: <200612132237.10051.andyparkins@gmail.com> <7vk60vbcfz.fsf@assigned-by-dhcp.cox.net> <200612140959.19209.andyparkins@gmail.com> <7v7iwu93rv.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0612141343200.18171@xanadu.home> <Pine.LNX.4.64.0612142307160.18171@xanadu.home> <20061215042459.GC27343@spearce.org> <45825E0B.5010200@op5.se> <20061215150909.GE17860@spearce.org> <4582C022.3030706@op5.se> <20061215154025.GF17860@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 15 Dec 2006 15:50:43 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <20061215154025.GF17860@spearce.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34523>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvFKT-0004uu-Au for gcvg-git@gmane.org; Fri, 15 Dec
 2006 16:50:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752757AbWLOPu2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 10:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752758AbWLOPu2
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 10:50:28 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:55314 "EHLO
 smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1752757AbWLOPu1 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 10:50:27 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 775326BCBC; Fri, 15 Dec 2006 16:50:26 +0100 (CET)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce wrote:
> Andreas Ericsson <ae@op5.se> wrote:
>> Yes, but it makes sense for merges where you generally pull someone 
>> elses work or one of your topic branches because it gives a general feel 
>> for the amount of modifications and are a sort of conclusion. Commits 
>> are a different thing, because you should know what kind of changes 
>> you've just done. If you don't you have other problems. I for one run 
>> git diff quite frequently when I'm getting close to a commit to make 
>> sure I don't get only the changes I want. I imagine others do too, so 
>> getting a diffstat when issuing the actual commit would just be noisy 
>> and irritating.
> 
> I do the same (diff a lot before commit) and thus find commit
> outputting anything at all to be noisy and irritating.  Frankly
> the new
> 

I could live with one line (Committed revision %d), but a diffstat is 
always 3 lines minimum, which might well turn out to be 2 lines more 
than I changed. That's way too noisy.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
