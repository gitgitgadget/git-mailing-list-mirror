X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Add support to git-branch to show local and remote branches
Date: Fri, 3 Nov 2006 13:40:30 +0100
Message-ID: <200611031240.34177.andyparkins@gmail.com>
References: <7v64dxl0bf.fsf@assigned-by-dhcp.cox.net> <200611031052.16095.andyparkins@gmail.com> <7vhcxg91gq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 3 Nov 2006 12:41:13 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=TZWxJltOwS3w7Pf9PL81h9hObsTe61TG+GGNwZy/9Vre9ommVy6MSD7kyjmAulU25WQiLkVj89uiPLwjsRZo1wps3y/NXvL/PE7A2LfAmTrPTvoZhHwRoB+RAr8rq9rYH2T6csrZB51sOkxiDsHHnnWXJf4HH6x5eGp1fhDua6s=
User-Agent: KMail/1.9.5
In-Reply-To: <7vhcxg91gq.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30841>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfyLi-00085K-DJ for gcvg-git@gmane.org; Fri, 03 Nov
 2006 13:40:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750956AbWKCMkj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 07:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWKCMkj
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 07:40:39 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:41484 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1750956AbWKCMkj
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 07:40:39 -0500
Received: by ug-out-1314.google.com with SMTP id m3so393475ugc for
 <git@vger.kernel.org>; Fri, 03 Nov 2006 04:40:37 -0800 (PST)
Received: by 10.66.243.4 with SMTP id q4mr2624387ugh.1162557636987; Fri, 03
 Nov 2006 04:40:36 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id 28sm797037ugc.2006.11.03.04.40.36; Fri, 03 Nov 2006 04:40:36 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Friday 2006 November 03 12:08, Junio C Hamano wrote:

> > +static int tidy_ref_list( struct ref_list *ref_list )
>
> Style.  No spaces before or after parameter list.

Bah!  It's so hard getting my fingers to remember what style goes in which 
project :-)

> I see you already parse "refs/tags" prefix. "git branch" would
> not print tags, but that part might be useful when we want to
> redo git-tag in C.

I'm going to have a look at that soon; I've got enough of a hang of things 
with this git-branch work that I think I could cope with writing git-tag in 
C.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
