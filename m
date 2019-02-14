Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC2241F453
	for <e@80x24.org>; Thu, 14 Feb 2019 15:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404600AbfBNPFL convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 14 Feb 2019 10:05:11 -0500
Received: from elephants.elehost.com ([216.66.27.132]:45383 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387401AbfBNPFK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 10:05:10 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1EF53fb013288
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 14 Feb 2019 10:05:04 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Cc:     <szeder.dev@gmail.com>, "'Max Kirillov'" <max@max630.net>
Subject: RE: [ANNOUNCE] Git v2.21.0-rc1 (NonStop Results)
Date:   Thu, 14 Feb 2019 10:04:56 -0500
Message-ID: <001501d4c476$a94651d0$fbd2f570$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdTEdZDqoV9s9iqeRr2p4IFSCOx6jQ==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 13, 2019 22:33, Junio C Hamano wrote:
> A release candidate Git v2.21.0-rc1 is now available for testing at the usual
> places.  It is comprised of 464 non-merge commits since v2.20.0, contributed
> by 60 people, 14 of which are new faces.

We are currently running through a full regression of v2.21.0-rc1 on NonStop. It will take about 30 hours, but preliminary results, relative to breakages found in rc0 are:

t1308 is fixed.
t1404 is still broken (explainable) - scraping strerror output mismatches reported error on NonStop for EEXIST
t5318 is fixed.
t5403 is fixed.
t5562 still hangs (blocking) - this breaks our CI pipeline since the test hangs and we have no explanation of whether the hang is in git or the tests.

Cheers,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.




