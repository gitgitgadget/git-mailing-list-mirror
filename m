Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 210B81FF76
	for <e@80x24.org>; Thu, 22 Dec 2016 09:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932199AbcLVJXS (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 04:23:18 -0500
Received: from mout.gmx.net ([212.227.17.21]:50426 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756145AbcLVJXR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 04:23:17 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LqV4f-1coMON1fGL-00e15O; Thu, 22
 Dec 2016 10:23:10 +0100
Date:   Thu, 22 Dec 2016 10:23:09 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH] winansi_isatty(): fix when Git is used from CMD
In-Reply-To: <xmqqlgv9i04z.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1612221019200.155951@virtualbox>
References: <cover.1481454992.git.johannes.schindelin@gmx.de> <42ddc270ea04e01e899cc479063e5d602e4a4448.1481454992.git.johannes.schindelin@gmx.de> <129f000c-49c1-0e75-26b3-c96e9b442443@kdbg.org> <xmqqy3zfsq4q.fsf@gitster.mtv.corp.google.com>
 <5977e71d-da58-7cb0-bc69-343bb3a1341d@kdbg.org> <ffc6a7a0-4ae4-b755-0b09-5bcd7114a2e6@kdbg.org> <alpine.DEB.2.20.1612201732160.54750@virtualbox> <xmqqtw9yleop.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1612211857480.155951@virtualbox>
 <xmqqlgv9i04z.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:rJV4IEiUF8TFMAzID52pTQ+99yHY66nPJfakDt84TZPCNk0N08r
 +kT5xrq+SplGCfcgRbjjzpjQYEq2UCd8HVhOph0f81lkyUPJ9znrsExuaZ3FVjmloSz0NwS
 /s/YzuuXlbpi7X1hD9AkCGbz3p1B7csVCWs62OGHeVKhyF3J3T5ZEXhf6uRy/x0wTskRNaS
 NS4TAVYRKQpIIqG+ZAxrQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KXa5GtfGZQ0=:CSdNRk9Z3Po1byr4L/HICB
 qymRcD32R7pYV7Q7yBpP0EnBVtUeZQSqr32vzry68XfSh/OAnb02TzNLz5Jqhl9zcNaw1rmoP
 zAoN6o3Oud0byBtFOt/ZwCiltPl55ZsFVN9HKBLdmvG04kc1l00eJAToOF39cy+ixUN1NdOmF
 rJesGfyHTZaLy/J97onKSYWzynrTpWirWxT5wKHyCdeymLb8/1Kj1XoCV1Tyg6synu8rVjqYB
 T4Oytw6Xn6nGngccaYB4sEXTm3jzChuMKt3+SYPr+okXtdMMtFSJbIYN3KSLvtRu5Nb0Gwg7X
 woN3uaOiOKVzQcEGJ+XLsSrRD2WfEwMpucgZpzzJK+YHAT6h6Fk0OPcHO7Z3ypgc/j9sw1HAf
 IaGMkOWuGArzYCxx8XAvBv8vjQFo9KbkNbwwY/ciEo+QCDvfX/+U/FUiO29elyAj9xemsctbU
 ETrRxEY1nY3wb+8Pwd0D7o6hYL/guL4gHocv2Odxxzdg0SIlOR8AmAqn6+dsDqisDMZBfllX1
 fUD/tu38vMXgbpcmUObPsUaFdiUuk7dwGRVDXrC2KWV8NrY4HkSXSQkqZGHrf1HZsrskiVZay
 eS5qT2TF/S7uysNy4F5cCyNDArFdWVt+3qzJS+T1UF8agbYefK9XakW5H6JcsThGz+hhLhtpP
 4ENIFDZxmPwpsaR5fYmc+u/gRuQBFamx1nV+yLhYq+Yv+UZVmf6tBj0gkkGBI2wB5gFKNDg2A
 mslO9qcJYT/P/k8G6un4A9ngqdevtDjegxGznp7g+ZRqTnOgzqj3bWGwWEVKpNWsL/sG8zHCS
 rb9RmZb+eVmFJFruWE6JXFfnr+IQg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 21 Dec 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > I prepared a patch series based on `pu`, on top of Hannes' patch, and
> > I also prepared a branch that is based on `master`, obviously without
> > Hannes' patch.
> 
> I think the latter is what you have at
> 
>  $ git fetch https://github.com/dscho/git mingw-isatty-fixup-master

Correct.

> If that is correct, I am inclined to fetch that and queue it on 'pu',
> replacing Hannes's patch, and then to ask him to Test/Ack it.

Okay, I will prepare v2 based on master and addressing your feedback.

Thanks,
Dscho
