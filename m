Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 671D61F461
	for <e@80x24.org>; Mon, 26 Aug 2019 14:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731715AbfHZO7T (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 10:59:19 -0400
Received: from mout.gmx.net ([212.227.15.18]:41241 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730725AbfHZO7S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 10:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566831548;
        bh=R3GoFvQLHArXkindHJELFw8J3iDC97avYc+9usPvHAk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=A12IROob09iYdQlh0z3D+dpb16sHHdkix9smZAukmdN08+p8TR1lnpspofS7nN78g
         9sn+dimR9ZV6cIozpija5jBczzEuc51V3RyfWWZkpg6AtOU2AT/CQP2fd6N0qsRBgF
         tC5zY8BObWSCJoua0p3mF6ejqi54cjD+Zc3GgFF4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LbM2k-1iU99K0aXS-00kxU1; Mon, 26
 Aug 2019 16:59:08 +0200
Date:   Mon, 26 Aug 2019 16:58:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] grep: use return value of strbuf_detach()
In-Reply-To: <caf49742-65ee-7b2a-0179-ee11822b2350@web.de>
Message-ID: <nycvar.QRO.7.76.6.1908261658210.46@tvgsbejvaqbjf.bet>
References: <caf49742-65ee-7b2a-0179-ee11822b2350@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1833179219-1566831549=:46"
X-Provags-ID: V03:K1:cqutznu09u3z2U1qmp/eBjqopZgBGeGcSkkLbXJP+tIUrUckYK7
 QZHvaB2mRijmwoXVGDhCNgnSvSllVmlistEz48zPJ2NfIDfMFvgGUyjFoRy7/EovwoH71za
 taxT9xaOqp8wA+8A0TEaNP8+CLIDCaHRSvr8s+rRwp1QfIEa+k4ABC0NuRdnlBgvjiWhaE+
 7awjIxbPD8GbL9aufIsLQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QA79vGvFMSM=:hpopwAzZdNviszpHJzrs4i
 mC1G7J118bQnePzD5Wzsl+Kuuqb2UrI3CHtMUZptBDbFg4Kg5uJEpMAYr5mmfKxz3NN7Zr7RR
 fNFp8NBR/mG65eneO6DOkdfX/pWg+0KwXfkNPHIGHpXSl8NrAxR8XfmzbyX59PYZHmPUvf9C8
 AcVtXiF0puzR3mNJgQNz53e/qslDiJZ5RFx2XEyxQfT4zrD9eXjYgT4rn1jK6CMJsTq4+NJ7d
 ZnNWW4o931J2NWUbcSTom56g7OxQg3xN2bKhb+y3ct/0ZGfOlzti9QpdXWdN8kCupl5nzbFmu
 LvZC+wbho6RSV1oJEdc0wcBfmqrTWNtszA8O0brpt+Obz5AAYZwr+QZ/QJ2V/+UNMRmYmcw8S
 0BF3oCfKPIfEWI3vG4re0RA5DL4njU5hKgE8gZvLL2jtHQ/YbVgBkSRMPGmybXTbRoLre1wJH
 cNYP0oymsUrMTwHKs6/DaOnHrmuEJaYbZhtmUwh5vwpi87b3jVeSh+qjwvCePpBidMG6jvUKK
 ka3HTmA4/PXabVND9Ay+R1UuXpTOuTsNqyPMEer5GCHCOTYBd4jKHAuiNMn4FszGyEce92IPD
 V0GzCUces+2MQXUVQ1VLRtvAebjjKyGlOly2Zq//qV93cldqEIUg9rY9zOMEsFg4eLf2RnYpi
 UeEveYVX5WKn5EUwZeQ+o/GZX3p4k95B+bcOAKKc7cZBt+ppwEdw1dYzhm5stzqzbtKCEswJ9
 2rYV4pojmwUZ1SFbXfDHPcE8j7D9ycJgNRKAR2EHoiPfEkfKtCZmTcaGTnfKyWokWmbu1tgVr
 vYBRpZGcGPbRT79OvxofvMXiQ67WjrKIeswGGj9tuBOqwn0WOUWBhNojRp3HWcbW9wONJlBsl
 TedjrK72v7eUzzSe5hDQk0bBaVv2W3PDAlBHOTljKt6pEgnQ8wicThuSaGmSY+KN9XPvUs3pd
 jgxSqTa5fGCNUa6kJGJbktK7SA4Jc30PhsMXgwQ+UciKNu2zOCNIoiZRSz64aKzLFSbv+sBIM
 +B/TgL6fz9bYLE0omJANbq3V4NnoI3kBFhbUXp2BM2vKVykzv73BRkS+hJgrAtKZL5Jek43R7
 2BRofo5J1/rL+iiXpy/2Nq5jwmtxHsyNNWOd9/xubuXGUfDxKpjjBinzjeVylWfMEAU3hXtOY
 y+D7u4CGFRlb5IWV4BTll4gO0Il1u9wT0wHKyVnGpuqg5c6Khg7cAQdUH0zWXcNb9YxyU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1833179219-1566831549=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ren=C3=A9,

On Sun, 25 Aug 2019, Ren=C3=A9 Scharfe wrote:

> Append the strbuf buffer only after detaching it.  There is no practical
> difference here, as the strbuf is not empty and no strbuf_ function is
> called between storing the pointer to the still attached buffer and
> calling strbuf_detach(), so that pointer is valid, but make sure to
> follow the standard sequence anyway for consistency.

ACK!

Thanks,
Dscho

>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  builtin/grep.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 2699001fbd..69ac053acc 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -1110,8 +1110,8 @@ int cmd_grep(int argc, const char **argv, const ch=
ar *prefix)
>  			strbuf_addf(&buf, "+/%s%s",
>  					strcmp("less", pager) ? "" : "*",
>  					opt.pattern_list->pattern);
> -			string_list_append(&path_list, buf.buf);
> -			strbuf_detach(&buf, NULL);
> +			string_list_append(&path_list,
> +					   strbuf_detach(&buf, NULL));
>  		}
>  	}
>
> --
> 2.23.0
>

--8323328-1833179219-1566831549=:46--
