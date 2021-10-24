Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54D9C433EF
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 15:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9196E60F21
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 15:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbhJXPkq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Oct 2021 11:40:46 -0400
Received: from mail.archlinux.org ([95.216.189.61]:56240 "EHLO
        mail.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbhJXPkp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Oct 2021 11:40:45 -0400
Message-ID: <b08a9b79-c53b-c2f3-f976-01822b362add@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1635089903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=URwIkRCvvUK5H3/UWiyuGrwpit5DcGbout2jkpaQfoY=;
        b=OjVDCXqslwdJMAlmuTi8YoB+8Al2XWcHN7COssR5opDNk+idks8TWqvNKF+biQmDf11SrA
        6C+njuZ50BGyPTUByrd780tfFZZsiRFiZ0KGpNbeWRQwHgJri3DEufOcHq9h9kten/KSkC
        pe70FsUUc/b/IlfGrnITMIjfefsUAJqoxvmNaZrfVVNnUD9z26pNxZiP5i9GAW+VzSm3HK
        mVEgaTqi451MOCiwGFW6Flk0VsgscQoozVgbweqJxlOUrKSiXNJ8124VsSgUC3b4oD+hzJ
        XvoM8Uu7d7jE2GGAGLSvAXG/LvCy7l8o7ZFnAdoPUIhE4CkjvlH/oXWkrnoIglfS0Bbwt3
        C7Rc51dhrKzzAMMr4IB6SROuYVqAgAW1ACMTXTdczDLqjdz79hLy5PdH3jPZDt2huDYO23
        hv9DdH3V25wZbGTAEk0kc7dI15xlasQ1AQYCE9lhKyq9iA+ApMYhEaICaoHrDTBtZQLhFR
        4va8XdNVEMUbCc/Bll/Ze+UX+9pRJZVF86ptmz5II0k8loalBR+3dwGp+U4GF9E98nuK0e
        YaOGlw4utmAXMGv++jjzQ7hHYfWV5FAKtxDxTrGuIjNYo23cfd8za6b0a+h2DidaQldf70
        7IYB5QMPsEQ5LzQwDxxdhgt3IO/Dg8GG8zogyyFxZpKvTof7TJMBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1635089903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=URwIkRCvvUK5H3/UWiyuGrwpit5DcGbout2jkpaQfoY=;
        b=Dv4/zt4Kh3PHhjz9CDHtVt7OP1tJpYEjBpOP266dQxyzH2OHfEOHjaJhGsuvQz/1Kjd/8Z
        bzjRuaEh4whhk2Cw==
Date:   Sun, 24 Oct 2021 11:38:20 -0400
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] pretty: add tag option to %(describe)
Content-Language: en-US-large
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <20211024014256.3569322-1-eschwartz@archlinux.org>
 <20211024014256.3569322-3-eschwartz@archlinux.org>
 <xmqq5ytn6mw2.fsf@gitster.g>
From:   Eli Schwartz <eschwartz@archlinux.org>
X-Clacks-Overhead: GNU Terry Pratchett
In-Reply-To: <xmqq5ytn6mw2.fsf@gitster.g>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------kt340f0tkraN1rrJSlOfi0tR"
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=eschwartz smtp.mailfrom=eschwartz@archlinux.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------kt340f0tkraN1rrJSlOfi0tR
Content-Type: multipart/mixed; boundary="------------SZqyZJuAm9Kgmbs3Gccgbe9J";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@archlinux.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <b08a9b79-c53b-c2f3-f976-01822b362add@archlinux.org>
Subject: Re: [PATCH 2/3] pretty: add tag option to %(describe)
References: <20211024014256.3569322-1-eschwartz@archlinux.org>
 <20211024014256.3569322-3-eschwartz@archlinux.org>
 <xmqq5ytn6mw2.fsf@gitster.g>
In-Reply-To: <xmqq5ytn6mw2.fsf@gitster.g>

