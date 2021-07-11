Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9742BC07E96
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 16:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BD14610CD
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 16:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbhGKRCl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 13:02:41 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39310 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229801AbhGKRCl (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 11 Jul 2021 13:02:41 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AD86A6042E;
        Sun, 11 Jul 2021 16:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1626022763;
        bh=bRGvoSHRjO4zbo+zniN3S9kHrmNiolyc8kUahdOJ5fA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=HCTMLLmFN7jQhHjEGJq7ZCkYUTcTPKPwSAGgr399b04MZcDxI9sxCgvsIWklErR3N
         RJxuuakA6ke5BwaSTzRPvrkgl4RUP8MlS92i+DW5mbqBFmkTBZ/YtNDwfwJEPXPIRV
         iX9F7g6t38fInsGH6+I+eO7uA7yrngUu7uGDjI+mcsYSWu4L5z42EMuiUM4OhTsljC
         KQaQImow/UVy1mthizCOveiDNnx0K16rPRzNWrpGK5r0Kp45EA2GKX05fZbrbMI+Aq
         2JzEIQkf9nfDDZqhXFHRk75dvOx8iMP2i6XHBJ9KTurTrbi0d18uO+5FnV7/8Dnzx6
         EzTWy4oLnO07Pnnl6PE6TSFXuSuSj7/gfS3QT5VXvFpaZyW14q+1ooIB7ZGuCQBuhv
         qLMPQKeJ/jEtjYw1DW5T0uGOxvEtvjD0iK081upOCbHq3s1CA29W3Om2KxEjgK2WDE
         w2Lu0xehUrhKuH7GfOlcMjXn9CdmmicP/g/9Yp2wyp9orHqSZYw
Date:   Sun, 11 Jul 2021 16:59:18 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Rose Kunkel <rose@rosekunkel.me>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2] submodule: mark submodules with update=none as
 inactive
Message-ID: <YOsjZldLHR/htyx9@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philippe Blain <levraiphilippeblain@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Rose Kunkel <rose@rosekunkel.me>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <YMvgRjwyrwyLz4SC@camp.crustytoothpaste.net>
 <20210701225117.909892-1-sandals@crustytoothpaste.net>
 <bf1893ee-6973-d8b2-659e-bb239a0a9ae2@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wQa3Zb+NopIk0Htb"
Content-Disposition: inline
In-Reply-To: <bf1893ee-6973-d8b2-659e-bb239a0a9ae2@gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wQa3Zb+NopIk0Htb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-07-09 at 20:26:35, Philippe Blain wrote:
> Hi brian,
>=20
> [re-cc'ing Emily and Jonathan who Junio cc'ed in <xmqqeed2sdwc.fsf@gitste=
r.g>
> but seemed to have been dropped when you sent v1 and v2 of the patch]
>=20
> Le 2021-07-01 =C3=A0 18:51, brian m. carlson a =C3=A9crit=C2=A0:
> > When the user recursively clones a repository with submodules
>=20
> Here I would add:
>=20
> ", or runs 'git submodule update --init' after a
> non-recursive clone of such a repository, "
>=20
> > and one or
> > more of those submodules is marked with the submodule.<name>.update=3Dn=
one
> > configuration, the submodule
>=20
> "those submodules" would be clearer, I think.

Sure, I can make that change.

> > will end up being active.  This is a
> > problem because we will have skipped cloning or checking out the
> > submodule, and as a result, other commands, such as git reset or git
> > checkout, will fail if they are invoked with --recurse-submodules (or
> > when submodule.recurse is true).
> >=20
> > This is obviously not the behavior the user wanted, so let's fix this by
> > specifically setting the submodule as inactive in this case when we're
> > initializing the repository.  That will make us properly ignore the
> > submodule when performing recursive operations.
> >=20
> > We only do this when initializing a submodule,
>=20
> Here for even more clarity I would add:
>=20
> i.e. 'git submodule init' or 'git submodule update --init',

Okay.

> > since git submodule
> > update can update the submodule with various options despite the setting
> > of "none" and we want those options to override it as they currently do.
> >=20
> > Reported-by: Rose Kunkel <rose@rosekunkel.me>
> > Helped-by: Philippe Blain <levraiphilippeblain@gmail.com>
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> >   builtin/submodule--helper.c |  6 ++++++
> >   t/t5601-clone.sh            | 24 ++++++++++++++++++++++++
> >   2 files changed, 30 insertions(+)
>=20
> As I said in my review of v1, I think this would warrant a mention in the=
 doc.
>=20
> In general, I think 'git-submodule(1)' could be more precise about which =
submodules
> are touched by which subcommands. Since the topic that introduced the 'ac=
tive' concept
> was merged in a93dcb0a56 (Merge branch 'bw/submodule-is-active', 2017-03-=
30), these subcommand
> recurse only in active submodules:
>=20
> - init (with a big caveat, see below)
> - sync
> - update
>=20
> The doc makes no mention of that for sync and update. sync says it synchr=
onizes 'all'
> submodules, and update says it updates 'registered' submodules ('register=
ed' in not
> defined formally anywhere either). And 'active' is mentioned in the descr=
iption of
> 'init', but not defined. It would be good to explicitely say "see the 'Ac=
tive submodules'
> section in gitsubmodules(7) for a definition of 'active'", or something l=
ike that.
>=20
> I'm not saying we need to fix that necessarily in this patch, I'm just no=
ting
> what my reading of the code and of the doc reveals.



