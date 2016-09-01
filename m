Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B6CC1F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 13:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932504AbcIANdU (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 09:33:20 -0400
Received: from mout.gmx.net ([212.227.17.20]:54946 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754807AbcIANdS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 09:33:18 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LZzY9-1bEJya3yv7-00lotE; Thu, 01 Sep 2016 15:33:10
 +0200
Date:   Thu, 1 Sep 2016 15:33:08 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 16/22] sequencer: prepare for rebase -i's GPG settings
In-Reply-To: <104de15c-77e8-9474-9579-4934ca8a4323@gmail.com>
Message-ID: <alpine.DEB.2.20.1609011516080.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <c6a37af958f59390c00429a5b38b34d34c9a5b95.1472457609.git.johannes.schindelin@gmx.de> <104de15c-77e8-9474-9579-4934ca8a4323@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-273417691-1472736789=:129229"
X-Provags-ID: V03:K0:YiuVcfKZvtLExvfP+8yATMNXcoHCKbxNJf0biDeUKWfN1W3ZUab
 37ao61tdCvdkQ0BdBPbmvbSz5YOouQjrxumkCvYYxCLLkgWmeF/CBBpNVH94VA+bCWIvRNE
 5/aoyC5fGJIA+Zr4TkXsx/UzgmcOGBANoxBFa/lVZPuIcKeS0cYf8NE1B7QPYk1pBLEBO68
 FKp+cEE7von1pBJQBLl6w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+9uX4cCDOr0=:cTVBN8Txk4Ac6n0baYPfKk
 2tc2hjFGzUZN7nA0XsQYkSjekBXzDg6vWzVRXPAxIYGgoBR94zMeqtw8qvz8N1gmsXp1OvJWi
 BtdmwddZGu8M/2ZfHpay8RaISTFP4qb2sr+H4qeZpDDrmjFQWE9qrvMv1ZwdimZScPMIQmXcD
 b/52RQEzCJycIsYKfk59i0wgvBl8iCjqzj167hhq7GGzMJTLKMGOJGra93JNV7LcDOJ+MhNDg
 Qe1cdP0OqI/s4DU8CKdm9kEGe9jhV8phdJB6yO8XYX4ng2CcvXJ6w2uweMMScSbCY8qGb7LHr
 UJAesfoEu8symVxE2yeXPbOmiJioiktYZlGmqhZblGsNnEQzZxlTwSIzOpfw+D1P7KdY4X5Gb
 qIAL5dLBIvA4PKBKRhDr9cA1tjFpP+H70qsmkoCnAdDesXjfQi0Jsvve7j6gA8RZdJpq9lyOw
 mDfjgPnIKj82LrKWZwVlhOgqbNlLZO7Tg95qanlbDWss6VvjNu7ZNDkdZbYh/3MoY5Hfu5+WN
 52uXYgOeuVCo4yx/peDFuWpFLOCSRpxtAOLh93cb9WJIKKPPhCMVLp4l0K3R4r3fuAMyJryXQ
 5YluFlESBLbwABeOtsk97BHQhgadUpeQ/2hitFJIjy78FUC42a0OO+nhHrwJj0mTc0A81hl0A
 Mm/fN7ge96s7jA1u+NRIy+/ppHq+dZJFARlPl7Ro2O/qYRE+rBMA8YyH9T0LIOFEZFiNkT/oN
 t7/scMvDuAUqnFiVpi/y1wyXm2e/CRe3/QvroJ6FfapBHqBFg2weO1jzyvAl/gPs4up7brefk
 1eHGKWy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-273417691-1472736789=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kuba,

On Wed, 31 Aug 2016, Jakub Nar=C4=99bski wrote:

> W dniu 29.08.2016 o 10:06, Johannes Schindelin pisze:
>=20
> > The rebase command sports a `--gpg-sign` option that is heeded by the
> > interactive rebase.
>=20
> Should it be "sports" or "supports"?

Funny. I got a PR last week that wanted to fix a similar expression.

I really meant "to sport", as in "To display; to have as a notable
feature.". See https://en.wiktionary.org/wiki/sport#Verb

> > +static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_=
opt")
>=20
> I know it is not your fault, but I wonder why this file uses
> snake_case_name, while all other use kebab-case-names.  That is,
> why it is gpg_sign_opt and not gpg-sign-opt.

Yes, you are correct: it is not my fault ;-)