--------------SZqyZJuAm9Kgmbs3Gccgbe9J
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/24/21 12:57 AM, Junio C Hamano wrote:
> Eli Schwartz <eschwartz@archlinux.org> writes:
>=20
>> The %(describe) placeholder by default, like `git describe`, only
>> supports annotated tags. However, some people do use lightweight tags
>> for releases, and would like to describe those anyway. The command lin=
e
>> tool has an option to support this.
>>
>> Teach the placeholder to support this as well.
>>
>> Signed-off-by: Eli Schwartz <eschwartz@archlinux.org>
>> ---
>>  Documentation/pretty-formats.txt | 11 ++++++-----
>>  pretty.c                         | 23 +++++++++++++++++++----
>>  t/t4205-log-pretty-formats.sh    |  8 ++++++++
>>  3 files changed, 33 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-f=
ormats.txt
>> index ef6bd420ae..14107ac191 100644
>> --- a/Documentation/pretty-formats.txt
>> +++ b/Documentation/pretty-formats.txt
>> @@ -220,6 +220,7 @@ The placeholders are:
>>  			  inconsistent when tags are added or removed at
>>  			  the same time.
>>  +
>> +** 'tags[=3D<BOOL>]': Also consider lightweight tags.
>>  ** 'match=3D<pattern>': Only consider tags matching the given
>>     `glob(7)` pattern, excluding the "refs/tags/" prefix.
>>  ** 'exclude=3D<pattern>': Do not consider tags matching the given
>=20
> What is the guiding principle used in this patch to decide where the
> new entry should go? =20
>=20
> The existing 'match' and 'exclude' are the opposites to each other,
> and it makes sense to keep them together, and between them, 'match'
> is the positive variant while 'exclude' is the negative one, so the
> current order makes sense.  I wonder why the new "also consider"
> should come before them, instead of after.
>=20
> I am not saying you should change the order, and I would be most
> unhappy if you did so without explanation in an updated patch.
> Rather, I would like to hear the reasoning behind the decision,
> preferrably in the proposed log message.


The guiding principle I used was to replicate the order in which the
same options are listed in git-describe(1).

Err, maybe that means I should not have used the word "also" in the doc
string...


>> @@ -273,11 +274,6 @@ endif::git-rev-list[]
>>  			  If any option is provided multiple times the
>>  			  last occurrence wins.
>>  +
>> -The boolean options accept an optional value `[=3D<BOOL>]`. The value=
s
>> -`true`, `false`, `on`, `off` etc. are all accepted. See the "boolean"=

>> -sub-section in "EXAMPLES" in linkgit:git-config[1]. If a boolean
>> -option is given with no value, it's enabled.
>> -+
>>  ** 'key=3D<K>': only show trailers with specified key. Matching is do=
ne
>>     case-insensitively and trailing colon is optional. If option is
>>     given multiple times trailer lines matching any of the keys are
>> @@ -313,6 +309,11 @@ insert an empty string unless we are traversing r=
eflog entries (e.g., by
>>  decoration format if `--decorate` was not already provided on the com=
mand
>>  line.
>> =20
>> +The boolean options accept an optional value `[=3D<BOOL>]`. The value=
s
>> +`true`, `false`, `on`, `off` etc. are all accepted. See the "boolean"=

>> +sub-section in "EXAMPLES" in linkgit:git-config[1]. If a boolean
>> +option is given with no value, it's enabled.
>> +
>=20
> This paragraph used to be inside the description of %(trailers:...),
> but that was only because %(trailers) was the only one that took a
> boolean value for its options, and not because it was the only one
> that had special treatment for its boolean options.  Because the
> existing rule for an option that takes a boolean value equally
> applies to the %(describe:...), and more importantly, because we
> expect that any other pretty-format placeholder that would acquire
> an option with boolean value would follow the same rule, it makes
> sense to move it here, together with other rules like %+ and %- that
> apply to any placeholders.
>=20
> Makes sense.  I very much appreciate this extra attention to the
> detail.


:)


