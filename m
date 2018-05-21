Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0392A200B9
	for <e@80x24.org>; Mon, 21 May 2018 12:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751109AbeEUMh3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 08:37:29 -0400
Received: from mout.gmx.net ([212.227.17.22]:58209 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751056AbeEUMh2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 08:37:28 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LcVOE-1g37Dd1JYc-00jtfv; Mon, 21
 May 2018 14:37:11 +0200
Date:   Mon, 21 May 2018 14:37:12 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Christian Couder <christian.couder@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@dwim.me>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        David Turner <novalis@novalis.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] t: make many tests depend less on the refs being files
In-Reply-To: <nycvar.QRO.7.76.6.1805211126140.77@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1805211436230.77@tvgsbejvaqbjf.bet>
References: <20180521055143.14701-1-chriscool@tuxfamily.org> <nycvar.QRO.7.76.6.1805211126140.77@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-203493503-1526906235=:77"
X-Provags-ID: V03:K1:wM1fbi71XVnGoM0zAyzwOxhOV6e0SKSdOi26S3kqDph20iFkrpN
 +A4Bfltai6NFrswFdHJBUilRZMc1wRU+xS4cICFecjRoWuAaoD75Pyep7crBF6IxhKep2uO
 2ZztfGBTyLabRM96zU/S2tVwdJD8V2IamUrzSY4MTaiXr0P2IunEPHNLxhGdNdgkyucCEa4
 D1Jbk2ggcDe6v3FJs97pw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:z2KqhMLhtW0=:Th6m7QNP2E6YxR0LYY3y4x
 EWfOBBO7Tpw+TFfwJbw5oBbjPiChGRMTdMQkGTnpWt7KCVPeVMqoxQFp9zzOLel/t1UUt8XoQ
 EIHDGNrZpoGdYXddWUJDx6ImcWM5dJokJMN2Z69nfL1DRDlQpco9zm/bVByNc21OaE5uhzsMZ
 chbRSJMqwVzR/29ZGQu4aDJiQiNapnQx5WEq6w3T3T+8ZAb94gjee5NIWHFeuOmLAlJQ+pvSP
 aoSVxi86j6d3bcSsC7q8EHyfe4ID8Xl5sOac8isi5kkT6aAqYRNNPZqtBKHgcWp5XCz256qOj
 mfPu3rTV544Hje9iHqWOuoRjHByXGRs1pQo0Z7+Ua7WJn/rWNFPoN5A/dXcGvRqLOXbiyzZgx
 2L2nfaeRa8+WOeyBy+2URHsOwbxV5MGQJcCL4slzPR/Hv5ypsjkGOrmfBEjwS7ENSV/Zp1+F6
 MuG7fRhA3IF9i8Oi6rTyaQGZQ0JFeMgp/gsBHzPBXiooX8YHAeO6YfGuY4QddkzkmrbXWAH7P
 wUaIu1ZSjGW4mFkWpOZKp7TOJKEbffiFrP739pXUkRDHdHEdSLTAD7yD3nhxRJzltD7JnsD7Z
 25Tvsrl+tORnN1re9U8nSe2teVwiegM3B3hNKcLRV5x+uE/H6ByXwTip3HwGC8eWY0mS6n21b
 acwrogqIJ1zcXObaz/ilAWbzcNREH57VmkUvqb2QytxTDkwH2hM+fE+QBReJNGrV6CZmIkUd4
 +0WUrbgO0o1W6l5/puWRvKGY8OBHKHi6vgics/9E6r3IMifWOszbC8inJBjkemKfjBKZNZDTw
 u55V05i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-203493503-1526906235=:77
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

of course I messed up and did not fix the Cc: list... now fixed ;-)


On Mon, 21 May 2018, Johannes Schindelin wrote:

