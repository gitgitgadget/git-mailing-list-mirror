Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B87491F424
	for <e@80x24.org>; Wed,  9 May 2018 22:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965204AbeEIWI5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 18:08:57 -0400
Received: from elephants.elehost.com ([216.66.27.132]:39448 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964997AbeEIWI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 18:08:56 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w49M8sTZ087482
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Wed, 9 May 2018 18:08:55 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [Best Practices Request] clean/smudge configuration
Date:   Wed, 9 May 2018 18:08:48 -0400
Message-ID: <004d01d3e7e2$517f78d0$f47e6a70$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdPn4NUCstNnS+0cQpWUjmoIOEpPow==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Git Team,

I'm trying to work out some best practices for managing clean/smudge filters
and hit a bump. The situation is that I have an environment where the
possible clean/smudge filter configuration can change over time and needs to
be versioned with the product being managed in a git repository. Part of the
configuration is no problem in .gitattributes, but the other bits are in
.git/config. I get that the runnable part of the filters need to be strictly
platform independent in principle, but I can abstract that part in this
situation.

The question: what is the best practice for versioning the parts of
clean/smudge filters that are in .git/config given that only some users in
my environment will be cloning the repository in question and that I really
can't put the entries in /etc/gitconfig or ~/.gitconfig because of potential
conflicts with other repositories that might also have clean/smudge
definitions.

Thanks,
Randall 




