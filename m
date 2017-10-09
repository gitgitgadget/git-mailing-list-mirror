Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D320320372
	for <e@80x24.org>; Mon,  9 Oct 2017 21:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755085AbdJIVMJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 17:12:09 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:47712 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755196AbdJIVMF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 17:12:05 -0400
Received: from cayenne.localnet (unknown [IPv6:2a01:e35:2ef1:f910:580d:40ec:c1e:d5b3])
        by smtp1-g21.free.fr (Postfix) with ESMTPS id 0663CB00563;
        Mon,  9 Oct 2017 23:11:42 +0200 (CEST)
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     Stefan Beller <sbeller@google.com>
Cc:     Martin =?ISO-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jiang Xin <worldhello.net@gmail.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Christopher =?ISO-8859-1?Q?D=EDaz?= 
        <christopher.diaz.riv@gmail.com>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Jacques Viviers <jacques.viviers@gmail.com>,
        m4sk1n <m4sk1n@o2.pl>
Subject: Re: [PATCH] submodule: avoid sentence-lego in translated string
Date:   Mon, 09 Oct 2017 23:11:42 +0200
Message-ID: <7894534.MaGmRTisnX@cayenne>
User-Agent: KMail/5.2.3 (Linux/4.12.0-2-amd64; KDE/5.37.0; x86_64; ; )
In-Reply-To: <CAGZ79ka7xo96MHaAUbkDuFjWMQaaD4j2UrRndcinAg6uzaP6Kw@mail.gmail.com>
References: <CANYiYbGHBDGMEjbrvX_ayXkXkciT3GgL4seM_X1NmWtud2upcg@mail.gmail.com> <CAN0heSqFSiev8BeZVu3KBA5vswsbQrrOH=tYYOSs_h_eq=8-3Q@mail.gmail.com> <CAGZ79ka7xo96MHaAUbkDuFjWMQaaD4j2UrRndcinAg6uzaP6Kw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday, 9 October 2017, 09:47:26 CEST Stefan Beller wrote:

> I always assumed that translators are aware of these issues and sort of
> work around this somehow, maybe like this:
> 
>   "submodule entry '%s' (%s) is not a commit. It is of type %s"

Translators can be aware of the issue if the coder commented the 
internationalization string with some possible candidates for the placeholders 
when it is not clear unless you check in the source code. Much effort was 
poured into translating the technical terms in other parts of Git; it seems 
awkward to just step back in this occurence.

