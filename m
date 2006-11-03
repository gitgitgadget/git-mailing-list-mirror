X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Added description for reversing git-update-index using --index-info
Date: Fri, 3 Nov 2006 09:21:52 +0100
Message-ID: <200611030821.54350.andyparkins@gmail.com>
References: <200611021113.01812.andyparkins@gmail.com> <7vfyd1mew3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 3 Nov 2006 08:22:35 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dFodINo9ydWXP+Sr2eUKlk78Wuzhshl8cSqcNxVPbRObbIX1Uace0QUVSQmwpIvcacr44PWAMl5MrZRQwN1TgWJYBSmpbLljdkg/k8HI6nIZ3RsRwj1VbmRaQkpNl1kNuCC5f8AChkX8H/NMTw9TsnqRC+pumbqFKAjHYSETqLI=
User-Agent: KMail/1.9.5
In-Reply-To: <7vfyd1mew3.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30795>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfuJe-0007Bs-3g for gcvg-git@gmane.org; Fri, 03 Nov
 2006 09:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751552AbWKCIWC (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 03:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751601AbWKCIWB
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 03:22:01 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:47768 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1751552AbWKCIWA
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 03:22:00 -0500
Received: by ug-out-1314.google.com with SMTP id m3so348586ugc for
 <git@vger.kernel.org>; Fri, 03 Nov 2006 00:21:59 -0800 (PST)
Received: by 10.67.19.17 with SMTP id w17mr2253365ugi.1162542118759; Fri, 03
 Nov 2006 00:21:58 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id k2sm535834ugf.2006.11.03.00.21.58; Fri, 03 Nov 2006 00:21:58 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Friday 2006 November 03 02:40, Junio C Hamano wrote:

> > +git ls-tree -r HEAD | git update-index --index-info
>
> While this is correct in the mechanical sense, it _sucks_ as an
> example, especially since you do not mention that the user would
> most likely need to do 'git update-index --refresh' afterwards
> to make the result useful.

I'm happy to ditch it if you wish; I included it only because it was one of 
the examples that Shawn gave me in my original question.

Would you like a new patch?


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
