Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F10481F453
	for <e@80x24.org>; Thu,  7 Feb 2019 13:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfBGNRc (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 08:17:32 -0500
Received: from mout.gmx.net ([212.227.15.15]:43491 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726732AbfBGNRc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 08:17:32 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MAhWl-1gz70N0l1n-00Bx9x; Thu, 07
 Feb 2019 14:17:20 +0100
Date:   Thu, 7 Feb 2019 14:17:03 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add_to_index(): convert forgotten HASH_RENORMALIZE
 check
In-Reply-To: <20190207020022.GA29974@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1902071416410.41@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1902061123410.41@tvgsbejvaqbjf.bet> <20190206104243.GJ10587@szeder.dev> <20190207020022.GA29974@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-881707564-1549545440=:41"
X-Provags-ID: V03:K1:ashJ+rD0DJDGyEXsV7aMu2t5QcuqhMAG8GIcBiiue8eoxbA/QUn
 8QZfYMNN/6Hi5i6Z6GOCRjTn7OZfBbbzz0naVh7TS/OKUMPGwE6WNvJz4WPDViqlifb6lg/
 7hMleFfLpClFuetgtjgVBnq0q/hQE2G55tQeIawjM7r3L1ZEk+EaT7S6Vt2qKsf1Cwp8uwK
 upRsNuZvnq8vBYiBTL2Ig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3txntNL0XcE=:RP6ANdX59/VyhZ/k26gz9Z
 T7Syk8ko8Oe1atIiWiOSjob5emNiaIBygfOfucj0E8j0UcTaX9grLi8ZFWdLRm1gg5BS1cddV
 fmmshVVuwXL85QfAfhOM60Bs1T04M9HF1jueRXFTbcU+UdkgsjgInlBtmRcTgaHxGMI+ZcVA/
 HSFUxMfMaZ5+VKE/IXMjsksHvu6sEBYffDbE7qa0XjHDNNlf12YSn0D44jr1yDieRE7J8LQc/
 LySYCpTCW359sGMJ3yaAVm4mITYidFPN+cPq/QHk6W+z3vIpuB33yyfg5x/reCQfnP92HWTNN
 V3dKe6P+7NZ7MS7A8MV0JWEz7cLOu6SBdiAuGfvza9qNTvt4RcteBK7gxCpUi8lY6CZhG6k+7
 ofWvMhToBz1z8aJIavjJla9GxvjYlI44D38VhL2Fr3FQgDX2I+umNm51jENtGWHBUPp0JX2LK
 S7M6mAEPIemg7az9WJwDDTXMtSYevKfsVXa4w/Cv8IePYmLVzNchH/8tDv9jdaIJx/ExPxouK
 Y1nG5DhJ/gWbPfdkt7hGNI8Cydojptr13TpMOGlPwL5eyETpjFeEbfWc6HXRlT+SaAfcbuhNb
 Dwq6jAoKrVa4nqSqktSJuq+1fMlc6/7LWqFs1cbKXrtFu7D4D4yl3kpYqhSx2QNuFfVmQz+bT
 lFK3MLudBV3xeGmPutNngfJSQGP6vrTf+jaCc4WDbGsrKW8Ok7vadNSoT61ZbTyPWPIFURojU
 1x7EFRCBa4O0M8tkxHjHwi/bJq8NW4isgyAywrHU7/ft9UAEWGgmBF325KcYRZCWIVQqxCFAJ
 IJc5CD0HndgE82QDCtokaJu1KMe4H9MUi2m5Dg0M6z45Y8DHrjGNmI/Fm6PBWype++MAaz6qI
 F6f00kRO6sr28SuOSbg1cIP8e5pbRmY81wJLf4CwEL2WsHlFelDYvpVgT4u/VldyJWW2gTs+4
 9xqtfLmRanw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-881707564-1549545440=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Peff,

On Wed, 6 Feb 2019, Jeff King wrote:

> On Wed, Feb 06, 2019 at 11:42:43AM +0100, SZEDER Gábor wrote:
> 
> > I reported this and Peff looked into it on the way to Git Merge, but
> > not working solution yet.
> > 
> > https://public-inbox.org/git/20190129225121.GD1895@sigill.intra.peff.net/T/#u
> 
> Oof. Well, now I know why my attempts to fix the test failed. It was not
> my new test that was failing at all, but rather the existing test. Which
> implies that I severely bungled the actual code change.
> 
> Armed with that knowledge, it was pretty easy to find said bungling. The
> fix is below.
> 
> Junio, this should go on top of jk/add-ignore-errors-bit-assignment-fix
> as soon as possible, as the regression is already in master. And I'll go
> find a brown paper bag. ;)

Thank you *so* much for the quick fix!
Dscho

> -- >8 --
> Subject: [PATCH] add_to_index(): convert forgotten HASH_RENORMALIZE check
> 
> Commit 9e5da3d055 (add: use separate ADD_CACHE_RENORMALIZE flag,
> 2019-01-17) switched out using HASH_RENORMALIZE in our flags field for a
> new ADD_CACHE_RENORMALIZE flag. However, it forgot to convert one of the
> checks for HASH_RENORMALIZE into the new flag, which totally broke "git
> add --renormalize".
> 
> To make matters even more confusing, the resulting code would racily
> pass the tests!  The forgotten check was responsible for defeating the
> up-to-date check of the index entry. That meant that "git add
> --renormalize" would refuse to renormalize things that appeared
> stat-clean. But most of the time the test commands run fast enough that
> the file mtime is the same as the index mtime. And thus we err on the
> conservative side and re-hash the file, which is what "--renormalize"
> would have wanted.
> 
> But if you're unlucky and cross that one-second boundary between writing
> the file and writing the index (which is more likely to happen on a slow
> or heavily-loaded system), then the file appears stat-clean. And
> "--renormalize" would effectively do nothing.
> 
> The fix is straightforward: convert this check to use the right flag.
> 
> Noticed-by: SZEDER Gábor <szeder.dev@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  read-cache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/read-cache.c b/read-cache.c
> index 9783c493a3..accc059951 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -746,7 +746,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
>  	if (ignore_case) {
>  		adjust_dirname_case(istate, ce->name);
>  	}
> -	if (!(flags & HASH_RENORMALIZE)) {
> +	if (!(flags & ADD_CACHE_RENORMALIZE)) {
>  		alias = index_file_exists(istate, ce->name,
>  					  ce_namelen(ce), ignore_case);
>  		if (alias &&
> -- 
> 2.20.1.1122.g2972e48916
> 
> 
--8323328-881707564-1549545440=:41--
