Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B247207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 17:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161636AbcIZRtJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 13:49:09 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42649 "EHLO mx2.imag.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034478AbcIZRtI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 13:49:08 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
        by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u8QHmucK010443
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Mon, 26 Sep 2016 19:48:57 +0200
Received: from z8-mb-verimag.imag.fr (z8-mb-verimag.imag.fr [129.88.4.38])
        by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u8QHmxoq008801;
        Mon, 26 Sep 2016 19:49:00 +0200
Date:   Mon, 26 Sep 2016 19:48:59 +0200 (CEST)
From:   Gustavo Grieco <gustavo.grieco@imag.fr>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Message-ID: <790613313.8353074.1474912139102.JavaMail.zimbra@imag.fr>
In-Reply-To: <xmqqbmzbwmfc.fsf@gitster.mtv.corp.google.com>
References: <1825523389.8224664.1474812766424.JavaMail.zimbra@imag.fr> <xmqqbmzbwmfc.fsf@gitster.mtv.corp.google.com>
Subject: Re: Stack read out-of-bounds in parse_sha1_header_extended using
 git 2.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [129.88.6.115]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF43 (Linux)/8.0.9_GA_6191)
Thread-Topic: Stack read out-of-bounds in parse_sha1_header_extended using git 2.10.0
Thread-Index: IRx6LHOm4fFpS//4+rteXsUjGY18mw==
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Mon, 26 Sep 2016 19:48:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u8QHmucK010443
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: gustavo.grieco@imag.fr
MailScanner-NULL-Check: 1475516941.43567@jEPjurcZ+d55NxICRlHmHw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Now that the cause of this issue is identified, i would like to know if there is an impact in the security, so i can request a CVE if necessary.

Thanks!
