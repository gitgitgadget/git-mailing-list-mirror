Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA79C1F453
	for <e@80x24.org>; Fri, 18 Jan 2019 21:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbfARVEW (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 16:04:22 -0500
Received: from mout.gmx.net ([212.227.15.15]:47781 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729437AbfARVEW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 16:04:22 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LfTVx-1hZY8624mP-00p88D; Fri, 18
 Jan 2019 22:04:15 +0100
Date:   Fri, 18 Jan 2019 22:03:58 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>
Subject: Re: [PATCH v4 0/8] Reimplement rebase --merge via interactive
 machinery
In-Reply-To: <xmqqmunxluj8.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1901182203350.41@tvgsbejvaqbjf.bet>
References: <20181122044841.20993-1-newren@gmail.com>        <20181211161139.31686-1-newren@gmail.com>        <CABPp-BE83Oe15U4yrkcV_-qzWocMS4UcVeG1VEoac-jXgw9Peg@mail.gmail.com>        <xmqq4lak8d4g.fsf@gitster-ct.c.googlers.com>       
 <xmqqzhsc6xdk.fsf@gitster-ct.c.googlers.com>        <CABPp-BFckuONYcGGkCY3BuPypRULmhsk_OFHyYA2E4jM66BfeQ@mail.gmail.com>        <nycvar.QRO.7.76.6.1901181434520.41@tvgsbejvaqbjf.bet>        <nycvar.QRO.7.76.6.1901181519230.41@tvgsbejvaqbjf.bet>
 <xmqqmunxluj8.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:T4UD/8c4Gxs5NEkeY+ttwcnWa8eFmio972KCPETpLKP5U/I3IKo
 qa3aSUp6ObZgPYM4oXTKJUVqMGCLxJiK0iw3icYKc1X1ZJqSCfyGMykBJ1QkCX9RklQCGcZ
 +s4nHTCSYcgq87biHxDr5T9bfag62Uu0Q/QTpV3jnCZACSoPNFtrUwlotQedoKbLuGN22+v
 wtcFK7e9vObCOxTjPLipw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eY4Ev7G2phk=:gx0/Zm+n/EEpRtvPQ+XFGZ
 LdesbLubFacmx913d5IEKF8y/5Fx1EUu0aqp3l/zS6zEeaZwzE7IFUp4LZSqLVYtP4aCTJ5JP
 rYuQs8d2pfRahneZJb2kfIG16b+NL+fueCjyCcqYXTBsVI4ofjphVxm9gLixpQLXW6nV9HqXi
 quagzYWLNOsWUrXjUs8ohtzOrj5D7+Uo51QQVySgMXxYVNN0EIK3ipWt8VaR0Q/NsyUW9dY0o
 Ba2zGFJSojKJfm1V41vSi+/fIdik3KK0LRk/Tf4gt5gQYH2vP/KqnIRvT7wvBqdL7q6utLGKf
 RwHgG/ITMg1JbkSXNqh1RSpsan6iajRTFOraWb7K2g/LssZnJc28WfE7cbpdCKDeBAEoYF993
 PGm490xVYReO6G+CvZDIzrFZ40jp47Q/6ai6dudQYN3c0dLiFY99p7Vb6vz9gVCFlXSCZmiim
 GSCXf1Dc/qcWSDl389ublvdiSU4mT+Ge79dHO2oPkpkBWv+wRPSw7iHkj43m0BPfc3JWcmYZq
 9kwbczXUO4S9kNpg0C/4K4Bqb/x/RIjKnI6kly94xhA/yHnFCFj6/QjnbT7n6GGnoEUdNffay
 mFAG3gEg5ybc8+cJOEfPZCHUd7hjcJi6XuJd9Agi3s/QoaNXIXRodzUXwzAH48txADr2ReB1t
 9zzuScN66WO2TQuqPKho4D2wrQ/2XvUMcWowwxQR3rqRzXHo0el3mfDFhGif9wbsq3BTbq2a4
 Wp+05HPRu5vSR4l6wAwk8i/VtSiS5oSL3j2sPXk5uSgzTZDdPA0SEUywmpoJ6uG3Dkj7D5wjQ
 jV+OBRu/IKF7S3WSUjNv2Nu4bvvtTK8VbdQ2eKIGXAaR4hznqsM8vqNUTtRuwFtuMkc1JeVVH
 1ny7yghNAHFnvidiOkKacSH1djPJXenks8tg13v2cAnBfRNW3U0q6fK39YTDV/pFgg/3jLN4V
 r7E8BE3eu3A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 18 Jan 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > I am about to submit a new iteration of my patch series, would it be too
> > much trouble for you to rebase on top? If it would be, let me know, then I
> > will rebase on top of yours.
> 
> Or both of you keep the topics as-is and self-consistent, and let
> the rerere machinery to squash it in when the two topics gets
> merged.

With all the experience I have with rerere, I don't trust it.

Ciao,
Johannes
