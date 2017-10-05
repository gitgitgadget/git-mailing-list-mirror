Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18DD620281
	for <e@80x24.org>; Thu,  5 Oct 2017 12:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751344AbdJEMU7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 08:20:59 -0400
Received: from mout.gmx.net ([212.227.17.21]:64435 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751317AbdJEMU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 08:20:58 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LhwAY-1dUqrE1yiY-00n9eV; Thu, 05
 Oct 2017 14:20:54 +0200
Date:   Thu, 5 Oct 2017 14:20:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] for-each-ref: let upstream/push optionally report
 the remote name
In-Reply-To: <xmqq376zcrls.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1710051419590.40514@virtualbox>
References: <cover.1506952571.git.johannes.schindelin@gmx.de> <0e03bf1e50e24a52f57be0f51d19f4657c68d2fa.1506952571.git.johannes.schindelin@gmx.de> <xmqq376zcrls.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:oYQoB5pZZXJbkXKnl9GTromrbdqy098djL6tbQfpZFSsHSxMPqy
 hMlTo3n2UHwMdXBe8iY8yYjPFLqL8TcyUePCG4iS93MstormeoLbJdzhibuKCzhjNaviqMj
 XpDPMPgN/WRDTsJDPg4AD6qfVXEVN0uijklZq12f6+GdBUik21fnBmWxWw3Qgj5b4r717VJ
 T8uS0U6d/XcC0COmBifaw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:C8xDFAn4b6s=:YLVYQwS7o3sCkcro5MF3PS
 ktf0qV2nYw5KM+EIAaquNkYiHItqptifbVmleugYyuPkI5Y3IA7qDWiQy3KzzxYBQ/Gs+GHK7
 K+DVtPA7j4I3XjPoxtl7ycxxRaiZhBietwMePOxPTvq12xqd0ZZzTcUoPCVJ/uQl25iKv1Zw/
 LEYljB5+gsXhmHs7L+QG4sF/bUQknV5dUHZaeJx3F4kKCbqk+kGY7zXNLZjPsXjdNRMR1LxDS
 VMZKUz6hOqpM7AIZxpkLVRZjPoKXr1KOIMuUmp2skQAZQNRLSVXdmdxLdPPsrCkKwGykqLjXO
 1gpBR2JgoQWltBA0dESkM9CvFtKH3eHvgjexH/0VSk6QLL5oyrsP/n4tC+KCRAfOYHSYyYhFa
 GmTIqPGZ3XqpyZCPwzdUJqIhWsTF7kZ5A3RPP8Nah2+5mb7rCGnUr0W/FG5j8YK+bLDY8P34t
 8BDmZxN2mYdyCH1jDGayuoGSaqiQTm4NC9zqNV6ZSLEQm3HN224A+zQkHGh++KuFI1BXhDyQT
 G5tdluGZE8TjEW31uklakBOZg6whwtIqCrb/ryEelV9lmrtqh9J2eBICzfSxhPKcnf53zefuc
 DYmdy/Oh9gjyHA0B9sSciEoDeZ3BKqzR2IHOfKttWvjpzjft4kwBeZ6WMBe1xS0+uwy3ihV8E
 zQG9QwCFr2nHSGExNJTO850kizCnd7ezmYsyynrZPYqEBZ78uuyGkYCr8XqFCeg0GcKdVNLce
 mV7ovcbPn0P0ljG7bOe2QxLgRJJMcW1akyYdTmJYGxkVtSlfYF2uj2xCRrfyLceg1om8q22zj
 m0JOrsgfOrVprdMWAcbuvDb3aNDFIIeUmJiCyQyJc7Ei7gDMOo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 4 Oct 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > This patch offers the new suffix :remote for the upstream and for the
> > push atoms, allowing to show exactly that.
> 
> Has the design changed since this description and examples were
> written?

Obviously.

Also, I tried to address all of your concerns (or at least those that were
remaining in the end).

Thank you for your review,
Dscho
