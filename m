From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: "git-send-pack"
Date: Thu, 30 Jun 2005 14:24:10 -0400
Message-ID: <42C438CA.3040507@gmail.com>
References: <Pine.LNX.4.58.0506301025510.14331@ppc970.osdl.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 30 20:17:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do3b4-0000h7-U0
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 20:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262843AbVF3SYf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 14:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262839AbVF3SYf
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 14:24:35 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:35632 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262836AbVF3SYc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jun 2005 14:24:32 -0400
Received: by wproxy.gmail.com with SMTP id i31so144935wra
        for <git@vger.kernel.org>; Thu, 30 Jun 2005 11:24:32 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=B3fvTGZcL6Jw4mj74PA/u7QmJOLBmz84UBr0Cko47a+oansZX/AfBd8va55Gm2Xn9WXqaCs9MklCmzBq49xPSvKn5OAtiebqBumbPxdKQtVrkAjVznSujmjhv1Xr2nTtiDohn9TEKrmYQM1VYOCMmzouTrWa2AqI/KZsohdgxBg=
Received: by 10.54.18.22 with SMTP id 22mr535438wrr;
        Thu, 30 Jun 2005 11:24:12 -0700 (PDT)
Received: from ?10.0.0.6? ([70.89.97.97])
        by mx.gmail.com with ESMTP id 24sm110081wrl.2005.06.30.11.24.12;
        Thu, 30 Jun 2005 11:24:12 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506301025510.14331@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Have you tried something like the following?

ssh torvalds@master.kernel.org \
	'/bin/sh -c "export PATH=/tmp/foo:$PATH ; env"'

Linus Torvalds wrote:
> 
...
 >
> Anyway, please do give it a test. I think I'll use this to sync up to
> kernel.org, except I _really_ would want to solve that ssh issue some 
> other way than hardcoding the /home/torvalds/bin/ path in my local 
> copies.. If somebody knows a good solution, pls holler.
