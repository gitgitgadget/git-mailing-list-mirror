Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 072331F462
	for <e@80x24.org>; Tue,  4 Jun 2019 14:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfFDOd2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 10:33:28 -0400
Received: from mout.gmx.net ([212.227.15.15]:37199 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727204AbfFDOd1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 10:33:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559658804;
        bh=98zXOU+Z/KyXzJpO/wgriqCpkYZnyr3yIba1MzsSeww=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZNgvq+7AnedmuqHWB/z3jigAZ14r9UufzoihQRiVEd4aMHAJpu82WhkQ0Brb7RH1x
         1nk49nN4wMR2YnwOb2HP4FxRpOR6MK+k9Fmximnnkwp+IDWDIihR1/YpcT6dFzPdCZ
         aOU6u/KaqkoIy4uXKmpHB3sm7W6OhfoefQHVuwdE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lm34j-1gz6jV2XKr-00Zcjr; Tue, 04
 Jun 2019 16:33:24 +0200
Date:   Tue, 4 Jun 2019 16:33:08 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH v2] tag: add tag.gpgSign config option to force all tags
 be GPG-signed
In-Reply-To: <20190604114356.11042-2-tigran.mkrtchyan@desy.de>
Message-ID: <nycvar.QRO.7.76.6.1906041608570.1775@tvgsbejvaqbjf.bet>
References: <60741736.3439901.1509090074292.JavaMail.zimbra@desy.de> <20190604114356.11042-1-tigran.mkrtchyan@desy.de> <20190604114356.11042-2-tigran.mkrtchyan@desy.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:OF4ka3yUQn5lIA4GD9dt+JbDW55/4zask0p+VYfYLAMUg7d5J+n
 xsv03I8XiOjhESuFZGVuOXQSFMrKnU5PKgOmM7qxeAhXYj0UufJD9OKZPflrBazd55Cx1vJ
 K1K80jOxoyoTQqcc6CCC+DNepMzgqKDBYjhTkjBiVKw9mLLrP5AoUS6fRKBHqblYm9rFLfP
 1JQGCTuPlsLInhzdNtzXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S61Gv4PqlXc=:QjuFSFqp4cyasBcmHU3vwQ
 oO61qHudUcqlJ9EIyOuk61USu9L4C6dPMrIGrVIlH0Ak79hQliFUYcSLIc3DY3efd0GKlX/uJ
 FHKe8y6JDZDNDdMp8TlBLYcFfswa4FyGIX8LMvJoxCjowDvHdJLXz7j0eQ+FphNSOGu3k1/Ah
 ZnHnCVaITpz/XL00kZNJFM09QTUSXbfpqS5I6WpZ2rRKX3cPyTXLaaqnuYntiUFv+B5PUqnMb
 7jbgmHAbmFNv20NAF251sH7vNgemXGk/IRPicNOrUqTmPM5O6EwFKc6FcBITS0Cyve5kTYGKr
 RtSTpdXfLxt/NSVxa88HTTSPiTjmuA9mpln9KO7Q0WWvpA6v/aKQkRUdTkjaUN1h7r5m3dWLQ
 9CX8RTx+OZj/zONDcoAck0HMabT3ehamleWc8K41Ee1Qmboo7oGkqhSgC11/3/r9YB43bc7B8
 1zGdMa7qClS0bSAjEhjPruO+fYw/gjY+6xxWJ3DjCbglG6x2HoNk3cW9e3wjLfIsNAoZp+BA6
 yUP/s5RrPe9DoV40OdOLe8QH97hQSoMG0A8msqFVdlikgN2yn6C9IH1sc+aE5bUnChtccyyYW
 J/Hgt5BaZD3CH61kK4EoxciCL/hjT/Re9dQqxqieAX8W9lN8FlNuUt5Llb3/6J1r2ARYQ6Aq/
 g8KPR/DVkS+XOvikCPWWuHT1NgcRY970oC8DgznPKItVlfjgu/IeJ4XN8H0M7LJTLtY5L1zPo
 rx7oza6um4rIXP3UkM2BBJV8TRsEQ0p070f/brb4CxuPOJnVjbHbcQfLzq/2XIJjE/R3sWqNj
 RROAXa8j91OFf8lH2fzYwTcczMWGz8O9Hc5zzcGANgrikGU/f4gEOCS6HI/BrgSaoFHEOxTXn
 0ll5weyNXZnOJRsHuoqloMLridQiRXsP1tADt6tvmoc2dIAvEaa3Uvx3NHa7+sLXFktpUj2Ei
 MjPJ3r1mTo0es8dvj9/ZnltQhYX+oazaYlvM1v+2I79S3t3emCY3M
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Tigran,

