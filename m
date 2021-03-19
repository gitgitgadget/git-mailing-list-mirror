Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713C8C433E0
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 14:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A71964F11
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 14:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhCSOGT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 10:06:19 -0400
Received: from mout.gmx.net ([212.227.15.15]:33363 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229785AbhCSOGB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 10:06:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616162759;
        bh=1wKlR5xi6MvsRaSZ6aJzKizdapth1pT+VXFIJfEyPFQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NU4qxRHXwQYvxfS7miT5NRRXB0+4qMQ+j89zKuJJBMjLN/9YT270Sd3yn1IpqR+Gi
         dRArSGXkyHqkJhfdGuD4H2EEtrggUZIx8G5Dvs6iMIoxZFQBMFw0t/bj8b7IbWDxdh
         ahDUiYvGl9mvNBK+6kfYqJ9aY+omuCPCnejjEZD0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.24.97] ([213.196.212.127]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHGCo-1lRdUV1bJA-00DDhg; Fri, 19
 Mar 2021 15:05:59 +0100
Date:   Fri, 19 Mar 2021 15:05:54 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "Bagher Keshmiri (Gmail)" <bagherkeshmiri@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: windows git invalid path error
In-Reply-To: <b524f3b3-b1d2-b8c3-7209-38d81c9cf646@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2103191504050.57@tvgsbejvaqbjf.bet>
References: <b524f3b3-b1d2-b8c3-7209-38d81c9cf646@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-131025628-1616162756=:57"
X-Provags-ID: V03:K1:bJ7ilSocYh31EHdtZyh7dhtHndQ6lB834NGTuDWh2/2e8XDb9yQ
 T4c5ISR9wilAF6CZVNV474feN5Mk4BD4lHTwbGzcr4ZW0om15ruYx+M283ONOMqh+hIOWAp
 s6Nn6kZjmRSvjxizo2HGkZB24Mgo/8pxhM2ie51QZuE1FcQy2tFi5lj6xriAfHCyzEbWRBJ
 VxEfM+N5oSYXiaWc2o7eA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z4H9YxBEunM=:Yas//5ZASq/BCg5R006VEs
 sArwlSfuMEOdywF501UClYBQlYm1XWd/D72yz/J7Dav+JWDwirVD7VE4jmbse1G7mjqlqSNrA
 SjUlBXkGuO4aWV4GfteKfs1HYGghJurpH/FqncJfH5Xgrm8HDusKIkS9R0gWcyxsY3y9mubUK
 L/keRDDaaRa0SEZLEb9lytVaClQkk/BTvGqNStIMqJfGRoBCPLC8ysPLXo9675hU/bo7ldRmQ
 Yf9XkGtelDeuGAMTZxwbL2E3LeeC2SbydX8gCK16kj0GiqlV5gH5uDNyc/pxGQ+xrSJvzBf3a
 G7VXc5BPktcOYQCtdLKncoilnhNpx/4cghxd+OXjgms/d1cBVXJQDuBewaL/zMVI2Trw+c4YF
 1kMKjjWwy22TaMyND6+b00gd529IbEL86QGvXm17wNsPr9BKISjDhI1/juWxSo58fmqI6Aou5
 AB62VC3wgR3FW2ufpliV/svzHk3JpaTAW8Y6yRSk+Djugsc3mf3SKXafwBn3HlYjK0WNIcsZm
 EhU22W2GjuKbqy2OJuWIEq1y0pvJBcmlNUR8R2i+pLxMx01ZvSwssqt3L5S4aTKNJIFqBG+K2
 H2D3mfHiBsja37QkSgHgZlZIviVoE83Pzxs+tef/dyPiNoDh+q+usrazHIyAOLpFMTCfor8Nz
 WXs+QiIBu/KWcaTlwjOX0a8F2QOVxo7vGB15/ltATifvyHlLJdXPudVUJOkk01g5QzU7C/cXJ
 yy/mHAXl1ohUJwr7+PdTw0RWFSbXhWVIkqhQrA+wL+PAyrvU987nE+PHa9LfB/w5rbngjeM1W
 8ubBsRnlxEixi5L5t1tBqnAwLfSuTyqCqovuE94Wl+jvSf+s4vYvTE2f1tXWlB6erYEp0mizT
 gCimZ3pzG6cLcQQntIDSsRu6V9InMlhQA40OMvK6o=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-131025628-1616162756=:57
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 9 Mar 2021, Bagher Keshmiri (Gmail) wrote:

> hi
> i need pull changes from my gitlab project to my laptop but when i run g=
it
> pull show this error
>
> =C2=A0fatal: cannot create directory at 'public/C:\wamp64\www\exp2p\stor=
age\logs':
> Invalid argument

This looks as if some Unix-style absolute path was improperly converted to
a Windows path. However, with this little information to go on, it is hard
to tell.

Do you think you can come up with a Minimal, Complete & Verifiable Example
(https://stackoverflow.com/help/mcve) that allows others to see precisely
what they have to do to experience the same issue?

Ciao,
Johannes

--8323328-131025628-1616162756=:57--
