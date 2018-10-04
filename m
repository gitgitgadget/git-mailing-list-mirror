Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 392841F453
	for <e@80x24.org>; Thu,  4 Oct 2018 14:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbeJDVTs (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 17:19:48 -0400
Received: from mout.gmx.net ([212.227.17.20]:60753 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727322AbeJDVTs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 17:19:48 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LeiJ8-1fMMEy3VHy-00qRRM; Thu, 04
 Oct 2018 16:26:14 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LeiJ8-1fMMEy3VHy-00qRRM; Thu, 04
 Oct 2018 16:26:14 +0200
Date:   Thu, 4 Oct 2018 16:26:19 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ananya Krishna Maram <ananyakittu1997@gmail.com>
cc:     christian.couder@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH] [Outreachy] git/userdiff.c fix regex pattern error
In-Reply-To: <20181004113015.GA30901@manohar-ssh>
Message-ID: <nycvar.QRO.7.76.6.1810041624290.73@tvgsbejvaqbjf.bet>
References: <20181004113015.GA30901@manohar-ssh>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Zbj8WYOgrHdp/THM7rfg6YbAlkFxGrI5RJRi7CxmT/y/O1bWMsd
 3znQfiTGtVoNkzK1PcFPkC4E3hgs9XiZ3ZI+/7wi6rECFMNeyMgNiALNZOZS0Qf7TrGv3hZ
 uWzbv6YKHDgJ9OBI9qmCMG48x+8l2gvACL1NhxbHrxVJTtPVHJHIWbwo1F9Y6n7RwDb28qN
 8kdvNU+jAV5EAL6L1/xcQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xw4u0Z+zsTw=:bsO6+t7qD0GJLUSedml3C+
 tovmRWGFa7lA9wZQ01WzOcUCILJf+9085odvjyC5VzGXPyOH6U3CVN3VM7sCJQs5ecbTb+7ND
 0RxIoziIHAjOV1Gjn1TU0utvp2rPoRCaDimAwnqLNwVfsyYdexvJJ2JwSrv5s29n/tyfVCGQo
 OeIqoJS4o4ObIkIYsVOKahG4O1Yoj0ubymi5+vdoyjeXkd2dDJmDBYE9p1HrSx8dIS5dmqXLK
 7OWzeIn7jp4fFEEptHZjYObYoxasgTH+9eXzZoRxwnC31D7TLrlgaLAgZVQvp1u2Cn0FUlY3p
 eyswFtjTvAGoTY60FLpaPjgY+UGvaWu77RoxMpWbmVcisQljfZaUhEMrBxtYyUCahldvYe9V+
 Ka0HqKlLXoJn2ZEwPTjecYxOwTkdz5ZWER19MixSBs0ns6utZ4VzSgCIrHMp/2nenFGEUMQpG
 uDtJtOwCH8FI/8s+jaJJcsDHwq8iRfqJpjrhQkWR9WEsAeRc2rOiNTEtgwe0zQdlR1MPp8kZu
 qgVtxCOTP3jVJ8jqMl0bE/bXEXlSUJdZla9TU1eDVwLkL72gDNOWHB4rxh5ROraFo5q9mbi2r
 hBHCDkw1CSqONa4kmBqmH85uYq38SeWJbOhRuo7VWZIl/Gp0K2aeZu75KOPholgH15/YWdUWv
 OltZqbsxMcvdy+2bdFYi+7ZC5DJA0L4DasQXoL3oc17jmSVFV2G7c9lNUHB6WawGEvw8hqLwD
 b+l1MNjfE8SnPp9i/JWeRfDMy/uNGxkE4pJqeKEm7DgcfBtadCWEWmU7kqRG21I2s+Lr+hstG
 HxLlXYda2QZtlmUM6cUdZPdWrQWeKQWG/kVexdYRHQG4xfrjsE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ananya,

thank you for taking the time to write this patch!

On Thu, 4 Oct 2018, Ananya Krishna Maram wrote:

> the forward slash character should be escaped with backslash. Fix
> Unescaped forward slash error in Python regex statements.
> 
> Signed-off-by: Ananya Krishna Maram<ananyakittu1997@gmail.com>

That explains pretty well what you did, but I wonder why the forward slash
needs to be escaped? I would understand if we enclosed the pattern in
`/<regex>/`, as it is done e.g. in Javascript, but we do not...

Thanks,
Johannes

> ---
>  userdiff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/userdiff.c b/userdiff.c
> index f565f6731..f4ff9b9e5 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -123,7 +123,7 @@ PATTERNS("python", "^[ \t]*((class|def)[ \t].*)$",
>  	 /* -- */
>  	 "[a-zA-Z_][a-zA-Z0-9_]*"
>  	 "|[-+0-9.e]+[jJlL]?|0[xX]?[0-9a-fA-F]+[lL]?"
> -	 "|[-+*/<>%&^|=!]=|//=?|<<=?|>>=?|\\*\\*=?"),
> +	 "|[-+*\/<>%&^|=!]=|\/\/=?|<<=?|>>=?|\\*\\*=?"),
>  	 /* -- */
>  PATTERNS("ruby", "^[ \t]*((class|module|def)[ \t].*)$",
>  	 /* -- */
> -- 
> 2.17.1
> 
> 
