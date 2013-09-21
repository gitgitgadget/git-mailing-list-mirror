From: David Aguilar <davvid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] build: add default configuration
Date: Fri, 20 Sep 2013 19:44:43 -0500
Message-ID: <573b085d-d7fd-453e-8f2b-f83ba1f85ef7@email.android.com>
References: <1379423650-1311-1-git-send-email-felipe.contreras@gmail.com> <e8ccfba3-5198-4986-9b9d-1d69b965386f.maildroid@localhost> <CAMP44s35_emnh9Kce433oy1JW66xB2vaN5f5OO7VF1XqoO=YGQ@mail.gmail.com> <ab38a1b5-e354-4e32-8ede-46a401ef8053.maildroid@localhost> <CAMP44s3Q6ummNmLovw0BuGR=yNWfmRFmrg9xb50OawMwKznfBw@mail.gmail.com> <4d9893bc-c812-457b-9f40-ebe01d37df53@email.android.com> <523cb7e7a2d70_5010801e84148e8@nysa.mail>
Reply-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org,=?ISO-8859-1?Q?Br=E1ulio_Bhavamitra?= <brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-From: git-users+bncBD6J3AEPVABRBAWY6OIQKGQE6KSPBPY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Sat Sep 21 02:44:54 2013
Return-path: <git-users+bncBD6J3AEPVABRBAWY6OIQKGQE6KSPBPY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcggu-git-users@m.gmane.org
Received: from mail-vb0-f62.google.com ([209.85.212.62])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-users+bncBD6J3AEPVABRBAWY6OIQKGQE6KSPBPY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1VNBJc-0006Th-7m
	for gcggu-git-users@m.gmane.org; Sat, 21 Sep 2013 02:44:52 +0200
Received: by mail-vb0-f62.google.com with SMTP id x14sf247715vbb.17
        for <gcggu-git-users@m.gmane.org>; Fri, 20 Sep 2013 17:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=user-agent:in-reply-to:references:mime-version:subject:from:date:to
         :cc:message-id:x-original-sender:x-original-authentication-results
         :reply-to:precedence:mailing-list:list-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=CrpZOB6qcK2HA0RnK6oUcOBibQDTEMtQYHKFkMQNOQI=;
        b=kLta0eLa/0ofOkw6mXFcI2u7T4RvKIfxwc/qExIyYDkxR9LlNRkI57UrCSuDkKRIpV
         yhTO6fDOuoSXSXvjLfZTg/GBc0DQ771iDANgvUb7eA+j1Agat/IKz4TJUQM8ddgk98vw
         WMZbtxbmuH/W3hynhLiv2Bh1tg4t28Mb7wqzzCTr/r4boq8Uff4cR0CxZjQQU2362IfW
         ZXbpqWK9LvRp8LwLNjsWB3lorFNQuVKgrHHmGxeRW0SSM4wPNCM/84opeM+1YfWcCFKu
         gEoBd7z1llv7RyZCMExbyvokGBDJwE9+2V+hX0FF8iQ0lIJs/iKcSxJ2VLmf/oejmxp1
         1Z3A==
X-Received: by 10.49.70.138 with SMTP id m10mr210550qeu.9.1379724291474;
        Fri, 20 Sep 2013 17:44:51 -0700 (PDT)
X-BeenThere: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.49.96.9 with SMTP id do9ls427470qeb.80.gmail; Fri, 20 Sep 2013
 17:44:49 -0700 (PDT)
X-Received: by 10.236.101.103 with SMTP id a67mr3443683yhg.25.1379724289893;
        Fri, 20 Sep 2013 17:44:49 -0700 (PDT)
Received: from mail-yh0-x230.google.com (mail-yh0-x230.google.com [2607:f8b0:4002:c01::230])
        by gmr-mx.google.com with ESMTPS id a49si1869164yhc.5.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 20 Sep 2013 17:44:49 -0700 (PDT)
Received-SPF: pass (google.com: domain of davvid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 2607:f8b0:4002:c01::230 as permitted sender) client-ip=2607:f8b0:4002:c01::230;
Received: by mail-yh0-f48.google.com with SMTP id f10so496922yha.7
        for <git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Fri, 20 Sep 2013 17:44:49 -0700 (PDT)
X-Received: by 10.236.13.3 with SMTP id a3mr9484460yha.21.1379724289717;
        Fri, 20 Sep 2013 17:44:49 -0700 (PDT)
