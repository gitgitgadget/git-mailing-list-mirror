Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4B621F597
	for <e@80x24.org>; Fri, 27 Jul 2018 03:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbeG0FKI (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 01:10:08 -0400
Received: from p3plsmtpa12-04.prod.phx3.secureserver.net ([68.178.252.233]:51296
        "EHLO p3plsmtpa12-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725988AbeG0FKI (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 27 Jul 2018 01:10:08 -0400
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id itlcfstpYrxlhitlffEvLE; Thu, 26 Jul 2018 20:50:17 -0700
Date:   Fri, 27 Jul 2018 06:50:13 +0300
From:   Max Kirillov <max@max630.net>
To:     Max Kirillov <max@max630.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v9 0/3] http-backend: respect CONTENT_LENGTH as specified
 by rfc3875
Message-ID: <20180727035013.GC1959@jessie.local>
References: <20180610150521.9714-1-max@max630.net>
 <20180727034859.15769-1-max@max630.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727034859.15769-1-max@max630.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfCZqqX5nIf6B9YFgOMY076X+/v23SEaTeN6wLR7iTwCxuBhEZCiGuUZY/XSNRbvkoFCYznXBgjN/EEoKp2KiT78IBAwpXDC1Xbx6sM1iutFqVOIBZ+eB
 Lul5kNiTa5lJiD53xUctFW+WbxF8RU3TKZyVXW80RKQFiUK7oyrz6DlIbYEFSDF93vXUzYvfZVQ8625X3FWVLXlnbhYG/7vVmKf99hZfIn7uFHx2qyZMvqF3
 gKsU2Vyq0CvaVWGRLdf0Klz1FJfRyRQeJFzKs+9VpkQJVHKbH+nNCOs4zjK3e/eeSOtmSTmIwInJUBZ3BJUWMssou8fd6UwyWutUMiCKFQ7zThl7RUj2SErv
 /EuNbKuBTGNQXzyrNOqLHMRGBY1+uqDrNJy1TnElZCoFOVmdW1nhdcbWaL5DStRRQpkdTbdhmZbiFBMMq746+/l/8resvA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Only the 3rd patch has changed
