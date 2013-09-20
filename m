From: David Aguilar <davvid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] build: add default configuration
Date: Fri, 20 Sep 2013 13:31:15 -0500
Message-ID: <4d9893bc-c812-457b-9f40-ebe01d37df53@email.android.com>
References: <1379423650-1311-1-git-send-email-felipe.contreras@gmail.com> <e8ccfba3-5198-4986-9b9d-1d69b965386f.maildroid@localhost> <CAMP44s35_emnh9Kce433oy1JW66xB2vaN5f5OO7VF1XqoO=YGQ@mail.gmail.com> <ab38a1b5-e354-4e32-8ede-46a401ef8053.maildroid@localhost> <CAMP44s3Q6ummNmLovw0BuGR=yNWfmRFmrg9xb50OawMwKznfBw@mail.gmail.com>
Reply-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org,=?ISO-8859-1?Q?Br=E1ulio_Bhavamitra?= <brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-From: git-users+bncBD6J3AEPVABRB7NI6KIQKGQETGDT5OY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Fri Sep 20 20:31:29 2013
Return-path: <git-users+bncBD6J3AEPVABRB7NI6KIQKGQETGDT5OY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcggu-git-users@m.gmane.org
Received: from mail-pb0-f62.google.com ([209.85.160.62])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-users+bncBD6J3AEPVABRB7NI6KIQKGQETGDT5OY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1VN5UF-0000hN-Mu
	for gcggu-git-users@m.gmane.org; Fri, 20 Sep 2013 20:31:28 +0200
Received: by mail-pb0-f62.google.com with SMTP id md4sf186583pbc.27
        for <gcggu-git-users@m.gmane.org>; Fri, 20 Sep 2013 11:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=user-agent:in-reply-to:references:mime-version:subject:from:date:to
         :cc:message-id:x-original-sender:x-original-authentication-results
         :reply-to:precedence:mailing-list:list-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type;
        bh=s+5+gqcm/cdLymoT2Auvev964bEaVCXE1poGxjKLIVc=;
        b=AYD28ncpKZ6roJo3/lioCDDQXlz/p+xeNsVn0EsdZI3dLt4Vs5lhoCwunSM2iRlCk7
         /t+cUUkNBaTEhE2I71TNhJVHtrHPR5qFT8cDdRwLO74BI/nZpGXz0ruAoMRPZZ5S/INP
         At/zwxKUVAwOFffP3Kbwo/vBZYCdD7Rpa3K5fPQwIzAqk0nmtt0+/dpNkjBwDv4F2q6/
         VOTGL1REgAb64sRjYf1gsj9OPxVQOY2rl16R4jU3lfAgutLtb8hTVqBbz4nao6IceC+P
         rA1haP3XzqrbUBr6LLL6iFUIXrLcJA5jiYsyQZzK9v+Rpc5Jlww44f27oLWpjOIogKMp
         bSww==
X-Received: by 10.49.70.170 with SMTP id n10mr92098qeu.22.1379701886301;
        Fri, 20 Sep 2013 11:31:26 -0700 (PDT)
X-BeenThere: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.49.87.36 with SMTP id u4ls337368qez.56.gmail; Fri, 20 Sep 2013
 11:31:25 -0700 (PDT)
X-Received: by 10.236.110.168 with SMTP id u28mr1760543yhg.40.1379701885293;
        Fri, 20 Sep 2013 11:31:25 -0700 (PDT)
Received: from mail-yh0-x233.google.com (mail-yh0-x233.google.com [2607:f8b0:4002:c01::233])
        by gmr-mx.google.com with ESMTPS id a49si1597346yhc.5.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 20 Sep 2013 11:31:25 -0700 (PDT)
Received-SPF: pass (google.com: domain of davvid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 2607:f8b0:4002:c01::233 as permitted sender) client-ip=2607:f8b0:4002:c01::233;
Received: by mail-yh0-f51.google.com with SMTP id t59so317918yho.10
        for <git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Fri, 20 Sep 2013 11:31:25 -0700 (PDT)
X-Received: by 10.236.117.106 with SMTP id i70mr8051984yhh.29.1379701885115;
        Fri, 20 Sep 2013 11:31:25 -0700 (PDT)
Received: from [172.20.17.174] ([200.10.66.132])
        by mx.google.com with ESMTPSA id 48sm19830774yhq.11.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 20 Sep 2013 11:31:24 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMP44s3Q6ummNmLovw0BuGR=yNWfmRFmrg9xb50OawMwKznfBw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
X-Original-Sender: davvid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of davvid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 2607:f8b0:4002:c01::233 as
 permitted sender) smtp.mail=davvid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235077>

Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>On Wed, Sep 18, 2013 at 9:30 PM, David Aguilar <davvid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>wrote:
>>>On Wed, Sep 18, 2013 at 1:13 PM, David Aguilar <davvid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>wrote:
>>>>
>>>> Will this not conflict with folks that supply their own gitconfig?
>>
>>> You mean people that provide their own ETC_GITCONFIG? If you mean
>> distributions, their packaging would override /etc/gitconfig, if you
>> mean people that have already a /etc/gitconfig, packaging systems
>> usually save the old one so they can solve the conflict manually
>(e.g.
>> /etc/gitconfig.pacsave). So no, it would not conflict.
>>
>> Yuck. Yes, that one. I package my own /etc/gitconfig (as we have long
>advertised as the "way to do it")
>
>You package /etc/gitconfig *outside* the git package? I don't see how
>that could have been ever advertised as the way to do it.

Okay so how exactly are we supposed to do it?  Duh, rpm is the right choice for redhat systems. 

>Users don't package /etc/gitconfig outside git.

Wrong. Existence proof: me. 


>>>> I like the idea. Docs?  Also, should this not be done in the C side
>so that we don't waste time reading the config, and also prevent users
>from overriding these?
>>
>>> But we want them to be easily readable, and possibly allow
>> distributions to easily modify them.
>>
>> In that case I take it back -- I dont like that approach.  We want
>consistency, not divergence. This encourages the former.
>
>So you think we have more consistency right now? We don't even have a
>predefined /etc/gitconfig, that creates more inconsistency, as
>everybody's configs and aliases are very very different.
>
>This patch would definitely make things more consistent.

We don't need this patch to allow distros to modify aliases. Likewise, allowing the aliases to diverge is less consistent. Do it at a lower level. 

I also agree with Junio's notes about "ci". Something short that can add and remove from the index would be nice. 


-- 
David

-- 
You received this message because you are subscribed to the Google Groups "Git for human beings" group.
To unsubscribe from this group and stop receiving emails from it, send an email to git-users+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/groups/opt_out.
