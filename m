Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 425831F406
	for <e@80x24.org>; Thu, 21 Dec 2017 07:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750871AbdLUHWr convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 21 Dec 2017 02:22:47 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:52780 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750782AbdLUHWq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Dec 2017 02:22:46 -0500
Received: from mail.cetitecgmbh.com ([37.123.123.67]) by
 mrelayeu.kundenserver.de (mreue001 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0LaOJ5-1eqVoo3kbP-00mIjB; Thu, 21 Dec 2017 08:22:13 +0100
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id D0CB464A285;
        Thu, 21 Dec 2017 07:22:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PEMSToNpDOVp; Thu, 21 Dec 2017 08:22:09 +0100 (CET)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
        by mail.cetitecgmbh.com (Postfix) with ESMTPS id DAE6964853B;
        Thu, 21 Dec 2017 08:22:09 +0100 (CET)
Received: from pflmari.corp.cetitec.com (10.8.0.2) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.847.32; Thu, 21 Dec 2017 08:22:09 +0100
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)       id
 00407804D2; Thu, 21 Dec 2017 08:22:07 +0100 (CET)
Date:   Thu, 21 Dec 2017 08:22:07 +0100
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
CC:     <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Casey <drafnel@gmail.com>, Petr Baudis <pasky@ucw.cz>,
        Gerrit Pape <pape@smarden.org>,
        "martin f . krafft" <madduck@madduck.net>, Eric Wong <e@80x24.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        "Randall S . Becker" <rsbecker@nexbridge.com>,
        Michael J Gruber <git@grubix.eu>,
        Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v6] Makefile: replace perl/Makefile.PL with simple make
 rules
Message-ID: <20171221072207.4hdshon4ytgboonx@pflmari>
References: <20171220174147.GG3693@zaya.teonanacatl.net>
 <20171220182419.16865-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20171220182419.16865-1-avarab@gmail.com>
X-Originating-IP: [10.8.0.2]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
X-Antivirus: Avast (VPS 171220-2, 20.12.2017), Outbound message
X-Antivirus-Status: Clean
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K0:L+UWa2o/zrLAyCWnSFy7nmaySKvEQJsJUCXkylesOFqLF2aAP4e
 l7pitX+rK7+cJavRnbm4ncpyKcBiluc98WPMirtK7nzB+T2RXDk+LAmeguJGjPpoJsTeGdr
 yZxa96yPMWrIdMUG7yWxiaDmRYryxieiKTg61wVW0KFiJR72QOozcULFhUQjkVYLT9/d/1a
 kj7Ee5oVAH++JyBiz55wg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/2DzsjE63OI=:SAnWW3tf8NQcQRW+a30JlN
 3D5SUAjLVk43S/hUYFN2uNpz8ljc0Q8muvb8oncY71td7ql6Us3MP/SHmLlefi/lMQEN9xMbu
 6RTs4C0oluSUUNe7+KnOf3NQm6yhv3miqOIzchdWiuTwNqWdWyrD5LtxjeTkBFZJt8T5htIIx
 YolZyr3OZivG/ScNgfTvLr1N34xOzM5wJ7wxbr1BIMhgnPsZwqo3tS+emMwM3jY5P6YJAjUOY
 W9nQmmWkANwKg8uBuYQq+nDQER1XNX51DgHhnakrLImrtb5Nd5j44m/rJSwCSLCdZe8CMuzQ8
 McaEeLVlgtZMjuTXrTh5VUtuYdPEnmfUUPJZsBNKyU3RRWXNooNyUqdEsWePz9oTZP/AweQgl
 nhE79Sb0RYwgqgogA7knJVEEFCpqiRHspKs4BrXHZzUU2bz4EKWQFivuff80C0Ex2f1O0/WiS
 4Adz+qv8W58gcEouYIwlknwAxtnQ69hTgga2JuKLs7a8Gwbvl5JWUjAGO4WSUpQVErSP4ju5F
 Up8KfMG/S32lU+KcQN5c2j3ZOL2P59Vw/cWF21gbACchOKHyEuk6GxQd8ZiZiHA72J6Ms+iv9
 pDQRd/NIkOSUiUuPAU8kQrC+Wq84R+EJeg1BDVMRI/YgDoyeTyPdd6VQp0YIBfJ+ddTfsF5su
 lcXTpATN1vOlwDwkiKj5wtNQ4zKQYEMUMIveu+nVLGBGC3fuqhR3RYe1uAJ3uBETzv7tm7DLM
 QpR4oiv9ro83jkxe1qnQWdL8H+lDOfyBYmrQIQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason, Wed, Dec 20, 2017 19:24:19 +0100:
> diff --git a/INSTALL b/INSTALL
> index ffb071e9f0..808e07b659 100644
> --- a/INSTALL
> +++ b/INSTALL
> @@ -84,9 +84,24 @@ Issues of note:
>  
>  	GIT_EXEC_PATH=`pwd`
>  	PATH=`pwd`:$PATH
> -	GITPERLLIB=`pwd`/perl/blib/lib
> +	GITPERLLIB=`pwd`/perl/build/lib
>  	export GIT_EXEC_PATH PATH GITPERLLIB

Sincerely sorry for off-topic, I just wonder why this section of INSTALL
uses the backticks for command substitution. Is there a shell which does not
support the alternative form $(...) but has all the rest of the used syntax?


---
Diese E-Mail wurde von Avast Antivirus-Software auf Viren geprüft.
https://www.avast.com/antivirus

