Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3FCA1F461
	for <e@80x24.org>; Wed, 26 Jun 2019 14:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfFZOFi (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 10:05:38 -0400
Received: from mout.gmx.net ([212.227.17.20]:50413 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfFZOFh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 10:05:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561557921;
        bh=mYtSLJ5yFaigFXcC4wVdGe1J7xbbO6aRDQ8xbeBF4Mw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bDfoVrDJ2Ba2poaxq6hvcC2m/uiyqGsGdwTF8qDUUFZJgPUHNUppYlshIYlFMuJqm
         OMrs63xxEQJffsAnc7gEKXrccMK0+Z3i0cO2Vt8FetsEgwHHGVq1hNXxI0Lx93b+Px
         FyZKKpaeZ8LiaNn02XUYJpnGEghj7643unjL8cm8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxUnp-1iUV5M11ab-00xtVk; Wed, 26
 Jun 2019 16:05:21 +0200
Date:   Wed, 26 Jun 2019 16:05:41 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, git-packagers@googlegroups.com,
        gitgitgadget@gmail.com, gitster@pobox.com, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com
Subject: Re: [RFC/PATCH 2/7] grep tests: move "grep binary" alongside the
 rest
In-Reply-To: <20190626000329.32475-3-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906261603380.44@tvgsbejvaqbjf.bet>
References: <87r27u8pie.fsf@evledraar.gmail.com> <20190626000329.32475-3-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1144635054-1561557942=:44"
X-Provags-ID: V03:K1:W0yefpB9bCCA1lxmx3EvoQGt3QxVnVZuTh5CfZ++8m8ra5x2M8d
 5mQYNIFWmw6MEAM6okzSCcTSSnMW/ztaWEVO6MCZ7+e29afDmgC8FSsFteps/3hQchIUTue
 zg7NmGBK67jkJaTV44MuUfypxQ5F4LECN0/YpxJtExfBZVsZRGrEmMdHk5nAYM04AEz515n
 50dlcJ7blKrcco1hIg85Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Zzol7DIJOGo=:QjJVBmddE7HswW5aAMOcUJ
 fWp3RmB57hw5hVLXuc2AnEG/gFCFZgALkfrcXR67f6+yLIomNkXE89Ejosn7rIbxJeDSegV6X
 dkMXWG8xhiMHh854AHu5KnsnuS0rDl+MhpVSfIBkLiB0OLo1Md2BSLKzW9RinpvXo9eFxZ6CM
 wlwCCtYpAZzF3zUOxVXM1Yx32wWFILTm3+T5+442e/cVXrjvym+ByYtgvs3RQrOClHHIDEtmB
 eWe0E6HOsM9B8vqanI8o2D3vouPA7AAcu2mDL8Dwd+9v4x15Q1fnbkUSlqSiFpkRSccfGMor4
 Qp5X2iiR8wj8LZM8nl4duqBJlwYlbhYveGCSB6tGVZbVbS25XUj2XfxkZR+dx65kvAm8MjV4j
 mBNPwkoofananIohDyigb4Ddbs1CHvoGMUpEi/9uxhAiAYXIjeePK2/tLcDpM+S0grJlF03F1
 k+E3SYzsRkxqcbjI7CR7TkQgbMGdn64GLLRODve44X8IN64yb2a6wMHEBlM0THpZOlY6tcqxv
 quSHMOP2Yp87+q/oo5zHVyDKFNbAQSY912UTTiLS7slrTcytfKEt13YFXh/F7SnKQC32+cpbu
 6CizeU0pZpzJ8DA6zPCfcbXRSun4VSUJtM1qMtKVdvpo1XZcXTaowWtG/i7//AB2lD0SQNqbi
 ceT9pC+t9RFwddVWPPj1/0RcqwpthcqCW/oZvz/NQgGxFoLKe2/ljNO9WLFyRyTPrNFLKATcq
 TdGSHejlWuaNzOInyGOOGRNsHUvlkL5mmf10WQAjaV6lFNSFXryfACmuW+gG0t8sKgTmZovM2
 r14CJ7AeODEN/qhiIL7UBpEjZGsZbDMDhxQn+mutVFw3KjzeIqMpTKz1L/dyFbVmPJ41I7QBu
 +CdcQ2dcqkhL6Phk30Spw+2YFKoItd1iqMKtjiVqgVSJ7oZvqLMgVJq/s0axmF7bPDwiGhZ7A
 tdIuZeM8G04cRn0XP8FBk/b3vcaNU7tlz44lPO1IwKs9erVaJNFDfhuHagZCPBsTdxzbJIhJp
 frk2rqMjnVFCJfbuWTRu6pKrCt/eJ3ZeejGcE7fW6HyBzZorpXUj2BnlClYADu43ekFct/PVV
 Fs8FKf6t6NTEUGo31QpGgE7nTDwc9cH1gX0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1144635054-1561557942=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Wed, 26 Jun 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Move the "grep binary" test case added in aca20dd558 ("grep: add test
> script for binary file handling", 2010-05-22) so that it lives
> alongside the rest of the "grep" tests in t781*. This would have left
> a gap in the t/700* namespace, so move a "filter-branch" test down,
> leaving the "t7010-setup.sh" test as the next one after that.

I would be totally fine with having gaps.

Ciao,
Dscho

--8323328-1144635054-1561557942=:44--