> I did more testing with this patch applied and I fear it is not
> completely sufficient. There are 2 main problems, I think.
> The first is that the following still triggers the bug:
>=20
>     git clone server client
>     git -C client submodule update --init
>     git -C client submodule init       # should be no-op, but isn't
>     git -C client reset --hard --recurse-submodules
>=20
> That's because:
>=20
> 1) 'git submodule init' operates on *all* submodules if 'submodule.active=
' is unset
>     and not <path> is given.
>     (see submodule--helper.c::module_init), or the doc [1].
> 2) 'git submodule init' sets 'submodule.$name.active' to true for the sub=
modules
>     on which it operates, unless already covered by 'submodule.active'
>     (see submodule--helper.c::init_submodule)
> 3) the code we're adding to set 'active' to false if 'update=3Dnone' is o=
nly executed
>    if 'submodule.c.update' is not yet in the config, so it gets skipped i=
f we
>    repeat 'git submodule init'. (I think this behaviour is sound).
>=20
> So that's unfortunate, and is also kind of contradictory to what the doc =
says
> for 'git submodule init':
> "This command does not alter existing information in .git/config.".
> And just to be clear, the behaviour I describe above is already existing,=
 the current
> patch just makes it more obvious.

Right, I noticed that.

> I think we could manage to change that behaviour a bit
> in order to have 'submodule init' not modify the config for submodules wh=
ich are already marked inactive,
> *unless* they are explitely matched by the pathspec on the command line.
> So we would have:
>=20
>     git clone server client; cd client
>     git submodule init      # initial call sets 'submodule.c.active=3Dfal=
se'
>     git submodule init      # does not touch c, it's already marked inact=
ive
>     git submodule init c    # OK, we really want to mark it as active

We could also add an option, --all, to make it work on all submodules.
That's because previously "git submodule init" did work on all the
submodules in the repository in question, but it doesn't now because of
our change.

> So it's all a little bit complicated! But I think that with my suggestion=
 above,
> i.e. that 'git submodule init', in the absence of 'submodule.active', wou=
ld
> only switch inactive submodules to active if they are explicitely listed,=
 then
> we could get a saner behaviour, at the expense of having to explicitely i=
nit
> 'update=3Dnone' submodules on the command line if we really want to '--ch=
eckout' :
>     git clone server client
>     git -C client submodule update --init        # first call: set c to i=
nactive
>     git -C client submodule update --init        # no-op
>     git -C client submodule update --checkout    # does not clone c (curr=
ently quiet)
>     git -C client submodule update --checkout c  # does not clone c, but =
warns (current behaviour)
>     git -C client submodule init c               # sets c to active
>     git -C client submodule update --checkout    # clones c
>=20
> where the last two command could be a single
> 'git submodule update --init --checkout c' and ideally the
> 4th command should also warn the user that they now have to explicitely '=
init'
> c if they want to check it out, which could simply mean tweaking the alre=
ady
> existing message in next_submodule_warn_missing to also check if
> the current submodule has 'update=3Dnone' and then display the warning
> (instead of just showing it if the submodule was listed on the command
> line, which is the current behaviour). Additionnaly, the warning should
> say "Maybe you want to use 'update --init %s'?", i.e. specify the path.
>=20
>=20
> What do you think of my suggestions ? I can help push this forward
> by contributing patches if we agree that we should go forward with
> this slight behaviour change in 'git submodule init' ...

With the modification of adding --all to init so users can get a
behavior a little more similar to the previous, yes, that sounds good.
It would be great if you'd be willing to send a few patches.

> > diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> > index c0688467e7..efe6b13be0 100755
> > --- a/t/t5601-clone.sh
> > +++ b/t/t5601-clone.sh
> > @@ -752,6 +752,30 @@ test_expect_success 'batch missing blob request do=
es not inadvertently try to fe
> >   	git clone --filter=3Dblob:limit=3D0 "file://$(pwd)/server" client
> >   '
> > +test_expect_success 'clone with submodule with update=3Dnone is not ac=
tive' '
> > +	rm -rf server client &&
> > +
> > +	test_create_repo server &&
> > +	echo a >server/a &&
> > +	echo b >server/b &&
> > +	git -C server add a b &&
> > +	git -C server commit -m x &&
> > +
> > +	echo aa >server/a &&
> > +	echo bb >server/b &&
> > +	git -C server submodule add --name c "$(pwd)/repo_for_submodule" c &&
> > +	git -C server config -f .gitmodules submodule.c.update none &&
> > +	git -C server add a b c .gitmodules &&
> > +	git -C server commit -m x &&
> > +
> > +	git clone --recurse-submodules server client &&
> > +	git -C client config submodule.c.active >actual &&
> > +	echo false >expected &&
> > +	test_cmp actual expected &&
> > +	# This would fail if the submodule were active, since it is not check=
ed out.
> > +	git -C client reset --recurse-submodules --hard
> > +'
>=20
> I think we might want to also test the non-recursive clone case as well,
> i.e. 'git clone' and then 'git submodule update --init', as well as
> subsequent calls to 'git submodule init' in light of my analysis above.
>=20
> Also, the only place in the test suite that I could find where
> 'update=3Dnone' is tested is in t7406.35-38 in t7406-submodule-update.sh
> so maybe it would make more sense to put the test(s) there ?

Sure, I can do that.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--wQa3Zb+NopIk0Htb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYOsjZQAKCRB8DEliiIei
gXeGAP9Qoko+nGsX0hmbsSHcN5oGhh2gibcjTgf/5vM5D3ceiAEAmCenGk8ZHhKi
7cIvm2xPG1Ohc2oSfH/IEMgtDivxhgQ=
=JuOU
-----END PGP SIGNATURE-----

--wQa3Zb+NopIk0Htb--
