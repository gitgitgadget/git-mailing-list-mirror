Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A57AA1FE4E
	for <e@80x24.org>; Mon, 21 Nov 2016 13:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753972AbcKUNjz (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 08:39:55 -0500
Received: from hayek.cendio.se ([193.12.253.119]:56702 "EHLO mail.cendio.se"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753261AbcKUNjz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 08:39:55 -0500
X-Greylist: delayed 543 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Nov 2016 08:39:54 EST
Received: from ossman.lkpg.cendio.se (unknown [IPv6:2a00:801:107:4700:92b1:1cff:fe97:f932])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.cendio.se (Postfix) with ESMTPSA id A7FBCC0A4AE6
        for <git@vger.kernel.org>; Mon, 21 Nov 2016 14:30:47 +0100 (CET)
To:     git@vger.kernel.org
From:   Pierre Ossman <ossman@cendio.se>
Subject: --root seems to cancel out --keep-empty in git-rebase
Organization: Cendio AB
Message-ID: <a7d01933-bdf6-140d-3eb1-f015e1338375@cendio.se>
Date:   Mon, 21 Nov 2016 14:30:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As the subject says, these two commands give identical behaviour:

	git rebase --interactive --keep-empty --root

and:

	git rebase --interactive --root

I.e. --keep-empty has no effect when --root is specified.

Ideas for workaround welcome.

Regards
-- 
Pierre Ossman           Software Development
Cendio AB               https://cendio.com
Teknikringen 8          https://twitter.com/ThinLinc
583 30 Linköping        https://facebook.com/ThinLinc
Phone: +46-13-214600    https://plus.google.com/+CendioThinLinc

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
