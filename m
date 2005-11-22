From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Re: [PATCH] Fix git.c compilation target
Date: Tue, 22 Nov 2005 08:47:50 +0100
Message-ID: <81b0412b0511212347n6f478824i7ad0ffdaa78285f3@mail.gmail.com>
References: <81b0412b0511210010m66a3f898q6d108a799de023d9@mail.gmail.com>
	 <81b0412b0511210124u5cc0d4efv2045123d92872c66@mail.gmail.com>
	 <7vlkzhmwq4.fsf@assigned-by-dhcp.cox.net> <43825BCF.8040402@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 08:48:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeSsd-0007uV-6F
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 08:47:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbVKVHrw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 02:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbVKVHrw
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 02:47:52 -0500
Received: from nproxy.gmail.com ([64.233.182.204]:60312 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932382AbVKVHrv convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 02:47:51 -0500
Received: by nproxy.gmail.com with SMTP id n28so117199nfc
        for <git@vger.kernel.org>; Mon, 21 Nov 2005 23:47:50 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X4tQ2ey5tVPQmikyd7PDWUNjMX4auvRg7ZrJGKmitRnn7d7wmamQ0cPqf5Re4qiK42QqED0PnZtZ5tARnHeK9SjyRODYgdwIG3vd19nAKR49mUQta8VBUdEcs4LmDEB72uSG+leLjbjTCZNAtm24X3JALDZrKa1NZUrZXzkGqpk=
Received: by 10.48.163.13 with SMTP id l13mr345404nfe;
        Mon, 21 Nov 2005 23:47:50 -0800 (PST)
Received: by 10.48.248.18 with HTTP; Mon, 21 Nov 2005 23:47:50 -0800 (PST)
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43825BCF.8040402@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12534>

On 11/22/05, Andreas Ericsson <ae@op5.se> wrote:
> >  - make git$(X) part of PROGRAMS (probably it is a
> >    SIMPLE_PROGRAM that does not link with many extra stuff, or a
> >    class on its own);
> >
> >  - have "install" target depend on "all".
> >
>
> Something like this?
>
> ##########
> Introduce $(ALL_PROGRAMS) for 'all:' and 'install:' to operate on.
>

Yes, that's what I _actually_ mean :)
