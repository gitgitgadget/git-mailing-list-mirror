Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 809F51F829
	for <e@80x24.org>; Tue,  2 May 2017 11:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750995AbdEBLqc (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 07:46:32 -0400
Received: from mout.gmx.net ([212.227.17.22]:62731 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750886AbdEBLqc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 07:46:32 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MOfQw-1dBYfk0pLq-006A7r; Tue, 02
 May 2017 13:46:18 +0200
Date:   Tue, 2 May 2017 13:46:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Lars Schneider <larsxschneider@gmail.com>
cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Automating Coverity, was Re: [PATCH 00/26] Address a couple of
 issues identified by Coverity
In-Reply-To: <73A81857-0083-4A70-88AE-FAA025B6A4B7@gmail.com>
Message-ID: <alpine.DEB.2.20.1705021345100.3480@virtualbox>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <CAGZ79kbbHshh4=WC2ymG15=W5oq98b3KTV4zxiTx0LgCLeYwfQ@mail.gmail.com> <alpine.DEB.2.20.1704280010160.3480@virtualbox> <CAGZ79kYOp1deMgcEB3HHXeEcLOKNs4KPjdT_W2CD+4Amduv2Wg@mail.gmail.com>
 <alpine.DEB.2.20.1704282205320.3480@virtualbox> <73A81857-0083-4A70-88AE-FAA025B6A4B7@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:nOZ5D6pKy9ulVP8DvcpD2pChAuEEY6ylkeO9V69Por6PFcbIayJ
 tRDjyeJYxFFenAi0L6TtEuLeGciXYt7om2giq+CAncN4N637ncyer/EjYpqLEt+AYug2dWH
 Z3PzgskXv8UOKnrMRSHgBEqKWUmGvHEQuGZsXVqStfdrXdPVFKudmjI4kzcG9ruvc641/PG
 ZZkTirxRC4tpYChWd3Ivg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XBsl+/zfRR8=:CIyqVCCutIz/1SCm0rELyB
 2GIYo4XOklgmwmM9I67l8wKvZP6K/rOzh5R68Q12pozITS9ILjbygqOODrmPPPMUyxelPzUXG
 3zmnbFLZtYuR1YfAwxRBQMRoJgM1q+6/fs+lSrYlzorHiloolAbmIdXk1Zvt4ocdUITzQgcSw
 BkaSNhyj9h1pNi49Gcxf+rH0l7BX6PnmX9qpQipRURbS/83PnH/RanlQnD/hCZnP9dl57o/Yt
 c1xundZnDAHpkhCdtRt1sifQH0CTIlqRlyWFrDOWPXbbAEq0WZJRhlGae2biPH0UX8259FCXv
 ovapDquxs0DzmnFgteo+4bySZf787wcqoujGU+Mju56eAIcyzg0I+5RdqUo2hbXKU8DmnqJDg
 9HSE4c5CZ//XsoMzjsbUs+2h09D0iHzYIsCpQZawH80b+5OWlPSP7g9k/urehhWgI9CGwZifw
 pDi9KFZBo0P6DzBpjL3BqHY5+18lz458PPZeLu0AQBAr2W64Umnt80CkWLXFrmt0YbfNndQA7
 r64SRx3+KUKHiJ5E0RJVfvnTaxaQhbN5dCJDdTgomoKvzdZ/GLlETrYty9oZPPGQNLsPpUA0V
 yJxlJgpCjpZ0D1jQrqxBKd2faGFqcy3sHtYCWa68p+6uJzPWGfKbFEKKNJilVj/QwD4jOz26l
 C/rs9/4EP9RHszUxmA57gNFlIAQ+OAVVXGfdm7xunudfy6aK+hreY8o/O6W2W/TYa5gYrKj0U
 5lfhX0gtTFriKcd+btaPmV0bYeK/b2JnG6yzN4LOPxMwYjtboEyBtDy25F9mW3qE3pzgg6dvW
 i4tgBy4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lars,

On Mon, 1 May 2017, Lars Schneider wrote:

> Looks like Coverity has TravisCI integration and I assume you wouldn't
> need to worry about downloading the tool in that setup:
> https://scan.coverity.com/travis_ci

Except for that tiny little fact that Travis CI does not support Windows
backends (nor would they even respond to my offer to work with them).

Ciao,
Dscho
