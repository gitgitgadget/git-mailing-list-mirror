Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B90C31F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 13:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbeK1ACK (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 19:02:10 -0500
Received: from mout.gmx.net ([212.227.17.21]:60769 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729756AbeK1ACK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 19:02:10 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MOOJl-1gLsP61xg5-005mfN; Tue, 27
 Nov 2018 14:04:17 +0100
Date:   Tue, 27 Nov 2018 14:04:01 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git-for-windows@googlegroups.com
cc:     git@vger.kernel.org
Subject: Git for Windows v2.19.2 demoted to "pre-release"
Message-ID: <nycvar.QRO.7.76.6.1811271402080.41@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UZOXFcmLS84WbhzPY2BMKyL3OogPrWbcqFVD3xb7DL3FrOyDGCB
 2m0aBe5XXQ/UqMU/BeNoPMRZ727eaCBiyUZxu5FHwszGynO5b344zCxl3MmauIF+rIA9CMv
 pOqwqQAJStL/bYyx88FUGKTGDSQHubHP1IM3MmrxC1gAl77wC1zQi1Ji8tlt4eAb2h5Sfh7
 dBcD6++QCPv8+Ql89QDow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G26tKEzL7bk=:pgTSWjOgkr6xQiTQlVMRi5
 CM4GTxLBuUt0Vcc0K6P4aV2YZV3upX//O4PJTCBJj8sImCvlgPr9NfFi7o/H5I5md7RTkHINS
 JukLXtxdTIsMH0xZI01AZCeUCF4//ikY5dTKegRrQGg3JNNcY2l+fz5Q+Dqh+6V8054nvv1pd
 oE6hW1fTkelz38UomjsMiTtKJSoV8ay0GqGJstFn3KS9x8ee5oADNVuCiddRfAza/m5cA74Al
 T68pPcKLAiaUUKwJzHaLAhHRrP7x4xNfNb/z7PcTYOkXaV3mL1DFm/RXmZLbvO2bXpd9jAz9i
 vjIci07af9DF66A2/KnhV0KzM/Gjng/B09JzzscVkWyXxoasnIGw7T7rTLmyUwPjEo8W8yfQz
 dbh0adSW+YhydjO49mtmmMBcst5Wik7yH7SKySIPVmQ9k/AIEbzxmsW5wS04r5dP8nukH6Wyr
 lYqahLFvqN5clwJZp/sfaUdH1McvJE6rRgb96fzmQ/v/tTMDppk1At1qjZ5j/0tGq5oT0u50l
 tm5rTQbDKXDyzmpsyl2BPfuSUe3T+u2KeuA1Y6R1eOyfoTL+xO8odPr+eHqkowijE3coWgAGJ
 O51O0OgPb5Su91z7Z1tq/N/XBGr6ItZSzS1vHOfgMIH8y4ODkFgIIbV7GMjvJriiMNZw0ebT8
 P7RIp9weM8mwHAP18QkJAO5xTnPbzGG8XeNFTgxjWejWJprdODLlWnXz4wK/iB4x/BT44q4iS
 cdTIMmGg548YDY501EnvTaHjGlPmuuDviPy4RnTUp5+x2gy23McD6uFUi6uAUEB4kV+OU/FrS
 cvXxkTH+2N65BwdOuiuNymd4YG9L4u4N+OLaG85th2pm/weSxAuXPJdnrIyvj2JZD8Gg8aqZx
 jPGJTn9petoioXpl9kNkFfMEEbGbVKzE48qAK9BkZrzMiIeuMKy5c4r+a0h9GU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Team,

sorry for the inconvenience, but I had to "pull" Git for Windows v2.19.2
because of two major bugs: 32-bit Git Bash simply failed to start, and all
operations using git:// URLs were broken.

This close to v2.20.0, I was uncomfortable pushing yet another upgrade to
users that would have been made obsolete a mere week from now.

I apologize for the trouble,
Johannes

