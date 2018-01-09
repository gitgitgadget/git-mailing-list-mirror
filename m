Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C32141FADF
	for <e@80x24.org>; Tue,  9 Jan 2018 06:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758146AbeAIGUt (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 01:20:49 -0500
Received: from mout.web.de ([212.227.17.12]:61153 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751071AbeAIGUs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 01:20:48 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lp6xk-1f2bmd2dbI-00euhy; Tue, 09
 Jan 2018 07:20:31 +0100
Date:   Tue, 9 Jan 2018 07:20:29 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, lars.schneider@autodesk.com,
        git@vger.kernel.org, j6t@kdbg.org, sunshine@sunshineco.com,
        peff@peff.net, ramsay@ramsayjones.plus.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v3 5/7] convert_to_git(): safe_crlf/checksafe becomes int
 conv_flags
Message-ID: <20180109062029.GA18135@tor.lan>
References: <20180106004808.77513-1-lars.schneider@autodesk.com>
 <20180106004808.77513-6-lars.schneider@autodesk.com>
 <xmqq4lnw82hi.fsf@gitster.mtv.corp.google.com>
 <FFFF054A-6049-49A6-9B31-3E2D6585B21A@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FFFF054A-6049-49A6-9B31-3E2D6585B21A@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:PtaAK//RbHNuEoRg9n71PA/o0sT6/ec+ftZezIvskj8O3UKsQRJ
 omRmBFQ4d3sbwx8s1WOfbu8dSXdVPQs1jCAnYQUjvgPrQsXRlhBkazKPOxBcOhWfp0dXqZV
 HMggxuC2HIgS096lOahJhsG1GBR06Jfc7xdr4GG34I6idZFNWPG3W9JgWNNZfik0Dlng9bX
 Cd8CHwKAQbj2L0EfoF1cg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HVEBJ3/dAwA=:a8yG9tsfcVZM/brgXIydwa
 gc8foFepKLHy6IRmo/KNCBKjLBI/4M+t7ywDo7YATDoskZGIMtsEbpg4GcXizYzOUOaTieamM
 4Fw2FZFzslJ8cL/+bis1fJ8PeanTkGjJvo7zEPLS3GD+xNUTFVF1JozT1EL9DzMdnbrFUs5WA
 TCM+xC2MUXyBZxrPPh9tlT+bXyRGDTXgki3vf9GmJa2RvzJPaxScAr68vVqyjf8LGviNoZ+1V
 km8fYOT22WXiIEYQgBpgGq3fT+32dFMAhdqvOhtwSkrZIKLi/zHC7sGfjFyNlMbCB4Ot89k+Z
 mutPmJz5ceY8eHhGXqs3+9pXLoi3mpelDxdUGdRd2kh5V5hN+ZxKGTcsE3Oo5yoUWdupcPyB3
 JsmIWUVCaQ89B8n8QkMm+vBThtmTFUBVwqMyqd0oAkGPzfMYY16HtwIVDslpiYfDgaT/sgMkn
 HSq/3VVzFIU2tqZSNk3GBvbIB2t69qBcBdFezHezN5kl+mhdczooLL+6j74AAMOTuJtEf3BjM
 L485I5QV8MlAYkWbiF9FXSxTXkksgK+zu2OyOgWo/5wKZWRZmL9W1EsKFdMLv1CZpL+DwSsg9
 RDTntkdXICYjwRd8v+xcoFv/2BgkPJ8Vga+rB5xFr0vSuHCZKHOMwKk+G2Y+UF5hrX65Z4eea
 zMFEcT9ibsX2nEbBhIIECGjuyq9UtC8Zyu/0YkVcObsuixWvaqybGvqhZAMNHCqktqak8oZDj
 Ayl2p0YCSZpfkemyiAZvfwaFOCi5ES8QXjBdektqeh1rRC57ZGraEZtezTWFhcW3iSUiawMNI
 AFuAN+9HZ4+fThuguoKyIg7loX6jw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 08, 2018 at 11:47:20PM +0100, Lars Schneider wrote:
> 
> > On 08 Jan 2018, at 22:28, Junio C Hamano <gitster@pobox.com> wrote:
> > 
> > lars.schneider@autodesk.com writes:
> > 
> >> diff --git a/sha1_file.c b/sha1_file.c
> >> index afe4b90f6e..dcb02e9ffd 100644
> >> --- a/sha1_file.c
> >> +++ b/sha1_file.c
> >> @@ -75,14 +75,14 @@ static struct cached_object *find_cached_object(const unsigned char *sha1)
> >> }
> >> 
> >> 
> >> -static enum safe_crlf get_safe_crlf(unsigned flags)
> >> +static int get_conv_flags(unsigned flags)
> >> {
> >> 	if (flags & HASH_RENORMALIZE)
> >> -		return SAFE_CRLF_RENORMALIZE;
> >> +		return CONV_EOL_RENORMALIZE;
> >> 	else if (flags & HASH_WRITE_OBJECT)
> >> -		return safe_crlf;
> >> +		return global_conv_flags_eol | CONV_WRITE_OBJECT;
> > 
> > This macro has not yet introduced at this point (it appears in 6/7
> > if I am not mistaken).
> 
> Nice catch. I'll fix that in the next iteration.
> 
> Is it OK if I send the next iteration soon or would you prefer
> it if I wait until after 2.16 release?
> 
> Plus, is it ok to keep the base of the series or would you prefer
> it if I rebase it to the latest master (because of a minor conflict)?
> 
> Thanks,
> Lars

I noticed the missing macro as well, while doing the rebase
to git.git/master, but forget to mention it here on the list

Lars, if you want, please have a look here:
https://github.com/tboegi/git/tree/180108-1858-For-lars-schneider-encode-V3C
