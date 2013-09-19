From: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] build: add default configuration
Date: Wed, 18 Sep 2013 22:49:06 -0500
Message-ID: <CAMP44s3Q6ummNmLovw0BuGR=yNWfmRFmrg9xb50OawMwKznfBw@mail.gmail.com>
References: <1379423650-1311-1-git-send-email-felipe.contreras@gmail.com>
	<e8ccfba3-5198-4986-9b9d-1d69b965386f.maildroid@localhost>
	<CAMP44s35_emnh9Kce433oy1JW66xB2vaN5f5OO7VF1XqoO=YGQ@mail.gmail.com>
	<ab38a1b5-e354-4e32-8ede-46a401ef8053.maildroid@localhost>
Reply-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, 
	=?UTF-8?Q?Br=C3=A1ulio_Bhavamitra?= <brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: David Aguilar <davvid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-From: git-users+bncBDBJVMGGZYNBBM7I5GIQKGQEZ5ZOJNI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Thu Sep 19 05:49:11 2013
Return-path: <git-users+bncBDBJVMGGZYNBBM7I5GIQKGQEZ5ZOJNI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcggu-git-users@m.gmane.org
Received: from mail-wi0-f190.google.com ([209.85.212.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-users+bncBDBJVMGGZYNBBM7I5GIQKGQEZ5ZOJNI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1VMVEr-0002Y8-Ez
	for gcggu-git-users@m.gmane.org; Thu, 19 Sep 2013 05:49:09 +0200
Received: by mail-wi0-f190.google.com with SMTP id ey11sf760036wid.7
        for <gcggu-git-users@m.gmane.org>; Wed, 18 Sep 2013 20:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:x-original-sender:x-original-authentication-results:reply-to
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=bUsKkgaFPgIctDmMFvIWQINb2UrdCSm8eEl9nIt4mXw=;
        b=U+N01UqrWGsYUKJgNDm0O1m2PZwCs1jrxonikq4juHgE4QPQcSUCHx3d6A/xXUXAxF
         WmUbsqbHI6/H4+AtsWls2lEOesk+lMaqCu7OCOZkpTjn/UEGdPTmSm7oTGHWoTGPuUTp
         Niy1xAa79WAD4dWphRqEkJZC1G1ZJwUqx91gAoPPsDNkTx7NhZflz8Lz2lEJhM3clMjA
         VgKOcy8eSYEz0MKUW1h4KxjwqZHJmxLGOc+MkGwx7svqszRPcT6SUHJ9D0ZcCwn6RJpF
         IzwxxYpqupsLOIsovLl2oEpQYoKwZrWiubcl9jTCiZLSVWFf+Zg1/kv3Wz1BIssERT30
         CPEA==
X-Received: by 10.180.39.177 with SMTP id q17mr440670wik.11.1379562549104;
        Wed, 18 Sep 2013 20:49:09 -0700 (PDT)
X-BeenThere: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.180.82.106 with SMTP id h10ls64643wiy.23.canary; Wed, 18 Sep
 2013 20:49:07 -0700 (PDT)
X-Received: by 10.205.86.131 with SMTP id as3mr5494534bkc.5.1379562547314;
        Wed, 18 Sep 2013 20:49:07 -0700 (PDT)
Received: from mail-la0-x22c.google.com (mail-la0-x22c.google.com [2a00:1450:4010:c03::22c])
        by gmr-mx.google.com with ESMTPS id jt16si358478bkb.0.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Sep 2013 20:49:07 -0700 (PDT)
Received-SPF: pass (google.com: domain of felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 2a00:1450:4010:c03::22c as permitted sender) client-ip=2a00:1450:4010:c03::22c;
Received: by mail-la0-f44.google.com with SMTP id eo20so6477247lab.31
        for <git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Wed, 18 Sep 2013 20:49:07 -0700 (PDT)
X-Received: by 10.152.30.74 with SMTP id q10mr14771345lah.27.1379562547008;
 Wed, 18 Sep 2013 20:49:07 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Wed, 18 Sep 2013 20:49:06 -0700 (PDT)
In-Reply-To: <ab38a1b5-e354-4e32-8ede-46a401ef8053.maildroid@localhost>
X-Original-Sender: felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates
 2a00:1450:4010:c03::22c as permitted sender) smtp.mail=felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org;
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235001>

On Wed, Sep 18, 2013 at 9:30 PM, David Aguilar <davvid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>On Wed, Sep 18, 2013 at 1:13 PM, David Aguilar <davvid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>>
>>> Will this not conflict with folks that supply their own gitconfig?
>
>> You mean people that provide their own ETC_GITCONFIG? If you mean
> distributions, their packaging would override /etc/gitconfig, if you
> mean people that have already a /etc/gitconfig, packaging systems
> usually save the old one so they can solve the conflict manually (e.g.
> /etc/gitconfig.pacsave). So no, it would not conflict.
>
> Yuck. Yes, that one. I package my own /etc/gitconfig (as we have long advertised as the "way to do it")

You package /etc/gitconfig *outside* the git package? I don't see how
that could have been ever advertised as the way to do it.

> and asking users to manually fix up thousands of machines is a bad idea.

Users don't package /etc/gitconfig outside git.

>>> I like the idea. Docs?  Also, should this not be done in the C side so that we don't waste time reading the config, and also prevent users from overriding these?
>
>> But we want them to be easily readable, and possibly allow
> distributions to easily modify them.
>
> In that case I take it back -- I dont like that approach.  We want consistency, not divergence. This encourages the former.

So you think we have more consistency right now? We don't even have a
predefined /etc/gitconfig, that creates more inconsistency, as
everybody's configs and aliases are very very different.

This patch would definitely make things more consistent.

-- 
Felipe Contreras

-- 
You received this message because you are subscribed to the Google Groups "Git for human beings" group.
To unsubscribe from this group and stop receiving emails from it, send an email to git-users+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/groups/opt_out.
