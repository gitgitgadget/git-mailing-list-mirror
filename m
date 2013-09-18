From: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] build: add default configuration
Date: Wed, 18 Sep 2013 13:23:29 -0500
Message-ID: <CAMP44s35_emnh9Kce433oy1JW66xB2vaN5f5OO7VF1XqoO=YGQ@mail.gmail.com>
References: <1379423650-1311-1-git-send-email-felipe.contreras@gmail.com>
	<e8ccfba3-5198-4986-9b9d-1d69b965386f.maildroid@localhost>
Reply-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, 
	=?UTF-8?Q?Br=C3=A1ulio_Bhavamitra?= <brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: David Aguilar <davvid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-From: git-users+bncBDBJVMGGZYNBBIO746IQKGQEQBZHMQA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Wed Sep 18 20:23:33 2013
Return-path: <git-users+bncBDBJVMGGZYNBBIO746IQKGQEQBZHMQA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcggu-git-users@m.gmane.org
Received: from mail-ee0-f62.google.com ([74.125.83.62])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-users+bncBDBJVMGGZYNBBIO746IQKGQEQBZHMQA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1VMMPT-0008IA-Eq
	for gcggu-git-users@m.gmane.org; Wed, 18 Sep 2013 20:23:31 +0200
Received: by mail-ee0-f62.google.com with SMTP id c41sf755770eek.7
        for <gcggu-git-users@m.gmane.org>; Wed, 18 Sep 2013 11:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:x-original-sender:x-original-authentication-results:reply-to
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=oJWWpx4d9PzI2gH37MI16/yYnhz0M59yH+r4IE5Iv54=;
        b=UY5oqpNVGhxcYxpMQ1CHB/PgfPwN4x+Yd83TM2BwZTsYzQQfZFCfY7Z1xSkutJUMJj
         mHHzk5lmv0egQiFXoSKRQebd/9wjcMaKwASQXC9uuV/NCxIJJ3pWd4iu646wu5IqSyMn
         sstltVWwUadnegbwPvLXOhvQv3vv/9dQ9h3QNmsjO3fANT2BRcJWRm79Y/NUQGwFW40r
         iLymZTVlP/6yi+mcUIobq0eKOMvSeCCopmO8ddZx8CIh4ck8z9bAAa93wQte5FByTj/i
         vUYvugepQgfJFQpBPTeBVKgDnY3HaRB1Dz9izlfNUaOjb1iplMSTW6mH5Z7I10YdZVou
         sDYQ==
X-Received: by 10.180.206.205 with SMTP id lq13mr375873wic.14.1379528611160;
        Wed, 18 Sep 2013 11:23:31 -0700 (PDT)
X-BeenThere: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.180.98.37 with SMTP id ef5ls1343098wib.35.canary; Wed, 18 Sep
 2013 11:23:29 -0700 (PDT)
X-Received: by 10.205.5.202 with SMTP id oh10mr5320308bkb.3.1379528609463;
        Wed, 18 Sep 2013 11:23:29 -0700 (PDT)
Received: from mail-la0-x234.google.com (mail-la0-x234.google.com [2a00:1450:4010:c03::234])
        by gmr-mx.google.com with ESMTPS id jt16si229900bkb.0.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Sep 2013 11:23:29 -0700 (PDT)
Received-SPF: pass (google.com: domain of felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 2a00:1450:4010:c03::234 as permitted sender) client-ip=2a00:1450:4010:c03::234;
Received: by mail-la0-f52.google.com with SMTP id ev20so5913406lab.39
        for <git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Wed, 18 Sep 2013 11:23:29 -0700 (PDT)
X-Received: by 10.152.26.72 with SMTP id j8mr35969868lag.19.1379528609146;
 Wed, 18 Sep 2013 11:23:29 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Wed, 18 Sep 2013 11:23:29 -0700 (PDT)
In-Reply-To: <e8ccfba3-5198-4986-9b9d-1d69b965386f.maildroid@localhost>
X-Original-Sender: felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates
 2a00:1450:4010:c03::234 as permitted sender) smtp.mail=felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org;
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234981>

On Wed, Sep 18, 2013 at 1:13 PM, David Aguilar <davvid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Apologies for top post -- anybody have a recommendation for a better app then maildroid?
>
> Will this not conflict with folks that supply their own gitconfig?

You mean people that provide their own ETC_GITCONFIG? If you mean
distributions, their packaging would override /etc/gitconfig, if you
mean people that have already a /etc/gitconfig, packaging systems
usually save the old one so they can solve the conflict manually (e.g.
/etc/gitconfig.pacsave). So no, it would not conflict. If you mean
people that have ~/.gitconfig, then absolutely not, because that one
takes precedence.

Alternatively, we could have a higher level configuration file (e.g.
/usr/share/git/config), but I think that's overkill.

> I like the idea. Docs?  Also, should this not be done in the C side so that we don't waste time reading the config, and also prevent users from overriding these?

But we want them to be easily readable, and possibly allow
distributions to easily modify them.

-- 
Felipe Contreras

-- 
You received this message because you are subscribed to the Google Groups "Git for human beings" group.
To unsubscribe from this group and stop receiving emails from it, send an email to git-users+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/groups/opt_out.
