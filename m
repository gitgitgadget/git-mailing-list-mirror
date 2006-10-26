X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Improve git-prune -n output
Date: Thu, 26 Oct 2006 18:37:23 +0100
Message-ID: <200610261837.31356.andyparkins@gmail.com>
References: <200610261138.24761.andyparkins@gmail.com> <7vlkn3kn65.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 26 Oct 2006 17:40:26 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=MIjqejyXRlAhYwRkJ4m6tFuGTtEEw0BGihBDb3//B/2UsoX+KMOyb77nFhrWJywa3kbuFHVw5ryWjp0VblNPiqkd+7VJyktLu2K5voP7Usip4743/JQpWfQn1f+IaO9TDmSEmzXw1z0NjCc3jiBmerOeKzL4y+UTX7jv2Q/GdAM=
User-Agent: KMail/1.9.5
In-Reply-To: <7vlkn3kn65.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30252>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd9DA-0006WH-7X for gcvg-git@gmane.org; Thu, 26 Oct
 2006 19:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423465AbWJZRkI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 13:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423686AbWJZRkH
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 13:40:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:58684 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1423465AbWJZRkB
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 13:40:01 -0400
Received: by ug-out-1314.google.com with SMTP id 32so437995ugm for
 <git@vger.kernel.org>; Thu, 26 Oct 2006 10:40:00 -0700 (PDT)
Received: by 10.67.117.2 with SMTP id u2mr3256422ugm; Thu, 26 Oct 2006
 10:39:59 -0700 (PDT)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id u1sm570474uge.2006.10.26.10.39.58; Thu, 26 Oct
 2006 10:39:59 -0700 (PDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Thursday 2006, October 26 18:21, Junio C Hamano wrote:

> I do not have an objection to what this does, except I wonder if
> somebody's script relies on parsing this output already.

I did think of that, but the existing output looked pretty non-useful for easy 
parsing because of the fact that filenames where being printed instead of 
hashes.  If I were given free reign I think I'd want to drop the "would 
prune" message as well.

> It is customary to have one empty line before the S-o-b: line.

I didn't do it.  Git did :-)  I'll keep an eye out for it from now on.  
Apologies (as usual)


Andy
-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
