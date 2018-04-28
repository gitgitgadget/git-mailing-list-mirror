Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CA981F428
	for <e@80x24.org>; Sat, 28 Apr 2018 13:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933502AbeD1NNu (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 09:13:50 -0400
Received: from mout.gmx.net ([212.227.17.20]:48047 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933450AbeD1NNt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 09:13:49 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MS5jy-1eofUr05xC-00TE2Q; Sat, 28
 Apr 2018 15:13:43 +0200
Date:   Sat, 28 Apr 2018 15:13:37 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Philip Oakley <philipoakley@iee.org>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v6 11/11] Remove obsolete script to convert grafts to
 replace refs
In-Reply-To: <A37AE6B64CF7414ABE41697663B2BEC4@PhilipOakley>
Message-ID: <nycvar.QRO.7.76.6.1804281513140.79@tvgsbejvaqbjf.bet>
References: <cover.1524650028.git.johannes.schindelin@gmx.de> <cover.1524865158.git.johannes.schindelin@gmx.de> <b321979f88589e7b006466159c470800db948d66.1524865158.git.johannes.schindelin@gmx.de> <A37AE6B64CF7414ABE41697663B2BEC4@PhilipOakley>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:x2+xPPAwftgDXZ14oULAEIsbSQ6Yx8g4mDukqcdm++BO8hAYN8F
 8prI9qscYN/bm882wdpNy0EPeeLHZtfhENM664vt2r4kYLm42OqMY89B/P6FtOioonsKA9t
 pY40qd/xt2z4gzlZlRFbPCJ6GGgOO55xUZMND/qyX602JE5xhYfQfTr3G/GiwrRsXa6u1Go
 cWNlFFakXuNklpS2vQyVA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UtXb+muQKiI=:uIB6V7uRTPN8aEf206aRwn
 QId/d53JCI8WLxJd/lp0ZsLQFI8HbdwScnyfBbG1j9y81sgiKZABtjoFpS0WzUXtnIJRShT2L
 ZvUgdD0HBGV599+7JdMor2CCeBz3GvG1JgaMJXF20jE5eA7eIOIucVz253vu3ObO4shfPs7v6
 CptDzi1O8aZKakwcVTg2cZnti7OeylpXxICQqz1ch6TzNNmgFVRAPPP3wgcmbqKAoSK23MCJ5
 2yt67/rZE5zS7yK1RFcJpLd0wfqMTrCKAh8jBS8fMrOhP9RPfZlyQBh7zc18fEZaoVwrqZpp4
 /6+AsrCBsbiDAQbxD5xygZ0L7+9W4jENrmZ8ljazDHXF4WcDXTfCWvYil9T1bIvB+eZ8BNh+R
 62t5hBh2Sz5zfqr/FprRFCdh+UL/yhJhNXypp+K9DqE66o/7TPm56rawgAJs4HgzKqxWN7yVq
 UrZQYj8kBViZ9Y6DGCquDdCPEJ7NFDvqM+go++ReuuLNIHeyWr55yhbL6TU0++6117i8YPqnk
 dNqCtYdnre2ZBZyF/3H10cO77NFc8ZScv6jfu6ReHlHuIM1h1NcZgy021JB8sTgxUybPJlXot
 J4duIMoSjrsN1lifC+EV63CKTY1jcJTohOvxmZCW3107jqWB01hM4bmG8qZcFQRQo+megaXx+
 esG6Yn+T1lOw9bclKYIHTaMKNEdocf3MnRAMHlH3pFhbZbKIwp5QUpHBw/NFSILjbjl4q2op/
 1TqECxP2FPydgrqT25mchpKtB3p9VE9iUTUZ9xmd3wMgQehSDDn+/XANRlnHS54XOce1InxzQ
 EGE7vwC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Sat, 28 Apr 2018, Philip Oakley wrote:

> From: "Johannes Schindelin" <johannes.schindelin@gmx.de>
> > The functionality is now implemented as `git replace
> > --convert-graft-file`.
> 
> A rather late in the day thought: Should this go through the same
> deprecation dance?
> 
> I.e. replace the body of the script with the new `git
> replace --convert-graft-file` and echo (or die!) a warning message that this
> script is now deprecated and will be removed?
> 
> At least it will catch those who arrive via random web advice!

Originally, I did not even want to remove it... I just did as I was told
by Junio...

Ciao,
Dscho
