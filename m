Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B04812082F
	for <e@80x24.org>; Sat, 15 Jul 2017 19:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751190AbdGOTa7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jul 2017 15:30:59 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:10336 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751170AbdGOTa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jul 2017 15:30:58 -0400
Received: from [10.219.8.130] (unknown [213.174.99.138])
        (Authenticated sender: jn.avila)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id 2DC215FE84;
        Sat, 15 Jul 2017 21:30:19 +0200 (CEST)
Subject: Re: [L10N] Kickoff of translation for Git 2.14.0 round 1
To:     Jiang Xin <worldhello.net@gmail.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOi?= =?UTF-8?Q?n?= 
        <vnwildman@gmail.com>, Nelson Martell <nelson6e65@gmail.com>,
        Brian Gesiak <modocache@gmail.com>, m4sk1n <m4sk1n@o2.pl>,
        Vitaly <vitaly.gorodetsky@gmail.com>,
        "Ying Ruei Liang (KK)" <thumbd03803@gmail.com>,
        babycaseny <babycaseny@gmail.com>, johannes.schindelin@gmx.de,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
References: <CANYiYbET27mNrZZTNmn_dKBHLLEb4wJiznZ2O1X=WQ_GtamN7w@mail.gmail.com>
Cc:     Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
Message-ID: <249ac6f8-af3c-4b20-5bf0-87a82866cc7a@free.fr>
Date:   Sat, 15 Jul 2017 21:30:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CANYiYbET27mNrZZTNmn_dKBHLLEb4wJiznZ2O1X=WQ_GtamN7w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 15/07/2017 à 07:06, Jiang Xin a écrit :
> Hi,
>
> Git v2.14.0-rc0 has been released, and it's time to start new round of git l10n.
> This time there are 30+ updated messages need to be translated since last
> update:
>
>     l10n: git.pot: v2.14.0 round 1 (34 new, 23 removed)
>
>     Generate po/git.pot from v2.14.0-rc0 for git v2.14.0 l10n round 1.
>
>     Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
>
> You can get it from the usual place:
>
>     https://github.com/git-l10n/git-po/
>
> As how to update your XX.po and help to translate Git, please see
> "Updating a XX.po file" and other sections in “po/README" file.
>
> --
> Jiang Xin
Hi all,


A few remarks on i18n:

 * commit cb71f8bdb5 ("PRItime: introduce a new "printf format" for
timestamps") does not play well with i18n framework. The static string
concatenation cannot be correctly interpreted by msgmerge. I don't know
how we can combine variable format indicators with translatable strings.

 * commit 4ddb1354e8 ("status: contextually notify user about an initial
commit") plays sentence lego while introducing colorization which again
does not play well with i18n.


Thank you.

