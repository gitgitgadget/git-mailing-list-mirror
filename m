Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD9641FC96
	for <e@80x24.org>; Thu,  1 Dec 2016 07:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753413AbcLAHZI (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 02:25:08 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:20120 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750908AbcLAHZI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 02:25:08 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3tTphd70Krz5tlX;
        Thu,  1 Dec 2016 08:25:05 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 7E6B4143;
        Thu,  1 Dec 2016 08:25:05 +0100 (CET)
Subject: Re: [PATCH v6 5/6] grep: enable recurse-submodules to work on <tree>
 objects
To:     Brandon Williams <bmwill@google.com>
References: <1479840397-68264-1-git-send-email-bmwill@google.com>
 <1480555714-186183-1-git-send-email-bmwill@google.com>
 <1480555714-186183-6-git-send-email-bmwill@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com,
        jonathantanmy@google.com, gitster@pobox.com
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <c6b2ddad-ac09-3457-8289-88a3f52b7e4b@kdbg.org>
Date:   Thu, 1 Dec 2016 08:25:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.0
MIME-Version: 1.0
In-Reply-To: <1480555714-186183-6-git-send-email-bmwill@google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.12.2016 um 02:28 schrieb Brandon Williams:
> +	git init "su:b" &&

Don't do that. Colons in file names won't work on Windows.

-- Hannes

