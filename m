X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 2/4] Rename remote_only to display_mode
Date: Fri, 03 Nov 2006 11:51:39 +0100
Message-ID: <454B1F3B.1020603@op5.se>
References: <bec6ab7849e3fcacac23cca44a0ba93282af5fca.1162465753.git.andyparkins@gmail.com> <200611021111.09434.andyparkins@gmail.com> <7v64dxl0bf.fsf@assigned-by-dhcp.cox.net> <200611030841.05888.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 3 Nov 2006 10:52:04 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <200611030841.05888.andyparkins@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30820>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfweJ-0006Zo-P5 for gcvg-git@gmane.org; Fri, 03 Nov
 2006 11:51:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753206AbWKCKvp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 05:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753209AbWKCKvo
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 05:51:44 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:3984 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1753206AbWKCKvo (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 05:51:44 -0500
Received: by smtp-gw1.op5.se (Postfix, from userid 588) id 3C6816BD29; Fri, 
 3 Nov 2006 11:51:43 +0100 (CET)
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id CE6066BCD9; Fri,  3 Nov 2006 11:51:39 +0100 (CET)
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:
> Digressing a little: what is the polite form of patches for git?  My strategy 
> with this set was to make each patch as small as possible to reach my end 
> point.  If those patches were okayed on the list, I could then do a "make 
> more beautiful" patch, which is really nothing to do with the original 
> changes to functionality but would make the code prettier.

I believe the order of preferrence goes: tested, concise, short.

Linus has a nasty habit of ending his mails with "totally untested 
ofcourse", which is not a good strategy to adopt if you want your 
patches included.

>  Really I'm asking 
> what level of intrusiveness of patch is not considered rude?  In making my 
> patches, should I ride rough-shod over current implementation and just do it 
> how I'd do it or should I try to fit in (as I did in this case)?
> 

If you *need* to change something, change it. If you *want* to change 
something just because it's not written the way you would write it, back 
away. If you think some interface you're using needs clearing up 
(codewise or with extra comments), send a separate patch for that so the 
actual feature/bugfix you're sending in doesn't drown in cosmetic 
changes to the interfaces the patch uses/touches.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
