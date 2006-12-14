X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: What's in git.git (stable)
Date: Thu, 14 Dec 2006 22:55:06 +0100
Message-ID: <4581C83A.10907@op5.se>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net> <200612140959.19209.andyparkins@gmail.com> <7v7iwu93rv.fsf@assigned-by-dhcp.cox.net> <200612141136.59041.andyparkins@gmail.com> <20061214114546.GI1747@spearce.org> <8764ce6654.wl%cworth@cworth.org> <20061214120518.GL1747@spearce.org> <Pine.LNX.4.64.0612141251520.18171@xanadu.home> <7vy7pa45m8.fsf@assigned-by-dhcp.cox.net> <20061214200245.GP1747@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 21:55:48 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <20061214200245.GP1747@spearce.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34411>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuyYD-0006AL-R2 for gcvg-git@gmane.org; Thu, 14 Dec
 2006 22:55:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964832AbWLNVzf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 16:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbWLNVze
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 16:55:34 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:41339 "EHLO
 smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S964832AbWLNVze (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 16:55:34 -0500
Received: from [192.168.1.20] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
 by smtp-gw1.op5.se (Postfix) with ESMTP id E37706BCC4; Thu, 14 Dec 2006
 22:55:32 +0100 (CET)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce wrote:
> 
> About the only trouble that can cause is a failed push when
> git-receive-pack needs to generate the reflog entry but cannot
> get the user's committer data because their gecos information
> doesn't exist.
> 

In that case, it would be best if it let the commit go through using 
only the username. Reflogs are fixable afterwards, so there's no real 
harm done.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
