From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Git 1.1.6.g4d44 make test FAILURE report
Date: Fri, 10 Feb 2006 19:52:00 -0800
Message-ID: <43ED5F60.1010408@gmail.com>
References: <43ED0368.7020204@gmail.com>	<7vhd76vqrg.fsf@assigned-by-dhcp.cox.net> <43ED3FD3.7020005@gmail.com> <7vvevmtza4.fsf@assigned-by-dhcp.cox.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 11 04:52:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7lnt-0004rH-4s
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 04:52:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWBKDwF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 22:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWBKDwF
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 22:52:05 -0500
Received: from xproxy.gmail.com ([66.249.82.207]:32911 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932214AbWBKDwE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2006 22:52:04 -0500
Received: by xproxy.gmail.com with SMTP id t15so364230wxc
        for <git@vger.kernel.org>; Fri, 10 Feb 2006 19:52:03 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=b81bUu+c4wdFZstXTojU/tFsnIOVc9fhC6SVthelffcWD3dTi/hopeZw96FIdri8ybztjbDQzs8mgl8HbgEgwGulVyOJyzC5WFh2fIomEqviaquhwow5sqaw+itkI1kzx2eZxc6YSiSHzPxXIWP/j3OFf4claSUABU7ijSDKjdg=
Received: by 10.70.124.11 with SMTP id w11mr141026wxc;
        Fri, 10 Feb 2006 19:52:03 -0800 (PST)
Received: from ?10.0.0.6? ( [68.234.172.144])
        by mx.gmail.com with ESMTP id i35sm2890578wxd.2006.02.10.19.52.02;
        Fri, 10 Feb 2006 19:52:03 -0800 (PST)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvevmtza4.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15920>

Junio C Hamano wrote:
> A Large Angry SCM <gitzilla@gmail.com> writes:
> 
>>Also, git-var complains when used by an account with an empty gcos
>>field; thereby, breaking all the non-C git commands even when the user
>>is not committing.
>>
>>If the _intent_ was to force commiters and author names in commits,
>>why was the test not placed only in commit-tree.c?
> 
> git-var was more or less intentional.  Scripts such as
> git-applypatch, git-commit and git-tag use the command to grab
> COMMITTER_IDENT to generate sign-off line and tagger information
> when asked, and commit-tree.c changes alone would not catch
> them.
> 
> A user eventually would make commit so it may not be a too bad
> to _strongly_ encourage setting up these environment variables,
> by being nasty ;-).  I agree it would be _very_ annoying until
> you either fix your gecos and/or environment.
> 
> Ideas welcome.

It also breaks a lot of commands not related to making commits; 
git-fetch for one.
