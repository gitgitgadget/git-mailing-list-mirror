Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 476951F404
	for <e@80x24.org>; Wed,  5 Sep 2018 18:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbeIEX3X (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 19:29:23 -0400
Received: from [195.159.176.226] ([195.159.176.226]:49119 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbeIEX3W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 19:29:22 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-3@m.gmane.org>)
        id 1fxcxo-0001r7-VG
        for git@vger.kernel.org; Wed, 05 Sep 2018 20:55:40 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 2/9] ci/lib.sh: encapsulate Travis-specific things
Date:   Wed, 5 Sep 2018 20:57:44 +0200
Message-ID: <179314eb-774a-bc98-4a41-f79ec78c8466@gmail.com>
References: <pull.31.git.gitgitgadget@gmail.com>
 <18e6beec5f48ad5a17c7c7309e0507b01a53c2ec.1536009027.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12)
 Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
X-Mozilla-News-Host: news://news.gmane.org
In-Reply-To: <18e6beec5f48ad5a17c7c7309e0507b01a53c2ec.1536009027.git.gitgitgadget@gmail.com>
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/3/2018 11:10 PM, Johannes Schindelin via GitGitGadget wrote:

> +if test -n "$TRAVIS_COMMIT"
> +then
> +	# We are running within Travis CI

Personally, I'd find a check like

if test "$TRAVIS" = "true"

more speaking (also see [1]).

[1] https://docs.travis-ci.com/user/environment-variables/

-- 
Sebastian Schuberth

