Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D91D1F404
	for <e@80x24.org>; Fri, 19 Jan 2018 23:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756070AbeASXSM (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 18:18:12 -0500
Received: from elephants.elehost.com ([216.66.27.132]:19929 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932314AbeASXSG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 18:18:06 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0JNI4TK000684
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Fri, 19 Jan 2018 18:18:05 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [Nit] Lots of enumerated type warnings
Date:   Fri, 19 Jan 2018 18:17:58 -0500
Message-ID: <001601d3917b$c1ade3c0$4509ab40$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdORepMpGPUkntY0QYWhkaztDuv9jg==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So here a bit of a nit or nano-quibble that I have. Call it my "warnings
OCD" if you want. I'm seeing an increase in the enumerated type warnings
coming from my use of the c99 compiler for compiling git over time (loads
more for 2.16.0 compared to 2.3.7 when I took it on). What is the general
feeling on these? I would be willing do static casts rather than see the
warnings, mostly because I advocate in public that warnings are actually
future potential errors, so clean compiles are better. I don't see this
conflicting with anything in gcc. Is there a desire/need to clean up this
stuff? I can take a stab at gradually cleaning this up when $DAYJOB and
#FAMILY don't conflict.

Although, given the choice, I'd rather look into that whole --via concept
from a different thread ;-)

Cheers,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



