Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B523F20248
	for <e@80x24.org>; Sat, 16 Mar 2019 21:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfCPV6J (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Mar 2019 17:58:09 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:30940 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726493AbfCPV6J (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Mar 2019 17:58:09 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 44MGXb28PPz5tlB;
        Sat, 16 Mar 2019 22:58:07 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id A8ED520D1;
        Sat, 16 Mar 2019 22:58:06 +0100 (CET)
Subject: Re: "man gitattributes" doesn't explain comma-separated attribute
 values
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
References: <alpine.LFD.2.21.1903160816410.10724@localhost.localdomain>
Cc:     Git Mailing list <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <408d82f6-e935-487a-6d0c-9ec4be5e8b6e@kdbg.org>
Date:   Sat, 16 Mar 2019 22:58:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.1903160816410.10724@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.03.19 um 13:22 schrieb Robert P. J. Day:
>   as a working example, i looked at the top-level .gitattributes file
> in the git source code itself, which opens with:
> 
>   * whitespace=!indent,trail,space
>   *.[ch] whitespace=indent,trail,space diff=cpp
>   *.sh whitespace=indent,trail,space eol=lf
>   ... snip ...
> 
> first observation is that i see nothing in the man page that explains
> the notion of a comma-separated list of attribute values.

This comma-separated list is not a property of attributes in general,
but a property of the whitespace attribute in particular. See
core.whitespace in git-config(1) and "Checking whitespace errors" in
gitattributes(5).

-- Hannes
