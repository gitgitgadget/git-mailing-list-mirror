From: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] build: add default configuration
Date: Sat, 21 Sep 2013 06:07:03 -0500
Message-ID: <CAMP44s0Aiu9uH_XkRiRRqbi_V_BPZL79BFktHH7yjDhgNi8PFQ@mail.gmail.com>
References: <1379423650-1311-1-git-send-email-felipe.contreras@gmail.com>
	<e8ccfba3-5198-4986-9b9d-1d69b965386f.maildroid@localhost>
	<CAMP44s35_emnh9Kce433oy1JW66xB2vaN5f5OO7VF1XqoO=YGQ@mail.gmail.com>
	<ab38a1b5-e354-4e32-8ede-46a401ef8053.maildroid@localhost>
	<CAMP44s3Q6ummNmLovw0BuGR=yNWfmRFmrg9xb50OawMwKznfBw@mail.gmail.com>
	<4d9893bc-c812-457b-9f40-ebe01d37df53@email.android.com>
	<523cb7e7a2d70_5010801e84148e8@nysa.mail>
	<573b085d-d7fd-453e-8f2b-f83ba1f85ef7@email.android.com>
	<CAMP44s14hn5qvG_88e_7FDx9ExSSu8DsVFUa5uhU-aOzSFy4MQ@mail.gmail.com>
	<749d06d0-3e17-49bf-8299-86c99c0dd9f5@email.android.com>
Reply-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, 
	=?UTF-8?Q?Br=C3=A1ulio_Bhavamitra?= <brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: David Aguilar <davvid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-From: git-users+bncBDBJVMGGZYNBBWH36WIQKGQEPWK5CXY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Sat Sep 21 13:07:08 2013
