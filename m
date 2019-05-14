Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E14081F461
	for <e@80x24.org>; Tue, 14 May 2019 09:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfENJZG (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 05:25:06 -0400
Received: from hayek.cendio.se ([193.12.253.119]:42074 "EHLO mail.cendio.se"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726148AbfENJZG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 05:25:06 -0400
X-Greylist: delayed 347 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 May 2019 05:25:06 EDT
Received: from ossman.lkpg.cendio.se (unknown [IPv6:2a00:801:107:4700:92b1:1cff:fe97:f932])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.cendio.se (Postfix) with ESMTPSA id E9F49C0A4A4C
        for <git@vger.kernel.org>; Tue, 14 May 2019 11:19:17 +0200 (CEST)
To:     git@vger.kernel.org
From:   Pierre Ossman <ossman@cendio.se>
Subject: git blame doesn't respect diff algorithm?
Openpgp: preference=signencrypt
Autocrypt: addr=ossman@cendio.se; keydata=
 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
 oK3I6bEZ79k5bBHzCAw=
Organization: Cendio AB
Message-ID: <f0ed56fd-092e-92e5-35b5-7adfd740d5bf@cendio.se>
Date:   Tue, 14 May 2019 11:19:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

It seems like there is a bug in git blame where it doesn't respect the
diff algorithm setting. It happily parses it on the command line, but
there is no change to the output.

The problem materialises in that git blame will claim a line comes from
a certain commit. But when I do "git show --patience" on that commit,
the relevant line was not changed.

I could not find anything about this on the mailing list, so is this a
previously overlooked issue?

If you want to test it for your self, then do:

 1. Clone tigervnc's git repo
 2. git blame --patience vncviewer/DesktopWindow.cxx
 3. Check line 906, it should say 7e546feba
 4. git show --patience 7e546feba

This was with git-2.20.1-1.fc29.x86_64.

Regards
-- 
Pierre Ossman           Software Development
Cendio AB               https://cendio.com
Teknikringen 8          https://twitter.com/ThinLinc
583 30 Linköping        https://facebook.com/ThinLinc
Phone: +46-13-214600

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
