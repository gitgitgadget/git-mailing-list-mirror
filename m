From: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] build: add default configuration
Date: Fri, 20 Sep 2013 22:54:38 -0500
Message-ID: <CAMP44s14hn5qvG_88e_7FDx9ExSSu8DsVFUa5uhU-aOzSFy4MQ@mail.gmail.com>
References: <1379423650-1311-1-git-send-email-felipe.contreras@gmail.com>
	<e8ccfba3-5198-4986-9b9d-1d69b965386f.maildroid@localhost>
	<CAMP44s35_emnh9Kce433oy1JW66xB2vaN5f5OO7VF1XqoO=YGQ@mail.gmail.com>
	<ab38a1b5-e354-4e32-8ede-46a401ef8053.maildroid@localhost>
	<CAMP44s3Q6ummNmLovw0BuGR=yNWfmRFmrg9xb50OawMwKznfBw@mail.gmail.com>
	<4d9893bc-c812-457b-9f40-ebe01d37df53@email.android.com>
	<523cb7e7a2d70_5010801e84148e8@nysa.mail>
	<573b085d-d7fd-453e-8f2b-f83ba1f85ef7@email.android.com>
Reply-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, 
	=?UTF-8?Q?Br=C3=A1ulio_Bhavamitra?= <brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: David Aguilar <davvid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-From: git-users+bncBDBJVMGGZYNBB7VQ6SIQKGQEAF5FLYY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Sat Sep 21 05:54:41 2013
