From: David Turner <dturner@twopensource.com>
Subject: Re: [WIP PATCH 00/14] Protocol v2 patches
Date: Wed, 25 May 2016 15:31:39 -0400
Organization: Twitter
Message-ID: <1464204699.24478.144.camel@twopensource.com>
References: <1461972887-22100-1-git-send-email-sbeller@google.com>
	 <1464130008.24478.134.camel@twopensource.com>
	 <xmqqfut6150a.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 25 21:31:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5eWx-0005bF-9E
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 21:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108AbcEYTbn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 15:31:43 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:34613 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918AbcEYTbm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 15:31:42 -0400
Received: by mail-qk0-f172.google.com with SMTP id y126so42391550qke.1
        for <git@vger.kernel.org>; Wed, 25 May 2016 12:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=yoYy+93bTU7VUyPu4R6jEvwDfJoeB2/ArczznER+Wcc=;
        b=SA7veX0oRVJcwHJTgJLxI1wkKDWbdjli85KstnXQ4LFgGUzgkouwgRVO5DQJdvDlaO
         ErElc2Cxn3HssCa9LzqbQhF85aEgCwl+xG8e0TmKpGW0EEe57bQ+fbPgs0EhHCpuFgW9
         k5WlOt5WNF4Y09Df2rzNjVo2RFpiXHjQaoD/FbhuqPSLwcbDdSXUf83tKg3AZJQYT9ce
         IyCdqTm3I3t5Jf1sAmGWyOqiIxcXmLi3c209wOaTg9Du1cwrXshYk88543eYxaDVU17g
         VPVP+vtnUB5O2vJwJk/3Yt/FC7LsyKyIJEPMlhNpHLzRWgUKGO5rbQ7wCQjXOrw/b3wy
         PZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=yoYy+93bTU7VUyPu4R6jEvwDfJoeB2/ArczznER+Wcc=;
        b=a7xJZHTgE/1uNK+xH88V7SPHKdeIp2Z9ieJXiP7YwJ0aB142fS7akgwZYAT2sImYvY
         EgyxMpavhSFYzffZ9fnkAWjqdxZugfeMezKRJ33jpkhltP27zNtHpk221UuBc3PnTNv0
         BfFiZ+1Ylcmj7gA26Ef0ZqYYHBch//sTbzAynK18fr3eCPRGmLYA/DF2uivtmXlANDJA
         uwAB1x3Ln7kCmOFlhKUzChRsqGAmpUedjsqpsHfOAXE2+xUJ/J3fK8KtqLxnvDkws4L4
         LzW+xHHzAiY7kdhG4hIDQAQj3oMBshmM1eSgL+9+rFnzo2JruV7Ccp+oLCFtHBez7IhJ
         /WAw==
X-Gm-Message-State: ALyK8tLQlBRzoJ38/LVb580zwkWj0WIwxI8ygaiCtDCbHoo9CRURGyOfsTAgisHVLyjXgg==
X-Received: by 10.233.235.88 with SMTP id b85mr5305619qkg.83.1464204701553;
        Wed, 25 May 2016 12:31:41 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id c203sm2748637qhc.41.2016.05.25.12.31.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 May 2016 12:31:40 -0700 (PDT)
In-Reply-To: <xmqqfut6150a.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295586>

On Wed, 2016-05-25 at 09:23 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > I was looking at this again today, and noticed that it doesn't
> > really
> > address the HTTP case.
> > 
> > The central problem is that protocol v2 goes like this:
> > server: I have capabilities w,x,y, and z
> > client: I want capabilities x and z.
> > 
> > But HTTP goes like this:
> > client: [request]
> > server: [response]
> 
> I wonder if that can be solved by speculative request?
> 
> Let the connection initiator say "If you can do x and z, please do
> so", and allow the responder to say either "OK, I can do x and z; by
> the way the full capabilites I support are w, x, y and z", or
> "Sorry, can't do that; I have capabilities w, x, and y".

That protocol is somewhat more complicated.  And it's different than
the v2 protocol for the other transports (unless you are thinking that
we should change those too?).  It's actually a tiny bit like what I
originally proposed for HTTP. 

It sounds OK to me, but I want to know what others think before I start
implementing.
