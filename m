Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CB4320248
	for <e@80x24.org>; Wed, 17 Apr 2019 12:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731594AbfDQMwQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 08:52:16 -0400
Received: from mout.gmx.net ([212.227.15.19]:51291 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727034AbfDQMwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 08:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555505531;
        bh=+46ZZBXWL2mhLE5z0x8sx4PhaA7RqwteH+r28qFd8pQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Z5ZFxIE3aLdeQaFNqQ5RjcKTeUmZGbhDAsBEJm9ZCmxyMYgQzzg3yk20+nV+IqKRg
         isVUQucfglPC3GT6xnUEGVUkSTvrdj2W+BRoOk4arM0Js+/W7r/nsXZvP66zlswWJC
         ohKddy49bZyu7gM+5kUEHHeSKusty1zgn8xRc7dM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LkgAG-1ggaPn2ivM-00aVJp; Wed, 17
 Apr 2019 14:52:11 +0200
Date:   Wed, 17 Apr 2019 14:52:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: ab/test-lib-pass-trace2-env, was Re: What's cooking in git.git (Apr
 2019, #03; Tue, 16)
In-Reply-To: <xmqqef62ozny.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1904171451480.46@tvgsbejvaqbjf.bet>
References: <xmqqef62ozny.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:N2VGpnd0XJDu1PqGpUkcHoAWbhs3/8MIMLYvRYSXkuEsZSuS/ow
 KL+vSek1Z8TFHVEDhhubeMSQAY3a2/CFvwdzX4snYkuwpt87J9Gq/XVKnUSD5GRb6o5EV5T
 05SnNLvAXPozFkg6TX6w1kpRxhobBIAOFtghpiSA4JfM9gOasi+DPyFC9aNyVdZ556UsgUt
 TiIuM+0cKEbQnHOxaP1YQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hYcD8fjWb2I=:3vUpuAWbPdCCa8Fhliz68r
 Ws7ZwG3/MxB/0caKeMMPiUM5nImxTVsbIY3lp9YrAktu2Quhl20yFAMywNhrvXoJqFsRgRUoB
 h47TH+uIDlGl3FxAg/DD+Yj5mAd5sOU3MDMIYYeqf9PHtDKFlnWj0f+hGCLD2j+ptI87/mprp
 nmLubF4gJ7cOpbDIkHFRbDQFBktRXpptLfMEU3y8wTYuWCEmjqiTuCn2PXTpuAInLntgncOiR
 Qc603OToXKektyFiqlqKmOiI67jFiOgZjTjk2o4GWuCnfRVQGNxFGfWqr0ghzQ9UeB6nFNCrf
 JIW+MsBvpVqCOae3/UHr2I4td6CaxN410YFSW9jNLQp8HGNsQwJjPW6Jvg9BXUSFPhxZmgTBE
 gw4eEynT/XjrqiugKOwAUgrwSExwy2yb3hhCqyfT0zj+zML9y8c6+wuTMyfFuqoqtUr8GDACc
 9oSKI5g0VPzZ4vwG9u6/g/Gwld0/8lzla+Qy/wNFq2Dv7e1N5/s4tW4DeZUYGUs0o21jccWDI
 cjjjrzKG4LEc+npQLecOitv5FCbM9II84lKFi6IrBTKFxqn1VBMIkFT/COtTZhM399fIN+dts
 SG11V5dSCWGy2eq7ecUziTfwmcUcVV25BLkJzbkp0NOCf1oj1QWGtIHAEvXh3fKCwfkkf6hL8
 duiPMrcxW3QECmuhDUKe27OSaOSzZItA0WUFE+FdvKC3jPe/HKOBgfAv860rk0wizpiTVOagk
 K0S8h5jz13K76zZRUM6Qjn1Ia+4yGaDCZMSmiCf5cRGa8fvu2Zb8wqAzcWWV8ldBN2cBTvBGc
 GZj/1vBQtRirRog/HNvcE7qqsgrBNMeSs8TK0VafQePysS7enwxxHQchvYcR5c47Uv6lx0w4z
 QUXuV8wSkRCpLcnsqG30MDRtqFzDibUb78xLzkmVlI6I2Q1SEz3xmClm02nNVxichAoxikPao
 bLmi7uyTRBw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 16 Apr 2019, Junio C Hamano wrote:

> * ab/test-lib-pass-trace2-env (2019-04-01) 1 commit
>   (merged to 'next' on 2019-04-16 at 4dad6d6d7a)
>  + test-lib: whitelist GIT_TR2_* in the environment
>
>  Allow tracing of Git executable while running out tests.

Did you mean "our" instead of "out"?

Ciao,
Dscho
