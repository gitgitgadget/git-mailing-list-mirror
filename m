Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD2071F43C
	for <e@80x24.org>; Mon, 13 Nov 2017 11:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752385AbdKMLWh (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 06:22:37 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:46603 "EHLO mail.cixit.se"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751756AbdKMLWh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 06:22:37 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
        by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id vADBMT3C023316
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 13 Nov 2017 12:22:29 +0100
Received: from localhost (peter@localhost)
        by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id vADBMT5J023312;
        Mon, 13 Nov 2017 12:22:29 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
Date:   Mon, 13 Nov 2017 12:22:29 +0100 (CET)
From:   Peter Krefting <peter@softwolves.pp.se>
To:     Elijah Newren <newren@gmail.com>
cc:     Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: cherry-pick very slow on big repository
In-Reply-To: <CABPp-BEu_DOg5t0qHnyLYSok+J+onGFPoFBbgp9P-S5JfhcRjw@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1711131221150.22867@ds9.cixit.se>
References: <alpine.DEB.2.00.1711100959300.2391@ds9.cixit.se> <20171110102011.yqtka6a3wmgcvkl6@sigill.intra.peff.net> <alpine.DEB.2.00.1711101333030.2391@ds9.cixit.se> <7e242038-50e5-2cfc-e810-401af78b8cdc@gmail.com> <alpine.DEB.2.00.1711101436270.2391@ds9.cixit.se>
 <CABPp-BEu_DOg5t0qHnyLYSok+J+onGFPoFBbgp9P-S5JfhcRjw@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Organization: /universe/earth/europe/norway/oslo
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Mon, 13 Nov 2017 12:22:29 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren:

> I would be very interested to hear how my rename detection 
> performance patches work for you; this kind of usecase was the exact 
> one it was designed to help the most.  See 
> https://public-inbox.org/git/20171110222156.23221-1-newren@gmail.com/

I'd be happy to try them out. Is there a public repo where I can pull 
these patches from instead of trying to apply them manually, as there 
are several patch series involved here?

-- 
\\// Peter - http://www.softwolves.pp.se/
