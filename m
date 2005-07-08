From: Bryan Larsen <bryan.larsen@gmail.com>
Subject: Re: patches to support working without the object database
Date: Fri, 08 Jul 2005 16:09:45 -0400
Message-ID: <42CEDD89.6010200@gmail.com>
References: <42CE5764.9010405@gmail.com> <7vwto16t6h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 08 22:23:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqzNV-0000ky-Je
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 22:23:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262857AbVGHUWd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 16:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262886AbVGHUT5
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 16:19:57 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:57570 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262872AbVGHUT0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jul 2005 16:19:26 -0400
Received: by zproxy.gmail.com with SMTP id i1so237119nzh
        for <git@vger.kernel.org>; Fri, 08 Jul 2005 13:19:25 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=fwGoqJroM91QdjiuYrwY2C9j/MagyXrFVsJVn4pPnAIC6eMDtjDrL08DekANCtaujMpcGKD925E/kOeOB6UMY4NaXtxPa6F17e3JOXMJzonsj1KWBJWpwyX6qakYPKsPNvxeVOWnX5f82gz+gLvXCZZOsRdgEU6x35LffC+yxKw=
Received: by 10.36.221.60 with SMTP id t60mr638590nzg;
        Fri, 08 Jul 2005 13:19:25 -0700 (PDT)
Received: from ?192.168.1.100? ([70.26.43.137])
        by mx.gmail.com with ESMTP id 12sm1062843nzn.2005.07.08.13.19.25;
        Fri, 08 Jul 2005 13:19:25 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwto16t6h.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
>>>>>>"BL" == Bryan Larsen <bryan.larsen@gmail.com> writes:
> 
> 
> BL> Sometimes you may wish to keep an audit trail of what changed, where,
> BL> and by whom.  You do not need to know the exact details of the change,
> BL> and the files are so large that keeping an extra copy of the data in
> BL> the object database cache is prohibitively expensive.
> 
> I am basically OK with this patch series, except I have one
> minor problem about interface detail, and more seriously, that
> the patch is whitespace mangled and would not apply.  E.g.
 >
* SNIP *
> 
> Also please make sure that core GIT part patch applies against
> Linus tip (especially [PATCH 2/7]) as well. I think it does, but
> please double check.
> 
> 
I had trouble getting tip.  That may be because I'm on OS X: I want to 
try it on
a Linux box to narrow down the source of my problems.  Given that it's 
currently
4PM on Friday, I don't think the IT staff is going to fix the firewall 
before Monday.
So please excuse me while I scrounge up another Linux box or two.

After that happens, I'll fix up my patches as suggested by you and 
Linus, get
myself a real mailer and resubmit.

thanks,
Bryan
