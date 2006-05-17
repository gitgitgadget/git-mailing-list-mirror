From: "Stefan Pfetzing" <stefan.pfetzing@gmail.com>
Subject: Re: Git 1.3.2 on Solaris
Date: Wed, 17 May 2006 12:41:39 +0200
Message-ID: <f3d7535d0605170341n1a68de90g4deeb3f17a7d9432@mail.gmail.com>
References: <f3d7535d0605161652n3b2ec033r874336082755e728@mail.gmail.com>
	 <7vpsidhx79.fsf@assigned-by-dhcp.cox.net>
	 <f3d7535d0605170206y76e24f25w305a688d32f4a0a1@mail.gmail.com>
	 <7v7j4lhup3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed May 17 12:42:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgJTV-0003B3-Js
	for gcvg-git@gmane.org; Wed, 17 May 2006 12:41:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWEQKll (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 06:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWEQKll
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 06:41:41 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:4060 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932119AbWEQKll convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 May 2006 06:41:41 -0400
Received: by wr-out-0506.google.com with SMTP id i7so180124wra
        for <git@vger.kernel.org>; Wed, 17 May 2006 03:41:40 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cMQMEtrNbAqJapPqd/J+RbRzkrfo8gI8gyZ9rvxkXi/0YfpZkor7w90tZgMlGRati3CWBqSZE0m+zcD6L9mV0OcujPH1CM8Ht68Is4TQEOAUNOV6xDgtVLnoh7kuyXmX7KF4pjIphTETpjouBG72eLilZwXnuZAB69bBEzk6ztQ=
Received: by 10.65.148.2 with SMTP id a2mr851744qbo;
        Wed, 17 May 2006 03:41:39 -0700 (PDT)
Received: by 10.65.20.19 with HTTP; Wed, 17 May 2006 03:41:39 -0700 (PDT)
To: "Git Mailing List" <git@vger.kernel.org>
In-Reply-To: <7v7j4lhup3.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20185>

Hi Junio,

2006/5/17, Junio C Hamano <junkio@cox.net>:
> If you look at our Makefile, you will see bindir does not have
> to be gitexecdir.  The suggestion by Linus is that you set
> bindir to /usr/local/bin or whereever your distribution's
> packaging scheme wants the locally installed software to be that
> is on user's PATH, and gitexecdir to /usr/local/libexec/git
> (again, whereever), _and_ have:
>
>         ln -s /usr/bin/gtr /usr/local/libexec/git/tr
>         ln -s /usr/bin/gxargs /usr/local/libexec/git/xargs
>         ...

Nice, that looks like a solution, but will this also "fix" the tr usage for
the git tests? If so, I'll write a small shellscript to create the links and
so on, and test it on Solaris later today.

bye

dreamind
-- 
       http://www.dreamind.de/
Oroborus and Debian GNU/Linux Developer.
