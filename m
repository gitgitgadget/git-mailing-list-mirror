Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03FB01F437
	for <e@80x24.org>; Thu, 26 Jan 2017 11:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752158AbdAZLQe (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 06:16:34 -0500
Received: from mout.gmx.net ([212.227.17.21]:61872 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752099AbdAZLQd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 06:16:33 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MZ7bs-1cn8QC2ea4-00KvcL; Thu, 26
 Jan 2017 12:16:12 +0100
Date:   Thu, 26 Jan 2017 12:16:10 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: Fixing the warning about warning(""); was: Re: [PATCH] difftool.c:
 mark a file-local symbol with static
In-Reply-To: <20170125183542.pe5qolexqqx6jhsi@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1701261213060.3469@virtualbox>
References: <xmqqinr4bkf4.fsf@gitster.mtv.corp.google.com> <59da5383-16a0-b327-75a8-b4c4ad7bd479@ramsayjones.plus.com> <20161201040234.3rnuttitneweedn5@sigill.intra.peff.net> <xmqq60n3bjel.fsf@gitster.mtv.corp.google.com> <20161201185056.eso5rhec7izlbywa@sigill.intra.peff.net>
 <20170122052608.tpr5pihfgafhoynj@gmail.com> <20170124142346.u3d7l6772mtkgpcf@sigill.intra.peff.net> <xmqqlgu0ceia.fsf@gitster.mtv.corp.google.com> <20170124230500.h3fasbvutjkkke5h@sigill.intra.peff.net> <alpine.DEB.2.20.1701251135090.3469@virtualbox>
 <20170125183542.pe5qolexqqx6jhsi@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:lnxU++i2aNFSeorSXlk6owxDo+C2t/n95aYLr9FOQ3s1asTQrrN
 J9ICHANtEgoQy7IeqWv0ESEI4/kG9d2J0h696zUD5a4OO0lVsUStZPQdz3RN/gtYg6ldnTS
 y7LNrvPOPFJufcYu/Jr5PcPv6KCGKb37x3tFkA5f7NquiHIJzoZkHkQWjRE0YBiliHdb296
 H6WsE59aXl1cQ75hIml3g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1xzmHIo6W7M=:NEtC5jQ3tymL+Ww13Kob2f
 9gsQj1fSK1vKNwLUGY04xjKkxwW6Pov2iDqIUw9jdFsDv7BQHNqqdGIKZ3EKxHW5d1BAyRbho
 bOzxpbj0y/jkdHV46XiR0077Tw9YvxRcG2+t+womSxUgdNPvqDt+tj31CzhKPk6TdMafMPkfp
 u0OjgsMmjR5WXAUG9B6UqlP98oVZaUqdCtc09qUpAKfvYzrljxdErFatl+u0jxxwdman7VVED
 iSm5KlnalDxai9D4V+HSTeqsoKbpsFMqGn2FDswCyLFIetjU14SKnLt/t67+SGfj7UMPzAcx/
 REtTRuKPw7JauzWPzTzEHJXU/mtHSoj3yAOSUEoFmszs6iL9w8JrByGESEDrIk/sIVnhoLyPD
 nGhZDeCCrt9Mmys0qhjLI2DZArw8MWdxM+0XAkiz0KxE3KiFV/MgSAhO6NT2zy6eTGquid9ht
 C1xcAwaIy6JhzDRN/8j/GITyi7vQGvFim4Rm7CTaoYvlm6WNOTBj9217Ho1Z6Q1RKjwDHNVSK
 iVHz5ToNwk2YaQTHdFtHx28JDxnOcfXKZCCFRIMic40Keujk3hTrAO5cH8BvRr9fGJYCllIe1
 zewz0H0TDO5BKOsCv4y5UfqOaMqiSDqVBiaQVV41bBnwljNQr8BLrGzZoMO82SJMysoeScjRF
 +N+7paZ9Eol3FbA1VsMl+nvPEreuZ/O7EnS17pemI7HFQwwqvEfQgFBszjhBRmKJWG1VgD6HG
 wrXtR398XE3PwWlXC1xEcDhBehxKZU01HzyqJhdMIfzjDrXwSU/gc9OvslRK70/R3fOl+Ye9t
 eHR9If08zo8OU/1FdOOgcaCx5sKtMxZ51RHCcod9o7r1B2po+5X4d2Ui/iIn62DW7ejrKuZxA
 MMOyKGSA7emRgqSkcLzXOLW4dkK40OdSIg7KvogAtpCk/XEXjTOze0jTBp3aiwyq5ChQv5CyF
 88dTlI3nruCNOAZ5vlLKs2NqRIebntGEdIEvZwnYG38PTl7DXx53PXyGKeC3Br2XqsWiaWNJA
 zp6GVH4mEH1Ac7b8mifdJFdGo9xmCn4JiD15Wrj9heQ1/RlqULVGUIIMVHIHL9wGlA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 25 Jan 2017, Jeff King wrote:

> On Wed, Jan 25, 2017 at 11:36:50AM +0100, Johannes Schindelin wrote:
> 
> > > Gross, but at least it's self documenting. :)
> > > 
> > > I guess a less horrible version of that is:
> > > 
> > >   static inline warning_blank_line(void)
> > >   {
> > > 	warning("%s", "");
> > >   }
> > > 
> > > We'd potentially need a matching one for error(), but at last it avoids
> > > macro trickery.
> > 
> > I fail to see how this function, or this definition, makes the code better
> > than simply calling `warning("%s", "");` and be done with it.
> 
> The only advantage is that it is self-documenting, so somebody does not
> come through later and convert ("%s", "") back to ("").

We could switch the DEVELOPER option on by default, when gcc or clang is
used at least. Otherwise the DEVELOPER option (which I like very much)
would not be able to live up to its full potential.

Another thing we should consider: paying more attention to Continuous
Integration. At the moment, it happens quite frequently that `pu` builds
and passes the test suite fine on Linux, but neither on Windows nor on
MacOSX and it takes days to get the regressions fixed.

I vote for this patch:

> -- >8 --
> Subject: [PATCH] difftool: hack around -Wzero-length-format warning
> 
> Building with "gcc -Wall" will complain that the format in:
> 
>   warning("")
> 
> is empty. Which is true, but the warning is over-eager. We
> are calling the function for its side effect of printing
> "warning:", even with an empty string.
> 
> Our DEVELOPER Makefile knob disables the warning, but not
> everybody uses it. Let's silence the warning in the code so
> that nobody reports it or tries to "fix" it.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/difftool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/builtin/difftool.c b/builtin/difftool.c
> index 42ad9e804..b5e85ab07 100644
> --- a/builtin/difftool.c
> +++ b/builtin/difftool.c
> @@ -567,7 +567,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
>  				warning(_("both files modified: '%s' and '%s'."),
>  					wtdir.buf, rdir.buf);
>  				warning(_("working tree file has been left."));
> -				warning("");
> +				warning("%s", "");
>  				err = 1;
>  			} else if (unlink(wtdir.buf) ||
>  				   copy_file(wtdir.buf, rdir.buf, st.st_mode))
> -- 
> 2.11.0.840.gd37c5973a

Ciao,
Dscho