On Tue, 4 Jun 2019, Tigran Mkrtchyan wrote:

> As may CI/CD tools don't allow to control command line options when

s/may/many/, maybe?

> executing `git tag` command, a default value in the configuration file
> will allow to enforce tag signing if required.
>
> The new config-file option tag.gpgSign enforces signed tags. Additional
> command line option --no-gpg-sign is added to disable such behavior if
> needed. E.g.:
>
>     $ git tag -m "commit message"
>
> will generate a GPG signed tag if tag.gpgSign option is true, while
>
>     $ git tag --no-gpg-sign -m "commit message"
>
> will skip the signing step.
>
> Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
> ---
>  Documentation/git-tag.txt |  7 +++++++
>  builtin/tag.c             | 18 +++++++++++++++---

How about adding a section to Documentation/config/tag.txt as well?

Even better: it could be modeled after the description of commit.gpgsign
to which Stefan Beller linked in his review of your earlier patch (see
https://public-inbox.org/git/20131105112840.GZ4589@mars-attacks.org/):

  tag.gpgsign::
	A boolean to specify whether all tags should be GPG signed.
	Use of this option when running in an automated script can
	result in a large number of tags being signed. It is therefore
	convenient to use an agent to avoid typing your gpg passphrase
	several times.

>  t/t7004-tag.sh            | 21 +++++++++++++++++++++
>  3 files changed, 43 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index a74e7b926d..d9dbfb4e37 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -64,6 +64,9 @@ OPTIONS
>  -s::
>  --sign::
>  	Make a GPG-signed tag, using the default e-mail address's key.
> +	The default behabior of tag GPG-signing controlled by `tag.gpgSign`

s/behabior/behavior/ maybe?

And I would also insert an "is" before "controlled".

> +	configuration variable if it exists, or disabled oder otherwise.
> +	See linkgit:git-config[1].
>
>  -u <keyid>::
>  --local-user=3D<keyid>::
> @@ -193,6 +196,10 @@ This option is only applicable when listing tags wi=
thout annotation lines.
>  	that of linkgit:git-for-each-ref[1].  When unspecified,
>  	defaults to `%(refname:strip=3D2)`.
>
> +--no-gpg-sign::

Should this not be `--no-sign`? There is already a `--sign` option, and I
would wager a guess that it automagically handles `--no-sign`...

> +	Countermand `tag.gpgSign` configuration variable that is
> +	set to force each and every tag to be signed.

If you replace "Countermand" by "Override", you could simply merge this
into the section talking about `--sign`...


> diff --git a/builtin/tag.c b/builtin/tag.c
> index ef37dccf86..7f9aef4840 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -33,6 +33,7 @@ static const char * const git_tag_usage[] =3D {
>
>  static unsigned int colopts;
>  static int force_sign_annotate;
> +static int sign_tag;

Since this holds the value parsed from the config, I would like to see
some indication of that in the name. Maybe something like
`config_sign_tag`?

Also, I would recommend to initialize it with `-1` to be able to discern
between the three states `true`, `false` and `unspecified`.

>  static int list_tags(struct ref_filter *filter, struct ref_sorting *sor=
ting,
>  		     struct ref_format *format)
> @@ -144,6 +145,11 @@ static int git_tag_config(const char *var, const ch=
ar *value, void *cb)
>  	int status;
>  	struct ref_sorting **sorting_tail =3D (struct ref_sorting **)cb;
>
> +	if (!strcmp(var, "tag.gpgsign")) {
> +		sign_tag =3D git_config_bool(var, value);
> +		return 0;
> +	}
> +
>  	if (!strcmp(var, "tag.sort")) {
>  		if (!value)
>  			return config_error_nonbool(var);
> @@ -392,6 +398,7 @@ int cmd_tag(int argc, const char **argv, const char =
*prefix)
>  	struct ref_format format =3D REF_FORMAT_INIT;
>  	int icase =3D 0;
>  	int edit_flag =3D 0;
> +	int no_gpg_sign =3D 0;
>  	struct option options[] =3D {
>  		OPT_CMDMODE('l', "list", &cmdmode, N_("list tag names"), 'l'),
>  		{ OPTION_INTEGER, 'n', NULL, &filter.lines, N_("n"),
> @@ -413,6 +420,7 @@ int cmd_tag(int argc, const char **argv, const char =
*prefix)
>  					N_("use another key to sign the tag")),
>  		OPT__FORCE(&force, N_("replace the tag if exists"), 0),
>  		OPT_BOOL(0, "create-reflog", &create_reflog, N_("create a reflog")),
> +		OPT_BOOL(0, "no-gpg-sign", &no_gpg_sign, N_("do not GPG-sign tag")),
>
>  		OPT_GROUP(N_("Tag listing options")),
>  		OPT_COLUMN(0, "column", &colopts, N_("show tag list in columns")),
> @@ -445,6 +453,10 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
>
>  	argc =3D parse_options(argc, argv, prefix, options, git_tag_usage, 0);
>
> +	if (no_gpg_sign) {
> +		sign_tag =3D 0;
> +	}
> +

Hmm. I'd rather like to see this folded into the `--no-sign` option
implied by the `OPT_BOOL('s', "sign", ...)` part. The way this would work
would be to initialize the struct like this:

		struct create_tag_options opt =3D { .sign =3D -1 };

then leave

		OPT_BOOL('s', "sign", &opt.sign, N_("annotated and GPG-signed tag")),

as-is, and later do this:

	if (opt.sign < 0)
		opt.sign =3D config_sign_tag > 0;

> @@ -463,7 +475,7 @@ int cmd_tag(int argc, const char **argv, const char =
*prefix)
>  	if (cmdmode =3D=3D 'l')
>  		setup_auto_pager("tag", 1);
>
> -	if ((create_tag_object || force) && (cmdmode !=3D 0))
> +	if ((create_tag_object || force || no_gpg_sign) && (cmdmode !=3D 0))
>  		usage_with_options(git_tag_usage, options);

Should we really try to be that strict? If so, we would have to test for
`opt.sign > 0` here and make sure that above-mentioned `if (opt.sign < 0)`
block comes *after* this block.

> @@ -556,8 +568,8 @@ int cmd_tag(int argc, const char **argv, const char =
*prefix)
>
>  	create_reflog_msg(&object, &reflog_msg);
>
> -	if (create_tag_object) {
> -		if (force_sign_annotate && !annotate)
> +	if (create_tag_object || sign_tag) {
> +		if (sign_tag || (force_sign_annotate && !annotate))
>  			opt.sign =3D 1;

This would probably be better handled via

-	create_tag_object =3D (opt.sign || annotate || msg.given || msgfile);
+	create_tag_object =3D (opt.sign > 0 || config_sign_tag > 0 ||
+		annotate || msg.given || msgfile);

earlier. After all, this assignment of `create_tag_object` suggests that
it is a Boolean that catches *all* cases where a tag should be created.

But then, we would have to be very careful about this, as we don't want to
error out when a user calls `git tag -l` while `tag.gpgSign =3D true`. So
maybe instead:

-	create_tag_object =3D (opt.sign || annotate || msg.given || msgfile);
+	create_tag_object =3D (opt.sign > 0 || annotate || msg.given || msgfile)=
;

and later, after that test whether `(create_tag_object || force) &&
cmd_mode !=3D 0` do:

	if (opt.sign < 0) {
		opt.sign =3D config_sign_tag > 0;
		create_tag_object ||=3D opt.sign;

> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index 6aeeb279a0..98a07a29d2 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -932,6 +932,27 @@ test_expect_success GPG \
>  	test_cmp expect actual
>  '
>
> +get_tag_header gpgsign-enabled $commit commit $time >expect
> +echo "A message" >>expect
> +echo '-----BEGIN PGP SIGNATURE-----' >>expect
> +test_expect_success GPG \
> +	'git tag configured tag.gpgsign enables GPG sign' \
> +	'test_config tag.gpgsign true &&
> +	git tag -m "A message" gpgsign-enabled &&
> +	get_tag_msg gpgsign-enabled>actual &&
> +	test_cmp expect actual
> +'
> +
> +get_tag_header no-gpg-sign $commit commit $time >expect
> +echo "A message" >>expect
> +test_expect_success GPG \
> +	'git tag --no-gpg-sign configured tag.gpgsign skip GPG sign' \
> +	'test_config tag.gpgsign true &&
> +	git tag -a --no-gpg-sign -m "A message" no-gpg-sign &&

With my idea above, this would of course become `--no-sign`.

> +	get_tag_msg no-gpg-sign>actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success GPG \
>  	'trying to create a signed tag with non-existing -F file should fail' =
'
>  	! test -f nonexistingfile &&

Apart from the things I suggested in the hope to help you improve the
patch, this looks good to me so far.

Thanks,
Johannes
