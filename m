Return-Path: <SRS0=Mgdg=4W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E052C3F2CD
	for <git@archiver.kernel.org>; Thu,  5 Mar 2020 15:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55FEE2073D
	for <git@archiver.kernel.org>; Thu,  5 Mar 2020 15:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgCEPWZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Mar 2020 10:22:25 -0500
Received: from elephants.elehost.com ([216.66.27.132]:27998 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgCEPWZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Mar 2020 10:22:25 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 025FMMLg098036
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Thu, 5 Mar 2020 10:22:23 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Git'" <git@vger.kernel.org>
Subject: t0301: inconsistent test results
Date:   Thu, 5 Mar 2020 10:22:16 -0500
Message-ID: <017f01d5f301$dde755a0$99b600e0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdXzAX+zNd57wOMrQu2+3Kde64pymQ==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running t0301 on NonStop platforms, we are seeing the subtests 21, 24,
25, and 27 failing occasionally but inconsistently under bash and /bin/sh.
When run with the --verbose option and/or --debug options, the tests
consistently succeed. This is perplexing and possibly a problem with our
bash and/or /bin/sh, but isolating this is rough. Any advice?

Thanks,
Randall
 
-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.


