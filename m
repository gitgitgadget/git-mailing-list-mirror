Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56CA420282
	for <e@80x24.org>; Tue, 13 Jun 2017 11:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbdFMLDJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 07:03:09 -0400
Received: from mout.gmx.net ([212.227.15.18]:63143 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752033AbdFMLDI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 07:03:08 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MQ2zr-1dFWf322nz-005FwD; Tue, 13
 Jun 2017 13:02:50 +0200
Date:   Tue, 13 Jun 2017 13:02:49 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/8] config: report correct line number upon error
In-Reply-To: <20170610090424.zibu4sgd2lr7ghfk@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.21.1.1706131256400.171564@virtualbox>
References: <cover.1496951503.git.johannes.schindelin@gmx.de> <291e8b643990aee04654b34c6f953387c3c030d4.1496951503.git.johannes.schindelin@gmx.de> <20170610090424.zibu4sgd2lr7ghfk@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:SmGLfiuFAfY37+G3NKkgot+FmYNcMeWR7/5OEaN5sPUsKZpl3tK
 zYofNzEacrPfV3iCH+ADKGJYCdoNjF8W0MwV9qV9jQVF464F0lsl6yp/ZdJAvTg94gUTTG0
 2hOzRSCJyeYsYVRGuNf21aq900u/x5B0xQHKXQZPijVhJQjOP/tmgdCzFPxw3qZTFnAGei4
 SjGuQNyFxReNRrhe+fQ5g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:s1/9rQd6UKA=:udU9rkglgXXXSU6K1FBkd9
 PpL+wc5s3ly+1sTmDo2RwjkRIOBqEkGrIZb8trTjh70V0FlepNY75HfIYfq5Fa78xcIX+JAPf
 XR4XMc3t4eDL3P5yX0UMBHdARJJQIZSL4pYtoT75SY1dZlK9b2/r0AAfK+gEF4BpQdC+66p74
 4/R/cH1qY1Ss8CVj/yxRn+jihwqCYbD1O6Er52If2i9JWU+hBXqS3r2MjalANxGtoEz+alPRZ
 gTowIUxHGKp+DbCEjeoLaeFSI7OA6BCqbNISmijQW5VEIYMh5H8X29DgBo8di8yoA5TI4IZAQ
 l2XRSBaOhM7/o0MGwSB1NUHLeObgoCi427/GNeYkvNWcj4thxQzHAMvooj2UoPwuXqZwpZsID
 6k4QGlB50+xRz0VMMXI4doUne+BvGq9GuSkmthA5hh4XhsjHO5uSkdkRXKAGS40AlqSP/Zgwg
 av13fZJGrCBGJGGyij/tyi5Ew2DOoABGQcZegDS4Q3Nw4DNAJBeKq70LOm3K2uuE+BELNYnaG
 SVpQYgXuy41S8E0weDuYDySOp7FHzi9QivAvhLGbgid2yr7CLr2uVuTxEwUxG2HnsOZqaOrsV
 LhDGVHNO57TzLW9ssBZFQOx521YO6glTMaTwhHQPyER+V7NrvZWOVrqNN94vdABguXeibun/8
 bXHK8vU2PZDGDkSkHzmRhHWZULhvu23+F4QxTMI9CZ0kiSQSleP5TOTJfxpy+OkQDd51poCwJ
 Iw+WKOX4IzvmL0P9T2Xe93bo3FHLKGXocXX9CnexHb2qwCPZ9nyDV3oZ8ua7tOhMxV4X3E++U
 InLoGGF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Sat, 10 Jun 2017, Jeff King wrote:

> On Thu, Jun 08, 2017 at 09:53:35PM +0200, Johannes Schindelin wrote:
> 
> > When get_value() parses a key/value pair, it is possible that the line
> > number is decreased (because the \n has been consumed already) before the
> > key/value pair is passed to the callback function, to allow for the
> > correct line to be attributed in case of an error.
> > 
> > However, when git_parse_source() asks get_value() to parse the key/value
> > pair, the error reporting is performed *after* get_value() returns.
> > 
> > Which means that we have to be careful not to increase the line number
> > in get_value() after the callback function returned an error.
> 
> Good catch. Would we want a test here, like:
> 
> diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
> index 13b7851f7..4cad8366a 100755
> --- a/t/t1300-repo-config.sh
> +++ b/t/t1300-repo-config.sh
> @@ -703,6 +703,12 @@ test_expect_success 'invalid unit' '
>  	test_i18ngrep "bad numeric config value .1auto. for .aninvalid.unit. in file .git/config: invalid unit" actual
>  '
>  
> +test_expect_success 'invalid path' '
> +	echo "[bool]var" >invalid &&
> +	test_must_fail git config -f invalid --path bool.var 2>actual &&
> +	test_i18ngrep "line 1" actual
> +'
> +
>  test_expect_success 'invalid stdin config' '
>  	echo "[broken" | test_must_fail git config --list --file - >output 2>&1 &&
>  	test_i18ngrep "bad config line 1 in standard input" output
> 
> which currently reports "line 2" instead of line 1.

Mmmmkay.

I am always reluctant to add *even more* stuff to the test suite, in
particular since my patch series implicitly changes t1308 to test for this
very thing.

But I guess my fight against the test suite taking longer and longer and
longer is a fight I must lose, as I am pretty alone in that endeavor, and
would have have to fight fellow developers. So I guess it is time to give
up.

I added the test case you suggested, with a title that I find a bit more
descriptive.

> I wondered if the same bug could be found earlier (e.g,. from
> parse_value() when it sees an unpaired quote), but it looks like we do a
> cf->linenr-- rollback there already.

Right.

The underlying bug, of course, is that we use a different machinery to
handle cached vs non-cached config, but that is a different story.

> > diff --git a/config.c b/config.c
> > index 146cb3452ad..9b88531a70d 100644
> > --- a/config.c
> > +++ b/config.c
> > @@ -604,7 +604,8 @@ static int get_value(config_fn_t fn, void *data, struct strbuf *name)
> >  	 */
> >  	cf->linenr--;
> >  	ret = fn(name->buf, value, data);
> > -	cf->linenr++;
> > +	if (!ret)
> > +		cf->linenr++;
> >  	return ret;
> >  }
> 
> I think this should be "if (ret < 0)". The caller only considers it an
> error if get_value() returns a negative number. As you have it here, I
> think a config callback which returned a positive number would end up
> with nonsense line numbers.

I think you are half-correct: it should be `if (ret >= 0)` (the linenr
needs to be modified back in case of success, not in case of failure, in
case of failure there will be some reporting going on that needs the same
line number as `fn()` had seen).

Ciao,
Dscho
