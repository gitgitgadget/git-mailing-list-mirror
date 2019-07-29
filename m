Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 277951F462
	for <e@80x24.org>; Mon, 29 Jul 2019 02:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfG2CfI (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jul 2019 22:35:08 -0400
Received: from 195-159-176-226.customer.powertech.no ([195.159.176.226]:49938
        "EHLO blaine.gmane.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfG2CfI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jul 2019 22:35:08 -0400
Received: from list by blaine.gmane.org with local (Exim 4.89)
        (envelope-from <gcvg-git-3@m.gmane.org>)
        id 1hrvVA-000L1w-EE
        for git@vger.kernel.org; Mon, 29 Jul 2019 04:35:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] git-gui: Perform rescan on window focus-in
Date:   Sun, 28 Jul 2019 22:26:51 -0400
Message-ID: <7082b89b-be6c-fd8f-fd8e-397b28b5b1c2@gmail.com>
References: <20190728151726.9188-1-me@yadavpratyush.com>
 <20190728213634.GB162590@genre.crustytoothpaste.net>
 <e3f296a6-f33b-7b52-c4cb-9acf65145e64@yadavpratyush.com>
 <20190728224943.GC162590@genre.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <20190728224943.GC162590@genre.crustytoothpaste.net>
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/28/19 6:49 PM, brian m. carlson wrote:> On 2019-07-28 at 22:10:29, 
Pratyush Yadav wrote:
 >> The function is not documented, and I only started spelunking the code a
 >> couple days back, so I'll try to answer with what I know. It might 
not be
 >> the full picture.
 >>
 >> Running git-gui --trace, these commands are executed during a rescan:
 >>
 >> /usr/lib/git-core/git-rev-parse --verify HEAD
 >> /usr/lib/git-core/git-update-index -q --unmerged --ignore-missing 
--refresh
 >>
 >
 > Great. This sounds like a well-reasoned change. I'll let other folks who
 > use git-gui more chime in to see what they think as well.
 >

I'm assuming this does what is currently done by F5.
A simple rescan from git-gui in the git repository takes about 8 seconds 
on my corporate laptop running Windows, making this happen on change of 
window focus is definitely not a friendly change from my view point.

Mark

