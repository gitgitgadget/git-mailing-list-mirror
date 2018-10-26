Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E23B51F453
	for <e@80x24.org>; Fri, 26 Oct 2018 15:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbeJZXxF (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 19:53:05 -0400
Received: from mout.web.de ([212.227.17.12]:45175 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726113AbeJZXxE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 19:53:04 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LmLoU-1fgRpk1Yzy-00ZzPY; Fri, 26
 Oct 2018 17:15:34 +0200
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LmLoU-1fgRpk1Yzy-00ZzPY; Fri, 26
 Oct 2018 17:15:34 +0200
Date:   Fri, 26 Oct 2018 17:15:33 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v1 2/2] curl_off_t xcurl_off_t is not portable
Message-ID: <20181026151533.GA15410@tor.lan>
References: <20181025161310.29249-1-tboegi@web.de>
 <xmqq4ld9e83d.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq4ld9e83d.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:AM4lsVLII9j8twRylLue94hd3KAsn6pE3gy12Ou6Wp3PiqovSzJ
 tgr8Z2TOWnDKE51JjkedCKP2sdeun20CvAap5UOW/++UMmhCRhQTCflAESHfQiTIsexuZsK
 DtsYZkEhVjtjFC6tS5hJIWXgD/5iSdmrDAIA4Q0QTuGH6xwQTtdHosM5MEtV6dPNDpGMwIj
 Oza04naqycw0gcHnkBXHQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:O38w5J+q3sI=:HJN9PKeIyEJ6PQrHVEGihd
 SEwN/aXYaV9rX/WwAjpoZYwONj97HSGEoun0EbxEIbglJ1Ye8Ntr+XKsUXpvTBzPv2kH9VF8b
 OSqgmZloDZyZovz1pGwnV7NHgkHLWrFRWglFkHTtgR1nK3XyDtKYjOZeHHn9LanVcMnophxgB
 EXmC15mLBafNfLRDORfqC1dxwiix/s+Rdutbyz3VozaGu7Y/KbZb9tAddnDT2rwUQtlRA430y
 BTUFiWrVWiU5Z3XQFvvnnie+HINM8hS/L1EJGelqGiaJ2h5b8vq0l6DPrr/9uty975J/coc82
 GmMxKSOmpwC9J1muroq15halG4nRv2AQtUX6V3Xvj5CjXtStWTtwzoJG/mihaK6f4x0F6KID6
 nd7hxpUlgp8DRh1XBINipgqn3pVNvBeexDwjM4Y63P0dAnv9fWAIZj1DFXbCsJikwM0/mJEML
 RS3AUO8AZOzCwLdyBRxnVsc41nlh3kFE0CoQNhHPH5dPy5sMkf0elWg9iu++9T46c6pog0O83
 NzuDyUzacIOHqu1wDym+SB1tMGBYrJxZBayWVtAaEF5hc4ph2jYX+Uy9elmImdycpzj0sIIdW
 +OmIsqKGlLMq1x6uL4mz57DyXUhOHrn38ORnj1vxaN/aaeQzGMBWcYzRu/GfCMIChGLeFFg2U
 S3AVT5mNafy6i1CJ5E0LAjo4uWyq5ltcA4xku+P43CJVqV9wbXb7xl63FX//LdaXbGON89eD7
 iGVnWSW32wyWJHcLHiKIaqyGuuj13VyqBi0m+B/+LlIhd6byQdaDPCQnJLY3L9eNX8FtN8GA9
 EkeNeR730gykS/7KGPI3OgQR6gHKw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 26, 2018 at 11:48:38AM +0900, Junio C Hamano wrote:
> tboegi@web.de writes:
> 
> > From: Torsten Bögershausen <tboegi@web.de>
> 
> > Subject: Re: [PATCH v1 2/2] curl_off_t xcurl_off_t is not portable
> 
> That title is misleading; it sounded as if the are these two
> typedefs and they do not work correctly on some platforms, but that
> is not what you are doing with the patch.

OK.

> 
> > Comparing signed and unsigned values is not always portable.
> 
> Is that what the compiler is complaining about?  There is this bit
> in git-compat-util.h:

No, not that either, see below.

> 
> /*
>  * Signed integer overflow is undefined in C, so here's a helper macro
>  * to detect if the sum of two integers will overflow.
>  *
>  * Requires: a >= 0, typeof(a) equals typeof(b)
>  */
> #define signed_add_overflows(a, b) \
>     ((b) > maximum_signed_value_of_type(a) - (a))
> 
> which is designed to be fed signed a and signed b.  The macro is
> used in packfile codepaths to compare int, off_t, etc..
> 
> So the statement may be true but it does not seem to have much to do
> with the problem you are seeing with maximum_signed_value_of_type().
> 
> > When  setting
> > DEVELOPER = 1
> > DEVOPTS = extra-all
> >
> > "gcc (Raspbian 6.3.0-18+rpi1+deb9u1) 6.3.0 20170516" errors out with
> > "comparison is always false due to limited range of data type"
> > "[-Werror=type-limits]"
> 
> Then this sounds a bit different from "comparison between signed
> ssize_t len and unsigned maximum_signed_value_of_type() is bad".
> Isn't it saying that "No matter how big you make len, you can never
> go beyond maximum_signed_value_of_type(curl_off_t)"?

I digged a little bit deeper into the raspi, and this is what I find
under
/usr/include/arm-linux-gnueabihf/curl

curlbuild.h:#define CURL_TYPEOF_CURL_OFF_T int64_t
curlbuild.h:typedef CURL_TYPEOF_CURL_OFF_T curl_off_t;

> 
> > diff --git a/remote-curl.c b/remote-curl.c
> > index 762a55a75f..c89fd6d1c3 100644
> > --- a/remote-curl.c
> > +++ b/remote-curl.c
> > @@ -618,9 +618,10 @@ static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
> >  }
> >  
> >  static curl_off_t xcurl_off_t(ssize_t len) {
> > -	if (len > maximum_signed_value_of_type(curl_off_t))
> 
> Is the issue that len is signed and maximum_signed_value_of_type()
> gives an unsigned value, and these two are compared?  As we saw
> earlier, signed_add_overflows() is another example that wants a
> mixed comparison.
> 
> I am just wondering if casting len to uintmax_t before comparing
> with maximum_signed_value_of_type() is a simpler solution that can
> safely be cargo-culted to other places without much thinking.

I don't know.
Since ssize_t is 32 bit on the raspi, and curl_off_t is 64 bit,
the test seems not to be needed at all ;-)
I don't know if it makes sense to stop thinking here and if
casting to uintmax_t is the right solution here.

And, I like the easy-to-read xsize_t, which is safe and warm.
Agreed that the commit message is wrong.
I would like to keep the xsize_t aproach, are there more thoughts ?

> 
> "git grep maximum_signed_value_of_type" reports a handful
> comparisons in vcs-svn/, all of which does
> 
> 	if (var > maximum_signed_value_of_type(off_t))
> 
> with var of type uintmax_t, which sounds like a sane thing to do.
> 
> Thanks.
> 
> > +	curl_off_t size = (curl_off_t) len;
> > +	if (len != (ssize_t) size)
> >  		die("cannot handle pushes this big");
> > -	return (curl_off_t) len;
> > +	return size;
> >  }
> 
