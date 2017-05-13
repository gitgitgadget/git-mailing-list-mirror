Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6195820188
	for <e@80x24.org>; Sat, 13 May 2017 15:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752380AbdEMPh3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 11:37:29 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:9593 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751519AbdEMPh3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 11:37:29 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wQ9vV6cXYz5tlM;
        Sat, 13 May 2017 17:37:26 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 25F7442B7;
        Sat, 13 May 2017 17:37:26 +0200 (CEST)
Subject: Re: [PATCH v4 1/3] usability: don't ask questions if no reply is
 required
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jean-Noel Avila <jn.avila@free.fr>, git@vger.kernel.org
References: <20170503162931.30721-1-jn.avila@free.fr>
 <20170512130317.25832-1-jn.avila@free.fr>
 <xmqqpofd4s91.fsf@gitster.mtv.corp.google.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <3c1fb7c7-9306-b0c9-f0ea-cabcd944b124@kdbg.org>
Date:   Sat, 13 May 2017 17:37:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <xmqqpofd4s91.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.05.2017 um 00:36 schrieb Junio C Hamano:
> Thanks, all three patches look good.  Will queue.
> 
> Let's merge them to 'next' soonish and eventually down to 'master'
> and 'maint'.

The patches change translated strings. You should probably wait for an 
update of their translations before you release a maintenance version 
with these changes.

-- Hannes
