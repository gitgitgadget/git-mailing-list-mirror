X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: What's in git.git (stable)
Date: Thu, 14 Dec 2006 10:03:57 +0000
Message-ID: <200612141003.58418.andyparkins@gmail.com>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net> <200612140927.27259.andyparkins@gmail.com> <20061214093637.GC1747@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 10:04:12 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=uUobYPeOnW953AGtK3bSV8qKPo7PMlHvKIpNWHq1NZbCdzWZykWTs/LY32NdxDJb4mKhTTvGjPj/Q1pNf6bGyPRJQbmevhZynz9TqjGlHfwjnFHjlrI+BLNT2rj7Wk8JMggIdL4PP58xJQGCMbB3ZhEs3w37jJ3mfGRzk501tm8=
User-Agent: KMail/1.9.5
In-Reply-To: <20061214093637.GC1747@spearce.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34297>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GunRg-0002jr-SN for gcvg-git@gmane.org; Thu, 14 Dec
 2006 11:04:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751825AbWLNKEF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 05:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751839AbWLNKEF
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 05:04:05 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:29586 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751825AbWLNKEC (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec
 2006 05:04:02 -0500
Received: by ug-out-1314.google.com with SMTP id 44so446182uga for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 02:04:01 -0800 (PST)
Received: by 10.67.19.13 with SMTP id w13mr1167172ugi.1166090641710; Thu, 14
 Dec 2006 02:04:01 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id m1sm1834886ugc.2006.12.14.02.04.01; Thu, 14 Dec 2006 02:04:01 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Thursday 2006 December 14 09:36, Shawn Pearce wrote:

> But I'm not sure that git-add should output anything.  Last I checked
> the 'mv' command in Linux doesn't say "Move 5 files" when I move 5
> files into a directory.  Likewise I don't think that knowing that
> 6781 files were added is useful, what if it should have really been
> 6782 files?  I'm unlikely to know, care, or realize it.

That's a very particular example you've picked out there.  Of course the user 
won't know if it should be 6781 or 6782; they might know if it should have 
been 2 or 10 though; 0 or 100.  In your example, output like "about six and a 
half thousand", would probably be perfectly useful, but why not just output 
the number?

> Your niggle list (is that what you called it) has been useful
> fodder for discussion.  I'm glad you took the time to write it up,
> and to argue it so well on the list.  There's a number of items on
> it that I'd like to see happen too; enough that I may code some of
> them if nobody beats me to it.

I'm glad it was useful.  I never know how many disclaimers to put on these 
things.  I always feel that every message I write should begin with "I love 
git and use it every day, so please don't take this the wrong way, but..."



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
