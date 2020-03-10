Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A719C10F27
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 14:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A309227BF
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 14:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbgCJOaF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 10:30:05 -0400
Received: from elephants.elehost.com ([216.66.27.132]:14865 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgCJOaF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 10:30:05 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 02AEU3TU063079
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Tue, 10 Mar 2020 10:30:03 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Git'" <git@vger.kernel.org>
References: 
In-Reply-To: 
Subject: RE: t0301: inconsistent test results
Date:   Tue, 10 Mar 2020 10:29:55 -0400
Message-ID: <011301d5f6e8$61e5bfb0$25b13f10$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdXzAX+zNd57wOMrQu2+3Kde64pymQD5sFOQ
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On March 5, 2020 10:22 AM, I wrote:
> When running t0301 on NonStop platforms, we are seeing the subtests 21,
> 24, 25, and 27 failing occasionally but inconsistently under bash and
/bin/sh.
> When run with the --verbose option and/or --debug options, the tests
> consistently succeed. This is perplexing and possibly a problem with our
bash
> and/or /bin/sh, but isolating this is rough. Any advice?

This appears to have been fixed at 2.26.0-rc0.

Regards,
Randall

