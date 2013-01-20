From: David Aguilar <davvid@gmail.com>
Subject: Re: Re: [PATCH 1/2] Change old system name 'GIT' to 'Git'
Date: Sat, 19 Jan 2013 16:47:59 -0800
Message-ID: <CAJDDKr4TVC7nWkN++D5FhnG+0qTThHe9LdKT-Y=1wCMU=RR1yQ@mail.gmail.com>
References: <732444561.1327663.1358589465467.JavaMail.ngmail@webmail24.arcor-online.net>
	<379071741.1327695.1358589560822.JavaMail.ngmail@webmail24.arcor-online.net>
	<CAJDDKr5_AWFF6MR2Kwt5FzA0vaSE-wx8xFO3xcRnKZ168hXBrg@mail.gmail.com>
	<310504838.1116553.1358607676116.JavaMail.ngmail@webmail10.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Sun Jan 20 01:48:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Twj5G-0004pb-51
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 01:48:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018Ab3ATAsD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2013 19:48:03 -0500
Received: from mail-ea0-f177.google.com ([209.85.215.177]:34327 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572Ab3ATAsB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2013 19:48:01 -0500
Received: by mail-ea0-f177.google.com with SMTP id n13so1921214eaa.36
        for <git@vger.kernel.org>; Sat, 19 Jan 2013 16:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=0mbJaMMrX0iKZWYYG34qG9BnBWLmrDjCDN9cXPr+JrY=;
        b=hCMpwEOe7u/2p0yb2s0HIuox8mLd0GkMN9o/o773A5o2fZSH6J20gXM6NxfDkHNMXW
         ZmRBwLPIuh7oxdMmriQBZTJHKAwzlsnWSEUxYPno24Q9MzWFpk36xZm/sTCWQtwOwWhV
         Qsr4VZ9cJ25o5MjlMc2pQTqKQhUjOLqQI8DU0bAgNCG7tTj8jJKXvBSeqi37DicB1RLC
         IDHEUic3hSLXl4WGAiY8VbbdGm02uXKptxojlnSY7Qz8B1LTBDM+jWmyN9ZRdIfVTSJp
         xPvZNKjAcYPJfCb5nn++SHBWKj6jHpG3u0lyTnIFpwosmm5J4kg7f7SC7FLvghLK6BNn
         lxSQ==
X-Received: by 10.14.175.70 with SMTP id y46mr43130873eel.6.1358642880135;
 Sat, 19 Jan 2013 16:48:00 -0800 (PST)
Received: by 10.14.125.135 with HTTP; Sat, 19 Jan 2013 16:47:59 -0800 (PST)
In-Reply-To: <310504838.1116553.1358607676116.JavaMail.ngmail@webmail10.arcor-online.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213996>

On Sat, Jan 19, 2013 at 7:01 AM, Thomas Ackermann <th.acker@arcor.de> wrote:
>
>>
>> What about GITweb?
>>
> You are right; I missed that because I grepped only for 'GIT' as a whole word.
> 'gitweb' and 'GITweb' should be changed to 'Gitweb'.
>
>>
>> IMO some of these look nicer when everything is lowercase.
>> e.g. "standard git committer ident format".
>>
> IMHO what seems nicer here is the spelling we are all accustomed to.
> The whole point of my patch is to use 'Git' consistently when
> we are talking about the system and not the individual command.
>
>>
>> $ git grep 'git repositor' | wc -l
>> 226
>>
>> These changes touch, for example, git-clone.txt to make it
>> say: "Make a 'bare' Git repository".  Why not lowercase?
>>
> When you also apply my second patch you only get 17 occurences of "git repository"
> which I missed to change to 'Git repository' ...
>
> Thanks for looking into this!

Thank *you* for tackling these last 226 and listening to my silly opinions.
The end result will be much nicer all around.
-- 
David
