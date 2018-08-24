Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E701B1F428
	for <e@80x24.org>; Fri, 24 Aug 2018 16:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbeHXTpg (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 15:45:36 -0400
Received: from mout.gmx.net ([212.227.15.18]:44757 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbeHXTpf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 15:45:35 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Me8di-1gJ9uU1cNy-00Pu5o; Fri, 24
 Aug 2018 18:10:12 +0200
Date:   Fri, 24 Aug 2018 18:10:11 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     Pratik Karki <predatoramigo@gmail.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/11] builtin rebase: support --force-rebase
In-Reply-To: <CAGZ79ka1uokeUzyZ37=o7J0Tu0k8P4fKj8hv8L-GpktU5i7+mQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1808241809110.73@tvgsbejvaqbjf.bet>
References: <20180808134830.19949-1-predatoramigo@gmail.com> <20180808134830.19949-9-predatoramigo@gmail.com> <CAGZ79ka1uokeUzyZ37=o7J0Tu0k8P4fKj8hv8L-GpktU5i7+mQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:79/MnkT/N+uyd1ifN0QmQPeJF4DZRKcaBt3am8twMrs+eUNr8Ej
 n+NMxOJJCmmvOiej6keUo1dZq1/gHszOxNKhSCzzoJAjySxFRVOxoK0UA+gmv5PjahjZhjK
 TdjdZndAaHozNqcouOknr6H7c0E/N2/znJIw86j5KKrehHUPqDyx5IGiWtIXjtMNnfZnIKm
 wFa1rXSU+4T/B/BhnG7aw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Lz2RYvdlvhU=:NmoCfZai8FmQwFmMUcxp9v
 jrWnRrZN8F1EAgbmsHvFOnmzM87wuvuMs5ZqECpKh6xsDELAYAXPpxbeUa/jRZ2Nd0OBefgDz
 IR94m4A4PePwjhaNYaSxbamTV/N2ar9KRF8cIJhSwGjOhMGQkvnN2opLBmfaC6lRrNN2Y6ebB
 2rcbKsjHT1bCsiL892vSRenSG9x7vFhX8JO7N1xXZUA8UqNQnJ3jcGoTw874LIFI29TWi/qQN
 uwP+I6kuv+ObuLqplJs9rZnNeBgOGmQR1sRGdnOZH9Ai+uP2EtrTkZK5Qi/vNqvEdcCpqGIEa
 2FMLP8q5pvnhLsPzukGasOG4jUbugAP9HciLfnttzKFdjj4thTNBEnraqD5KbutBtdF27QTpv
 YQZ8PEKuslah3oW7hFmrteCxNsv9Lk8ZnpXI1NXToOk+6ovIBOtUNxQZ7t96spISpcyA2Q3+U
 TY2x+CD3XMIpOQG9jg1Z3iFCKNr+tdh50O9TrqMrxOp7v5/YHGgECGfPKoGq0MSkye0qybpij
 NPkJlwFjJ3/nbTveqErpz41bl9kSPp8Rnrd1mIBN5MskZW0rkJY3zGrkTBHXOR5FG8zBQW7Gi
 JdY4ObjJuhm+LrK+ffUOz41D89ic79KGtHeia0JpT+E5jqPBzA+ounkH/FoREt8pw1XEFSh8P
 GC0oy10oPnhppIF1Gq/gJ653xYfkqLX9h8oh5sUmAdqv/LsDKhEDYT+jnsQgWNQxCKmC5DPgj
 BBlqqvxhZlExAenG51FVEpn5lgeKkj1HkCq6WXasK70pdLGRF51hvIpi10xbLnBQS/9AG+ADT
 rGaVOPt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Wed, 8 Aug 2018, Stefan Beller wrote:

> On Wed, Aug 8, 2018 at 6:51 AM Pratik Karki <predatoramigo@gmail.com> wrote:
> 
> > @@ -551,10 +560,21 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
> [...]
> >                         ; /* be quiet */
> >                 else if (!strcmp(branch_name, "HEAD") &&
> > -                       resolve_ref_unsafe("HEAD", 0, NULL, &flag))
> > +                        resolve_ref_unsafe("HEAD", 0, NULL, &flag))
> 
> This line is changing only the indentation whitespace?
> Would it make sense to have it in the previous patch?

Correct. I will fix this before sending the next iteration,
Dscho
