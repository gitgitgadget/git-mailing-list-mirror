From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Fix interesting git-rev-list corner case
Date: Fri, 29 Jul 2005 21:08:17 -0400
Message-ID: <42EAD301.90804@gmail.com>
References: <Pine.LNX.4.58.0507291542060.29650@g5.osdl.org> <20050730001158.GF32263@mythryan2.michonline.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 30 03:13:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dyfu5-0005Xk-8Z
	for gcvg-git@gmane.org; Sat, 30 Jul 2005 03:12:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262892AbVG3BJ6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 21:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262870AbVG3BJr
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 21:09:47 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:23192 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262865AbVG3BIV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2005 21:08:21 -0400
Received: by wproxy.gmail.com with SMTP id i6so773784wra
        for <git@vger.kernel.org>; Fri, 29 Jul 2005 18:08:20 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=p86vCrIgYO+95jlybQbHQA+NmKcpBJO8LSmfkHAccxNchg/5UZvjSuMbI3gLU1OtenBKUw80n/tTdlZ3p7utrGZv/TX2hFeHhVYV1eXDghe2rnDawD1FvvlZDdlkR8Hv2L2kYDwdmY6GB8BKQfn7BqSMYw9EOW3bOvntYIqc3jI=
Received: by 10.54.46.20 with SMTP id t20mr1672344wrt;
        Fri, 29 Jul 2005 18:08:20 -0700 (PDT)
Received: from ?10.0.0.6? ([70.89.97.97])
        by mx.gmail.com with ESMTP id g3sm33646wra.2005.07.29.18.08.20;
        Fri, 29 Jul 2005 18:08:20 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20050730001158.GF32263@mythryan2.michonline.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ryan Anderson wrote:
> Maybe it'd make sense to have the commits refuse to add a commit when it
> would be younger than one of it's parents?

Better not to trust timestamps in distributed federations since you 
can't guarantee any kind of accuracy across administrative boundaries.
