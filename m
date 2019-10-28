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
	by dcvr.yhbt.net (Postfix) with ESMTP id 59DBA1F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 13:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389017AbfJ1N1v (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 09:27:51 -0400
Received: from mout.gmx.net ([212.227.17.21]:50681 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbfJ1N1v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 09:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572269268;
        bh=Fw++DueW827kvkH0EJZ/ktpFnUeHsjysButmuZBWGKk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HGzNPduaLhvHbIb5/BAEVnxkWy0rPsxFb2KMdnm4b7/uPG0ATeuSy4ZRQNxDDrBmJ
         TgDV6IIXUChiI9/CDygUiq2iYg4+w77Q/LXQF9DawJflTs5/kau7t5qtF1UEJwPkVs
         Ak23pxxfwbGEzK82P6pyoibqt6yUUIPcor9nXhRI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAfYm-1iIRER3ppQ-00B05P; Mon, 28
 Oct 2019 14:27:48 +0100
Date:   Mon, 28 Oct 2019 14:27:32 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/9] bugreport: generate config whitelist based on
 docs
In-Reply-To: <20191025025129.250049-3-emilyshaffer@google.com>
Message-ID: <nycvar.QRO.7.76.6.1910281425360.46@tvgsbejvaqbjf.bet>
References: <20191025025129.250049-1-emilyshaffer@google.com> <20191025025129.250049-3-emilyshaffer@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Gc7ivBJ82Rd437SUUoWHE3LfJyOWQDgzBEP1EDvbsTkFBm1W7Ns
 HYvpaR+u42cQ9uw3eiDLigtZy5UV3bJbcKVaSNbt6jTleoAT5lDZqYxC12TuZq/i8sKiZag
 lkQGMTg6S+GD8SAO0Qv/OL0P0KXIEi1LB5pbCYQ29XCHgwjTSF12b+suuG571oo6CSFBgnt
 ozO1DUZjXMpxzbo3JoqNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w5pEhDHuwts=:J9XVaaM1T3qHqLbyZ7bCj2
 qohtlj9h4DRxoGrNE/hf2y3WGrOftJ3Rcx6/aKJrNjhWtBS+YSt/wWEEfvK074WHHEHFRhQuQ
 Rl6ais1vq+TqlSZo77n9/SoRNHjkVU8KRZRwk9h07uDelxia2Vcp7Yp09rZsTp0y5hI3IMVjC
 MSxx9OFuYXRLwNG0zKWz7O7IlmG9aXiKgfOWn3xc/gMTONRfQT/47IZUZC3P/vWEoTiglOo9v
 FQbz6dtmPChl5FQrr+yZdecmK9WPFSVKkYFWDwwtLJFGmqFifX/6QRjvO125vZFS+NfSBDwf+
 VbkjJFMQGRT4k4lyPzPXJkLIFx2r0J6cCloq+j2pmchnB3ENtWdjZ9pcz0lecXuNZGeu76LKI
 BHRRZwHK+NsO/Zn0DgoElxzZavfRYMsLfb4j2Cgy5yzqWcU/jI0kOX9nXKJKgIvBEdumuB9px
 K9DThPDKXG/96xPd/Im0qQGUag2LzhwNqbB5Lkgs0XOSJV8Q8uGVst984Mw5DLQYPuxgQjO+t
 TSYwCH4vvu+hWiWOPTiiBo7F8w6Arfr8ZMiQgZF69CaoCikwTupMJf3TKTbrvg/iM4/cusswl
 E87mwLE9jPTGaNV7MGkwhcE0CINstrSL59r7F/gsCI/kuXqV9KwT8UGHTv6BNcRfrBDsFTe2T
 NyKw1RDH7cjaZhNC2ywQMH9QaF64l81S3TbYiMqiC0dAukaEz3Z3m3AdUHoGdi9V6bGK7KBHo
 qxByhDkM/yr7Xzu7T/MqmU8XFbHw34aG0HXUeBHxSBBc5uwkVOlZ33vAb4QmWeUNzLIQRyzmS
 xYX+3tUz5nVwbfNbXsyrZWxbf9LwIJCjPdNTvDwWzWx+HMRJnbx3FJkcJf7o3li3vZgMqYmGI
 ar0MWZJkkgkAzBidiwdVm7eambVlYo8yEUmi2ZbBSTjRpB5s40GKMeaOaXXtSDNWDT/iTDBk+
 GI7lm4iUyphR+2CwbSWxzJM6PsJIN5MHQTCpLU++MAA0BzhGVfDzm84E9b84WzkulOW5fGxp/
 ecoyUtHJlDFes7xMgl7Z3hUPqhRp7RIlaByalocQMZ/zYwjDZVm8Y9EiqI1FP0UDOjfcIGySG
 0chUzcMv53mH6iiQAveOgQtEJq3kFMFrgLeYl9JVbTMCGL7V5xpdHJM3AgtAexOWM5GnYisfC
 16ErMWw4UeL8ydjhzMSAACA4M6usldFjufr6o3/Kx3MLrzC11jQ/w8ZzyuJaAlnLWmhGqS9wl
 OENs5rVMvV3uVVcJD7bHSBQp0O7jdougfA8hbCN3M6+f0Ik35baWwZ1mRKLU=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Thu, 24 Oct 2019, Emily Shaffer wrote:

> diff --git a/bugreport-generate-config-whitelist.sh b/bugreport-generate=
-config-whitelist.sh
> new file mode 100755
> index 0000000000..ca6b232024
> --- /dev/null
> +++ b/bugreport-generate-config-whitelist.sh
> @@ -0,0 +1,4 @@
> +#!/bin/sh
> +
> +grep -RhPo ".*(?=3D:: \/\/ bugreport-include)" Documentation/config \

I am rather certain that `-P` is not supported by BSD grep (see
https://man.openbsd.org/grep).

Why not something portable, e.g.

	find Documentation/config -type f -exec cat {} \; |
	sed -n 's/^\(.*\):: \/\/ bugreport-include$/\1/p' \

?

Ciao,
Dscho

> +  >git-bugreport-config-whitelist
> --
> 2.24.0.rc0.303.g954a862665-goog
>
>
