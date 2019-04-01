Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 342B920248
	for <e@80x24.org>; Mon,  1 Apr 2019 15:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfDAPiC (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 11:38:02 -0400
Received: from mout.gmx.net ([212.227.15.19]:35275 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbfDAPiC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 11:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554133061;
        bh=XEL7dN276RhwzGNdsqve8seIwL7QHLhcRqsFuAqCXiU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NdRQ8E6UEejMTe8iosVlIAMguYA9dcJnSdiU8QBRYpNgxbsB5myqN7/0W1jYmwxWB
         pTov8+WLCGZlvqa4jC4T50Le0kC9jh2ne2VtYyvrqhlW3ZXfJJlwFaRJ8TA/tgLTmO
         uXGqkmevpli3QB0i+5I3dtSM+aCps0Y8sE0KnQCY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MDhGw-1h9ISZ2PGA-00HBF1; Mon, 01
 Apr 2019 17:37:41 +0200
Date:   Mon, 1 Apr 2019 17:37:46 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] praise: make 'blameless' cultural enforcement
 configurable
In-Reply-To: <20190401101246.21418-2-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1904011737050.41@tvgsbejvaqbjf.bet>
References: <20190401101246.21418-1-avarab@gmail.com> <20190401101246.21418-2-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1307536628-1554133067=:41"
X-Provags-ID: V03:K1:WUPFYi84/TfAXOJOWmxI6b8lBJZAc+Q+jr01nP3HdEmJoSSH+/D
 8NCR0J4gXMQCG22zZL+t9bb1pvtDtNf2SzVTZdcNoxp6XffIJzR03QWtZKVD0GmtaGeviHc
 4FCnqZbBCJ6JuDYHh5KubuZ7+k+As907xr9WvIk1yvoe4WXdU1/ju3L++dJxIQtbTl2VC5M
 M87iyxey1QKkOPE7QY1Eg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SyoDth8PGdA=:SgOyhyntCqbD4S41s9h+yM
 x4OODye+l9/r5cfGXUFkeI+DtJHfAphQ7NRU4peYWW7LrlInoRnLiUk38GlP0iyE0BEtJsyYi
 6kmn2UKaEhnFhaoMi5HWxJHm0jy0adosWHB+tmzmZs7/bF6KhYXMb18I3YMtNQognITvDlB87
 AeMg4bZ8p0HVoFHCx7clanzEQk202UINVU1GopdVnJk+hV1vSDKDpu0eYRRCPLhAuWG2L9/pP
 f24XSVyfIfYQ0rCkpCG62Ytgu3ZMD0b5CaYwYVajl3kfxFzjrc8lai0Y1VXmeM9H/7cnSD8JI
 NWP23kgH0D8kF6PP5mp6qOJQRQRPULlG9ERGIJu9NfuiaKcSfGTcx7bQt0V47H4AdOVKd4JQM
 JMNyeSSsbkXkPgRdZbshIQo0/bAcipQmsvBZuTw+cddI3kNpAuzet6u/ftFjfgzQZoUsr/Kmh
 pRuF6UcXc/kQ1Rpsdh6cojlaaLu/TuIzzBg3BlC8AZA0sYd0mfXqT18fdIje54ioWiPNfje8b
 RMBgLWkI/09iX+CyYOcBus2kv8tAK+VsPJwm6fSz9zqv76RZXl6xLBwfYk4tQKbve8dr1EeO4
 1pK2lJ/3cnAJ48CWmucHO02zRmTOEPtNm+iG9oYA3dIsrtuHjPfzgVLuKsb7SsaCIUHAzyET9
 2Um4ibyrY7lLML6Qtvv1QfhZu7p+dmLX009Omgh9cGnaH+PxWxaJI6Z49T3YRnJbIfh9NfpJP
 HGQQQ6/CXq9T8ICU4sXsBOPHA2uUQgh61myLKzzrUM9euorIvwx0XeZv7LpNWv4bfJxQwW368
 s3x/yf3JNpnkN2mp2O5BEarCH9VhanxYOg3LnK5oK3Ql9QHZS9Gpgt05qxEmzZB91wqIJIKcl
 bljgtJKf+b96ScKrl8k6rpAxwIQvfhXH2C1I6RVY7fHWvJgZqwmJVX//E4qHcxOcnyCkW2Aaf
 oX+IpBNlXJw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1307536628-1554133067=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 1 Apr 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> The culture shock of having a 'blameless' culture from day one might
> be too much for some, so let's allow for setting
> "blame.culture.enforcement=3Dwarning" to allow for easing into the
> default of "error".
>
> Also allow for excluding non-interactive users of "blame". There are
> some automated users who use "blame" but don't use the "--porcelain"
> format (which was already excluded). Those can set
> e.g. "error:interactive" to only emit errors when "blame" is
> interacting with a TTY.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

I reviewed both patches, and they look fine to me. So they are

Blessed-by: Johannes Schindelin <johannes.schindelin@gmx.de>

:-D

> ---
>  Documentation/config/blame.txt | 12 ++++++++++++
>  builtin/blame.c                | 27 ++++++++++++++++++++++++++-
>  t/t8002-blame.sh               | 28 ++++++++++++++++++++++++++++
>  3 files changed, 66 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config/blame.txt b/Documentation/config/blame=
.txt
> index c85b35de17..13570192cf 100644
> --- a/Documentation/config/blame.txt
> +++ b/Documentation/config/blame.txt
> @@ -7,6 +7,18 @@ blame.culture::
>  +
>  Note that the `--porcelain` format for machine consumption is exempt
>  from this enforcement to avoid breaking existing scripts.
> ++
> +See `blame.culture.enforcement` below for tweaking the error behavior.
> +
> +blame.culture.enforcement::
> +	When `blame.culture=3Dblameless` is set invoking
> +	linkgit:git-blame[1] becomes an `error` This variable can also
> +	be set to `warning` to only warn, and to either
> +	`error:interactive` or `warning:interactive` to only error out
> +	or warn if stderr is connected to a TTY.
> ++
> +This allows for enforcing a blameless culture on interactive users,
> +while leaving any automated use alone.
>
>  blame.blankBoundary::
>  	Show blank commit object name for boundary commits in
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 238b19db48..9f62950559 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -59,6 +59,12 @@ static size_t blame_date_width;
>
>  static struct string_list mailmap =3D STRING_LIST_INIT_NODUP;
>
> +static enum {
> +	BLAME_ENFORCE_ERROR		=3D 1<<0,
> +	BLAME_ENFORCE_WARNING		=3D 1<<1,
> +	BLAME_ENFORCE_INTERACTIVE	=3D 1<<2
> +} blame_culture_enforcement =3D BLAME_ENFORCE_ERROR;
> +
>  #ifndef DEBUG
>  #define DEBUG 0
>  #endif
> @@ -686,6 +692,19 @@ static int git_blame_config(const char *var, const =
char *value, void *cb)
>  		blameless_culture =3D !strcmp(value, "blameless");
>  		return 0;
>  	}
> +	if (!strcmp(var, "blame.culture.enforcement")) {
> +		if (!strcmp(value, "error"))
> +			blame_culture_enforcement =3D BLAME_ENFORCE_ERROR;
> +		else if (!strcmp(value, "error:interactive"))
> +			blame_culture_enforcement =3D (BLAME_ENFORCE_ERROR |
> +						     BLAME_ENFORCE_INTERACTIVE);
> +		else if (!strcmp(value, "warning"))
> +			blame_culture_enforcement =3D BLAME_ENFORCE_WARNING;
> +		else if (!strcmp(value, "warning:interactive"))
> +			blame_culture_enforcement =3D (BLAME_ENFORCE_WARNING |
> +						     BLAME_ENFORCE_INTERACTIVE);
> +		return 0;
> +	}
>  	if (!strcmp(var, "blame.showemail")) {
>  		int *output_option =3D cb;
>  		if (git_config_bool(var, value))
> @@ -897,7 +916,13 @@ int cmd_blame(int argc, const char **argv, const ch=
ar *prefix)
>  		blame_date_mode.type =3D DATE_ISO8601;
>  	} else if (!cmd_is_praise && blameless_culture &&
>  		   !(output_option & OUTPUT_PORCELAIN)) {
> -		die(_("must be invoked as 'git praise' with 'blame.culture=3Dblameles=
s' set!"));
> +		if (!(blame_culture_enforcement & BLAME_ENFORCE_INTERACTIVE) ||
> +		    isatty(2)) {
> +			if (blame_culture_enforcement & BLAME_ENFORCE_ERROR)
> +				die(_("must be invoked as 'git praise' with 'blame.culture=3Dblamel=
ess' set!"));
> +			else if (blame_culture_enforcement & BLAME_ENFORCE_WARNING)
> +				warning(_("should be invoked as 'git praise' with 'blame.culture=3D=
blameless' set!"));
> +		}
>  	} else {
>  		blame_date_mode =3D revs.date_mode;
>  	}
> diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
> index 2d59b856d1..09ef0bc440 100755
> --- a/t/t8002-blame.sh
> +++ b/t/t8002-blame.sh
> @@ -2,6 +2,7 @@
>
>  test_description=3D'git blame'
>  . ./test-lib.sh
> +. "$TEST_DIRECTORY/lib-terminal.sh"
>
>  PROG=3D'git blame -c'
>  . "$TEST_DIRECTORY"/annotate-tests.sh
> @@ -60,9 +61,36 @@ test_expect_success 'praise' '
>
>  test_expect_success 'enforced praise' '
>  	test_must_fail git -c blame.culture=3Dblameless blame one 2>err &&
> +	test_i18ngrep "must be.*git praise" err &&
> +	test_must_fail git -c blame.culture=3Dblameless \
> +		-c blame.culture.enforcement=3Derror blame one 2>err &&
>  	test_i18ngrep "must be.*git praise" err
>  '
>
> +test_expect_success 'recommended praise' '
> +	git -c blame.culture=3Dblameless \
> +		-c blame.culture.enforcement=3Dwarning blame one 2>err &&
> +	test_i18ngrep "should be.*git praise" err
> +'
> +
> +test_expect_success TTY 'interactive: praise blame.culture.enforcement=
=3D*:interactive' '
> +	test_must_fail test_terminal git -c blame.culture=3Dblameless \
> +		-c blame.culture.enforcement=3Derror:interactive blame one 2>err &&
> +	test_i18ngrep "must be.*git praise" err &&
> +	test_terminal git -c blame.culture=3Dblameless \
> +		-c blame.culture.enforcement=3Dwarning:interactive blame one 2>err &&
> +	test_i18ngrep "should be.*git praise" err
> +'
> +
> +test_expect_success TTY 'non-interactive: praise blame.culture.enforcem=
ent=3D*:interactive' '
> +	git -c blame.culture=3Dblameless \
> +		-c blame.culture.enforcement=3Derror:interactive blame one 2>err &&
> +	test_i18ngrep ! "must be.*git praise" err &&
> +	git -c blame.culture=3Dblameless \
> +		-c blame.culture.enforcement=3Dwarning:interactive blame one 2>err &&
> +	test_i18ngrep ! "should be.*git praise" err
> +'
> +
>  test_expect_success 'blame with showemail options' '
>  	git blame --show-email one >blame1 &&
>  	find_blame <blame1 >result &&
> --
> 2.21.0.392.gf8f6787159e
>
>

--8323328-1307536628-1554133067=:41--