Received: from [172.20.6.118] ([190.81.185.2])
        by mx.google.com with ESMTPSA id s21sm22116497yhk.9.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 20 Sep 2013 17:44:49 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <523cb7e7a2d70_5010801e84148e8-9w9IBNBfMV1mR6Xm/wNWPw@public.gmane.org>
X-Original-Sender: davvid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of davvid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 2607:f8b0:4002:c01::230 as
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235089>

Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>David Aguilar wrote:
>> Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> >On Wed, Sep 18, 2013 at 9:30 PM, David Aguilar <davvid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> >wrote:
>> >>>On Wed, Sep 18, 2013 at 1:13 PM, David Aguilar <davvid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> >wrote:
>> >>>>
>> >>>> Will this not conflict with folks that supply their own
>gitconfig?
>> >>
>> >>> You mean people that provide their own ETC_GITCONFIG? If you mean
>> >> distributions, their packaging would override /etc/gitconfig, if
>you
>> >> mean people that have already a /etc/gitconfig, packaging systems
>> >> usually save the old one so they can solve the conflict manually
>> >(e.g.
>> >> /etc/gitconfig.pacsave). So no, it would not conflict.
>> >>
>> >> Yuck. Yes, that one. I package my own /etc/gitconfig (as we have
>long
>> >advertised as the "way to do it")
>> >
>> >You package /etc/gitconfig *outside* the git package? I don't see
>how
>> >that could have been ever advertised as the way to do it.
>>=20
>> Okay so how exactly are we supposed to do it?  Duh, rpm is the right
>choice for redhat systems.=20
>
>The same way kerberos, mariadb, apache, and essentially every other
>tool that
>has a configuration file in /etc.

Good point. These tools (apache, for example) allow inclusion of a director=
y. Users are encouraged to package their stuff inside eg httpd.d/, and the =
distros ship a neutral config that includes that directory.=20

Your patch does not add this capability, so by your own definition it's inc=
omplete.  As-is, the patch is half-baked.

If we have a clear upgrade path -- eg "move your current configs over to /e=
tc/git.d/your.conf" -- then it's a non-issue.=20

As-is, you're asking users to manually deal with the fallout. You're also a=
sking users to modify a package-manager controlled file (after your patch),=
 which IMO is suboptimal.=20

>
>> >Users don't package /etc/gitconfig outside git.
>>=20
>> Wrong. Existence proof: me.=20
>
>You as a user are not packaging it, it's you as a system adimistrator.

Strawman. I represent at least at least a hundred users, but who cares. It =
doesn't matter.  The patch is incomplete.=20

>Either
>way, you are 0.0001% of Git's userbase, you are not representative.

And your point is what exactly?  That once proven wrong you move the goalpo=
sts?

>
>> >>>> I like the idea. Docs?  Also, should this not be done in the C
>side
>> >so that we don't waste time reading the config, and also prevent
>users
>> >from overriding these?
>> >>
>> >>> But we want them to be easily readable, and possibly allow
>> >> distributions to easily modify them.
>> >>
>> >> In that case I take it back -- I dont like that approach.  We want
>> >consistency, not divergence. This encourages the former.
>> >
>> >So you think we have more consistency right now? We don't even have
>a
>> >predefined /etc/gitconfig, that creates more inconsistency, as
>> >everybody's configs and aliases are very very different.
>> >
>> >This patch would definitely make things more consistent.
>>=20
>> We don't need this patch to allow distros to modify aliases.
>Likewise, allowing the aliases to diverge is less consistent. Do it at
>a lower level.=20
>
>We already allow the aliases to diverge, we allow it much more.
>
>The pach will make the aliases more consistent.
>
>> I also agree with Junio's notes about "ci". Something short that can
>add and remove from the index would be nice.=20
>
>cvs ci, svn ci, hg ci, they all work, but suddenly ci is not good
>enough for Git? Yeah, sure.

IMO this isn't the kind of thing that you or I can decide in isolation.  Ma=
ybe it is, or maybe the real differences between the "ci" mental model are =
enough that it isn't. But you don't actually know the answer. You might thi=
nk you do, but your guess is just as good/bad/ugly as mine.=20

--=20
David

--=20
You received this message because you are subscribed to the Google Groups "=
Git for human beings" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to git-users+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/groups/opt_out.
