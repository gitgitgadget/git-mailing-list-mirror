Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 999471F404
	for <e@80x24.org>; Wed,  4 Apr 2018 02:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755295AbeDDCjl convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 3 Apr 2018 22:39:41 -0400
Received: from elephants.elehost.com ([216.66.27.132]:42936 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754850AbeDDCjj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 22:39:39 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w342dZfT032139
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 3 Apr 2018 22:39:36 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Cc:     "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
        <git-packagers@googlegroups.com>
References: <xmqq6059z9kz.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq6059z9kz.fsf@gitster-ct.c.googlers.com>
Subject: RE: [ANNOUNCE] Git v2.17.0
Date:   Tue, 3 Apr 2018 22:39:29 -0400
Message-ID: <025601d3cbbe$2b5a9da0$820fd8e0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFhLuUQLx28uJBqsgyhh0QfTRDAYKTVHiJw
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 2, 2018 3:34 PM, Junio C Hamano wrote:
> Subject: [ANNOUNCE] Git v2.17.0
> 
> The latest feature release Git v2.17.0 is now available at the usual places.  It is
> comprised of 516 non-merge commits since v2.16.0, contributed by 71
> people, 20 of which are new faces.

The NonStop platform variant's regression suite (after applying are now very small set of platform mods) had the usual failures in t1308:23, t1404:52, and 4 in t9001. This is equivalent to the same breaks since 2.8.5 through 2.16.2. We should be installing in production tomorrow.

Thanks for everyone's hard work.

Cheers,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.


