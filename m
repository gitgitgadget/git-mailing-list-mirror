Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 021A71F453
	for <e@80x24.org>; Fri, 26 Oct 2018 11:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbeJZUIj (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 16:08:39 -0400
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:50727 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727428AbeJZUIj (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 26 Oct 2018 16:08:39 -0400
Received: from tri.shiar.net ([83.161.198.138])
        by smtp-cloud9.xs4all.net with ESMTP
        id G0LHgQ8FzSskCG0LIgfXR7; Fri, 26 Oct 2018 13:31:53 +0200
Received: by tri.shiar.net (Postfix, from userid 1000)
        id 7FA8A21A20A; Fri, 26 Oct 2018 13:31:51 +0200 (CEST)
Date:   Fri, 26 Oct 2018 13:31:51 +0200
From:   Mischa POSLAWSKY <git@shiar.nl>
To:     Jeff King <peff@peff.net>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Junio C Hamano <gitster@pobox.com>,
        "lhf635@163.com" <lhf635@163.com>, git <git@vger.kernel.org>
Subject: Re: the opposite of .gitignore, whitelist
Message-ID: <20181026113151.dgjta7tlcjgnttcx@shiar.net>
References: <201810251039388653199@163.com>
 <xmqqh8hak2mh.fsf@gitster-ct.c.googlers.com>
 <c166b421-a228-8349-0815-2ebb9dcab998@lakedaemon.net>
 <20181026093644.GA20876@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181026093644.GA20876@sigill.intra.peff.net>
User-Agent: Mutt 20170113 + Vim 8.0 (Debian 9.5 GNU/Linux 4.9.0-6-amd64)
X-URL:  http://shiar.nl/
X-Accept-Language: nl, eo, en
X-CMAE-Envelope: MS4wfO1OJCemOvETo+swjAUedJUJoszD9q3Vbma23GdnVubvvoWCYDGSGOCf+u6rwmOQy+v9oP9or4tcji8kkte7m4dz8O/1r048gocEvZDR21Y3eWPI/lKc
 5EVJY8ffLM04wN011T0HNmbUNJ21kR1urqAy0VwF4j/h6XfrzFE0yP1CY4vgntK5rFMl6VNAhXGkTsNsb1177MVKivImh7MX424RANLGygC8M1Vx5vVuxwIo
 IhdxqPASVE0MQO9NH+DBj/BSG2UU3qgxoUBMaJhrb90=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote 2018-10-26 5:36 (-0400):
> I think what Junio meant is to ignore everything by default, like:
> 
>   echo '*' >.gitignore
> 
> and then selectively use negative patterns (and being in .gitignore,
> that makes them positive "yes, include this") to add things back:
> 
>   echo 'foo' >>.gitignore
> 
> which ends up being roughly the same as your .gitonly concept.

To clarify, Peff meant to say echo '!foo' to whitelist. See git help ignore.

-- 
Mischa
