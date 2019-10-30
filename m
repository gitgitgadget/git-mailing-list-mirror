Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C52CB1F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 22:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfJ3Wjl (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 18:39:41 -0400
Received: from mout.gmx.net ([212.227.15.18]:60537 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbfJ3Wjl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 18:39:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572475176;
        bh=ZAio5mp0ch6+q/u5Uw/wasbvKbN99Vj9S27rNtrF70w=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GLlqQBEYm+hO4cvqYOtcL1sIiDxQJOlK2/6m7rD1GhHscghjcnfQ8RGeZ86rcxser
         nQIYc46+QrJm1Eu63WK2ldA9rowNm/0yCxoqITfJcZYX7lN/9vG5PjXGAItGVjuRVA
         hqJY2T5qJQmfW/rhIaWKjlUOl7QDCgaUPtC18JAE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3lY1-1iPfds3BnH-000vtt; Wed, 30
 Oct 2019 23:39:35 +0100
Date:   Wed, 30 Oct 2019 23:39:20 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: ds/commit-graph-on-fetch, was Re: What's cooking in git.git (Oct
 2019, #07; Wed, 30)
In-Reply-To: <xmqqd0ee3du9.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910302338040.46@tvgsbejvaqbjf.bet>
References: <xmqqd0ee3du9.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VwqnluLt7ykUTig2nyW6YQI/QknqqE76p+p7DPtzeco29BGjLXP
 F4G0MPpGaKv2JM5VN4cZgY0xdvm5AkWSS7VeIV37sQXhklSnXDQJyPddnSv0sBIDqBXU5is
 mHfjJTior0f/8eoBrpp10NZsShDmeIMXqZe0U/EdYQAhYNcn4r+GDvoAavteGu85w4T5Vjk
 KD1gilSyf3w6bEuiVcEWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uF4fhRUYE2I=:2gwwx4YxlqPYukeF4auJGT
 8w45U35yh7WNnHE3cFTia/o9XqTEaRq8xn3KH7okMvgUOcS3hO18enGPgP9+XVft+dXI01M4l
 DjPUHNJeUpdeKTMEhmUmq50Jfj61gN1/rTQH2pRROkQ27DDp1o5qMLRRn0bO4ap3ZusrUqNp6
 EIT7LLBsgXnZ+5GL+OHUBQGPyhH1+RFLVur8vuQ+0IyAQfwAb/EYhVrmLh6pDBYpAuMscjhwU
 HtDt8L+hmcBmmfFAXpt1Mc43sRg7XNn2Nt+Ri0Is47U/nBq5z8aahaXoTx1rluzPs/1Qp7S+a
 iFlyQm+33ILn1Dqe6AfrWpwQ9QTzzR4zgoONU+bel/N0dAA5QhLwimksQa40MaGKLk38Z6AYl
 LTNMaFVEbq24kyJynOmwBkCH66ri6zPbDf2DTXLmIrA3bS9+q89f/AbLWFcanj3DQ0L3/j247
 xojG21V+un5zyY6gGwuUBlemnQTX/JpsfU2mnWLRFNEy0G45wVg+BJ5BNqU5uT44EgtJTzNOk
 0R6EMK9z4Idno0nJmRXBXZp3FDCcKYmL87hHfmjAT/HIB3wSRjaNRC565IdyIXT/uKoxpwFGC
 rtfF6V2IlRHxvEu3TSFTpK+f2g6Rh4idM6kV8FnDPjz+yT4lt+Edm6gfYa4ZRc2NNn4QgFatm
 GXkykoTEVfzNZqIEf9/XPnixuSbsy4K1z+pIZ8g3hIX29ZZ/Aow8nVRyt3CiWuKyJ5xhkSuyM
 4OBWJS2jy/UKiei6AiuihfzwEuJRLdmmAljJA6zCOpdGsAMSUQpjNx3mPxKQFnpeKDtu6lTSA
 BjIrd/kJtF+hnawKdnrjD4OYJJqkd6Pty/Tap8/t/Uobp2olYTXfZJC6CyzxQVi/XvI0/Zt5W
 M3e201MM3YFLeugLzAODjsWsLPS8s0W1K8L0oMod0GOF5aMhPQm5B/pjwc7hb5pcnUSFkmbVo
 oaD0XhUq/BeQL6hGpVdl8uPoIGX4BQTXclPnHMkVHy7cTg7smA57K1tTmzTSxPZMkywm78b28
 iMtKhTxLjQPEW71SxcSIfVO907/fRTEte8OFzExrYwMHz9jiaCgITgFhVGumGZ+o9QFRhtnN9
 DxchU21AlwaUEDKYyCmTugkzslT5oCrKJSXKQklmSj2fKltXm6WaeTd6OB9yWsXMwi8o/nVtm
 QCyp7OGcdhB+0v4LVT0PwQSNBhgEGx74m1MaDn8FptpxTnvqbBFZ/bHX332+QPoPTAAY/UsHA
 uCyT1UWHOqEgUtWCfHwaVfRASnThesTB5byAbyakrDUOboCgHUpD0sezK8Zs=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 30 Oct 2019, Junio C Hamano wrote:

> * ds/commit-graph-on-fetch (2019-10-25) 2 commits
>   (merged to 'next' on 2019-10-30 at 3ca711f743)
>  + commit-graph: fix writing first commit-graph during fetch
>  + t5510-fetch.sh: demonstrate fetch.writeCommitGraph bug
>
>  "git commit-grph write" hit BUG() in corner cases.
>
>  Will cook in 'next'.

This is not actually a corner case, I don't think. I get bitten by this
every time I pull when fetch.writeCommitGraph is true.

Ciao,
Dscho
