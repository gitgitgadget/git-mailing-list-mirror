X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] Add git-count-packs, like git-count-objects.
Date: Thu, 2 Nov 2006 16:30:16 +0700
Message-ID: <fcaeb9bf0611020130r70ed6f4cnf67586deff36452e@mail.gmail.com>
References: <20061028040056.GA14191@spearce.org>
	 <7v8xj1axlm.fsf@assigned-by-dhcp.cox.net>
	 <20061028065143.GA14607@spearce.org> <ehvpcs$20j$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 2 Nov 2006 09:30:38 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tuwuScufd7ABqxbRIdEW9/w7ONxvvjvmoYwOU+zrpmdp8P3BCKcJPmKgtXyRwywPMXztpMErI62K9/mludmMpYUNPt6KwiVvtuL5ehka2leJRWi6W3hbkSFFlSKrsazwBCXrom4i0wvjp2S8HR6IpV8alDAFGeUqtjvWbJVH/aY=
In-Reply-To: <ehvpcs$20j$2@sea.gmane.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30698>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfYtz-0000LG-Kj for gcvg-git@gmane.org; Thu, 02 Nov
 2006 10:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752771AbWKBJaU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 04:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752772AbWKBJaT
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 04:30:19 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:43206 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1752771AbWKBJaS
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 04:30:18 -0500
Received: by ug-out-1314.google.com with SMTP id m3so72959ugc for
 <git@vger.kernel.org>; Thu, 02 Nov 2006 01:30:17 -0800 (PST)
Received: by 10.78.97.7 with SMTP id u7mr298104hub.1162459816289; Thu, 02 Nov
 2006 01:30:16 -0800 (PST)
Received: by 10.78.100.8 with HTTP; Thu, 2 Nov 2006 01:30:16 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On 10/28/06, Jakub Narebski <jnareb@gmail.com> wrote:
> Perhaps to nod add yet another command to already large set, rename
> git-count-objects to git-count end enhance it to count both loose objects
> and packs (or not, and use git-count-objects name).

Oh if so, I'd suggest git-stats over git-count :-)
-- 
