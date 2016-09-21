Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 347BC1F935
	for <e@80x24.org>; Wed, 21 Sep 2016 17:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757371AbcIURS2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 13:18:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64994 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755735AbcIURS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 13:18:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A7F5C3E97F;
        Wed, 21 Sep 2016 13:18:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PXo6dELObL4P
        Kbt6WhsuZWvu6Qw=; b=ff8BrNNLvD0q7FGR4wJmS/JANsPAhYxk0XUqikvdLp/i
        SX0XPnRuNrddl66eP4YdKvll3/vNG98x85zsBQBofK18/nEVxn+9xh2VFJlFm7Rk
        uix6cVepASI7dNhUAejTbNK+2jzkZP7kMohk1jz3uYfj52+mrMoswRKMwC7uuXc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=EL6hLH
        FPAdJzTWmbQIF2aoa277qUQWPmJMfXu4+3ix0TmaCjv8+UzGzxuDP73q51mKJJC/
        NcQ2tvH0Nmrke5RFI1iXg+smCDHYgX5Jw7s5H530YfHa2rzTDq/Te5LtI3GCDH3v
        gh3u0fJsDMefXr19wrfZBvyyToVJIVEKt/j7w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A08F13E97E;
        Wed, 21 Sep 2016 13:18:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 422093E97C;
        Wed, 21 Sep 2016 13:18:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>, git@vger.kernel.org,
        Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/6] i18n: commit: mark message for translation
References: <1474290501-2743-1-git-send-email-vascomalmeida@sapo.pt>
        <34292875.FKhN8jTqO5@cayenne>
        <xmqq4m5begxj.fsf@gitster.mtv.corp.google.com>
        <1579845.fzuqLqrEJ8@cayenne>
Date:   Wed, 21 Sep 2016 10:17:57 -0700
In-Reply-To: <1579845.fzuqLqrEJ8@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
        "Tue, 20 Sep 2016 21:04:27 +0200")
Message-ID: <xmqqintp9np6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 637CC730-801F-11E6-BF25-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-No=C3=ABl AVILA <jn.avila@free.fr> writes:

> Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
> Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
> ---
>
> Instead of distillating change requests, I'd better do it by
> myself. Here is the reworked version of the patch.
>

It would have helped if you had an in-body header to retitle this
patch for 3/6, instead of leaving it as 1/6 for "commit" X-<.

Will tweak and fit it in.  Thanks.

>  diff.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index c6da383..494f723 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -55,6 +55,11 @@ static char diff_colors[][COLOR_MAXLEN] =3D {
>  	GIT_COLOR_NORMAL,	/* FUNCINFO */
>  };
> =20
> +static NORETURN void die_want_option(const char *option_name)
> +{
> +	die(_("option '%s' requires a value"), option_name);
> +}
> +
>  static int parse_diff_color_slot(const char *var)
>  {
>  	if (!strcasecmp(var, "context") || !strcasecmp(var, "plain"))
> @@ -3325,7 +3330,7 @@ void diff_setup_done(struct diff_options *options=
)
>  	if (options->output_format & DIFF_FORMAT_NO_OUTPUT)
>  		count++;
>  	if (count > 1)
> -		die("--name-only, --name-status, --check and -s are mutually exclusi=
ve");
> +		die(_("--name-only, --name-status, --check and -s are mutually exclu=
sive"));
> =20
>  	/*
>  	 * Most of the time we can say "there are changes"
> @@ -3521,7 +3526,7 @@ static int stat_opt(struct diff_options *options,=
 const char **av)
>  			if (*arg =3D=3D '=3D')
>  				width =3D strtoul(arg + 1, &end, 10);
>  			else if (!*arg && !av[1])
> -				die("Option '--stat-width' requires a value");
> +				die_want_option("--stat-width");
>  			else if (!*arg) {
>  				width =3D strtoul(av[1], &end, 10);
>  				argcount =3D 2;
> @@ -3530,7 +3535,7 @@ static int stat_opt(struct diff_options *options,=
 const char **av)
>  			if (*arg =3D=3D '=3D')
>  				name_width =3D strtoul(arg + 1, &end, 10);
>  			else if (!*arg && !av[1])
> -				die("Option '--stat-name-width' requires a value");
> +				die_want_option("--stat-name-width");
>  			else if (!*arg) {
>  				name_width =3D strtoul(av[1], &end, 10);
>  				argcount =3D 2;
> @@ -3539,7 +3544,7 @@ static int stat_opt(struct diff_options *options,=
 const char **av)
>  			if (*arg =3D=3D '=3D')
>  				graph_width =3D strtoul(arg + 1, &end, 10);
>  			else if (!*arg && !av[1])
> -				die("Option '--stat-graph-width' requires a value");
> +				die_want_option("--stat-graph-width");
>  			else if (!*arg) {
>  				graph_width =3D strtoul(av[1], &end, 10);
>  				argcount =3D 2;
> @@ -3548,7 +3553,7 @@ static int stat_opt(struct diff_options *options,=
 const char **av)
>  			if (*arg =3D=3D '=3D')
>  				count =3D strtoul(arg + 1, &end, 10);
>  			else if (!*arg && !av[1])
> -				die("Option '--stat-count' requires a value");
> +				die_want_option("--stat-count");
>  			else if (!*arg) {
>  				count =3D strtoul(av[1], &end, 10);
>  				argcount =3D 2;
