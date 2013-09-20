From: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] build: add default configuration
Date: Fri, 20 Sep 2013 16:02:31 -0500
Message-ID: <523cb7e7a2d70_5010801e84148e8@nysa.mail>
References: <1379423650-1311-1-git-send-email-felipe.contreras@gmail.com>
 <e8ccfba3-5198-4986-9b9d-1d69b965386f.maildroid@localhost>
 <CAMP44s35_emnh9Kce433oy1JW66xB2vaN5f5OO7VF1XqoO=YGQ@mail.gmail.com>
 <ab38a1b5-e354-4e32-8ede-46a401ef8053.maildroid@localhost>
 <CAMP44s3Q6ummNmLovw0BuGR=yNWfmRFmrg9xb50OawMwKznfBw@mail.gmail.com>
 <4d9893bc-c812-457b-9f40-ebe01d37df53@email.android.com>
Reply-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 
 git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, 
 =?UTF-8?B?QnLDoXVsaW8gQmhhdmFtaXRyYQ==?= <brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: David Aguilar <davvid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, 
 Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-From: git-users+bncBDBJVMGGZYNBBQPU6KIQKGQE4XP2UII-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Fri Sep 20 23:12:36 2013
Return-path: <git-users+bncBDBJVMGGZYNBBQPU6KIQKGQE4XP2UII-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcggu-git-users@m.gmane.org
Received: from mail-pb0-f61.google.com ([209.85.160.61])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-users+bncBDBJVMGGZYNBBQPU6KIQKGQE4XP2UII-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1VN80B-0000uF-U1
	for gcggu-git-users@m.gmane.org; Fri, 20 Sep 2013 23:12:36 +0200
Received: by mail-pb0-f61.google.com with SMTP id jt11sf210519pbb.26
        for <gcggu-git-users@m.gmane.org>; Fri, 20 Sep 2013 14:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:x-original-sender:x-original-authentication-results
         :reply-to:precedence:mailing-list:list-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type;
        bh=YIB7GY2g7freCmwAnLlDbRhwFPjzkiuFT97g8YFV3NI=;
        b=P3wukF7OFg6PEzpBNPJGv7sIYkkAUCB17Z4auKo8biDtmOB7ATpCussU5h8dhi7ejY
         rDg4FfbutZNXn9eaRlgWjKyqtgHcumry8D1y5hk6eJOK5s6ntQIWqBFM5YRrnSSk0y/X
         Hc2sKQiG224YEKfu2iDZfAAcSBzdc4Ev+4s1y0pbiJ3qjCJ9Lm0QDtxwmK3SP22JVeK/
         L4se/RlIeilbuvEYZyk6od3So0RJXwKOxujJXaMZx5F2oKNZ12eJZXnn2DM9k4S1fWX5
         C2qYfLO5wfnIIyhHTkzfKWA5sUKsW/c7ZyHHMon+e7LZF42NFk1zy9QwesOe9tB7s/4k
         ulBQ==
X-Received: by 10.49.48.38 with SMTP id i6mr440816qen.4.1379711554735;
        Fri, 20 Sep 2013 14:12:34 -0700 (PDT)
X-BeenThere: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.49.24.233 with SMTP id x9ls413900qef.46.gmail; Fri, 20 Sep
 2013 14:12:33 -0700 (PDT)
X-Received: by 10.236.69.35 with SMTP id m23mr3362112yhd.6.1379711553159;
        Fri, 20 Sep 2013 14:12:33 -0700 (PDT)
Received: from mail-ob0-x229.google.com (mail-ob0-x229.google.com [2607:f8b0:4003:c01::229])
        by gmr-mx.google.com with ESMTPS id a42si1718219yhj.6.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 20 Sep 2013 14:12:33 -0700 (PDT)
Received-SPF: pass (google.com: domain of felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 2607:f8b0:4003:c01::229 as permitted sender) client-ip=2607:f8b0:4003:c01::229;
Received: by mail-ob0-f169.google.com with SMTP id wp4so1255349obc.0
        for <git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Fri, 20 Sep 2013 14:12:32 -0700 (PDT)
X-Received: by 10.182.96.100 with SMTP id dr4mr7633107obb.22.1379711552881;
        Fri, 20 Sep 2013 14:12:32 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id d3sm6163443oek.5.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 20 Sep 2013 14:12:31 -0700 (PDT)
In-Reply-To: <4d9893bc-c812-457b-9f40-ebe01d37df53-2ueSQiBKiTY7tOexoI0I+QC/G2K4zDHf@public.gmane.org>
X-Original-Sender: felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates
 2607:f8b0:4003:c01::229 as permitted sender) smtp.mail=felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org;
       dkim=pass header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; contact git-users+owners-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-ID: <git-users.googlegroups.com>
X-Google-Group-Id: 934228491576
List-Post: <http://groups.google.com/group/git-users/post>, <mailto:git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:git-users+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/git-users>
Sender: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/git-users/subscribe>, <mailto:git-users+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/git-users/subscribe>, <mailto:googlegroups-manage+934228491576+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235082>

David Aguilar wrote:
> Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >On Wed, Sep 18, 2013 at 9:30 PM, David Aguilar <davvid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >wrote:
> >>>On Wed, Sep 18, 2013 at 1:13 PM, David Aguilar <davvid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >wrote:
> >>>>
> >>>> Will this not conflict with folks that supply their own gitconfig?
> >>
> >>> You mean people that provide their own ETC_GITCONFIG? If you mean
> >> distributions, their packaging would override /etc/gitconfig, if you
> >> mean people that have already a /etc/gitconfig, packaging systems
> >> usually save the old one so they can solve the conflict manually
> >(e.g.
> >> /etc/gitconfig.pacsave). So no, it would not conflict.
> >>
> >> Yuck. Yes, that one. I package my own /etc/gitconfig (as we have long
> >advertised as the "way to do it")
> >
> >You package /etc/gitconfig *outside* the git package? I don't see how
> >that could have been ever advertised as the way to do it.
> 
> Okay so how exactly are we supposed to do it?  Duh, rpm is the right choice for redhat systems. 

The same way kerberos, mariadb, apache, and essentially every other tool that
has a configuration file in /etc.

> >Users don't package /etc/gitconfig outside git.
> 
> Wrong. Existence proof: me. 

You as a user are not packaging it, it's you as a system adimistrator. Either
way, you are 0.0001% of Git's userbase, you are not representative.

> >>>> I like the idea. Docs?  Also, should this not be done in the C side
> >so that we don't waste time reading the config, and also prevent users
> >from overriding these?
> >>
> >>> But we want them to be easily readable, and possibly allow
> >> distributions to easily modify them.
> >>
> >> In that case I take it back -- I dont like that approach.  We want
> >consistency, not divergence. This encourages the former.
> >
> >So you think we have more consistency right now? We don't even have a
> >predefined /etc/gitconfig, that creates more inconsistency, as
> >everybody's configs and aliases are very very different.
> >
> >This patch would definitely make things more consistent.
> 
> We don't need this patch to allow distros to modify aliases. Likewise, allowing the aliases to diverge is less consistent. Do it at a lower level. 

We already allow the aliases to diverge, we allow it much more.

The pach will make the aliases more consistent.

> I also agree with Junio's notes about "ci". Something short that can add and remove from the index would be nice. 

cvs ci, svn ci, hg ci, they all work, but suddenly ci is not good enough for Git? Yeah, sure.

-- 
Felipe Contreras

-- 
You received this message because you are subscribed to the Google Groups "Git for human beings" group.
To unsubscribe from this group and stop receiving emails from it, send an email to git-users+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/groups/opt_out.
