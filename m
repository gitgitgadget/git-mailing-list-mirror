Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7016D1F89D
	for <e@80x24.org>; Sun, 23 Jul 2017 02:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752342AbdGWCoF (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Jul 2017 22:44:05 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:51656 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752080AbdGWCoE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jul 2017 22:44:04 -0400
Received: from [172.31.18.214] (unknown [103.90.76.125])
        (Authenticated sender: jn.avila)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 1A8B613F86A;
        Sun, 23 Jul 2017 04:43:18 +0200 (CEST)
Subject: Re: [L10N] Kickoff of translation for Git 2.14.0 round 1
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
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
        babycaseny <babycaseny@gmail.com>, johannes.schindelin@gmx.de
References: <CANYiYbET27mNrZZTNmn_dKBHLLEb4wJiznZ2O1X=WQ_GtamN7w@mail.gmail.com>
 <249ac6f8-af3c-4b20-5bf0-87a82866cc7a@free.fr>
 <1500742926.2744.4.camel@gmail.com>
Cc:     Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
Message-ID: <70aeede1-6052-94fb-71a5-ff2f5717098a@free.fr>
Date:   Sun, 23 Jul 2017 04:43:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1500742926.2744.4.camel@gmail.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Content-Language: fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 22/07/2017 à 19:02, Kaartic Sivaraam a écrit :
> On Sat, 2017-07-15 at 21:30 +0200, Jean-Noël Avila wrote:
>>  * commit 4ddb1354e8 ("status: contextually notify user about an initial
>> commit") plays sentence lego while introducing colorization which again
>> does not play well with i18n.
>>
> What, if anything, should be done about this?
>

I only spotted it because the string is new for translation. But the
previous version was already playing sentence lego. So this is not a
regression ;-)


If I understand correctly, getting a i18n friendly string would require
being able to "color_sprintf" the branche name, and then "color_fprintf"
the output with a %s formatting string. None of this is already
available and that would introduce cumbersome logic in the code.


More generally, i18n puts some pressure on coding style for sure, and it
gets worse with multi-platform and coloring... how can we ease the
burden of developpers on this front without resorting to ad hoc patches?

