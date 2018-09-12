Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1390A1F404
	for <e@80x24.org>; Wed, 12 Sep 2018 19:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbeIMAWO (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 20:22:14 -0400
Received: from elephants.elehost.com ([216.66.27.132]:18421 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbeIMAWO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 20:22:14 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w8CJGFL0010493
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 15:16:15 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [Question] Signature calculation ignoring parts of binary files
Date:   Wed, 12 Sep 2018 15:16:07 -0400
Message-ID: <003901d44acd$12c2bb90$384832b0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdRKy6P0kRI3GRyaTlCi5sGlIY2jOQ==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I feel really bad asking this, and I should know the answer, and yet.

I have a binary file that needs to go into a repo intact (unchanged). I also
have a program that interprets the contents, like a textconv, that can
output the relevant portions of the file in whatever format I like - used
for diff typically, dumps in 1K chunks by file section. What I'm looking for
is to have the SHA1 signature calculated with just the relevant portions of
the file so that two actually different files will be considered the same by
git during a commit or status. In real terms, I'm trying to ignore the
Creator metadata of a JPG because it is mutable and irrelevant to my repo
contents.

I'm sorry to ask, but I thought this was in .gitattributes but I can't
confirm the SHA1 behaviour.

Sheepishly,
Randall


-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



