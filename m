Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F3F11F453
	for <e@80x24.org>; Tue, 29 Jan 2019 07:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbfA2HiW (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 02:38:22 -0500
Received: from mout.web.de ([212.227.17.11]:42369 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbfA2HiW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 02:38:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1548747491;
        bh=pJwcFfvQih95lCkvTB8BSOogGQ4McmFtDgmJEPkZYP8=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=bEfF1p7CTGFRlwPbKUuLDSxV0xxkYYNm+UOwfLvg/p26vwC0Q1CqslxKAIOO4xafe
         fAAZ0onaQoc/2AEqqMgNAzLJrHWvoz0bxOMyzmTVgPO5VflLPl9pEf26kNmixYGX/F
         iUJM4p0oK+X6ExrOw7SRf4rTBVSD+WNbklW6rUJk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LmLgE-1hOGgb0lus-00ZwW5; Tue, 29
 Jan 2019 08:38:11 +0100
Date:   Tue, 29 Jan 2019 07:38:10 +0000
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Jeff King <peff@peff.net>
Cc:     Sergey Lukashev <lukashev.s@ya.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: unclear docs
Message-ID: <20190129073810.23op5qaibyj2amwq@tb-raspi4>
References: <57362151548583138@iva8-37fc2ad204cd.qloud-c.yandex.net>
 <13169311548590123@iva1-16f33c6a446b.qloud-c.yandex.net>
 <20190128160944.GB23588@sigill.intra.peff.net>
 <1593541548699120@myt6-27270b78ac4f.qloud-c.yandex.net>
 <20190128183117.GA13165@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128183117.GA13165@sigill.intra.peff.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:KelmjuwWQRwy5UAbSsGb0v0+O3Jjf2H5eGpA1o9cQy5QoMD0Lti
 G7NX7HY0vF1ioDDw080v1BqW5TVm+jBXyHzIGUSkTQihivMR7aqGJmSw+j2Vl4UcKw0m+xv
 +UvfLfxM631c/Xz/SAy99L2MXK7HYZ2aT1T8qEOi/EL1nCkVXZBjySpuv/VvDQALWG2tftW
 xz6r4zbBQAudwaynUQMRA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2EH/tTSFWU8=:9pKOSN8Z1ULrWBlq8bSI0j
 pGcLDYJvpFv8CANtbqaU6IPfLgsaSaZRDuhiAP/CbzEen19q6/lYeu5SB/xL9uKPnEmk6wqvV
 Rs3wvo45ws5ZCghBRSSDavozc1XNANrmBjLhiRop7xKEygFCIA4h27CqDxCCs9q53eeiuxYAc
 wyqdNGFbQaGGOPrr2mBeybes9+owila9E3CMeKSYNypsMsr5t0SfzgCU+81bnHBykfPiUUH1V
 1QLaH1T4JVn/nPnZx/PDmLYutt2fQHaQjRWcVbo273wnF2n1/0BPZSfXGfPAyTykO9j4hEf4b
 +IsHOtJfDN98rjxJHrDq0dOln7qTMeJNBDtBLjLgenuNdbIokNtMdxw8vQDbxD3BfPMJGXD2m
 bI4496MNQcWJRknEu6S6y0K+XfVsVx/ncIf2b6H8iEwEuKOP3oL8utYRFLFVRCz9sJ50z8Xp6
 WU/opMsJEatXFPFshXc4YCVc1MdzyVzTdAMpCCBk7kebiGu9j1LlPHZONJqBseFzsfh2WJo4y
 K7qfGXtmPrZ/37UFNEQVH9Rwvk4MQVMv5xL7iHWC53pZmGWLG1Yu9XpwjNiJecMna3bLoslcK
 A+mRjJ5rZcOfjfOcr11nDrHx7zpQJ1jcfIcP7zm8IAa+eKMSY6Y6ppwlqOuDH6y9XMz0MbnIo
 MO0++h3tiO+rwE8p+Y8EMf25Ml0sQ5i2YUJ1DgdxzgQPuu7MVPSOSzeDVmlofzshUZXdZVbQu
 LnD2YSlK66xc83DT9X6tKJI5ld9Pv23IZw1Mv1dmL0fBnvHgJTZG72kAo3SU74PlrSaK8x78B
 tCnBKt+au7WQsP/JRgRhXLMYL8zhtzWMMEQDT4gD6i3/W4hSvXdzp7B9BOBG3tGQNlqu9s8RM
 T1Rg0BYc+wIv/52A83mL/elbbD2PNOuI7CXVBzg52GxL0lICuZytlcTY6fbzXJ
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 28, 2019 at 01:31:17PM -0500, Jeff King wrote:
> On Mon, Jan 28, 2019 at 09:12:00PM +0300, Sergey Lukashev wrote:
>
> > Thank you. Does the paragraph about core.eol refers to the text
> > attribute? It's written 'property' there. I was thinking it means
> > whether git thinks file is text, using .gitattributes OR otherwise.
> > Maybe changing this word will make it clearer?
>
> Yeah, I think the word "property" is unnecessarily confusing. Here's
> another patch (meant to go on top of the other).

The property was originally meant to say:
- Either the "text" attribute is set in .gitattributes
  or
- The "text=3Dauto" attribute is set in .gitattributes and
  Git auto-detects the file as text (and not as binary).



>
> -- >8 --
> Subject: [PATCH] docs/config: clarify "text property" in core.eol
>
> The word "property" is less clear than "attribute", which is used
> elsewhere in the (surprise!) gitattributes documentation. So let's use
> that.
>
> While we're here, let's make the paragraph a little easier to read by
> de-emphasizing the "when core.autocrlf is false" bit. Putting it in the
> first sentence obscures the main content, and many readers won't care
> about autocrlf (i.e., anyone who is just following the gitattributes(7)
> advice, which mainly discusses "text" and "core.eol").
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/config/core.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config/core.txt b/Documentation/config/core.t=
xt
> index d0e6635fe0..69c73ffe30 100644
> --- a/Documentation/config/core.txt
> +++ b/Documentation/config/core.txt
> @@ -121,11 +121,12 @@ core.quotePath::
>
>  core.eol::
>  	Sets the line ending type to use in the working directory for
> -	files that have the `text` property set when core.autocrlf is false.
> +	files that have the `text` attribute.
>  	Alternatives are 'lf', 'crlf' and 'native', which uses the platform's
>  	native line ending.  The default value is `native`.  See
>  	linkgit:gitattributes[5] for more information on end-of-line
> -	conversion.
> +	conversion. Note that this value is ignored if `core.autocrlf`
> +	is set to `true`.

Should that be
 > +	conversion. Note that this value is ignored if `core.autocrlf`
 > +	is set to `true` or `input`.

As we look at convert.c:

static int text_eol_is_crlf(void)
{
  if (auto_crlf =3D=3D AUTO_CRLF_TRUE)
    return 1;
  else if (auto_crlf =3D=3D AUTO_CRLF_INPUT)
    return 0;
  if (core_eol =3D=3D EOL_CRLF)
    return 1;
  if (core_eol =3D=3D EOL_UNSET && EOL_NATIVE =3D=3D EOL_CRLF)
    return 1;
  return 0;
}

