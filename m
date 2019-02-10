Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDC0F1F453
	for <e@80x24.org>; Sun, 10 Feb 2019 21:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfBJV44 (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Feb 2019 16:56:56 -0500
Received: from smtp-31.italiaonline.it ([213.209.10.31]:53351 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726008AbfBJV44 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Feb 2019 16:56:56 -0500
Received: from DESKTOP-E4U7JCE ([158.148.75.163])
        by smtp-31.iol.local with ESMTPA
        id sx5qgK2elCH4tsx5qgUdMu; Sun, 10 Feb 2019 22:56:54 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1549835814; bh=RHPKt9Q3zdCizSRirfu2DPhZZHinG7vpKs0tYYtlF50=;
        h=Subject:From:To:Date;
        b=BUdV8NzlM32rT0kJ935jQLzVguxvpHaPDKUggccIhWjCI3w1DJKL7SXxDtXoOHJ9D
         V0wVfZgtzUX6XLZB0ORdNone6GvTz70iB1pOFeLgeisUur3C2n27MgVEnPT5YEPX9N
         FT+oR1bbqb3c+FXsfkfq4Tr3OQ0YD7HEKzyTIeZuxpL0NBjAL/3GWGJgXcDJeBhdio
         E9heB5kes1s2aqU04u/aQ4v6iJU65BBSD60Gw2jyYEC2du9vLkqVAIdQ1aY+Vo4K7I
         cc3w66ue5NxISwubuC9gtgo2k4z5UW8AuNyeswj3MBsT50JSaEahXwrDQqf1VZS4nV
         qybytoTEMxd5Q==
X-CNFS-Analysis: v=2.3 cv=R4HS5uZX c=1 sm=1 tr=0
 a=GGocWB3/63TfxpwkRNvZew==:117 a=GGocWB3/63TfxpwkRNvZew==:17
 a=IkcTkHD0fZMA:10 a=aSwji-zoxQ_bfCt3maMA:9 a=QEXdDO2ut3YA:10
 a=pHzHmUro8NiASowvMSCR:22 a=nt3jZW36AmriUCFCBwmW:22
Message-ID: <1549835814.5977.11.camel@libero.it>
Subject: Am a newby and I cannot compile git
From:   Fabio Aiuto <polinice83@libero.it>
To:     git@vger.kernel.org
Date:   Sun, 10 Feb 2019 22:56:54 +0100
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDBPprjP5+0r/f5yP/lGzPoWPWrTcrevhWyQ0bFUsjf3Z4eMhtYT9VhsdyhDFtHl/jfryWjokg7yVf7B4UoByGV8zLpmxlHQ2zwv6Of3pbh5N64Cprlm
 ANXYziMiy6h6/Woj6Jd2JZQjNZTvqkG96OvJokmYMlx1dAXbz9G87RRWJTPnhlVx4wNAX/lE2GnZZQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello again my problem is that I cannot compile git.
The error message says:

	Type'z_stream' could not be resolved

I don't know why, because I installed the package zlib1g-dev and in the
header file zlib.h this structure is declared. Help me!!!
Fabio.
