Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F1CE207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 18:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752292AbcJCSPz (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 14:15:55 -0400
Received: from mail.gooeysoftware.com ([208.100.15.213]:60929 "EHLO
        mail.gooeysoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752168AbcJCSPz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 14:15:55 -0400
Received: from [192.168.1.3] (82-69-83-224.dsl.in-addr.zen.co.uk [82.69.83.224])
        by mail.gooeysoftware.com (Postfix) with ESMTPSA id 002A818A2781
        for <git@vger.kernel.org>; Mon,  3 Oct 2016 13:17:00 -0500 (CDT)
Message-ID: <57F29FEF.30700@game-point.net>
Date:   Mon, 03 Oct 2016 19:14:07 +0100
From:   Jeremy Morton <admin@game-point.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     git@vger.kernel.org
Subject: Reference a submodule branch instead of a commit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At the moment, supermodules must reference a given commit in each of 
its submodules.  If one is in control of a submodule and it changes on 
a regular basis, this can cause a lot of overhead with "submodule 
updated" commits in the supermodule.  It would be useful of git allows 
the option of referencing a submodule's branch instead of a given 
submodule commit.  How about adding this functionality?

-- 
Best regards,
Jeremy Morton (Jez)
