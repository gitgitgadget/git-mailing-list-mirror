Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECE4B202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 22:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753180AbdKAWl4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 18:41:56 -0400
Received: from mout.gmx.net ([212.227.17.20]:59094 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752129AbdKAWlz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 18:41:55 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LpwZn-1dXPAa05Id-00fiVz; Wed, 01
 Nov 2017 23:41:47 +0100
Date:   Wed, 1 Nov 2017 23:41:45 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>, Kevin Daudt <me@ikke.info>
Subject: Re: [PATCHv2 6/7] builtin/describe.c: describe a blob
In-Reply-To: <CAGZ79kbOEM_W65Rym4yiDNHpFGTNWMYdh=aVPjThNWjEHPQong@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1711012340290.6482@virtualbox>
References: <20171031003351.22341-1-sbeller@google.com> <20171031211852.13001-1-sbeller@google.com> <20171031211852.13001-7-sbeller@google.com> <xmqqbmkmvdrq.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1711011329300.6482@virtualbox>
 <CAGZ79kZPNiNnSJd6CNYb7XkTVsT2ONLQLhwAQxt6_SPFTSwMcw@mail.gmail.com> <EF573E5E-EA72-4DEE-822C-B44265FD581B@gmail.com> <alpine.DEB.2.21.1.1711012310250.6482@virtualbox> <CAGZ79kbOEM_W65Rym4yiDNHpFGTNWMYdh=aVPjThNWjEHPQong@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9ZettWPyhnvm3Z8/G/YBuKF7yzru3z12aFGbn03W+GgJ9S3sPpm
 rPG4+LQ8swzwO4VhU2mRuJdGqSxZQAKdlMj28ufDGfuxvQuj7CtkK4q8mKe4Axt3hJPKcZz
 1IrEJsywbFNWdzfMz2b1yiw6OdYii1ueQorqYRN773ZgZIBaN2A4WmWHKgiXjW398oK9IbA
 PCBJiMSPdctrGHhFHoEGA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:owIwFobikiw=:xq1QVB4xDCHMySYnEqgj2U
 GzrX7uAO1sHt5wPvqw7f1xup+l1biD4urbwjma6LuCLeF0we6PGEFLTd52WRzVlhFBb8WnuFC
 fAEiOm/XddS9VQb1Qey2JJ38lUikhphhBNeQp/9ExWT5xpcsl6b0jQ5UvSJrOI0jw3gQMJO/D
 9N5tGq8ONj0Mo/kTY6KC0nKSwkl7i0WAYk1NGSi0RRgkIK4LCnexGOVbHbZrE35f4gw4ORi+3
 uibVBfLFwxxFzAg4IhiPvsU/vafO2QnNdJTrvVDNBPoi0JDjZE59CxJiGikQvuIwYeQLdKTdZ
 nzWVrFgc4IrMVvxl9UcjUSNZ5hVytJZ9TUA9hjlueBwNX+QxWg5vbFP3TOdjegc1UAETcp5De
 qG+NBexD15VjcTEuUWK9WVvxOAwCAqbiEi+uCoGPxiWQ0srr5nS1RX6bqWE+baooqq2wkENzN
 r2FuaHCOqZhuK74a0miI2yuk+EL9K/zXKU4HJFEGWkSVNnnc4QvAlppwvcUoI2+VmWXsDRODn
 7gDiqgCKBJVeiviZYu8ApsKPMoYla0PojpxCIMVzQAJeKBvO83QK0yVW/XQmj/55iNOuOFcvd
 cJ/QioYfdH7s5572SKVs2OPdMiseXlU70YdXM3eac7yK9MusXjS+ZGaK6nbfjouayVrDsesvs
 JvWdHzl0CJ48ZTNErL9mdNvZe9IVrjYrTwv2j+1bLyNLvo1EuIkfZ42y/Xw8dK/kpyBmb3DMO
 1AzPNIvtJmXDtOODup6K5jum9nMtzjZpR045FMCJkHOpVZWHjWp5/7zSTOhTSSI1xiE/iOU+6
 kN8gjEyWgawegj3F0GNCH5N/UrHULJ/b7kQJwLkX0EK/6Bcd44=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Wed, 1 Nov 2017, Stefan Beller wrote:

> >> I know id prefer the first commit that introduced the blob. That's
> >> what describing a commit does, it finds the oldest tag prior to the
> >> commit, while --contains finds the first tag that contains the commit
> >> as an ancestor.
> >
> > It is very easy to wish for "the oldest commit introducing a blob". But
> > since we're in a DAG, this question is not necessarily easy to answer:
> >
> > - A - B - C
> >     \   /
> >       D
> >
> > Let's assume that all commits except A have the blob, and that B and D
> > (for some reason) have the same author/committer dates.
> >
> > Do you identify B or D as the commit introducing the blob?
> 
> The current implementation gives C, though.
> (assuming C is HEAD, and A is ancient)
> 
> With the --reverse flag one of B or D is given (not sure which,
> depends on the exact order).

Sure, but it is still a tricky thing. Imagine

- A1 - B1 - A2 - B2 - B3

where all the B* commits have the blob. Do you really want to report B1
rather than B2 as the commit introducing the blob? (I would prefer B2...)

Ciao,
Dscho
