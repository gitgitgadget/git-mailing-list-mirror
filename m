Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B608C433DF
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 14:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C8082065C
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 14:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgFAOug (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 10:50:36 -0400
Received: from elephants.elehost.com ([216.66.27.132]:30895 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgFAOug (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 10:50:36 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [173.32.57.223])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 051EoXBd078392
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Mon, 1 Jun 2020 10:50:34 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: Regression cycle running for 2.27.0.rc0 for HPE NonStop TNS/E
Date:   Mon, 1 Jun 2020 10:50:28 -0400
Message-ID: <006b01d63824$0100b510$03021f30$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdY4I4qKSn3KB1oMT4qrxH+rpqcrqQ==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our NonStop TNS/E platform variant machine is moved and now back up for
certification use. I am running a full regression cycle for 2.27.0.rc2. The
last cycle we ran successfully on that platform was 2.23.0 back in February
2020 before it was packed up. The platform variant TNS/X passes 2.27.0.rc2.
Will report back in 50 hours or so how that works it - yes, it's a slow box.

Cheers,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



