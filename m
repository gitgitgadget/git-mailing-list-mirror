Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF16B1F453
	for <e@80x24.org>; Mon, 28 Jan 2019 16:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732833AbfA1QKf (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 11:10:35 -0500
Received: from mout.gmx.net ([212.227.17.21]:50123 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732821AbfA1QKe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 11:10:34 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LcSWg-1hUbqB2fbS-00jpaE; Mon, 28
 Jan 2019 17:10:25 +0100
Date:   Mon, 28 Jan 2019 17:10:09 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: sparse job, was Re: [PATCH] test-xml-encode: fix sparse NULL pointer
 warnings
In-Reply-To: <68a8c70e-dc42-1df3-3616-c096f63cb848@ramsayjones.plus.com>
Message-ID: <nycvar.QRO.7.76.6.1901281706440.41@tvgsbejvaqbjf.bet>
References: <68a8c70e-dc42-1df3-3616-c096f63cb848@ramsayjones.plus.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:I8g9vulrEydKnINssCZi0iYirfilwPcl3tcv7w8XH+KgK9d8H7Y
 7YE5zkwj6jh/uv1DemtW7Cvuw5hCNeiitHWgulAYGFSpH8kiHdA2vjeQ8S4sN5Gykerlj4S
 7MK71VQYwiCsMPrUPoxVMVCRGHLcrXDUuycZ33YqX/M5WD2+4rWcGLOYj894ZnVy201H56H
 7HmTEJlycgZv8UxcnBegA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KmSx0zl9e9o=:sdrxjgTKMbM1KBji5tjmUe
 LRqs0/ptRHGcXRbT0AD2/nhkY++hoFI8PKn9XjhrL59KUF25Wip2xs1TEoKlb1vu65sYjJQNN
 sw3dV5FTsRmPAa4jz7jsYfTBkCyN9uOIBjBN7CiX+gXeZa+MQNxpwh6M/gUGN+1PetAqiLABq
 aZD4OfTC/JQQkTPZeC2460/Va+6MwxGlDpqskJCA689pTC505VmpwCeJOKLt7x7xVrr2FRjSA
 baHP+EDRLdxHUCodW48IM289SRkN/H9SWVLxnjmcXfbAP8GQy3MuAP3ZT4pkwJA6AZ7Q6mngY
 8LrReaNttQWRLqkHBJb79NzReZgYWf0kvzNOfi0nnqqzIfQcSeJpHmtzAcLQtXgG9KnCycUP5
 i9cmg2IyNwRDuiHo+oQxN0PFqxt+xu0e9DGQrbvMpU11EvShizfUsqrtYT+RgQhpxPRP3qNoR
 IksOt6+5+Aw0GMqClFxJiUy0ex/BMAbmDoBFRFhCOfCrguSb4l+AnZW1sQwgpqElvglFBEvtH
 XFi9Mcls8VRw9lUbNb3mMchYslnat6Oxk9XSjPyQhkE2wvym+hEug8kotH3UfInxhrboTYOys
 A46dBZPzYxN6S/ncDBvdmLklIvNVm5I+07PKCJ0oEjpMySBrnyP0YW5xzDrZoI8B4HYtk5859
 /4hpz41/76QNfnnj5w+yvOaNRBygPSTzzp3e8Xsto4YYHbTWkIHHMHNsqsGUzsonCNBU9q4Ph
 AVC4JS8cMpGL+qAHyFH9y8irPS/4jzcdleGDlraFYVWxRvqmP7qUVHveu0lSC1s4bgRMYdsw2
 DRjRBpfZ0qmxUXmLT3HxClPBsb+pxzuoiTRDCpfRID1IepCXO6zSD7gL9S2UAD9QjPLXmTLSe
 fSzpPMIQVAt7gpx3aEU48Ul7l+8o2slA0m2TfwHIDUit1T8gFDYTG24bxhQE5G0ZlHcLJa5Rk
 Zl4VwE60coQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ramsay,

On Sat, 26 Jan 2019, Ramsay Jones wrote:

> 
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
> 
> Hi Johannes,
> 
> If you need to re-roll your 'js/vsts-ci' branch, could you please
> squash this into the relevant patch (commit af7747e7c7 ("tests: optionally
> write results as JUnit-style .xml", 2019-01-23)).

Certainly!

BTW would you be interested in working with me on an Azure Pipeline that
runs `sparse` on all of Junio's branches? (I am now pretty proficient with
building a software package in one Azure Pipeline, publishing it as a
build artifact, then consuming it from another Azure Pipeline, so I would
build the `sparse` package as an Ubuntu package and offer it as a build
artifact.)

I seem to recall that you once explained to me what it takes, but that
mail vanished from my inbox and I cannot find it.

Thanks,
Dscho

> 
> Thanks!
> 
> ATB,
> Ramsay Jones
> 
>  t/helper/test-xml-encode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/t/helper/test-xml-encode.c b/t/helper/test-xml-encode.c
> index 367c4875e6..a648bbd961 100644
> --- a/t/helper/test-xml-encode.c
> +++ b/t/helper/test-xml-encode.c
> @@ -26,7 +26,7 @@ int cmd__xml_encode(int argc, const char **argv)
>  		if (tmp2) {
>  			if ((ch & 0xc0) != 0x80) {
>  				fputs(utf8_replace_character, stdout);
> -				tmp2 = 0;
> +				tmp2 = NULL;
>  				cur--;
>  				continue;
>  			}
> @@ -34,7 +34,7 @@ int cmd__xml_encode(int argc, const char **argv)
>  			tmp2++;
>  			if (--remaining == 0) {
>  				fwrite(tmp, tmp2 - tmp, 1, stdout);
> -				tmp2 = 0;
> +				tmp2 = NULL;
>  			}
>  			continue;
>  		}
> -- 
> 2.20.0
> 
