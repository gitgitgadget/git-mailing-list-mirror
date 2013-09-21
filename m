From: David Aguilar <davvid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] build: add default configuration
Date: Sat, 21 Sep 2013 01:33:49 -0500
Message-ID: <749d06d0-3e17-49bf-8299-86c99c0dd9f5@email.android.com>
References: <1379423650-1311-1-git-send-email-felipe.contreras@gmail.com> <e8ccfba3-5198-4986-9b9d-1d69b965386f.maildroid@localhost> <CAMP44s35_emnh9Kce433oy1JW66xB2vaN5f5OO7VF1XqoO=YGQ@mail.gmail.com> <ab38a1b5-e354-4e32-8ede-46a401ef8053.maildroid@localhost> <CAMP44s3Q6ummNmLovw0BuGR=yNWfmRFmrg9xb50OawMwKznfBw@mail.gmail.com> <4d9893bc-c812-457b-9f40-ebe01d37df53@email.android.com> <523cb7e7a2d70_5010801e84148e8@nysa.mail> <573b085d-d7fd-453e-8f2b-f83ba1f85ef7@email.android.com> <CAMP44s14hn5qvG_88e_7FDx9ExSSu8DsVFUa5uhU-aOzSFy4MQ@mail.gmail.com>
Reply-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org,=?ISO-8859-1?Q?Br=E1ulio_Bhavamitra?= <brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-From: git-users+bncBD6J3AEPVABRBVH36SIQKGQEKWNFSFA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Sat Sep 21 08:33:59 2013
Return-path: <git-users+bncBD6J3AEPVABRBVH36SIQKGQEKWNFSFA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcggu-git-users@m.gmane.org
Received: from mail-ye0-f192.google.com ([209.85.213.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-users+bncBD6J3AEPVABRBVH36SIQKGQEKWNFSFA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1VNGlS-0001uI-Vt
	for gcggu-git-users@m.gmane.org; Sat, 21 Sep 2013 08:33:59 +0200
Received: by mail-ye0-f192.google.com with SMTP id m5sf327894yen.9
        for <gcggu-git-users@m.gmane.org>; Fri, 20 Sep 2013 23:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=user-agent:in-reply-to:references:mime-version:subject:from:date:to
         :cc:message-id:x-original-sender:x-original-authentication-results
         :reply-to:precedence:mailing-list:list-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=caDZa0q/XA83YXoQgPtdf8aWtEsaDHLDze5u7fuwkCk=;
        b=qoxwTlzj5yiGNZChWxmgKliQoZnYV3NcYFrzzjojdLPC+v8yzcNDx5K7GeJVoOMW0D
         OAA0mZwKqvkziJlUDrZFtjG07kBq5NjQ9w3XW+l8UYwuYb+vy+UZtUBWDZhMG1rPgjkT
         H1Ytq1ibVkMlAnhbuXIeu4uqXHdMLPVeg4ujbyyGlkYDQOqdduAGohvIk2zl/4cxKQov
         IX3TN3dIxIPZhny1IWyBdDwbrLXYrUsYUmVfzN2/HXY4Q5Xe4P6N0uppW04RRaK0aA29
         nLL1Yr34xT5btcIYuVenDrHbiSJ/he0RZldKXk8MLIHhQqkm4vCzfQFbxGy1Ve0wkmZk
         jaVw==
X-Received: by 10.49.82.137 with SMTP id i9mr4398qey.16.1379745238191;
        Fri, 20 Sep 2013 23:33:58 -0700 (PDT)
X-BeenThere: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.49.94.68 with SMTP id da4ls538352qeb.24.gmail; Fri, 20 Sep
 2013 23:33:56 -0700 (PDT)
X-Received: by 10.236.142.38 with SMTP id h26mr22005yhj.57.1379745236813;
        Fri, 20 Sep 2013 23:33:56 -0700 (PDT)
Received: from mail-yh0-x22e.google.com (mail-yh0-x22e.google.com [2607:f8b0:4002:c01::22e])
        by gmr-mx.google.com with ESMTPS id t42si2038046yhm.3.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 20 Sep 2013 23:33:56 -0700 (PDT)
Received-SPF: pass (google.com: domain of davvid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 2607:f8b0:4002:c01::22e as permitted sender) client-ip=2607:f8b0:4002:c01::22e;
Received: by mail-yh0-f46.google.com with SMTP id c41so570478yho.19
        for <git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Fri, 20 Sep 2013 23:33:56 -0700 (PDT)
X-Received: by 10.236.54.232 with SMTP id i68mr10766220yhc.0.1379745236619;
        Fri, 20 Sep 2013 23:33:56 -0700 (PDT)
Received: from [172.20.6.118] ([190.81.185.2])
        by mx.google.com with ESMTPSA id s21sm23662335yhk.9.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 20 Sep 2013 23:33:56 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMP44s14hn5qvG_88e_7FDx9ExSSu8DsVFUa5uhU-aOzSFy4MQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
X-Original-Sender: davvid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of davvid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 2607:f8b0:4002:c01::22e as
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235093>

Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>I know 'git ci' is perfectly fine shortcut to 'git commit'.
>
>Either way, it doesn't matter. Even if we agree that /etc/gitconfig.d
>is what we want, or we add an /usr/share/git/config, Junio is not
>going to apply any patch, even if it's what most users want.

Please stop making personal attacks that add nothing to your argument. No o=
ne cares.  Let it be.

Let's move this in a more constructive direction then, no?

How about working on documenting the new aliases and add a knob to the Make=
file so that we can choose whether or not to install the stock config?

I'm not trying to fight this patch -- the idea is nice. Most users and dist=
ros probably won't change stock aliases, so your energy may be better spent=
 getting consensus on what the stock aliases could be.=20

Would it not be better to have these aliases, plus/minus one or two, then n=
one at all?
...
Yes I know about .rpmsave files. For rpm, it'll refuse to upgrade Git since=
 this new file will conflict with an existing package.  That's easier to de=
al with because the config package can then be independently modified to in=
stall its file to eg git.d/foo.conf in the directory include example.  That=
 would then allow the upgrade, and at no point did the intended config ever=
 get lost.

Puppet users, for example, may end up with rpmsave turds on their systems, =
though. When you are managing lots of machines this can be very annoying --=
 that's why I mentioned it.  Don't bother arguing this point any further. I=
t's boring.
...
In summary -- makefile knob, please, and at least mention the stock aliases=
 somewhere in the docs so that the users can know to read /etc/gitconfig if=
 they want to know more.  Who knows, maybe it will get applied, but it defi=
nitively won't if all you do is whine about it.

--=20
David

--=20
You received this message because you are subscribed to the Google Groups "=
Git for human beings" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to git-users+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/groups/opt_out.
