Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B3491F453
	for <e@80x24.org>; Tue, 29 Jan 2019 14:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfA2OHF (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 09:07:05 -0500
Received: from mout.gmx.net ([212.227.15.19]:34691 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbfA2OHF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 09:07:05 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MXZ4Q-1gcsPy0tN8-00WV4P; Tue, 29
 Jan 2019 15:07:00 +0100
Date:   Tue, 29 Jan 2019 15:06:43 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: tt/bisect-in-c, was Re: What's cooking in git.git (Jan 2019, #04;
 Mon, 28)
In-Reply-To: <xmqq4l9s9zee.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1901291506080.41@tvgsbejvaqbjf.bet>
References: <xmqq4l9s9zee.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:iPQIIsWLVaN2AaVA6pEjoBjTe3GWo60VHypQVZ6AM9EG3JksP50
 zmuOOTUA0pVslMy6TM/xhaM0QJNradWd+vOBV4wp1+jpD+uA/2zVVpdASZhg+DOInbZRZpq
 wIIFuOmdCy1k9F949CylYANbVxif9PICZ88dKMvVMm2XD5g4GSWc/dYDGKsnqJHl+jia5Xx
 XMICyjBxAg3hrLy4m55sw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1myVMNJBwEM=:lvxen2qKwd3fr6i3kHjeQE
 ZSSYyyPbS1QqZYqIJshEhQ85ftQs8BYQ6XCoAGGmpne4xIAwgKwjMKlR4//1Q04A20IGDwZ1f
 tgUfunTK4/nesXxYm+/XW9o1uwbzNrMphACuDDnxUEMp7yTUxZdTV05/euCwaoCx3/MzNYCEZ
 rZ12WCHcRK0vMe+dq+GmYYFyeoX7Q54JpVPdm3vY3NcPuDWADpsb/cgan9Ymf37IypnU+MsrM
 307pk43xpyY4xTcp6WHIgAJxtDuKgrbez0K68e/OQ9iafdXRrKUHZMA3jd847U/tUoiUhmeAo
 4V1XRGYQKIuwu/lsxEE3KJlM1PK4u5wkmnNk8URR4f7XSuVUwqmvImeymiA0iUiDXYVzMEOpg
 auyxqgUdu393tinYiNoNrDz3J78hhxPebWkPlHQlByJWLUbXaW2yb5z9FJIGxud4YHGMASCfz
 KyAltZe/GEjejriVnya2kksjGXg3r642Gjk7IjoI/KJEQk127bDYD0ekofr9rh7lx5LpUFpLL
 AaKzm4+PO5TUsJwqHCIgWUqWzvjhBAh33NuPB0vfXaY1n6UrLYqBDBQQLkz/FgavEWfNy2G1y
 p7+PuzrAfaLleoPgzaqd1NYBRXOMmHIVZBsP7DfUEprftwDUUdJyQ8XA2kzVwpXFDF2mgmk7S
 WF/WWjIU9Ch30Z0pTqa1ynS98nDxXr155wZ8OVDr6j8WuYwDpZmJphHs5BzSaKse903TWYRY4
 69uAC5dGhU44AhxdLS2MmpkfOSGU7BQIyZXRQxoHrMepNhUetl7SYUX5kdKIA9g+HgTUhwOzE
 orryze0sLxm7XDKBw8S+VUebDPKIG/qoAr0lG8gIrRn+DlFbaH7PhrmPvCOoFbqc9USPpKjJd
 GPtV0fXM0irGkBiH9tG3m83qeTCczzNMgy0KAEg7xAHvkAJ6VtgIjEx6wAB98UFEwCcNEEh8C
 zth6nFamVzg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 28 Jan 2019, Junio C Hamano wrote:

> * tt/bisect-in-c (2019-01-02) 7 commits
>  - bisect--helper: `bisect_start` shell function partially in C
>  - bisect--helper: `get_terms` & `bisect_terms` shell function in C
>  - bisect--helper: `bisect_next_check` shell function in C
>  - bisect--helper: `check_and_set_terms` shell function in C
>  - wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
>  - bisect--helper: `bisect_write` shell function in C
>  - bisect--helper: `bisect_reset` shell function in C
> 
>  More code in "git bisect" has been rewritten in C.
> 
>  Comments?

Just to make sure you know: both Chris and I reviewed the patches before
Tanushree sent them off...

Ciao,
Dscho
