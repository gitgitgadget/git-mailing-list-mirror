Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59EE31F454
	for <e@80x24.org>; Sat, 20 Oct 2018 16:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbeJUBBl (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 21:01:41 -0400
Received: from mout.web.de ([217.72.192.78]:34387 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbeJUBBl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 21:01:41 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M1o86-1fKQ4z1QpG-00tiBD; Sat, 20
 Oct 2018 18:45:27 +0200
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M1o86-1fKQ4z1QpG-00tiBD; Sat, 20
 Oct 2018 18:45:27 +0200
Date:   Sat, 20 Oct 2018 18:45:26 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Carlo Marcelo Arenas =?iso-8859-1?Q?Bel=F3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] builtin/receive-pack: dead initializer for retval in
 check_nonce
Message-ID: <20181020164526.GA1077@tor.lan>
References: <20181020070859.48172-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181020070859.48172-1-carenas@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:gvL4+SXPoU9y/9BOKnwdAJXkJI38ou+bPlMW1JVJR7sC3oNywUl
 dVpRKvl4ioS2WyhRIwNBeqfxf5W99CPD8y43dnvcRP+p4UqbtTyTWBF35TH99jStny54Rs7
 JfIefHEegqyYdcfVhZ7OMT82+qyZBvhTjOEYzl9BoAllepO4vQKLA6WU4dl67/oIe17g6wx
 EKjBvErbs+mCi6oKbCBlA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JTsav8hkZfs=:ihGA0uAjDfAojryDr0MMSI
 az3DvKAYWdG4fz9VvJkXmw78Ueo2k8FcjAzLiLFfLAELvP/1epczfmsyOyIpbU33h1NjDQP3I
 87NbwsDUQ/xR3hZ+1/KOcysC0cB/E7m8iPiWXDsoERSPx/0fcBghQbT7ZSiy+1mojEn+x0KSa
 o6yBLPq3WrGaHkwxTqSh57JE/QIJw01vaaKeINUnrBq5MDTuuopyjZBdlHmkWShzfBp9EJW84
 a7jbS72by8dQqKzPUhzrTuK4q03qgzgQAsx9aCc4TLF9bYZVdZQY/7NdfyW3pkSot8AOtynls
 N9YPfp9L2ZrJVgDaIn4b3ppwevPdMrfGfWTOeDzIMKZsJIENvi8OYxjZmVzsIDEg8CVH7/Pcq
 j/r81v97x3DS8gDtgDoYpdHKuUV+aTgpK+1Sobc+ljYNtvUZINa3jd6mj/MxI4L8uUN/rV0EM
 JFAxIp4WROXJ8yJYo0m8jbl0sNe23RiTFV9pfj0Ks55Lj65Jo24y175+L62/F3Bz/eo/umC6t
 zPHWTzMv8JKT0/Ez/NTfBjHLBuLGTpvdkddBS1lYa9zZdCqE3AnfGT7T6yDYBsUKqH7sV2uN2
 8cm6d1xm9cPtKqTAs2wybMeBI/WSYiFcySUNXRpwbT9FFWSiZ7hCD2pmMivk2tyfxRfGbKV2C
 NFdIOnMmKSwAKAyjAedn+kPFjfb2XsFgyuTx1/IFawYd/2AQgf1G86Au+hp1I7ldZuwi6yhMh
 5tWSRdwRJPcsDYCX+f3/2SKm2D/oW/e5vvc+WnSAsOsFgUheTMSI5mFP/zzHvoRfWGIqpRYfs
 Lde1pzhzIhEgUbXV25ARYlXh2SdwQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 20, 2018 at 12:08:59AM -0700, Carlo Marcelo Arenas Belón wrote:
> NONCE_BAD is explicitly set when needed with the fallback
> instead as NONCE_SLOP
> 
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  builtin/receive-pack.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 95740f4f0e..ecce3d4043 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -507,7 +507,7 @@ static const char *check_nonce(const char *buf, size_t len)
>  	char *nonce = find_header(buf, len, "nonce", NULL);
>  	timestamp_t stamp, ostamp;
>  	char *bohmac, *expect = NULL;
> -	const char *retval = NONCE_BAD;
> +	const char *retval;
>  
>  	if (!nonce) {
>  		retval = NONCE_MISSING;


Thanks for the patch.
The motivation feels a little bit weak, at least to me.
Initializing a variable to "BAD" in the beginning can be a good thing
for two reasons:
- There is a complex if-elseif chain, which should set retval
  in any case, this is at least what I expect taking a very quick look at the
  code:
	const char *retval = NONCE_BAD;

	if (!nonce) {
		retval = NONCE_MISSING;
		goto leave;
	} else if (!push_cert_nonce) {
		retval = NONCE_UNSOLICITED;
		goto leave;
	} else if (!strcmp(push_cert_nonce, nonce)) {
		retval = NONCE_OK;
		goto leave;
	}
	# And here I started to wonder if we should have an else or not.
	# Having retval NONCE_BAD set to NONCE:BAD in the beginning makes
	# it clear, that we are save without the else.
	# As an alternative, we could have coded like this:
	
	const char *retval;

	if (!nonce) {
		retval = NONCE_MISSING;
		goto leave;
	} else if (!push_cert_nonce) {
		retval = NONCE_UNSOLICITED;
		goto leave;
	} else if (!strcmp(push_cert_nonce, nonce)) {
		retval = NONCE_OK;
		goto leave;
	} else {
		/* Set to BAD, until we know better further down */
		retval = NONCE_BAD;
	}

# The second reason is that some compilers don't understand this complex
# stuff either, and through out a warning, like
# "retval may be uninitialized" or something in that style.
# This is very compiler dependent.

So yes, the current code may seem to be over-eager and ask for optimization,
but we don't gain more that a couple of nano-seconds or so.
The good thing is that  we have the code a little bit more robust, when changes are done
in the future.




