Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B59F20986
	for <e@80x24.org>; Mon,  3 Oct 2016 10:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752136AbcJCKAw (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 06:00:52 -0400
Received: from mail.gooeysoftware.com ([208.100.15.213]:58805 "EHLO
        mail.gooeysoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751140AbcJCKAv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 06:00:51 -0400
X-Greylist: delayed 541 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Oct 2016 06:00:51 EDT
Received: from [192.168.1.3] (82-69-83-224.dsl.in-addr.zen.co.uk [82.69.83.224])
        by mail.gooeysoftware.com (Postfix) with ESMTPSA id 956B918A2784
        for <git@vger.kernel.org>; Mon,  3 Oct 2016 04:52:56 -0500 (CDT)
Message-ID: <57F229D5.6060005@game-point.net>
Date:   Mon, 03 Oct 2016 10:50:13 +0100
From:   Jeremy Morton <admin@game-point.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     git@vger.kernel.org
Subject: Autoupdate / autoinit submodules?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apologies if this has already been discussed, but did any of the 
proposed patches to allow .gitmodules to be configured for a submodule 
to be automatically recursive cloned and/or automatically updated on 
pull make it in yet?

My use-case for submodules - which is shared libraries - almost always 
requires a recursive clone, so having to remember the --recursive 
param (or to use an alias) is annoying (and I usually forget), and it 
usually requires pulling the latest master on a "git pull", too.  I 
think both of these things should be able to be automated through git 
module configuration.

-- 
Best regards,
Jeremy Morton (Jez)
