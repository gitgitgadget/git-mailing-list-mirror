X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 2/4] Rename remote_only to display_mode
Date: Fri, 03 Nov 2006 14:23:46 +0100
Message-ID: <454B42E2.8070001@op5.se>
References: <bec6ab7849e3fcacac23cca44a0ba93282af5fca.1162465753.git.andyparkins@gmail.com> <200611030841.05888.andyparkins@gmail.com> <454B1F3B.1020603@op5.se> <200611031200.27275.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 3 Nov 2006 13:24:07 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <200611031200.27275.andyparkins@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30848>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfz1a-0001eY-FL for gcvg-git@gmane.org; Fri, 03 Nov
 2006 14:23:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752939AbWKCNXy (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 08:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752971AbWKCNXy
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 08:23:54 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:65175 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1752939AbWKCNXx (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 08:23:53 -0500
Received: by smtp-gw1.op5.se (Postfix, from userid 588) id 51B766BD3D; Fri, 
 3 Nov 2006 14:23:52 +0100 (CET)
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 0D6496BD29; Fri,  3 Nov 2006 14:23:47 +0100 (CET)
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:
> On Friday 2006 November 03 10:51, Andreas Ericsson wrote:
> 
>> If you *need* to change something, change it. If you *want* to change
>> something just because it's not written the way you would write it, back
>> away. If you think some interface you're using needs clearing up
>> (codewise or with extra comments), send a separate patch for that so the
>> actual feature/bugfix you're sending in doesn't drown in cosmetic
>> changes to the interfaces the patch uses/touches.
> 
> Thank you for the excellent advice.  What then would you suggest in the case 
> in point?  I made as minimal a change as I could make; but that left the code 
> a little bit bitty - I had press-ganged a variable into taking on another 
> function and was using numeric literals that should really have been given 
> meaning with #define?
> 
> My question is perhaps different from simply git-etiquette; it's should I 
> prefer my patches to be minimal or neat?  If there is a more appropriate way 
> of doing something should I do it or should I favour minimalism?
> 

Neat, imo. Re-using old variables might be appropriate if the name of 
the variable still makes sense, but rename it if there's a better name 
for it.

> I've actually rewritten it now as per Junio's request, and while I'm happier 
> with the code, it was much bigger change, that didn't really lend itself to 
> being broken into smaller patches as did my first attempt.
> 
> I guess in the end it's a judgement call and the best thing to do is post it 
> and see who shoots it down :-)
> 

Probably the most sensible approach. Even though the list is pretty 
trigger-happy, the guns are more of the playful water-squirt type than 
the high-powered big-calibre kind.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
