Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11E4F1F404
	for <e@80x24.org>; Wed, 28 Mar 2018 23:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751001AbeC1X1b (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 19:27:31 -0400
Received: from rcdn-iport-5.cisco.com ([173.37.86.76]:25194 "EHLO
        rcdn-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbeC1X1a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 19:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=240; q=dns/txt; s=iport;
  t=1522279650; x=1523489250;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WYjfk4pei52P+fONX+Ad+k46FnGpV6T5ZsxIZ4ioJk0=;
  b=aTtXeIkYS0FGBbWPmHXcQa6Zkfg36zwmRJWkdS0EqSJeO/pvW+2uuU0Q
   s7fKNIYLkGxYlrtz481W6qK0nWYklWUo+tUfjvlcwNjzD6F2xuQy2Ak+D
   k0zUpwER35O+/js8Plcpl/hAhqaaAaIDo97MX9m5STDms7+eiCuNjMJR0
   s=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0DgAACZI7xa/51dJa1dGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYMWK4FQMoNSiACNAIMDkkqBeguFBAIag3MhNBgBAgEBAQEBAQJ?=
 =?us-ascii?q?rKIUmBiMRRRACAQgODAImAgICHRMVEAIEDoUTqyuCHIRVg22CKYEIhDyCGoITg?=
 =?us-ascii?q?S6CNC6Eb4MAMIIkApczCAIYjg6BIQGLD49QAhETAYEkARw4gVJwFWQBghmCHxd?=
 =?us-ascii?q?6AQiNE48/gRcBAQ?=
X-IronPort-AV: E=Sophos;i="5.48,373,1517875200"; 
   d="scan'208";a="155874686"
Received: from rcdn-core-6.cisco.com ([173.37.93.157])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2018 23:27:29 +0000
Received: from XCH-RTP-018.cisco.com (xch-rtp-018.cisco.com [64.101.220.158])
        by rcdn-core-6.cisco.com (8.14.5/8.14.5) with ESMTP id w2SNRTvl006996
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 28 Mar 2018 23:27:30 GMT
Received: from xch-rtp-020.cisco.com (64.101.220.160) by XCH-RTP-018.cisco.com
 (64.101.220.158) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Wed, 28 Mar
 2018 19:27:29 -0400
Received: from xch-rtp-020.cisco.com ([64.101.220.160]) by
 XCH-RTP-020.cisco.com ([64.101.220.160]) with mapi id 15.00.1320.000; Wed, 28
 Mar 2018 19:27:29 -0400
From:   "Erik Brady -X (brady - ROBERT HALF INTERNATIONAL INC at Cisco)" 
        <brady@cisco.com>
To:     Jeff King <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Apparent bug in credential tool running...
Thread-Topic: Apparent bug in credential tool running...
Thread-Index: AQHTxsI9w7UvG8AaqkW66sXaczqa96PmP74A///ZHgA=
Date:   Wed, 28 Mar 2018 23:27:29 +0000
Message-ID: <75A80033-64BD-424D-886B-1D3F0B723D31@cisco.com>
References: <7898B9A4-D52E-41AD-9162-5B6B401A1AEA@cisco.com>
 <20180328184637.GB16931@sigill.intra.peff.net>
In-Reply-To: <20180328184637.GB16931@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.24.45.247]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC48A4471248A74C96D37502726E0CD7@emea.cisco.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

UXVpY2sgbm90ZTogSSBkaWQgc3VibWl0IHRoZSBwYXRjaCwgbG9vayBmb3Igc3ViamVjdCBsaW5l
ICIgW1BBVENIXSBjcmVkZW50aWFsOiBjcmVkIGhlbHBlciBmYXN0IGV4aXQgY2FuIGNhdXNlIFNJ
R1BJUEUsIGNyYXNoIi4NCg0KVGhhbmtzIGFnYWluIEplZmYsDQpFcmlrDQoNCu+7vw0KICAgIA0K
DQo=
