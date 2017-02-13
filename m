Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE73D1FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 23:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751374AbdBMXLS convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 13 Feb 2017 18:11:18 -0500
Received: from sp-internet-ext-ply.uhc.com ([198.203.175.175]:27964 "EHLO
        mail6.uhc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750975AbdBMXLS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 18:11:18 -0500
X-Greylist: delayed 574 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Feb 2017 18:11:17 EST
X-IronPort-AV: E=Sophos;i="5.35,158,1484028000"; 
   d="scan'208";a="796796822"
Received: from irmply49.uhc.com (HELO mail6.uhc.com) ([10.114.162.64])
  by mail8.uhc.com with ESMTP; 13 Feb 2017 17:01:42 -0600
X-IronPort-AV: E=Sophos;i="5.35,158,1484028000"; 
   d="scan'208";a="796796812"
X-CONF-FOOTER: True
Received: from apsep0925.ms.ds.uhc.com ([10.114.192.113])
  by mail6.uhc.com with ESMTP; 13 Feb 2017 17:01:42 -0600
Received: from apswp0428.ms.ds.uhc.com ([fe80::7cb7:a560:d0b0:bc2d]) by
 APSEP0925.ms.ds.uhc.com ([fe80::71f3:9715:e387:7dce%18]) with mapi id
 14.03.0279.002; Mon, 13 Feb 2017 17:01:42 -0600
From:   "Vanderhoof, Tzadik" <tzadik.vanderhoof@optum360.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: new git-diff switch to eliminate leading "+" and "-" characters
Thread-Topic: new git-diff switch to eliminate leading "+" and "-" characters
Thread-Index: AdKGTR6IIA548fKLReSKxHY4yrqMsA==
Date:   Mon, 13 Feb 2017 23:01:41 +0000
Message-ID: <2C8817BDA27E034F8E9A669458E375EF11886C5A@APSWP0428.ms.ds.uhc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.112.10.26]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-IP-VFilter-R: R
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The output of git-diff includes lines beginning with "+" and "-" to indicate added and deleted lines.  A somewhat common task (at least for me) is to want to copy output from a "diff" (usually the deleted lines) and paste it back into my code.

This is quite inconvenient because of the leading "+" and "-" characters.  I know there are shell and IDE / editor workarounds but it would be nice if there was a switch to git-diff to make it leave out those characters, especially since "--color" kind of makes those leading characters obsolete.

Would it make sense to develop such a switch or has there been work on that already?
______________________________
Tzadik Vanderhoof | Optum360 
Sr Software Engineer, NLP Innovation
www.optum360.com

This e-mail, including attachments, may include confidential and/or
proprietary information, and may be used only by the person or entity
to which it is addressed. If the reader of this e-mail is not the intended
recipient or his or her authorized agent, the reader is hereby notified
that any dissemination, distribution or copying of this e-mail is
prohibited. If you have received this e-mail in error, please notify the
sender by replying to this message and delete this e-mail immediately.