Return-path: <git-users+bncBDBJVMGGZYNBB7VQ6SIQKGQEAF5FLYY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcggu-git-users@m.gmane.org
Received: from mail-lb0-f186.google.com ([209.85.217.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-users+bncBDBJVMGGZYNBB7VQ6SIQKGQEAF5FLYY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1VNEHI-0004mv-JR
	for gcggu-git-users@m.gmane.org; Sat, 21 Sep 2013 05:54:40 +0200
Received: by mail-lb0-f186.google.com with SMTP id w6sf150619lbh.13
        for <gcggu-git-users@m.gmane.org>; Fri, 20 Sep 2013 20:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:x-original-sender:x-original-authentication-results:reply-to
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=5rqUXDwCBOHo5K0TLQlHs8vxJneTaj4QukNDo9oQghE=;
        b=rY3eJcpufExJZOD28StIPZzLfeh8Y7by3PxnswrPnz4ja3hCeP65X6iStsSHpuYgfv
         nbZ/sr65Xw54MkUcrDLLftEPAzsuOhLTivfF5m0iySqkfbO3Mvf8tu70602IEMrn5Q4g
         WM74jLg/Nc4Eb/+ZehpfS0I49VB97y0EVx0hqLphDcuIfLqB+Crdubxrwsy01asU7/vG
         F3JsxOUPSjf8T6bkDmce1TOHHPaixuSj3Rsh23HK9ioBUODWsvKe+8MC8sEx/zsQkag5
         FRv/n7zJ5eg2i2mjRSjS4UxopzK9UKgn7sDO8cAnkTj7KBxQPQnluqQ5sUHZ/3DSrvJq
         Wmeg==
X-Received: by 10.180.206.176 with SMTP id lp16mr227759wic.10.1379735680287;
        Fri, 20 Sep 2013 20:54:40 -0700 (PDT)
X-BeenThere: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.180.8.104 with SMTP id q8ls282559wia.42.gmail; Fri, 20 Sep
 2013 20:54:38 -0700 (PDT)
X-Received: by 10.205.24.131 with SMTP id re3mr553010bkb.0.1379735678491;
        Fri, 20 Sep 2013 20:54:38 -0700 (PDT)
Received: from mail-la0-x22a.google.com (mail-la0-x22a.google.com [2a00:1450:4010:c03::22a])
        by gmr-mx.google.com with ESMTPS id ra8si1133219bkb.2.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 20 Sep 2013 20:54:38 -0700 (PDT)
Received-SPF: pass (google.com: domain of felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 2a00:1450:4010:c03::22a as permitted sender) client-ip=2a00:1450:4010:c03::22a;
Received: by mail-la0-f42.google.com with SMTP id ep20so993445lab.1
        for <git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Fri, 20 Sep 2013 20:54:38 -0700 (PDT)
X-Received: by 10.112.198.39 with SMTP id iz7mr9059845lbc.24.1379735678131;
 Fri, 20 Sep 2013 20:54:38 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Fri, 20 Sep 2013 20:54:38 -0700 (PDT)
In-Reply-To: <573b085d-d7fd-453e-8f2b-f83ba1f85ef7-2ueSQiBKiTY7tOexoI0I+QC/G2K4zDHf@public.gmane.org>
X-Original-Sender: felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates
 2a00:1450:4010:c03::22a as permitted sender) smtp.mail=felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org;
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235091>

On Fri, Sep 20, 2013 at 7:44 PM, David Aguilar <davvid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>David Aguilar wrote:
>>> Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>> >On Wed, Sep 18, 2013 at 9:30 PM, David Aguilar <davvid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>> >wrote:
>>> >>>On Wed, Sep 18, 2013 at 1:13 PM, David Aguilar <davvid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>> >wrote:
>>> >>>>
>>> >>>> Will this not conflict with folks that supply their own
>>gitconfig?
>>> >>
>>> >>> You mean people that provide their own ETC_GITCONFIG? If you mean
>>> >> distributions, their packaging would override /etc/gitconfig, if
>>you
>>> >> mean people that have already a /etc/gitconfig, packaging systems
>>> >> usually save the old one so they can solve the conflict manually
>>> >(e.g.
>>> >> /etc/gitconfig.pacsave). So no, it would not conflict.
>>> >>
>>> >> Yuck. Yes, that one. I package my own /etc/gitconfig (as we have
>>long
>>> >advertised as the "way to do it")
>>> >
>>> >You package /etc/gitconfig *outside* the git package? I don't see
>>how
>>> >that could have been ever advertised as the way to do it.
>>>
>>> Okay so how exactly are we supposed to do it?  Duh, rpm is the right
>>choice for redhat systems.
>>
>>The same way kerberos, mariadb, apache, and essentially every other
>>tool that
>>has a configuration file in /etc.
>
> Good point. These tools (apache, for example) allow inclusion of a direct=
ory.

Wrong. Apache does, but neither does kerberos, nor mariadb, which have
a single configuration file, at least on all the systems I've seen.

You act as if you have never seen .pacsave/.rpmsave (and so on) files
before, they a are pretty common sight when the user modifies the
configuration files, and as kerberos and mariadb demonstrate, pretty
successful projects can survive with a simple single configuration
file.

> Your patch does not add this capability, so by your own definition it's i=
ncomplete.  As-is, the patch is half-baked.

It's not incomplete, any more than kerberos, mariadb, and countless
other programs are.

> If we have a clear upgrade path -- eg "move your current configs over to =
/etc/git.d/your.conf" -- then it's a non-issue.

But now you contradict yourself. This patch would force users to
resolve the conflicts eventually through .pacsave/.rpmsave, and with
your proposal to have directory includes, it would also force manual
user intervention by moving the configuration files and resolve the
conflict.

So why is one manual user intervention so appalling, and the other one so r=
ight?

Either way, if this patch is so wrong, then clearly the RedHat
packaging team would remove /etc/gitconfig from the Git RPM package,
and you would be fine, wouldn't you?

Or maybe you are afraid that RedHat packaging team would agree that
the /etc/gitconfig file provided by Git is fine.

> As-is, you're asking users to manually deal with the fallout. You're also=
 asking users to modify a package-manager controlled file (after your patch=
), which IMO is suboptimal.

In both cases the user has to manually deal with the fallout.

>>> >Users don't package /etc/gitconfig outside git.
>>>
>>> Wrong. Existence proof: me.
>>
>>You as a user are not packaging it, it's you as a system adimistrator.
>
> Strawman. I represent at least at least a hundred users, but who cares. I=
t doesn't matter.  The patch is incomplete.

No you don't, you represent a system administrator, not a user.

>>Either
>>way, you are 0.0001% of Git's userbase, you are not representative.
>
> And your point is what exactly?  That once proven wrong you move the goal=
posts?

It's called colloquial language. If I say, "people don't bark on the
street", and then you say "here, there's a guy that does bark on the
street", and then I say, fine, "people don't *NORMALLY* bark on the
street", what have we achieved?

This is just an exercise in pedanticism.

Sane users, under normal circumstances, for the overwhelmingly vast
majority of situations, do not package their /etc/gitconfig file.

>>> >>>> I like the idea. Docs?  Also, should this not be done in the C
>>side
>>> >so that we don't waste time reading the config, and also prevent
>>users
>>> >from overriding these?
>>> >>
>>> >>> But we want them to be easily readable, and possibly allow
>>> >> distributions to easily modify them.
>>> >>
>>> >> In that case I take it back -- I dont like that approach.  We want
>>> >consistency, not divergence. This encourages the former.
>>> >
>>> >So you think we have more consistency right now? We don't even have
>>a
>>> >predefined /etc/gitconfig, that creates more inconsistency, as
>>> >everybody's configs and aliases are very very different.
>>> >
>>> >This patch would definitely make things more consistent.
>>>
>>> We don't need this patch to allow distros to modify aliases.
>>Likewise, allowing the aliases to diverge is less consistent. Do it at
>>a lower level.
>>
>>We already allow the aliases to diverge, we allow it much more.
>>
>>The pach will make the aliases more consistent.
>>
>>> I also agree with Junio's notes about "ci". Something short that can
>>add and remove from the index would be nice.
>>
>>cvs ci, svn ci, hg ci, they all work, but suddenly ci is not good
>>enough for Git? Yeah, sure.
>
> IMO this isn't the kind of thing that you or I can decide in isolation.  =
Maybe it is, or maybe the real differences between the "ci" mental model ar=
e enough that it isn't. But you don't actually know the answer. You might t=
hink you do, but your guess is just as good/bad/ugly as mine.

I know 'git ci' is perfectly fine shortcut to 'git commit'.

Either way, it doesn't matter. Even if we agree that /etc/gitconfig.d
is what we want, or we add an /usr/share/git/config, Junio is not
going to apply any patch, even if it's what most users want.

--=20
Felipe Contreras

--=20
You received this message because you are subscribed to the Google Groups "=
Git for human beings" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to git-users+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/groups/opt_out.
