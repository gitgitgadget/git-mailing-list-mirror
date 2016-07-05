Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38AF12023C
	for <e@80x24.org>; Tue,  5 Jul 2016 11:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754822AbcGELnT (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 07:43:19 -0400
Received: from mout.gmx.net ([212.227.15.18]:60419 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754779AbcGELnS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 07:43:18 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M2L2a-1bd1ZD3rXA-00s2tf; Tue, 05 Jul 2016 13:43:04
 +0200
Date:	Tue, 5 Jul 2016 13:43:01 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff King <peff@peff.net>
cc:	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Marc Strapetz <marc.strapetz@syntevo.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: topological index field for commit objects
In-Reply-To: <20160629223007.GA4726@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1607051339040.8378@virtualbox>
References: <f15a14a5-f39d-9c41-16b9-fe0a48d7450b@syntevo.com> <CAPc5daVC-+0Vr30L_pbcL0GN2OmnGm-+V4tE2WTos_vPRb_S1g@mail.gmail.com> <CAGZ79kY6Ry+DfO90wza_RrVbCRAgNB4N=0W6svuJgvGNxeFh5Q@mail.gmail.com> <xmqqk2h73f2i.fsf@gitster.mtv.corp.google.com>
 <20160629205647.GA25987@sigill.intra.peff.net> <5774426F.3090000@gmail.com> <20160629220049.GA4416@sigill.intra.peff.net> <xmqqlh1n1w84.fsf@gitster.mtv.corp.google.com> <20160629223007.GA4726@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:zDCwenbvbjfuKnwO2obJtgMLc9m3xN/5lOoIsHBxQTVONnEj5WS
 edpN2TVzc2gLcgUnS4dFQl30XSpkyai3cp2Z/1yidzJ2FC+RJ3k+35BeY+zybLZkm5/UWuw
 u/ezV7mI6h9LjwaHLd4eKek4d+FtsHGecadFGF8aS1viVfI40P/RaZ5oOKFAogEs0H7sK4a
 V4tb9PV0Heg4843fnuETQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:ApsJu5hx5nk=:tKNknOlYBuoFh/XJojg2gO
 MjADH7hUz+tUSomBa4OGEjkHQbTlq7GxvvttxhvagaB5A0TGormgvIMS8lT37FdCzY4HhF2ys
 1ad6j9RklukxWCm9vtEq6mTPyWSrhEahvs684e9SPFUomLGzhHCEBaoq/IKnB2rGxDEPBoStA
 NUBHRz+4bPMmmf8lKUULwyZs85Mh2HX8tEsbUNu+RvfxENnSEGBI4fvsHsoZdmxGi6075oVWd
 ph0IzfzN5zDU+9qPyW9ixtGg0uDrC82DUEMqOhfDQYmcf2LoJaxtikAJOaVIoiRKTG0DxzHea
 YuKNEyrVQbIHdhCfv8Vf+3h5yYjfXH0NsLGJbj2ZZHjUXFRXuuv9s47bIUMjuqr8vrRJjeiIs
 z6pBBwVTg7o9YLw/ypn7JxSr0ToTrgcmn8/870uMl3/Yj67B0TGTDnUf52w7AC2JDKXn1MyYl
 EAR0nvcY3NHKtNwKO4ldUHnDB2fXhGsJrOBuwckip447M1k5niZvMO1CGvn606X2j3996fMJx
 cvf8wnp6d/Qa3+dQRCa7c5c71cvOmuxsJFW4ZNhxFFib+Mq9OfTL/0B9J5EhxVve6qd1X6MBr
 W3Nrr400d4KwdQ+Z3XTxaszDYRZ+ndgrkG29W9HSw1D1sM8wY1sjqSYbet+isUxOrRg+QWelY
 FbCmJGf8vCWmTQ/4S1qT+nrMpx5hLmtdKn5cYQavvb89opn3+LJ+9h81wlN3rVTGCjTK2o8X4
 SCOioCJRLZC8pac84EYLZRq93F2BUSCXMPlLgkGZ6rOLR60rUmQmGZ/dDY1ftPpK7xRMkziix
 dd87CTA
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Peff,

On Wed, 29 Jun 2016, Jeff King wrote:

> I haven't thought hard specifically about merge bases computation, so
> perhaps that is a case that isn't helped at all.

I guess it is not helped by generation numbers.

But then, we often ask: "is commit A an ancestor of commit B" e.g. to
check whether we can fast-forward. The way we do it now is to compute the
merge base (singular: if there are more than one, we stop at the first one
we found) and then look whether commit A is identical to the merge base.

If we had generation numbers available, then we would have to change those
computations in order to benefit from them when determining ancestry.

But then, reachability would accelerate that even more than generation
numbers.

Ciao,
Dscho
