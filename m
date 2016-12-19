Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA6BD1FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 13:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762784AbcLSNT7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 08:19:59 -0500
Received: from chiark.greenend.org.uk ([212.13.197.229]:46930 "EHLO
        chiark.greenend.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754837AbcLSNT6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 08:19:58 -0500
Received: by chiark.greenend.org.uk (Debian Exim 4.84_2 #1) with local
        (return-path ijackson@chiark.greenend.org.uk)
        id 1cIxrA-0000ej-Ou; Mon, 19 Dec 2016 13:19:56 +0000
From:   Ian Jackson <ijackson@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <22615.56956.698915.2223@chiark.greenend.org.uk>
Date:   Mon, 19 Dec 2016 13:19:56 +0000
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/5] check-ref-format: Refactor out check_one_ref_format
In-Reply-To: <3e277bb8-bd1f-0d8c-47a7-9673ad711bce@alum.mit.edu>
References: <20161104191358.28812-1-ijackson@chiark.greenend.org.uk>
        <20161104191358.28812-2-ijackson@chiark.greenend.org.uk>
        <3e277bb8-bd1f-0d8c-47a7-9673ad711bce@alum.mit.edu>
X-Mailer: VM 8.2.0b under 24.4.1 (i586-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty writes ("Re: [PATCH 1/5] check-ref-format: Refactor out check_one_ref_format"):
> On 11/04/2016 08:13 PM, Ian Jackson wrote:
> > +static int check_one_ref_format(const char *refname)
...
> This function needs to `return 0` if it gets to the end.

Indeed it does.  I'm kind of surprised my compiler didn't spot that.

Thanks for the careful review!

Regards,
Ian.

-- 
Ian Jackson <ijackson@chiark.greenend.org.uk>   These opinions are my own.

If I emailed you from an address @fyvzl.net or @evade.org.uk, that is
a private address which bypasses my fierce spamfilter.
