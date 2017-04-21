Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CA78207BC
	for <e@80x24.org>; Fri, 21 Apr 2017 17:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161919AbdDUQnl (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 12:43:41 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:61547 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161901AbdDUQn3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 12:43:29 -0400
Received: from skimbleshanks.math.uni-hannover.de ([130.75.46.4]) by
 mrelayeu.kundenserver.de (mreue003 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0MaFzQ-1chq2709TU-00Ju5v; Fri, 21 Apr 2017 16:47:15 +0200
Subject: Re: [BUG] test suite broken with GETTEXT_POISON=YesPlease
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <CACBZZX62+acvi1dpkknadTL827mtCm_QesGSZ=6+UnyeMpg8+Q@mail.gmail.com>
From:   Michael J Gruber <git@grubix.eu>
Message-ID: <e7aed763-cf46-4d7e-1b11-0a7a65b8f496@grubix.eu>
Date:   Fri, 21 Apr 2017 16:47:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.0
MIME-Version: 1.0
In-Reply-To: <CACBZZX62+acvi1dpkknadTL827mtCm_QesGSZ=6+UnyeMpg8+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:CgqtL4cT1fCDWxPqSI4cS2nJWXICdLMtTJy867Ssnu8IUKJuGIC
 s8JxG+9Ggksshwxhrxs5PSt4S8t6UKutensbmqG2e5drvadamcfW+LPB84ILAq6pBU6dIun
 8QbdyG00VX2FB842EqoZA+6uqAIM0P0yEfWyBDdP6YCDiLJDA5km0i1bhTVm0tSwPEvjl/H
 7G3jHrcNZKSvEWZxtOaTg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/jLJBULGh+I=:+fJHFredfRO5ISmOxY+5Tw
 QYJ6h6++b6OBJ11C3cxxEsK87ELAKZk8K6eMN9aOOe5wKurGaS4xBc6WYa4AH4yMPCfXEgIwt
 a2FujrYID7yGW89QzKe9ChAR/Olz2bL10XPxHLLhKWytIdeg9TFaHmcOBPjreUmGi1tVQ/Vgp
 YUgbKK9aAj8alZqyJOZwGIm9140iqBN8ZU9EAkj27QnUJV4fvM11rC5/9gQVCipZu+vGjQplg
 VoxqSFyiu3ZCmqPoSMmuXvkGRba85EoySDazUpeoXuHoySTFyx03nCn3TiKB80BEZfNqVUhSC
 nCwQweZM6A2WtzrDCq9nn3qZRr+TnRWWtyNpwtvf34o5x5WbNgmAhuk6qoKkUIqcqY82MCJnQ
 70nuhu1Lul9oy2TzN/ZkTfjDn9ibiqZUoNH14o6zlazD9gx7oAYrqr5PEBEyIpZ4pbacHy/er
 1G+GHtxybym8nGx++wbD6B58yy6jKzny87LptKGXuriSmEXkpIFZlU/Ue/s5qf7WmCCT4kRRG
 /5EM93OVNS24dd99mtS4CmmrjZMl11bmZ+9j9QcAGpWbECRxkzBAe1ZJBtrLOaNRKyQfRLICi
 09lHSdhrT1LI8XoHfphv52QHO7/uzdS2qOxyvBKTJIRRgUyusIWQQzsWkDU/eSQb/aVc7gfWg
 Jerv5t5Ql4albwxCIeDcPkbj8xyqBITTU3vYxINAxlnop7I6kAjhPqoIV2o/6N9wqMOnEU0GJ
 ooD3g7A8e7LQ9pwV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason venit, vidit, dixit 20.04.2017 23:58:
> As a refresh of everyone's memory (because mine needed it). This is a
> feature I added back in 2011 when the i18n support was initially
> added.
> 
> There was concern at the time that we would inadvertently mark
> plumbing messages for translation, particularly something in a shared
> code path, and this was a way to hopefully smoke out those issues with
> the test suite.
> 
> However compiling with it breaks a couple of dozen tests, I stopped
> digging when I saw some broke back in 2014.
> 
> What should be done about this? I think if we're going to keep them
> they need to be run regularly by something like Travis (Lars CC'd),
> however empirical evidence suggests that not running them is just fine
> too, so should we just remove support for this test mode?
> 
> I don't care, but I can come up with the patch either way, but would
> only be motivated to write the one-time fix for it if some CI system
> is actually running them regularly, otherwise they'll just be subject
> to bitrotting again.
> 

I use that switch when I change something that involves l10n, but
usually I run specific tests only. To be honest: I have to make sure not
to get confused by (nor forget one of) the build flag GETTEXT_POISON and
the environment variable GIT_GETTEXT_POISON. I'm not sure I always
tested what I meant to test...

Michael
