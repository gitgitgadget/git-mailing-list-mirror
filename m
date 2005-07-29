From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [RFC] extending git-ls-files --exclude.
Date: Fri, 29 Jul 2005 09:49:03 -0400
Message-ID: <42EA33CF.3080302@gmail.com>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca> <7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com> <20050722192424.GB8556@mars.ravnborg.org> <7vy87yr2xh.fsf@assigned-by-dhcp.cox.net> <20050722205948.GE11916@pasky.ji.cz> <7vd5p73jlu.fsf@assigned-by-dhcp.cox.net> <20050728155210.GA17952@pasky.ji.cz> <42E9020F.3080302@gmail.com> <pan.2005.07.28.19.25.39.562903@smurf.noris.de> <20050729072157.GD24895@pasky.ji.cz>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 15:49:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyVEj-0004or-Pd
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 15:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbVG2NtK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 09:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262594AbVG2NtK
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 09:49:10 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:28649 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262571AbVG2NtI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2005 09:49:08 -0400
Received: by wproxy.gmail.com with SMTP id i34so50625wra
        for <git@vger.kernel.org>; Fri, 29 Jul 2005 06:49:06 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=I1O8HIm3YnFjYIQZVgVHGjQo0veBrSMI38CgUzKL2cYHpYi35fUIPQNRJZAYSAchpJPRqJQkaMXHuIVAB9eUj3upjvX8aSsOTf+3Zr2HaBt2HN3HGK4GAL+MefEOxLmOSzKZ1O0vgQ+doDGgDAY7UeAOqB8pCPU2+qF42kIu7Eo=
Received: by 10.54.73.15 with SMTP id v15mr1341666wra;
        Fri, 29 Jul 2005 06:49:06 -0700 (PDT)
Received: from ?10.0.0.6? ([70.89.97.97])
        by mx.gmail.com with ESMTP id 45sm2163700wri.2005.07.29.06.49.05;
        Fri, 29 Jul 2005 06:49:06 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050729072157.GD24895@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:
> Dear diary, on Thu, Jul 28, 2005 at 09:25:45PM CEST, I got a letter
> where Matthias Urlichs <smurf@smurf.noris.de> told me that...
>>Hi, A Large Angry SCM wrote:
>>
>>>So you're arguing for "last match wins" versus "first match wins". I, 
>>>personally, find the former more natural and easier to debug by hand.
>>You know, up until five minutes ago, I thought so too.
> 
> So is the Large Angry SCM agreeing with me or not? I wrote long reply to
> his mail, then reread what he wrote again, and decided that he is
> _agreeing_ with me and you that "last match wins" is better. :-)
> 

*Oops!*

Yes, it looks that way doesn't it. But I had accidentally [*1*] typed 
"former" where I wanted "later". Either way works as long as it's well 
documented/understood.

[*1*] Either too much or too little caffeine at the time I suspect.
