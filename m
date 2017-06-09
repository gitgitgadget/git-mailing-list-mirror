Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A9B01FAED
	for <e@80x24.org>; Fri,  9 Jun 2017 08:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751726AbdFII2B (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 04:28:01 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:14336 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751576AbdFII2A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 04:28:00 -0400
X-Greylist: delayed 73905 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Jun 2017 04:28:00 EDT
Received: from [91.113.179.170] (helo=[192.168.92.20])
        by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.89)
        (envelope-from <marc.strapetz@syntevo.com>)
        id 1dJFGt-0007ji-Ry; Fri, 09 Jun 2017 10:27:55 +0200
Subject: Re: git stash --include-untracked possible destructive behavior
To:     Joel Teichroeb <joel@teichroeb.net>,
        Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
References: <2b695c73-9de2-5502-6d19-ba4ad0114978@syntevo.com>
 <197975d0-7ec3-0ff4-9201-48226fd3b60c@teichroeb.net>
 <20170608222949.GA121539@google.com>
 <e45eed21-f808-b2a8-a01b-78c18a9c343a@teichroeb.net>
From:   Marc Strapetz <marc.strapetz@syntevo.com>
Message-ID: <7bb9829b-21a4-bd9e-c6f1-521b808793ea@syntevo.com>
Date:   Fri, 9 Jun 2017 10:28:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <e45eed21-f808-b2a8-a01b-78c18a9c343a@teichroeb.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09.06.2017 00:39, Joel Teichroeb wrote:
> Looks like that series was merged last week, fixing this issue.
> 
> Marc, the fix will probably be in git 2.14.

Thanks, I can confirm that with current master "git clean" as well as 
"git stash" are working properly now (tested on Linux). I'm looking 
forward to version 2.14.

-Marc
