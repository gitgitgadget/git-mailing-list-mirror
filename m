Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B646202A0
	for <e@80x24.org>; Tue,  7 Nov 2017 13:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934126AbdKGNXR (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 08:23:17 -0500
Received: from mout.gmx.net ([212.227.17.21]:52927 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933608AbdKGNXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 08:23:16 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MCL6r-1eKY9f3kZ7-009BDe; Tue, 07
 Nov 2017 14:23:11 +0100
Date:   Tue, 7 Nov 2017 14:23:00 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] diff: --ignore-cr-at-eol
In-Reply-To: <20171107064011.18399-3-gitster@pobox.com>
Message-ID: <alpine.DEB.2.21.1.1711071345430.6482@virtualbox>
References: <xmqqshe7j0af.fsf@gitster.mtv.corp.google.com> <20171107064011.18399-1-gitster@pobox.com> <20171107064011.18399-3-gitster@pobox.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:A1Z80ifJzYDcq9zkY0BfqyjfW39xIfi1cTYyYa2FGK2ZIk9A4Qo
 Bs51z6OGqvqVhiNPVHpsR6bi0mhfjIFxlYCmNo0VxXPvTUzOPzaFR4WeDEGDR7rv2Y4V11/
 4xAcWwjJCcXdswhdc7B+AZe7wF16JMf89qYv09hfi7hBAbeGkjjWwN+p13plxVfDpz5gmG4
 I/TWKaKL0Jb6z0sLzo+gA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wrhjzQep/co=:XAZQfiPeCOkPucLZYKO2bs
 /vhAKtrBa1MefimAvWCMECy7jfWkQzwT1xgSfV03Pri4uidr/TbhUILFSTE+WoBp3dJ6V1tgq
 dZDu5DohLnLzjPz4l/CFq3Nb8ZG2FND68Ejuv8hmbs/wtD81f9iXO2DQP9tqnlsbg3V4VeyfJ
 RLWSu0uHAXhyySPzbmMnGghGUtODF0LPKF2RkhLlQ580eXw9gSAXFxKMNec+VndRFIxwRXxMU
 GMxUNf/Uvnix4P5G5KjstkbZPNrs0njG0NpqNl1SQIrM2gX7jmtTs/OmJq6KZ7U9khtPE9zJZ
 AbHWnrXMqU67JkScF26i7YRrmT4nZOldmYYfSncrlAxS1UNGB/HahCpk7hqrMvyjWn4Ix5Ns2
 BZbqqo0jS1fkixGf0d6rJ/gK/shPfdcDqCvh/zeywxDaxvm1OZjnr8PrnjG/OTuv59W0PTx+W
 fh3GYByWobYRcd820/ceO93s5mbqGUl+2wnOfHMEUgJ+Ke7GOvezaC3vOko5WInzeALNIsieh
 gOeRDjigam7+DfcvLPlhnj4cyBXgj8zoGamb2sQaa+B7jLw5dAKtEH7nMUCarot2OU7O31g6O
 Xh9+nwglDnChnNF9KjEjpGZ/vtiA6UsXPOWSmVfj2MGh2vMoG3Svy5anja508r+hrakIOSHRM
 vVq6N7hmtVCQ4KH1rKgEPjbk+jlnqTdIXxEFkUoAgP33yiCzaPEaFkak8Rc6ilaerN0RdZUs6
 MtoIN48WDoSvi/wdvnyv7XXy9rU3uBKxzFjEG/bD3HXlIGwdqdaewJFTaLwKDMC2bzCxJOQOg
 SdYDgSPRUGXjDeY7wzFxadKMYur9oXyZlUp5YDuT3BwTcxd1u0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 7 Nov 2017, Junio C Hamano wrote:

> A new option --ignore-cr-at-eol tells the diff machinery to treat a
> carriage-return at the end of a (complete) line as if it does not
> exist.
> 
> This would make it easier to review a change whose only effect is to
> turn line endings from CRLF to LF or the other way around.

If the goal is to make CR/LF -> LF conversions easier to review (or for
that matter, LF -> CR/LF), then this option may not be *completely*
satisfactory, as it would hide mixed changes (i.e. where some lines are
converted from CR/LF to LF and others are converted in the other direction
*in the same patch*).

I wonder whether it would make this patch series even more useful if you
would instead introduce --hide-crlf-to-lf and --hide-lf-to-crlf options
(not even necessarily mutually exclusive, in case the reviewer really
wants to ignore all line ending conversions).

> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 89cc0f48de..aa2c0ff74d 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -519,6 +519,9 @@ endif::git-format-patch[]
>  --text::
>  	Treat all files as text.
>  
> +--ignore-cr-at-eol::
> +	Ignore carrige-return at the end of line when doing a comparison.

I am not a native speaker, either, yet I have the impression that "do a
comparison" may be more colloquial than not. Also, it is a carriage-return
(as in Sinatra's famous song about Love and Marriage) not a carrige-return.

How about "Hide changed line endings"?

> diff --git a/xdiff/xutils.c b/xdiff/xutils.c
> index 04d7b32e4e..b2cbcc818f 100644
> --- a/xdiff/xutils.c
> +++ b/xdiff/xutils.c
> @@ -156,6 +156,24 @@ int xdl_blankline(const char *line, long size, long flags)
>  	return (i == size);
>  }
>  
> +/*
> + * Have we eaten everything on the line, except for an optional
> + * CR at the very end?
> + */
> +static int ends_with_optional_cr(const char *l, long s, long i)
> +{
> +	int complete = s && l[s-1] == '\n';
> +
> +	if (complete)
> +		s--;
> +	if (s == i)
> +		return 1;

What is the role of `s`, what of `i`? Maybe `length` and `current_offset`?

> +	/* do not ignore CR at the end of an incomplete line */
> +	if (complete && s == i + 1 && l[i] == '\r')
> +		return 1;

This made me scratch my head: too many negations. The comment may better
read "ignore CR only at the end of a complete line".

And now I understand even less why `1` is returned if `s == i`? Is this
not an empty line (complete or incomplete) *without* a CR?

> @@ -204,6 +223,14 @@ int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
>  			i1++;
>  			i2++;
>  		}
> +	} else if (flags & XDF_IGNORE_CR_AT_EOL) {
> +		/* Find the first difference and see how the line ends */
> +		while (i1 < s1 && i2 < s2 && l1[i1] == l2[i2]) {
> +			i1++;
> +			i2++;
> +		}
> +		return (ends_with_optional_cr(l1, s1, i1) &&
> +			ends_with_optional_cr(l2, s2, i2));

There are extra parentheses around the `return` expression.

To accommodate the tentative --hide-crlf-to-lf and --hide-lf-to-crlf
options that I suggested earlier, this would simply become something like
this:

	} else if (flags & (XDF_IGNORE_CRLF_TO_LF | XDF_IGNORE_LF_TO_CRLF)) {
		/* Early exit: length must be equal or differ by 1 */
		if (s1 - i1 != s2 - i2 &&
		    s1 - i1 != s2 + 1 - i2 && s1 + 1 - i1 != s2 - i2)
			return 0;

		/* Early exit: skip incomplete lines */
		if (!s1 || !s2 || l1[s1-1] != '\n' || l2[s2-1] != '\n')
			return 0;

		/* Find the first difference and see how the line ends */
		while (i1 < s1 && i2 < s2 && l1[i1] == l2[i2]) {
			i1++;
			i2++;
		}

		/* Lines must be identical or have the indicated EOL change */
		return ((i1 == s1 && i2 == s2) ||
			((flags & XDF_IGNORE_CRLF_TO_LF) &&
			 i1 + 2 == s1 && l1[i1] == '\r' && i2 + 1 == s2) ||
			((flags & XDF_IGNORE_LF_TO_CRLF) &&
			 i1 + 1 == s1 && i2 + 2 == s2 && l2[i2] == '\r');

Note: I do not even know whether the code in this function has to assume
that the lines can be byte-wise identical or not, I just erred on the side
of caution. I also do not know whether the return value 0 indicates a
mistmatch, I just assumed it did. I really wish that I could have reviewed
the real code, not a patch in a mail program that lacks the context.

Caveat emptor: my proposed code change has been written in the mail
program (if we had a more code-centric review process, you would have a PR
with a suggested alternative already, I am really sorry for the
inconvenience).

Ciao,
Dscho
