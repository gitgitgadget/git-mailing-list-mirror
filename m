X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] make commit message a little more consistent and conforting
Date: Fri, 15 Dec 2006 09:34:19 +0100
Message-ID: <45825E0B.5010200@op5.se>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net> <200612132237.10051.andyparkins@gmail.com> <7vk60vbcfz.fsf@assigned-by-dhcp.cox.net> <200612140959.19209.andyparkins@gmail.com> <7v7iwu93rv.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0612141343200.18171@xanadu.home> <Pine.LNX.4.64.0612142307160.18171@xanadu.home> <20061215042459.GC27343@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 15 Dec 2006 08:34:36 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <20061215042459.GC27343@spearce.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34476>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv8WW-0007uB-Ep for gcvg-git@gmane.org; Fri, 15 Dec
 2006 09:34:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750752AbWLOIeV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 03:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWLOIeV
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 03:34:21 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:48093 "EHLO
 smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1750752AbWLOIeV (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 03:34:21 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id B5FCF6BCBC; Fri, 15 Dec 2006 09:34:19 +0100 (CET)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce wrote:
> Nicolas Pitre <nico@cam.org> wrote:
>> It is nicer to let the user know when a commit succeeded all the time, 
>> not only the first time.  Also the commit sha1 is much more useful than 
>> the tree sha1 in this case.
> 
> I agree the commit sha1 is more useful than the tree sha1, but I'm
> not really sure its useful to show the commit sha1 post commit.
> If you want to show something the diffstat like what git merge does
> is better.
> 

diffstats can be huge though. I'd rather have those only with -v option.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
