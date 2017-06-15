Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE9B61FA7B
	for <e@80x24.org>; Thu, 15 Jun 2017 11:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751902AbdFOLFl (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 07:05:41 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:58952 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751937AbdFOLFk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 07:05:40 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.89)
        (envelope-from <mh@glandium.org>)
        id 1dLSaU-0001N1-2R; Thu, 15 Jun 2017 20:05:18 +0900
Date:   Thu, 15 Jun 2017 20:05:18 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Brandon Williams <bmwill@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, jonathantanmy@google.com,
        Jeff King <peff@peff.net>, Junio Hamano <gitster@pobox.com>
Subject: Re: Which hash function to use, was Re: RFC: Another proposed hash
 function transition plan
Message-ID: <20170615110518.ordr43idf2jluips@glandium.org>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
 <20170306002642.xlatomtcrhxwshzn@genre.crustytoothpaste.net>
 <20170306182423.GB183239@google.com>
 <alpine.DEB.2.21.1.1706151122180.4200@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1706151122180.4200@virtualbox>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 15, 2017 at 12:30:46PM +0200, Johannes Schindelin wrote:
> Footnote *1*: SHA-256, as all hash functions whose output is essentially
> the entire internal state, are susceptible to a so-called "length
> extension attack", where the hash of a secret+message can be used to
> generate the hash of secret+message+piggyback without knowing the secret.
> This is not the case for Git: only visible data are hashed. The type of
> attacks Git has to worry about is very different from the length extension
> attacks, and it is highly unlikely that that weakness of SHA-256 leads to,
> say, a collision attack.

What do the experts think or SHA512/256, which completely removes the
concerns over length extension attack? (which I'd argue is better than
sweeping them under the carpet)

Mike
