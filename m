Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA039C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 15:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BA9261285
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 15:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhFHPke (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 11:40:34 -0400
Received: from elephants.elehost.com ([216.66.27.132]:30043 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbhFHPke (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 11:40:34 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 158Fcdh9073647
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Tue, 8 Jun 2021 11:38:39 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [RFE] Teach git textconv to support %f
Date:   Tue, 8 Jun 2021 11:38:33 -0400
Message-ID: <01f901d75c7c$5a8bcb10$0fa36130$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AddcfFaR9bzvppBzT0OQ9uQSMkuHxw==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The filter structure provides a mechanism for providing the working directory's file name path to a filter using a %f argument. This
request is to teach the textconv mechanism to support the same capability.

The use case comes from a complex content renderer that needs to know what the original file name is, so as to be able to find
additional content, by name, that describes the file (base name+different extension).

If this is considered a good idea, I would be happy to implement this but need a pointer or two of where to look in the code to make
it happen.

Thanks,
Randall


-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.