>> diff --git a/pretty.c b/pretty.c
>> index 9db2c65538..3a41bedf1a 100644
>> --- a/pretty.c
>> +++ b/pretty.c
>> @@ -1216,28 +1216,43 @@ int format_set_trailers_options(struct process=
_trailer_options *opts,
>> =20
>>  static size_t parse_describe_args(const char *start, struct strvec *a=
rgs)
>>  {
>> +	const char *options[] =3D { "tags" };
>>  	const char *option_arguments[] =3D { "match", "exclude" };
>>  	const char *arg =3D start;
>> =20
>>  	for (;;) {
>>  		const char *matched =3D NULL;
>> -		const char *argval;
>> +		const char *argval =3D NULL;
>>  		size_t arglen =3D 0;
>> +		int optval =3D 0;
>>  		int i;
>> =20
>>  		for (i =3D 0; i < ARRAY_SIZE(option_arguments); i++) {
>>  			if (match_placeholder_arg_value(arg, option_arguments[i], &arg,
>>  							&argval, &arglen)) {
>>  				matched =3D option_arguments[i];
>> +				if (!arglen)
>> +					return 0;
>>  				break;
>>  			}
>>  		}
>> +		if (!matched)
>> +			for (i =3D 0; i < ARRAY_SIZE(options); i++) {
>> +				if (match_placeholder_bool_arg(arg, options[i], &arg,
>> +								&optval)) {
>> +					matched =3D options[i];
>> +					break;
>> +				}
>> +			}
>>  		if (!matched)
>>  			break;
>> =20
>=20
> I find this new structure of the code somewhat dubious.  Shouldn't
> we be rather starting with an array of struct that describes the
> token to match and how the token should be handled?  Something like
>=20
>     struct {
> 	const char *name;
> 	enum { OPT_STRING, OPT_BOOL } type;
>     } option[] =3D {
> 	{ "exclude", OPT_STRING },
>         { "match", OPT_STRING },
> 	{ "tags", OPT_BOOL },
>     };
>=20
>     for (;;) {
> 	int i;
> 	int found =3D 0;
> 	...
>         for (i =3D 0; !found && i < ARRAY_SIZE(option); i++) {
>             switch (option.type) {
>             case OPT_STRING:
>                 if (match_placeholder_arg_value(...)) {
>                     strvec_pushf(args, "--%s=3D%.*s", ...);
> 		    found =3D 1;
> 		}
>                 break;
>             case OPT_BOOL:
>                 if (match_placeholder_bool_arg(...)) {
> 		    found =3D 1;
> 		    if (optval)
> 			strvec_pushf(args, "--%s", option.name);
> 		    else
> 			strvec_pushf(args, "--no-%s", option.name);
> 		}
> 		break;
> 	    }
> 	}
>     }
>=20
> And instead of the option -> option_arguments rename, the 1/3 of the
> series can be to introduce the above structure, without introducing
> OPT_BOOL and "tags" element to the option[] array.


Maybe!

I'll confess that I'm a bit of a monkey-see-monkey-do coder when it
comes to C (I keep meaning to learn it properly, but as things stand I'm
a lot more comfortable in e.g. python). So there is a good chance I
could be a lot more optimized in my approach... your suggestion
resembles the kind of thing I might do in a language I know better.

I'll look into this, it makes sense.


>> -		if (!arglen)
>> -			return 0;
>> -		strvec_pushf(args, "--%s=3D%.*s", matched, (int)arglen, argval);
>> +
>> +		if (argval) {
>> +			strvec_pushf(args, "--%s=3D%.*s", matched, (int)arglen, argval);
>> +		} else if (optval) {
>> +			strvec_pushf(args, "--%s", matched);
>> +		}
>>  	}
>>  	return arg - start;
>>  }
>> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-format=
s.sh
>> index 5865daa8f8..d4acf8882f 100755
>> --- a/t/t4205-log-pretty-formats.sh
>> +++ b/t/t4205-log-pretty-formats.sh
>> @@ -1002,4 +1002,12 @@ test_expect_success '%(describe:exclude=3D...) =
vs git describe --exclude ...' '
>>  	test_cmp expect actual
>>  '
>> =20
>> +test_expect_success '%(describe:tags) vs git describe --tags' '
>> +	test_when_finished "git tag -d tagname" &&
>> +	git tag tagname &&
>> +	git describe --tags >expect &&
>> +	git log -1 --format=3D"%(describe:tags)" >actual &&
>> +	test_cmp expect actual
>> +'
>=20
> Nice.
>=20
> I like how the end-user visible part of this addition is designed to
> look very much.  With a cleaned up implementation it would be great.
>=20
> Thanks.
>=20


--=20
Eli Schwartz
Arch Linux Bug Wrangler and Trusted User

--------------SZqyZJuAm9Kgmbs3Gccgbe9J--

--------------kt340f0tkraN1rrJSlOfi0tR
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEYEETBMCdNmKDQO7/zrFn77VyK9YFAmF1fe0ACgkQzrFn77Vy
K9aXSBAAmQ43t1Mk333cMoaLJFzxcDT/WDnMnHVS75wmVUuNtX0g5wEh2AWzj21s
55qHXXHjjRMnXAuS7Ph1TNSsbVtFENohDubnS1VHpnp2lUDyJqhkc7nTqSekc9Lk
pttO9y2GXCeaMUZ9Z5K5jJiINBtpU94J/BcVD7/pcOGsho1Z9M9Rmqmoi6ew1XlN
jDjuMAqFOw/Q6ondB5WZBWt6HL8yrzeap78mNgobujUYOwyinOMFdLPKocI6WDQz
vbSSMnmX22kJRr1uxu0DCmJON+zYw5O50MdwfPwA+rC9HG0kubHvFx4xllvihoC1
hg9jKwt5i7Yt56iX2c8EDOtidXOX7kk7sz+Eiidzu51H/fHVEhjLaRIXXpU+HQmV
44UPEj5hUtanir8YxFlWZv4zIoZB8nE5ZLhNqivfIFDWtVM6G18gcCA8L1HqCitB
gP9djuNj7vwmRG2yMpDhWx708fAU4KLEebzwlqTKV1WOgg/rlhl+P3U0iudMdxsq
PTRo0K5TO6+gqq1BltBuQt2OdPlC+y+wHkTJrrri2fO4PC6lVSx6rnSHz6kI+aZt
Fp/4DeI3s68Bd026oV7wS95WWw/19/w6tgixeAw0+i/7dm5shk62wcQa5bpDk3dc
3EviO7+BqZtgVlvJsoskQ9xY6WIbJePnVZsduuqmVwLvsJORsL0=
=QLpW
-----END PGP SIGNATURE-----

--------------kt340f0tkraN1rrJSlOfi0tR--
