Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 417B91F462
	for <e@80x24.org>; Tue,  4 Jun 2019 20:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfFDUHL (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 16:07:11 -0400
Received: from mout.gmx.net ([212.227.15.19]:43837 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbfFDUHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 16:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559678823;
        bh=Usccl3HdNdo5i+1lan7zbX0qsgq+m9qrTl0erzEzvXE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=a2cge7MbWWJJUvSEtw/gN9DbT3mTTEb9223cGS6Qxsja8nlsXb5NsH02SD08Uknqb
         Ap/r2bbmdqR8BGKhMQu+NGJ2NJhBEjqNSQdietlNzjWpHsOAUYFMGS+z+YJtWnxQib
         Z9sYkAFTHzU3EEs2P1MIdtsczJFIbZKbOZVgiJOo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LaG7C-1gqggL1Zk6-00m3u0; Tue, 04
 Jun 2019 22:07:03 +0200
Date:   Tue, 4 Jun 2019 22:06:47 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: pw/rebase-abort-clean-rewritten, was Re: What's cooking in git.git
 (Jun 2019, #01; Mon, 3)
In-Reply-To: <xmqqsgsqto3n.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1906042205360.1775@tvgsbejvaqbjf.bet>
References: <xmqqsgsqto3n.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+Be2ZM+Eesq3SJHhl3f4T5zCSw0Yne+7G7jY607H2jnsynzsW4N
 zW7tot3kGFb1mk2k9yJtAs0+NDxm6377pD652aDNrPtjcQleAaoqsApYoeBqB4Qp/ujSSIW
 Y13MbhNZxmRn94qXRjsx7FA5r/4Lk3k354VWhZ1jAUypgQPnbJi7xAR3kAXgK/UXijnWF4M
 ow77cLLfgq7gYXs/ChdZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dsQuCJjFBCc=:Bk3IJVqUisjHSRb1vWbnUV
 2GxA6KzExPpJSxIK7z6FrW1bFITjb6d3PAbC+YFfy/JXDT8Co6+56T19u8WHkKrXNrIFoNXhC
 4BtFYhLLvT99ic8WgE4aya9jddagyc0bfUsiWt/jIP4/WBtYPMasqt1OjM1vSrfn6y2RwdUhI
 BcisFJdSUxmQUCtJNAOv+eoB55yohLTU+SrYnBAORCxmLaIN9EDCF26Qr7Cj4NdQgexewjgRU
 d/tL35gqVCaCA3wVBCTZ/i0uIxyocZ9DiV32kcIrP2cuqA4khDSLApH6DljmUGm0kStsF6kQj
 b4AnohAV+47Ceqzt84m6KhLZ2cgcIhAvks4LcBQCuk6p+wbkQW8XIEWhg6/EbrMQwZjhD/86q
 FP8o84YByaG/zyfiY+SEJZnhYxTNuI2KSeAZlwC7qxoc65MzWx1KPx2pb8C7m6B2N6+4jtptR
 fzbsNI375E53v9wHBdI07IqCK2DAVHQtuSXw8c4Ou0u7y7XfSLGUhHTyHHECaFpq7yE102j3d
 triGdsu2sG2Tbc77iANFQj7Cjcj4b1+Odk9jw//2BTtdImaelFSDfP5ZcyKd6Uy2makbQpXB6
 rRApB171mksCmjpSj2cUbOt6FOYUzcxpgAj8vOnv7D1yHPibO+fR8oJZoGE4UijNoKVOysmyi
 OYp82mhVdLlqPp5DKh2brerdWHmrkRdDUHN/UI4Ks5jiPPF7ayVB7adzgeyUSwsx+l5dbfpC6
 VIrxUnPAxEFiGIyUmJzzHjpNpfutXR14kV8q8Rd39zXVbvKuulegONU/2z+6llMGYoo2Kn3FB
 8iD+NIOnO7nZqMMaf+z6ytzZCRdgf9QwjtSkij9xQFmiRYoMhzXTIkbrtu0XeOtkx7lj94K/6
 5Vdy6DM5d4akm/OqPGIK+qlp1JsP47tME9sZT17S81DdG6w9J0AW6+XuymrXWrZEoXDqXZLK8
 RyUSbcm54gBG7kb9PRDV8DKah9y1TkF66Bg/LY0rzd61JOAfAzOft
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 3 Jun 2019, Junio C Hamano wrote:

> * pw/rebase-abort-clean-rewritten (2019-05-15) 4 commits
>  - rebase --abort/--quit: cleanup refs/rewritten
>  - sequencer: return errors from sequencer_remove_state()
>  - rebase: warn if state directory cannot be removed
>  - rebase: fix a memory leak
>
>  "git rebase --abort" used to leave refs/rewritten/ when concluding
>  "git rebase -r", which has been corrected.
>
>  On hold.
>  cf. <20190514180349.17245-1-phillip.wood123@gmail.com>

Maybe you meant to say "Will cook in `next`" here?

Ciao,
Dscho
