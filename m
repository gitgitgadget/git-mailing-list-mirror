From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [BUG?] rebase -i: edit versus unmerged changes
Date: Wed, 20 Mar 2013 13:42:42 -0700
Message-ID: <20130320204242.GA29311@google.com>
References: <CALkWK0n=fb_kq+Ed3rd9MhQUCHY3+_nj=zw4M+GmjbzEO56SOg@mail.gmail.com>
 <CADeaMWoeRQBbrqLsfieKTE2rRbpzU-Hyp+mv-=CTj+=Znmf=Zw@mail.gmail.com>
 <CALkWK0mgX40oicqxnoa7M3NJP_k8jDrg7mVGyWrg5T+=iRtHQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Wong <andrew.kw.w@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 21:43:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIPqy-0007er-Lm
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 21:43:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756178Ab3CTUmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 16:42:52 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:35356 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753080Ab3CTUmv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 16:42:51 -0400
Received: by mail-da0-f46.google.com with SMTP id y19so1207427dan.19
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 13:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=xlOv8I0SIbkK1cj/PvPs7PNeo2ZGzeMDMekJ1/8wNds=;
        b=e6gxYPZB2f3l+rq3zUwYyGBt92JInrvUtzXWRTsiKMXGiIMfegnbzcXmsW2TViEqR1
         Ck1gEnqzGDIn4TVWnF1BQT0Zd77jr3vW04rgvJd/HzNM1jvhCIRaE9X3NtfUw85/1iVa
         bl165ipGgefPQtVpl45bsohM/p2+o8vq0ffkLz8Euvn8voUIQqtjnR5EVj13+Ib6EMNN
         at/x37ITEmAGEhRQqAvJ4fphcPL28XnH2ArKIxgyoDkjvf32US00QNq7MuneG7GwXGeY
         ib/EaLfvWgvp0aNDeElOTiLS3DdMDh9/T7ZWz9R0knEYeNiHUYQ5kg7PVDZcnfss4f4k
         /fdA==
X-Received: by 10.66.240.2 with SMTP id vw2mr11196658pac.157.1363812171271;
        Wed, 20 Mar 2013 13:42:51 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id ax3sm3248593pbd.42.2013.03.20.13.42.48
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 20 Mar 2013 13:42:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0mgX40oicqxnoa7M3NJP_k8jDrg7mVGyWrg5T+=iRtHQA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218677>

Ramkumar Ramachandra wrote:
> Andrew Wong wrote:

>> You can actually rely on "rebase" to run the appropriate command.
>
> Didn't Junio explicitly mention that this is undesirable earlier (from
> the point of view of `rebase -i` design)?

I missed the earlier discussion.  Does the documentation (e.g.,
git-rebase(1)) cover this?  I can't think of any reason off-hand not to
rely on the DWIMery involved in "git rebase --continue".

Curious,
Jonathan
