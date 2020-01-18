Return-Path: <SRS0=dClv=3H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5C6C33CB1
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 17:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68543246A6
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 17:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgARRLv convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 18 Jan 2020 12:11:51 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:6390 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbgARRLv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jan 2020 12:11:51 -0500
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:33e:2802:50eb:d77d])
        by smtp2-g21.free.fr (Postfix) with ESMTP id 633CE2003F2;
        Sat, 18 Jan 2020 18:11:47 +0100 (CET)
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] po/fr.po: various typofixes
Date:   Sat, 18 Jan 2020 18:11:43 +0100
Message-ID: <2398105.z8pcppHtcz@cayenne>
In-Reply-To: <20200118135913.1845-1-alban.gruin@gmail.com>
References: <20200118135913.1845-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Saturday, 18 January 2020 14:59:13 CET Alban Gruin wrote:
> "commande" and "récupération" are feminin nouns in French, but here
> their definite article is "le", which is the article of masculine nouns;
> the correct article is "la".
> 
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>  po/fr.po | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/po/fr.po b/po/fr.po
> index 3ff44e57af..776c58e56d 100644
> --- a/po/fr.po
> +++ b/po/fr.po
> @@ -3556,7 +3556,7 @@ msgstr ""
>  msgid ""
>  "you may want to set your %s variable to at least %d and retry the command."
>  msgstr ""
> -"vous souhaitez peut-être régler la variable %s à au moins %d et réessayer le "
> +"vous souhaitez peut-être régler la variable %s à au moins %d et réessayer la "
>  "commande."
>  
>  #: dir.c:554
> @@ -3794,7 +3794,7 @@ msgstr "pas de commit commun"
>  
>  #: fetch-pack.c:1070 fetch-pack.c:1536
>  msgid "git fetch-pack: fetch failed."
> -msgstr "git fetch-pack : échec de le récupération."
> +msgstr "git fetch-pack : échec de la récupération."
>  
>  #: fetch-pack.c:1209
>  msgid "Server does not support shallow requests"
> 

Thank you.

Will propose a PR to git-l10n.

Jean-Noël



