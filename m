Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF4271F935
	for <e@80x24.org>; Fri, 23 Sep 2016 07:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756810AbcIWHoF convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 23 Sep 2016 03:44:05 -0400
Received: from mail.scaling.ch ([195.182.53.83]:50277 "EHLO mail.scaling.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752747AbcIWHoF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 03:44:05 -0400
Received: from scinchvirs03.sc.scaling.ch (scinchvirs03.sc.scaling.ch [10.7.2.3])
        by mail.scaling.ch (Postfix) with ESMTPS id 470A139F
        for <git@vger.kernel.org>; Fri, 23 Sep 2016 09:44:02 +0200 (CEST)
Received: from scinchvirs03.sc.scaling.ch (10.7.2.3) by
 scinchvirs03.sc.scaling.ch (10.7.2.3) with Microsoft SMTP Server (TLS) id
 15.0.1044.25; Fri, 23 Sep 2016 09:44:02 +0200
Received: from scinchvirs03.sc.scaling.ch ([::1]) by
 scinchvirs03.sc.scaling.ch ([::1]) with mapi id 15.00.1044.021; Fri, 23 Sep
 2016 09:44:02 +0200
From:   Nicolas Vollmar <Nicolas.Vollmar@flynt.io>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Keychain access does not work under macOS Sierra
Thread-Topic: Keychain access does not work under macOS Sierra
Thread-Index: AQHSFW5AechALm84Gke7VDzOntxO5A==
Date:   Fri, 23 Sep 2016 07:44:01 +0000
Message-ID: <D4F572AE-0550-4223-850F-6CF916BFD1DE@flynt.io>
Accept-Language: en-US, de-CH
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [195.182.53.78]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <001C0869CB183948885BC29B2485A29C@scaling.ch>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It seems there were some changes at the keychain in macOS Sierra, after upgrading git seems not to be able to find the client certificate required to connect to our server.

fatal: unable to access 'https://xxx:8443/git/proj.git/': SSL: Can't find the certificate "John Doe" and its private key in the Keychain.

We would appreciate some hints how to address that.

Kind regards,
Nicolas
