Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5E981F404
	for <e@80x24.org>; Wed, 25 Apr 2018 07:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751167AbeDYH0F (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 03:26:05 -0400
Received: from mout.gmx.net ([212.227.17.20]:58901 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750882AbeDYH0E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 03:26:04 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LnxVE-1eimkx3tWK-00g0cD; Wed, 25
 Apr 2018 09:26:00 +0200
Date:   Wed, 25 Apr 2018 09:25:58 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH v3] Make running git under other debugger-like programs
 easy
In-Reply-To: <20180424234645.8735-1-newren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804250923280.4978@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1804101023100.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <20180424234645.8735-1-newren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mDyGUpJYg63Fp2z2bO1vk5aSlJx6NUSfXDsiH9I/fw3Vm025TJC
 BCEvBAlbaXyS7Saluz/8mEbQC7jZyDP3kH/QzS2eWNM1EKf8RYiXIIdjsyzp9/zGqqSptT/
 Oiw5rJ+3SO8ZxBn0R5lOzKDQrykmAHiQNW2p53Yes4aC+ZnPrMH9uyWopS0qrrxrBgJ4b1d
 MbMP9/8KCNi58m4uBXEJg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dYyAnVSuOwI=:VP0vYBJ7b/vspoCaQzYUB1
 zX6rkhBokSnVNj9BBSB9CXkcJIYQTfsfBeGBBEfvr5pa3r0Zy8755TG/bs2jnF2r6RrFXRGD1
 wOZYpszSKJeNM8GKtYaL8CJM5lGqG/wHOOgCozXyvA0eUr/d1tQkyQeXbFFysxPUgGgDiluLj
 UAVqwth3p8z2kI7MUZAnJN2nEG/3BPnGDd6eY/UDFKN2gj2SUJbkhsagPDitP10Q9lXYq/EiF
 UP6yu0EHrAp+piwyL0tvCxScP1gpxkU0IeqHKQC5bznIJx19wCMwY/1paeRRBttR0qUFb2jPD
 EtIi/ftJ68AYKELfrvagZUUdlF/kZ5U6lGGRiKHXtrK9jNlGIHxBZLbsIuV6ujiVYFZdI2q9D
 7OgtX5Uqr1qdwVThVqoQ8ol40/ZZN7v98RYbsxQk3minpWQ++mLxNjhAodWPeaJ/nC0UoEqK8
 JziXbsmdXj3vEI6NQKsuP1rsPg38zXB8SBZrF6alDz3tCMP5dONGWRvKNDGOsqH5IecSbEk5U
 45oGkBlXmhMPabgS2IPscBHl6QJz6lBoKexCT7r6TcctGQrn8kO2PSuQKQFEVH4ZiRyRAJBUZ
 kCnoXowCSfFfSBo7KWqi6qWFzlreaTooul6rnvGmYRmVMME4vX+K3QjPfwyMp+bcRZRuOdl0p
 fXi4rQpPE8xDI7jxIdiaBIFe3ll7L1tESwJH27QKAJ6q4t4W/dR5s8t75s2tuvTrCffhAnbOX
 TUyhv4G15hljkRqjrW1LWmV7YZh41A5539whCXPAv32hyS5nE/w9AhJ+zxMnz0IRkwEyl01pk
 5dA1yBHgAt/Gr9K9xtxhWOXe8L89CSJnVxzdpqhKkqRZmcYwSs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Tue, 24 Apr 2018, Elijah Newren wrote:

> This allows us to run git, when using the script from bin-wrappers, under
> other programs.  A few examples for usage within testsuite scripts:
> 
>    debug git checkout master
>    debug --debugger=nemiver git $ARGS
>    debug -d "valgrind --tool-memcheck --track-origins=yes" git $ARGS
> 
> Or, if someone has bin-wrappers/ in their $PATH and is executing git
> outside the testsuite:
> 
>    GIT_DEBUGGER="gdb --args" git $ARGS
>    GIT_DEBUGGER=nemiver git $ARGS
>    GIT_DEBUGGER="valgrind --tool=memcheck --track-origins=yes" git $ARGS
> 
> There is also a handy shortcut of GIT_DEBUGGER=1 meaning the same as
> GIT_DEBUGGER="gdb --args"
> 
> Original-patch-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Elijah Newren <newren@gmail.com>

Looks good to me!
Dscho
