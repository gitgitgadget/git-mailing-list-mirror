Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 308371F404
	for <e@80x24.org>; Mon, 26 Feb 2018 17:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751472AbeBZRft (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 12:35:49 -0500
Received: from mout.web.de ([212.227.17.12]:44815 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751269AbeBZRfs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 12:35:48 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MGzba-1evMtJ0iQs-00DsQd; Mon, 26
 Feb 2018 18:35:35 +0100
Date:   Mon, 26 Feb 2018 18:35:33 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Jeff King <peff@peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <lars.schneider@autodesk.com>,
        git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v7 0/7] convert: add support for different encodings
Message-ID: <20180226173533.GA7877@tor.lan>
References: <20180215152711.158-1-lars.schneider@autodesk.com>
 <xmqqr2pm81hh.fsf@gitster-ct.c.googlers.com>
 <DC552BF4-3E87-41E0-BF92-4BA9633D374E@gmail.com>
 <20180216165815.GA4681@tor.lan>
 <19EDC192-0D83-4762-AC6A-81F7D693475A@gmail.com>
 <xmqqbmgfvf2y.fsf@gitster-ct.c.googlers.com>
 <xmqq7er3tqjq.fsf@gitster-ct.c.googlers.com>
 <FDF4DEB8-E71A-4BFC-9437-678C8F65BBDC@gmail.com>
 <20180226014445.GB8677@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226014445.GB8677@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:gWxDVRt+D29eJ1cjmNVJPRJX8X0czytSMAaqSWM3qWT3QNO2BuG
 LUozipO/P0G25s+H07t5ZKU79LduXY3bC3HBhkMB3V+XOOI09ftK6S0ouC5sQHSRQ4UEbiV
 M40gOY5YxfiAtNp+GKQoKWLY0xKj93gstneGv7mZu3s/Y1zF9P3gk98/ljoAICnS5d38dy8
 GI6z+VjtWGduUPrvoSoUA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BQA6sgCQe4I=:4g1POAAvPmiTau1k0oZiO1
 sSM7dgDjjMNMcXwUUOUlLgDOjOXHByLv0wu8Z/DkZkVRYqivGswy8rFV8zRd2gyAjXX1XUn0J
 hgtUB8xIpDh6X7DyW/xaRSh9HovXTLGx6XqI9OEfQpSMKpcIQrVqBZsu+B0eZmao6MaVX+9v7
 18O2gzYDnunhpQlnamc34xpJnJNtLpJ5EtuBKvsJZF1tPnomQwtJ0lZ8ejAmV1CQo8HDLkTC3
 AwgnMR7kRBft1aHfLnajFzIc2dsbmfpAmYEnd8z8T74R7OI/IKkHdwJNXN1yqV7ngKGeMDrq4
 rf231rln2eMAJoXXj4mPYYeA3rL2S72xnCbGsmE6sG63ldJp7/I52Z0XnBl8l5yL90VKo9FxJ
 zUnh1V4VX1IyqHtOkY3uvbvpbsu6mCYtrsauAAb7oUCGPBsk9VHhuXXGXdajqbhMlv41ObaSb
 WoaaLoHONrutJxESoJNgMeF0BkzEPWoTBwwXwQgWMPnMwvMrfaeA2555KENLxBJ9SWVjZ0Svk
 xE3GaKNl5ay+utqTBPV+lDWE0x3/yu3yALvRadrimITIKqzih6Ftq0S7f+dR3q5jOUCT47oBi
 fBsaYKdgXU5QQi3a9NWZmgufEDo5cCQ0dJoP5DNgswI99KBIcTAfxJ9qjsSP9ajE2tBOnu9Mp
 JrUbWqNGC2FbOlAGEYkVxo81czKmxm71aoJspaS6lhht7lsUWdtq7aNl8SAIVVwFp3t8cQa/M
 oHbZTzKUuGJgDrP1W85tPp2EStGN7UUaYZ4UnSlHXsHECNdDy0iVvpx6h/RzADUKCN/gLaVVc
 prhMwbM4PpzIjEvrpIaXCiuWwt+Mw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 25, 2018 at 08:44:46PM -0500, Jeff King wrote:
> On Sat, Feb 24, 2018 at 04:18:36PM +0100, Lars Schneider wrote:
> 
> > > We always use the in-repo contents when generating 'diff'.  I think
> > > by "attribute to be used in diff", what you are reallying after is
> > > to convert the in-repo contents to that encoding _BEFORE_ running
> > > 'diff' on it.  E.g. in-repo UTF-16 that can have NUL bytes all over
> > > the place will not diff well with the xdiff machinery, but if you
> > > first convert it to UTF-8 and have xdiff work on it, you can get
> > > reasonable result out of it.  It is unclear what encoding you want
> > > your final diff output in (it is equally valid in such a set-up to
> > > desire your patch output in UTF-16 or UTF-8), but assuming that you
> > > want UTF-8 in your patch output, perhaps we do not have to break
> > > gitk users by hijacking the 'encoding' attribute.  Instead what you
> > > want is a single bit that says between in-repo or working tree which
> > > representation should be given to the xdiff machinery.
> > 
> > I fear that we could confuse users with an additional knob/bit that
> > defines what we diff against. Git always diff'ed against in-repo 
> > content and I feel it should stay that way.
> 
> Well, except for textconv. You can already do this:
> 
>   echo "foo diff=utf16" >.gitattributes
>   git config diff.utf16.textconv 'iconv -f utf16 -t utf8'
> 
> We could make that easier to use and much more efficient by:
> 
>   1. Allowing a special syntax for textconv filters that kicks off an
>      internal iconv.
> 
>   2. Providing baked-in config for utf16.
> 
> The patch below provides a sketch. But I think Torsten raised a good
> point that you might want the encoding conversion to be independent of
> other diff characteristics (so, e.g., you might say "this is utf16 but
> once converted treat it like C code for finding funcnames, etc").
> 
> ---
> diff --git a/diff.c b/diff.c
> index 21c3838b25..04032e059c 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -5968,6 +5968,21 @@ struct diff_filepair *diff_unmerge(struct diff_options *options, const char *pat
>  	return pair;
>  }
>  
> +static char *iconv_textconv(const char *encoding, struct diff_filespec *spec,
> +			    size_t *outsize)
> +{
> +	char *ret;
> +	int outsize_int; /* this really should be a size_t */
> +
> +	if (diff_populate_filespec(spec, 0))
> +		die("unable to load content for %s", spec->path);
> +	ret = reencode_string_len(spec->data, spec->size,
> +				  "utf-8", /* should be log_output_encoding? */
> +				  encoding, &outsize_int);
> +	*outsize = outsize_int;
> +	return ret;
> +}
> +
>  static char *run_textconv(const char *pgm, struct diff_filespec *spec,
>  		size_t *outsize)
>  {
> @@ -5978,6 +5993,9 @@ static char *run_textconv(const char *pgm, struct diff_filespec *spec,
>  	struct strbuf buf = STRBUF_INIT;
>  	int err = 0;
>  
> +	if (skip_prefix(pgm, "iconv:", &pgm))
> +		return iconv_textconv(pgm, spec, outsize);
> +
>  	temp = prepare_temp_file(spec->path, spec);
>  	*arg++ = pgm;
>  	*arg++ = temp->name;
> diff --git a/userdiff.c b/userdiff.c
> index dbfb4e13cd..48fa7e8bdd 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -161,6 +161,7 @@ IPATTERN("css",
>  	 "-?[_a-zA-Z][-_a-zA-Z0-9]*" /* identifiers */
>  	 "|-?[0-9]+|\\#[0-9a-fA-F]+" /* numbers */
>  ),
> +{ "utf16", NULL, -1, { NULL, 0 }, NULL, "iconv:utf16" },
>  { "default", NULL, -1, { NULL, 0 } },
>  };
>  #undef PATTERNS

The patch looks like a possible step into the right direction -
some minor notes: "utf8" is better written as "UTF-8", when talking
to iconv.h, same for utf16.

But, how do I activate the diff ?
I have in .gitattributes
XXXenglish.txt diff=UTF-16

and in .git/config
[diff "UTF-16"]
      command = iconv:UTF-16


What am I doing wrong ?