> Hi Chris,
>=20
> On Mon, 21 May 2018, Christian Couder wrote:
>=20
> > From: David Turner <dturner@twopensource.com>
>=20
> I vaguely remember that Dave suggested using a different email address
> these days...
>=20
> *clicketyclick*
>=20
> ah, yes:
> https://public-inbox.org/git/1474935093-26757-3-git-send-email-dturner@tw=
osigma.com/
>=20
> So maybe update it here, too, to=20
>=20
> =09From: David Turner <novalis@novalis.org>
>=20
> ?
>=20
> > So that they work under alternate ref storage backends.
> >=20
> > This will be really needed when such alternate ref storage backends are
> > developed. But this could already help by making clear to readers that
> > some tests do not depend on which ref backend is used.
> >=20
> > This patch just takes care of many low hanging fruits. It does not try
> > to completely solves the issue.
> >=20
> > Signed-off-by: David Turner <dturner@twopensource.com>
> > Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> > ---
>=20
> This is great. I am all for making the tests better ;-)
>=20
> > diff --git a/t/lib-t6000.sh b/t/lib-t6000.sh
> > index 3f2d873fec..b8567cdf94 100644
> > --- a/t/lib-t6000.sh
> > +++ b/t/lib-t6000.sh
> > @@ -4,11 +4,10 @@ mkdir -p .git/refs/tags
> > =20
> >  >sed.script
> > =20
> > -# Answer the sha1 has associated with the tag. The tag must exist in .=
git/refs/tags
> > +# Answer the sha1 has associated with the tag. The tag must exist unde=
r refs/tags
> >  tag () {
> >  =09_tag=3D$1
> > -=09test -f ".git/refs/tags/$_tag" || error "tag: \"$_tag\" does not ex=
ist"
> > -=09cat ".git/refs/tags/$_tag"
> > +=09git rev-parse --verify "refs/tags/$_tag" || error "tag: \"$_tag\" d=
oes not exist"
>=20
> Line longer than 80 columns...
>=20
> > diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> > index 0680dec808..886a9e3b72 100755
> > --- a/t/t5500-fetch-pack.sh
> > +++ b/t/t5500-fetch-pack.sh
> > @@ -30,7 +30,7 @@ add () {
> >  =09test_tick &&
> >  =09commit=3D$(echo "$text" | git commit-tree $tree $parents) &&
> >  =09eval "$name=3D$commit; export $name" &&
> > -=09echo $commit > .git/refs/heads/$branch &&
> > +=09git update-ref refs/heads/$branch $commit &&
>=20
> I think we have to be careful here to quote both "refs/heads/$branch" and
> "$commit" here, as a bug that introduces spaces into $commit or $branch
> would have been caught earlier, but not now, unless we quote.
>=20
> This goes for all introduced `update-ref` calls.
>=20
> Maybe even for some `git rev-parse --verify` calls.
>=20
> > diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
> > index 8f5c811dd7..c3b89ae783 100755
> > --- a/t/t9903-bash-prompt.sh
> > +++ b/t/t9903-bash-prompt.sh
> > @@ -148,7 +148,7 @@ test_expect_success 'prompt - inside .git directory=
' '
> >  test_expect_success 'prompt - deep inside .git directory' '
> >  =09printf " (GIT_DIR!)" >expected &&
> >  =09(
> > -=09=09cd .git/refs/heads &&
> > +=09=09cd .git/objects &&
> >  =09=09__git_ps1 >"$actual"
> >  =09) &&
> >  =09test_cmp expected "$actual"
> > --=20
>=20
> This one looks wrong.
>=20
> Upon cursory review, one might be tempted to assume that the file is now
> written into .git/objects/ instead of .git/refs/heads/. And the patch
> context provided in the email is not enough to see (gawd, I hate
> mail-based patch review, it really takes all my Git tools away from me).
> The trick is that `actual` points at an absolute path:
>=20
> =09#!/bin/sh
> =09#
> =09# Copyright (c) 2012 SZEDER G=C3=A1bor
> =09#
>=20
> =09test_description=3D'test git-specific bash prompt functions'
>=20
> =09. ./lib-bash.sh
>=20
> =09. "$GIT_BUILD_DIR/contrib/completion/git-prompt.sh"
>=20
> =09actual=3D"$TRASH_DIRECTORY/actual"
> =09[...]
>=20
> So the remaining question (which probably wants to be added to the commit
> message together with a hint that `actual` points at an absolute path) is=
:
> Why not `cd .git` instead?
>=20
> Ciao,
> Dscho
--8323328-203493503-1526906235=:77--
