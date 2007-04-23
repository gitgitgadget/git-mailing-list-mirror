From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 23 Apr 2007 19:07:34 +0200
Message-ID: <81b0412b0704231007i81ee20cx9a37f1c8a3df62b1@mail.gmail.com>
References: <7vodly0xn7.fsf@assigned-by-dhcp.cox.net>
	 <7vr6qlxexe.fsf@assigned-by-dhcp.cox.net>
	 <7v647tcjr6.fsf@assigned-by-dhcp.cox.net>
	 <7vejmdq63w.fsf@assigned-by-dhcp.cox.net>
	 <7v647ninbq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 23 19:07:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg20p-0000xf-9L
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 19:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030285AbXDWRHg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 13:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030370AbXDWRHg
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 13:07:36 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:18972 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030285AbXDWRHf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 13:07:35 -0400
Received: by an-out-0708.google.com with SMTP id b33so1886865ana
        for <git@vger.kernel.org>; Mon, 23 Apr 2007 10:07:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y2kYq6EimzJqWoiFQD7SsQwABaZgqkEpOs0ED9DLM/vChoUWjmT3Zj9ikdDWSZOkRgTsmwqEO4bz4XrXv92DLnw6ftv4IoCAMrFaGQ50+4392YqvLHkc218pQJonGF/Q38/x6hI9DjbEogcc5Gcjq16peQx0QSYB2Tb1JI1RXQw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e7whjvrrcHmodXedWa5v14LKqseFSp1beHQ4XLw50gbdyg9zxtqBmFrk8jGJ74LNxvIrxhEWptjVDU5BcnVOpwcAwlZ6tH6E+vmRF7MBbvtTrYhWTKK6QxK2dKxncKXXbJYJVMXbLhOgJIZ80g/3QMc++5sg6S+WDk04OKZfyL0=
Received: by 10.100.133.9 with SMTP id g9mr3891218and.1177348054681;
        Mon, 23 Apr 2007 10:07:34 -0700 (PDT)
Received: by 10.100.225.3 with HTTP; Mon, 23 Apr 2007 10:07:34 -0700 (PDT)
In-Reply-To: <7v647ninbq.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45336>

On 4/23/07, Junio C Hamano <junkio@cox.net> wrote:
> * jc/attr (Sat Apr 21 03:14:13 2007 -0700) 2 commits
>  - Add 'filter' attribute and external filter driver definition.
>  - Add 'ident' conversion.
>
> As 'ident' conversion is stateless, I do not mind too much
> including it in v1.5.2-rc1.  On the other hand, the arbitrary
> 'filter' is quite contentious, although the character-code
> conversion example I gave myself might be a good enough reason
> for people to want it.  Undecided.

Can I suggest a config option to completely disable content
munging code? So that people who really care about the
real content, or just don't have the tools for the filters still
can checkout the repos depending on the filters.
