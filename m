Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6729F1F404
	for <e@80x24.org>; Wed, 11 Apr 2018 20:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756528AbeDKUlU (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 16:41:20 -0400
Received: from mout.gmx.net ([212.227.15.15]:55435 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756141AbeDKUlS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 16:41:18 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MRFwV-1ettfO1N0R-00UahS; Wed, 11
 Apr 2018 22:41:09 +0200
Date:   Wed, 11 Apr 2018 22:40:51 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Sergey Organov <sorganov@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v6 00/15] rebase -i: offer to recreate commit topology
In-Reply-To: <87h8oh51jm.fsf@javad.com>
Message-ID: <nycvar.QRO.7.76.6.1804112233470.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1519680483.git.johannes.schindelin@gmx.de> <cover.1523362469.git.johannes.schindelin@gmx.de> <87tvsj6rn2.fsf@javad.com> <nycvar.QRO.7.76.6.1804110009080.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <871sfm737e.fsf@javad.com>
 <nycvar.QRO.7.76.6.1804111324350.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <87h8oh51jm.fsf@javad.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QTlvdwi3xiYCbvrxdifVxTwEWDy7MB4k0CfLIXissGZfNd3JLsO
 vdmuT4VXn6ojgNRbQ+vg1IVCMumxaFvVU8QFubTt27QlAt1Qyo8kCN7wGx9+wKGsgLuOK92
 mtHdEEi2891I0/bOzDr70UuxkRfEPNpz1R+hNUQaPAwLo28x9czWAYQmSueMZ5O4DaM8QFg
 JnS1z7z3TG5IE5CEa2Naw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jCFqRBczV+A=:uQd6C1UwpwTS/fAYYWhqng
 oZjYcqllRaRXhqrzLceSTbj05PB7oKso920EsE+79oC0lOJDW7Pusjm3aHOC+/5lUOvH9beh6
 MwHiDyfehcFfavcKdhczPJD7LxdqDgSgRcW3HLphSKoVCacVWBPcj9iKVPqq9/gkIavE1CB99
 spRpCKk5xl7guZRwLLilu1gmlBTrUlMuwaaDTHzVOjW4FlBqfXjvIHEsGRY2vFpmKC8ULzN6B
 8BxXNazIRIfMH9bKZ0wBJS1tRxcDmJdczYAz7gpI2lcVKdCbUuHJnad0Vh0XAulmN6vZ4Mh2X
 ztLzHZwkQJsBaWyyG3quGphQOEa6gyTY4Pw45vwLNi1g6wFx35LE4ZLfyeFceaY49UtbJKdZV
 cHppEtFEqiA7QqYo1QQ1Nqt23JL8Kjnl/ZMT5rIwRQLk74GpbgvbNSgxZKmfSjClCQHticWlc
 mbuPny18nWP+l5GLayS0RUVNBQfiKhnoDAybSK0TTZbKi/xujmfH/Tp9jgRfwcbBu9b7q3mDC
 QwpF3iDJ4uiOZFGrNcO1zo+VmeexKqNOelFbtZ6B4bjJIgk+RefCzqM4I2bgvhtBymQrQc3eX
 R7ezIAW8QNezFrdkJHqDOLA/uIrrTvVcwP+bus2XBX1rJi+vqd0U+DIBvLq45Q/SJQOwO33+L
 KThrOxOpjiDyaz6PW8fvjlTFo1yOitJQ0sdegyO5DWru9OPtAaiVBqPXYEkY8JxIcBfyTmvXL
 8ve8hj2BgwIq6C5hHK9CU39vxUpko98GMaU/eBRFrfP4gtheDcfXfVoXhKZRg+uybVdMM84Jw
 gKMix8SF+fesvKDdY9zYKVh09ND6YV8rwzuRXbuw1suOdDR+Ug=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On Wed, 11 Apr 2018, Sergey Organov wrote:

> The RFC v2 and Phillip's strategy are essentially the same, as has been
> already shown multiple times, both theoretically and by testing.

No, they are not.

I am really tired of repeating myself here, as I have demonstrated it at
length, at least half a dozen times, that they are *not* in practice the
same.

If you had played through the example as I suggested, you would actually
see where the differences are, and that your proposal is simply
impractical.

And you would see that Phillip's strategy is better, but I get the
impression that you want to avoid that insight at all cost.

Ciao,
Johannes


