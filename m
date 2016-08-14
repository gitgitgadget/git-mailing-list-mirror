Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48E231FD99
	for <e@80x24.org>; Sun, 14 Aug 2016 23:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbcHNXKB (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 19:10:01 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:53266 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751282AbcHNXKA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 19:10:00 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17A471FD99;
	Sun, 14 Aug 2016 23:10:00 +0000 (UTC)
Date:	Sun, 14 Aug 2016 23:10:00 +0000
From:	Eric Wong <e@80x24.org>
To:	Christian Couder <christian.couder@gmail.com>
Cc:	Philip Oakley <philipoakley@iee.org>, git <git@vger.kernel.org>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Nicola Paolucci <durden@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Eric Wong <normalperson@yhbt.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Johannes Sixt <j6t@kdbg.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Josh Triplett <josh@joshtriplett.org>,
	Lars Schneider <larsxschneider@gmail.com>
Subject: Re: Draft of Git Rev News edition 18
Message-ID: <20160814231000.GB12202@dcvr>
References: <CAP8UFD1iveotLsMOBnpa=hU4ohcQjZ-X7tjnzY4k+xz5KJvqBw@mail.gmail.com>
 <D5A2E231FFE74D1C891A1653E1C2D797@PhilipOakley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D5A2E231FFE74D1C891A1653E1C2D797@PhilipOakley>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Philip Oakley <philipoakley@iee.org> wrote:
> From: "Christian Couder" <christian.couder@gmail.com>
> >You can also reply to this email.
> 
> I see you mention in passing (weel in the small headings near the bottom)
> that gmane web interface has gone away. It may be worth noting a few of the
> alternatives, and in particular Eric's newly updated public-inbox
> https://public-inbox.org/git/.

Thanks, I will also add that existing gmane links can be looked up
in instance I maintain via:

	public-inbox.org/git/?q=gmane:123456

It might be worth it to convert numeric links to Message-IDs in older
editions, as I also published a mapping at:

   https://public-inbox.org/.temp/gmane.comp.version-control.git-300599.txt.gz

> I've found it very useful and probably easier to use. (now I've seen
> https://public-inbox.org/design_www.html)

Based on closer reading of RFC3986, section 3.3, I deployed a
change to URL generation last night so the "%40" escape for '@'
no longer shows up in generated URLs (along with a few other
characters):

   https://public-inbox.org/meta/20160814105152.21925-1-e@80x24.org/

It might be worth updating this edition to avoid the percent
escaping since it might confuse users about what the Message-IDs
are (and to avoid users passing "%40" into their MUA)

Old URLs will always continue working, of course.