Return-path: <git-users+bncBDBJVMGGZYNBBWH36WIQKGQEPWK5CXY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcggu-git-users@m.gmane.org
Received: from mail-ea0-f190.google.com ([209.85.215.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-users+bncBDBJVMGGZYNBBWH36WIQKGQEPWK5CXY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1VNL1m-0003d6-55
	for gcggu-git-users@m.gmane.org; Sat, 21 Sep 2013 13:07:06 +0200
Received: by mail-ea0-f190.google.com with SMTP id h14sf159585eak.7
        for <gcggu-git-users@m.gmane.org>; Sat, 21 Sep 2013 04:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:x-original-sender:x-original-authentication-results:reply-to
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=wlEM5LfSVRUcl5qwJT6Ph54YstKdt11bssqmdnG99iM=;
        b=aaK0G6s2zhrT1Xa15gETaV18qk/uvsjsQVoL0X1OqC0UQy+GUGcS6NcsI2GAtI8J0v
         5m3lJixnixqPPsfxZcofS4KW5MIBGxPL8NpDtC62Zrdtpu1O7CLxs7Wev26FlIqARDDX
         0c1R4Qi7Y6E9otpQAJXnVWAqFIt9Hu0BY0xBzKCYOzX1CkJmRFDJk0iZ4xTDtj5vCfB5
         HooeEh/48M/GBvGrqawP+jbFOQK2oMIkozmS5UtrzkG0V0SJMw+CZJDnruFKQtku4RFN
         C+elCMRRT4eh0huo5ak1tKVYsDhaqyXH4G6JFDGWwvq4tBixwL+/IaoTvXJmppyELnyT
         kTfA==
X-Received: by 10.180.85.168 with SMTP id i8mr251354wiz.9.1379761625892;
        Sat, 21 Sep 2013 04:07:05 -0700 (PDT)
X-BeenThere: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.180.10.3 with SMTP id e3ls352035wib.38.gmail; Sat, 21 Sep 2013
 04:07:04 -0700 (PDT)
X-Received: by 10.204.230.12 with SMTP id jk12mr223bkb.8.1379761624316;
        Sat, 21 Sep 2013 04:07:04 -0700 (PDT)
Received: from mail-la0-x22d.google.com (mail-la0-x22d.google.com [2a00:1450:4010:c03::22d])
        by gmr-mx.google.com with ESMTPS id qy6si1238316bkb.3.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Sep 2013 04:07:04 -0700 (PDT)
Received-SPF: pass (google.com: domain of felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 2a00:1450:4010:c03::22d as permitted sender) client-ip=2a00:1450:4010:c03::22d;
Received: by mail-la0-f45.google.com with SMTP id eh20so1139295lab.18
        for <git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Sat, 21 Sep 2013 04:07:04 -0700 (PDT)
X-Received: by 10.152.37.103 with SMTP id x7mr1349975laj.28.1379761623979;
 Sat, 21 Sep 2013 04:07:03 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sat, 21 Sep 2013 04:07:03 -0700 (PDT)
In-Reply-To: <749d06d0-3e17-49bf-8299-86c99c0dd9f5-2ueSQiBKiTY7tOexoI0I+QC/G2K4zDHf@public.gmane.org>
X-Original-Sender: felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates
 2a00:1450:4010:c03::22d as permitted sender) smtp.mail=felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org;
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235095>

On Sat, Sep 21, 2013 at 1:33 AM, David Aguilar <davvid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>I know 'git ci' is perfectly fine shortcut to 'git commit'.
>>
>>Either way, it doesn't matter. Even if we agree that /etc/gitconfig.d
>>is what we want, or we add an /usr/share/git/config, Junio is not
>>going to apply any patch, even if it's what most users want.
>
> Please stop making personal attacks that add nothing to your argument. No=
 one cares.  Let it be.

There are no personal attacks here. A personal attack would be 'X is a
moron', or 'X doesn't know what he is talking about', I don't see any
of that.

This is a fact, do you see anybody besides you and me commenting about
the subject? More specifically, do you see Junio making any comment?

> Let's move this in a more constructive direction then, no?
>
> How about working on documenting the new aliases and add a knob to the Ma=
kefile so that we can choose whether or not to install the stock config?

Sure, but document these aliases where? If you mean document them in
the man page of each command (e.g. git commit, alias: ci), then sure,
that's fine by me.

Adding a know to the Makefile I think doesn't make sense, because a
packager would do.

% make NO_DEFAULT_CONFIG=3Dy install

Which is not very different from:

% make install
% rm -f $DESTDIR/etc/gitconfig

> I'm not trying to fight this patch -- the idea is nice. Most users and di=
stros probably won't change stock aliases, so your energy may be better spe=
nt getting consensus on what the stock aliases could be.

Thanks for stating so, unfortunately, I don't think it really matters
because this is a change, and the Git project is not welcome to
change.

> Would it not be better to have these aliases, plus/minus one or two, then=
 none at all?

Yes, but you don't see anybody advocating for that at all, do you?

> ...
> Yes I know about .rpmsave files. For rpm, it'll refuse to upgrade Git sin=
ce this new file will conflict with an existing package.

In your case, yes, not in the normal case, where /etc/gitconfig is not
provided by a package.

> That's easier to deal with because the config package can then be indepen=
dently modified to install its file to eg git.d/foo.conf in the directory i=
nclude example.  That would then allow the upgrade, and at no point did the=
 intended config ever get lost.

It might be easier to deal with, but it would still require an intervention=
.

> Puppet users, for example, may end up with rpmsave turds on their systems=
, though. When you are managing lots of machines this can be very annoying =
-- that's why I mentioned it.  Don't bother arguing this point any further.=
 It's boring.

It can be very annoying, but your /etc/gitconfig.d solution doesn't
help in that regard.

Either way, the move from 'git-foo' to 'git foo' was very annoying as
well, but we all agreed it was the right thing to do (most of us),
fortunately in this case I think the people that have a /etc/gitconfig
are significantly less.

> ...
> In summary -- makefile knob, please, and at least mention the stock alias=
es somewhere in the docs so that the users can know to read /etc/gitconfig =
if they want to know more.  Who knows, maybe it will get applied, but it de=
finitively won't if all you do is whine about it.

It won't get applied, I'll do the modifications, and you'll see.

--=20
Felipe Contreras

--=20
You received this message because you are subscribed to the Google Groups "=
Git for human beings" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to git-users+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/groups/opt_out.
