Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 084F41F404
	for <e@80x24.org>; Tue, 11 Sep 2018 12:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbeIKRv5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 13:51:57 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:2730 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbeIKRv5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 13:51:57 -0400
Received: from [192.168.1.108] (unknown [164.177.97.114])
        (Authenticated sender: jn.avila)
        by smtp6-g21.free.fr (Postfix) with ESMTPSA id 6659B780394
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 12:52:41 +0000 (UTC)
To:     git <git@vger.kernel.org>
From:   =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
Subject: Help on autocompletion not localized?
Message-ID: <3d9c42ea-70ba-a27c-1ece-797829caa1b0@free.fr>
Date:   Tue, 11 Sep 2018 14:52:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,


When invoking the autocompletion help with <TAB><TAB> after a double
hyphen under zsh, the help list is not localized. I guess the help list
comes from some usage output of the on-going git command, but I wasn't
able to find where and how this happens (completion scripts are quite
hairy).


Thanks
