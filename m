From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: "git-send-pack"
Date: Sat, 02 Jul 2005 14:12:03 -0400
Message-ID: <42C6D8F3.7050204@gmail.com>
References: <Pine.LNX.4.21.0506301651250.30848-100000@iabervon.org>	 <Pine.LNX.4.58.0506301514240.14331@ppc970.osdl.org>	 <42C482ED.1010306@zytor.com>	 <Pine.LNX.4.58.0506301656570.14331@ppc970.osdl.org>	 <42C5D553.80905@timesys.com>	 <Pine.LNX.4.58.0507011831060.2977@ppc970.osdl.org>	 <42C61351.10306@zytor.com>	 <Pine.LNX.4.58.0507012119360.3019@ppc970.osdl.org>	 <42C61818.30109@zytor.com>	 <Pine.LNX.4.58.0507021009580.3019@ppc970.osdl.org> <12c511ca05070210441c0d3a33@mail.gmail.com> <42C6D36D.4060006@zytor.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jul 02 20:12:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DomTW-0004ta-3w
	for gcvg-git@gmane.org; Sat, 02 Jul 2005 20:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVGBSMK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jul 2005 14:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVGBSMK
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jul 2005 14:12:10 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:60601 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261247AbVGBSMH (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Jul 2005 14:12:07 -0400
Received: by wproxy.gmail.com with SMTP id i31so499499wra
        for <git@vger.kernel.org>; Sat, 02 Jul 2005 11:12:05 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=gYdQY7eCQEk5nhMvlOv1XtLIZOa4nD7Lp+G9vAmdcUrkEpfcHO1Enw3FFpl9VBRj6s0aIJYqvw0RqGaF8tQEZfm3fy/A67vcbf/2hNt4eOIGoLu5lgeJsy5qQC8oxpjkbMMR8rItqFgGd+yTA1ld+uqlxXh6H4vNmY06wU16nHU=
Received: by 10.54.16.30 with SMTP id 30mr2562627wrp;
        Sat, 02 Jul 2005 11:12:05 -0700 (PDT)
Received: from ?10.0.0.6? ([70.89.97.97])
        by mx.gmail.com with ESMTP id d8sm2739881wra.2005.07.02.11.12.04;
        Sat, 02 Jul 2005 11:12:05 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <42C6D36D.4060006@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

H. Peter Anvin wrote:
> Tony Luck wrote:
>>
...
> 
> This is why I've been talking about a global object repository -- 
> including the problems associated with them.  git as it currently stands 
> permit a single global object store, *except* for the issue of duplicate 
> tags.

So why not store just the git objects in the global repository and keep
all the things that reference an object (HEAD, branches/*, refs/*/*,
etc.) in a per project and/or contributor area like it is currently?
