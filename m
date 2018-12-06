Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75F7F211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 10:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbeLFKmP (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 05:42:15 -0500
Received: from mail.cweiske.de ([5.35.241.22]:56154 "EHLO mail.cweiske.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727575AbeLFKmP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 05:42:15 -0500
X-Greylist: delayed 447 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Dec 2018 05:42:14 EST
Received: by mail.cweiske.de (Postfix, from userid 65534)
        id 315042EE045; Thu,  6 Dec 2018 11:34:46 +0100 (CET)
Received: from [172.16.2.92] (leipzig.mogic.com [146.0.122.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by mail.cweiske.de (Postfix) with ESMTPSA id 24F682EE03E
        for <git@vger.kernel.org>; Thu,  6 Dec 2018 11:34:44 +0100 (CET)
To:     git@vger.kernel.org
From:   Christian Weiske <cweiske@cweiske.de>
Subject: Bug: git add --patch does not honor "diff.noprefix"
Message-ID: <c165fc5f-c452-fb2e-8ac3-d2afb12948bc@cweiske.de>
Date:   Thu, 6 Dec 2018 11:34:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,


When running "git add -p" on git version 2.19.2 and "diff.noprefix" set
to true, it still shows the "a/" and "b/" prefixes.

This issue has been reported in 2016 already[1], but is still there in
2.19.2.


[1]
https://public-inbox.org/git/E1D7329A-A54B-4D09-A72A-62ECA8005752@gmail.com/T/

-- 
Regards/Mit freundlichen Grüßen
Christian Weiske

-=≡ Geeking around in the name of science since 1982 ≡=-
