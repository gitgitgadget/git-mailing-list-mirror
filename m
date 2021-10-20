Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCF8C433F5
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 11:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4711B61074
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 11:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhJTMAN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 08:00:13 -0400
Received: from mout.gmx.net ([212.227.15.19]:56927 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229702AbhJTMAN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 08:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634731063;
        bh=aUK4h/wnMzFTs4sLbiisSbLeqmTvrg9WofNBTqzxjC0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=a5jIqRd+MNMxC5+6pmOdUDQ+VFPAUAMasQXv8VV1U/yzNcAB5Of8C0D5Z/G29mbyI
         MG2Bf/cNmN5q8g1nJbDSoSkVf7RuWAnYsfC1iz3icxfys+lQCy+T7VZX7ykwOTCg23
         SK0ajbgEJT4c6QRWU1WXxPkcH4BWsa/tg9sRysgE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.7.163] ([89.1.213.179]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEFvj-1mVlpK0Yhp-00AITF; Wed, 20
 Oct 2021 13:57:43 +0200
Date:   Wed, 20 Oct 2021 13:57:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/4] gitfaq: add documentation on proxies
In-Reply-To: <20211020010624.675562-3-sandals@crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2110201357110.56@tvgsbejvaqbjf.bet>
References: <20211020010624.675562-1-sandals@crustytoothpaste.net> <20211020010624.675562-3-sandals@crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bCmhgjMjXRvPLuAyCR2SbCRjMP94MObc4AkhpmnAbYD7bZNXUZ9
 Z+zzUtXn09E+X1brvJdQSQq4kN5qqSfQyt8A5FOoF6CHN4Uk/MtOLhYqnUzwT8DXiX3SZSd
 lLLcpgS1vjWQ6KGJm1zv1KuyL9736f3VneUlmjV8VTpkP9HiMsqYco/tW5ES7QFhAvy2lGf
 qGJrZoNGFilHLUskeV/Sg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ljj/0FlXTwk=:ZTy4uvoIfIMd6wGtD3J9PG
 Ij8yfM5ITe0/foXtUNzpwPug+mvkq8BQ/DxvcQLH4J30eoCIMttJTJwATWy3705/Cg64aQ4/Q
 JFerCM9y98TRXiaAxNK29A/YewsHuKXTxynHNt1nhjTtf2+0mAilFVFvWA1mmkE9i+y5yWxNb
 TzAZFiIMC6D9eMMebOAndLstG1Em2RU+HXh2tLRse9dv1+tg1o6pSBsn01lu7YcpNk/Ek+0Ds
 Lu+u3wW84oP5gYMgvgzpj2tTpY8OBGhP5L13aEnKO6X6FKlEL13AUUVhcAfxu3h2vVMBsX1af
 ns6N4YacDZNSjCzLHWFrB6eD4XBuvorv26HlIqEnFAxlRQ9P+5APkknMCZ83Ash8bmI+ggd5O
 t8J4GNjT0CUv9u+5Q2Qs4CHWkN+l2R22OlueXtbFUwv8zoRdEeSDlUPVW62tfDIa6fo/el7c/
 xkEM/zi35QDLrdn/TclONQkuQsmbEb6N6B0Ws0Nan8lR8QJSzt2n9Zb2/P6azHrZpEMrXSmfE
 tVUPHIR3N1aM2gTQebEJz+D3aH9CcZQlyCiOj6EDCo1gb+O8Hd8Eh/FzihM0lVd7FVwwZswOJ
 5zV8tk3wUy2rfoyYhRsGo471r4vnizsjxrvzqnMqA5G1OwU6kuCyv9qZE5jWhyBycTw6QrlOn
 +j634Y/ZM92hEdJnWCswK9VE2fcfOn1iggxBwBcseOVGSQPQtxav7ofKDmCqp713FyMoeez3H
 wWWox3A0/5IFW0z0MmNDjqjfWU/GMDiiyC0P1I3QCXnHq0SR36pOxJJQlzWnUS9jQgYSXHoii
 6X6BecOmKqNrSfq5REu1zZ6iYRFgLyh5E+HSjR2ZJO5VNcm/YIza3AyJdzotNoAANMxrqmqFb
 Q8XA5BltOjsQgDPYbluMF+t+EkRYq63aR+tH9vq1+J5BnKg83osgMvxkTBdoeNsCURtXr1TDh
 vhnZ3kMCfxf0rBpF94Q9jJ7BxiR71s/AVb5vZtZrq0HIBxltUliQYvHu+LTGdW2p/rMA96BJd
 KVsbfdx7lCUW/1fDjvqFVhCzQm5YFHkExGbcXlR5GbutT4TmDfsmoaM0EBZe9IbUI+OjUnNko
 HMlYI3DAHJT9gE=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Wed, 20 Oct 2021, brian m. carlson wrote:

> Many corporate environments and local systems have proxies in use.  Note
> the situations in which proxies can be used and how to configure them.
> At the same time, note what standards a proxy must follow to work with
> Git.  Explicitly call out certain classes that are known to routinely
> have problems reported various places online, including in the Git for
> Windows issue tracker and on Stack Overflow, and recommend against the
> use of such software.

I fully agree with this patch, therefore: ACK!

Ciao,
Dscho