> Sidenote: it's a pity api-quote.txt is just a placeholder for proper
> documentation (including sq_quotef()).  I also wonder why it is not
> named sq_quotef_buf() or strbuf_addf_sq().

Heh. I did not even bother to check the documentation, it is my long-time
habit to dive right into the code.

> > @@ -471,17 +487,20 @@ int sequencer_commit(const char *defmsg, struct r=
eplay_opts *opts,
> > =20
> >  =09if (IS_REBASE_I()) {
> >  =09=09env =3D read_author_script();
> > -=09=09if (!env)
> > +=09=09if (!env) {
> > +=09=09=09const char *gpg_opt =3D gpg_sign_opt_quoted(opts);
> > +
> >  =09=09=09return error("You have staged changes in your working "
> >  =09=09=09=09"tree. If these changes are meant to be\n"
> >  =09=09=09=09"squashed into the previous commit, run:\n\n"
> > -=09=09=09=09"  git commit --amend $gpg_sign_opt_quoted\n\n"
>=20
> How did this get expanded by error(), and why we want to replace
> it if it works?

It did not work. It was a place-holder waiting for this patch ;-)

>=20
> > +=09=09=09=09"  git commit --amend %s\n\n"
> >  =09=09=09=09"If they are meant to go into a new commit, "
> >  =09=09=09=09"run:\n\n"
> > -=09=09=09=09"  git commit $gpg_sign_opt_quoted\n\n"
> > +=09=09=09=09"  git commit %s\n\n"
> >  =09=09=09=09"In both case, once you're done, continue "
> >  =09=09=09=09"with:\n\n"
> > -=09=09=09=09"  git rebase --continue\n");
> > +=09=09=09=09"  git rebase --continue\n", gpg_opt, gpg_opt);
>=20
> Instead of passing option twice, why not make use of %1$s (arg reordering=
),
> that is
>=20
>   +=09=09=09=09"  git commit --amend %1$s\n\n"
> [...]
>   +=09=09=09=09"  git commit %1$s\n\n"

Cute. But would this not drive the l10ners insane?

> So shell quoting is required only for error output.

Indeed.

> > @@ -955,8 +974,27 @@ static int populate_opts_cb(const char *key, const=
 char *value, void *data)
> > =20
> >  static int read_populate_opts(struct replay_opts *opts)
> >  {
> > -=09if (IS_REBASE_I())
> > +=09if (IS_REBASE_I()) {
> > +=09=09struct strbuf buf =3D STRBUF_INIT;
> > +
> > +=09=09if (read_oneliner(&buf, rebase_path_gpg_sign_opt(), 1)) {
> > +=09=09=09if (buf.len && buf.buf[buf.len - 1] =3D=3D '\n') {
> > +=09=09=09=09if (--buf.len &&
> > +=09=09=09=09    buf.buf[buf.len - 1] =3D=3D '\r')
> > +=09=09=09=09=09buf.len--;
> > +=09=09=09=09buf.buf[buf.len] =3D '\0';
> > +=09=09=09}
>=20
> Isn't there some strbuf_chomp() / strbuf_strip_eof() function?
> Though as strbuf_getline() uses something similar...

Even worse. read_oneliner() *already* does that. I just forgot to delete
this code when I introduced and used read_oneliner().

Thanks.

> > +=09=09=09if (!starts_with(buf.buf, "-S"))
> > +=09=09=09=09strbuf_reset(&buf);
>=20
> Should we signal that there was problem with a file contents?

Maybe. But probably not: this file is written by git-rebase itself. I
merely safe-guarded against empty files here.

> > +=09=09=09else {
> > +=09=09=09=09opts->gpg_sign =3D buf.buf + 2;
> > +=09=09=09=09strbuf_detach(&buf, NULL);
>=20
> Wouldn't we leak 2 characters that got skipped?  Maybe xstrdup would
> be better (if it is leaked, and not reattached)?

We do not leak anything because I changed the code locally already to use
sequencer_entrust() (I guess in response to an earlier of your comments).

Ciao,
Dscho
--8323329-273417691-1472736789=:129229--
