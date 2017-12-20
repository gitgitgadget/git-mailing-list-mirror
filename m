Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 900CE1F406
	for <e@80x24.org>; Wed, 20 Dec 2017 04:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754290AbdLTEa2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 23:30:28 -0500
Received: from p3plsmtpa07-06.prod.phx3.secureserver.net ([173.201.192.235]:51424
        "EHLO p3plsmtpa07-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754243AbdLTEa2 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2017 23:30:28 -0500
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with SMTP
        id RW1LerJlQBxSsRW1QerhAT; Tue, 19 Dec 2017 21:30:27 -0700
Date:   Wed, 20 Dec 2017 06:30:21 +0200
From:   Max Kirillov <max@max630.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Max Kirillov <max@max630.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v6 0/2] http-backend: respect CONTENT_LENGTH as specified
 by rfc3875
Message-ID: <20171220043021.GA20508@jessie.local>
References: <20171126193813.12531-1-max@max630.net>
 <xmqqo9mutlgy.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo9mutlgy.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfI+0JVWk3oaMBpIAUu9V0EX7Kel6Zub868Bl95jNd3eUaYnqu2+tv/dKs6GninuLZ2HUsIbS7UzIA9IAUNV1uIQrcMPObnD+scQqfD87akNl7freNc7m
 nOQ/iJFhb/U9C4CAh3hegM3pv2G+w2skArbdaT5OXK2g0DqwUDXBBL0vfkZjqyyC8iybPkEIBeYV2JoNPdElzj6V/PoQDsvYsVW21y+6up6+4SXNU2W3wKKL
 XDFAeUvA2cPPdUSsjT9HCbZCkARacmZsRtONGHeLif2VB2IdHJDs+eyKtv22b2jYDjvORy7TvrkrGpqu0jMBlxi57hXoTbLq3Q9CY10L6TWI+NC4RMZYX1wM
 64nyL26nHERnOuv3HCQ70VHrkWT+U2wDZ6DPgBSLSR4rpIO4FJo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 19, 2017 at 02:13:33PM -0800, Junio C Hamano wrote:
> So... is there going to be an update (or has there been one and I
> missed it)?

Yes there it! I wanted to add tests for the cases Jeff
mentioned. It is almost done, I just need to check I did not
miss some note.
