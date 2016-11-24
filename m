Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64F561FF76
	for <e@80x24.org>; Thu, 24 Nov 2016 22:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966411AbcKXWhV (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Nov 2016 17:37:21 -0500
Received: from mga07.intel.com ([134.134.136.100]:58751 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966049AbcKXWhT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2016 17:37:19 -0500
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP; 24 Nov 2016 14:37:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,543,1473145200"; 
   d="scan'208";a="1063850626"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga001.jf.intel.com with ESMTP; 24 Nov 2016 14:37:17 -0800
Received: from fmsmsx120.amr.corp.intel.com (10.18.124.208) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.248.2; Thu, 24 Nov 2016 14:37:17 -0800
Received: from lcsmsx153.ger.corp.intel.com (10.186.165.228) by
 fmsmsx120.amr.corp.intel.com (10.18.124.208) with Microsoft SMTP Server (TLS)
 id 14.3.248.2; Thu, 24 Nov 2016 14:37:17 -0800
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.44]) by
 LCSMSX153.ger.corp.intel.com ([169.254.8.87]) with mapi id 14.03.0248.002;
 Fri, 25 Nov 2016 00:37:14 +0200
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Jeff King <peff@peff.net>
CC:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Greg KH (gregkh@linuxfoundation.org)" <gregkh@linuxfoundation.org>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [char-misc-next] mei: request async autosuspend at the end of
 enumeration
Thread-Topic: [char-misc-next] mei: request async autosuspend at the end of
 enumeration
Thread-Index: AQHSRj7WsbWcWoZfOE2E/htadCzu2KDoR37ggAAxQACAADXbcA==
Date:   Thu, 24 Nov 2016 22:37:14 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B54331476@hasmsx108.ger.corp.intel.com>
References: <1479987242-32050-1-git-send-email-tomas.winkler@intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B5433132E@hasmsx108.ger.corp.intel.com>
 <20161124204316.sqxjpc7uzbrzhvho@sigill.intra.peff.net>
In-Reply-To: <20161124204316.sqxjpc7uzbrzhvho@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_IC
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMGEzYmI1NjEtYjEzMC00ODBjLWE0OGQtMDRmNDVhMTJjOTU5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX0lDIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE1LjkuNi42IiwiVHJ1c3RlZExhYmVsSGFzaCI6IkJFcFdNMWRTQjZqNE5qTmcrQ1dGd1ZkYTVWNUZNYVRKbkdhSGdJQ3lueHc9In0=
x-originating-ip: [10.184.70.11]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiANCj4gT24gVGh1LCBOb3YgMjQsIDIwMTYgYXQgMDQ6MTA6NDlQTSArMDAwMCwgV2lua2xlciwg
VG9tYXMgd3JvdGU6DQo+IA0KPiA+ID4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPiAjIDQu
NCsNCj4gPg0KPiA+IExvb2tzIGxpa2UgZ2l0IHNlbmQtZW1haWwgaXMgbm90IGFibGUgdG8gcGFy
c2UgdGhpcyBhZGRyZXNzIGNvcnJlY3RseQ0KPiA+IHRob3VnaCB0aGlzIGlzIHN1Z2dlc3RlZCBm
b3JtYXQgYnkgRG9jdW1lbnRhdGlvbi9zdGFibGVfa2VybmVsX3J1bGVzLnR4dC4NCj4gPiBDcmVh
dGUgd3JvbmcgYWRkcmVzcyBJZiBnaXQgcGFyc2VycyBpcyB1c2VkIDogJ3N0YWJsZUB2Z2VyLmtl
cm5lbC5vcmcjNC40KycNCj4gPg0KPiA+IFNvbWV0aGluZyBsaWtlIHMvIy4qJC8vIGlzIG5lZWRl
ZCBiZWZvcmUgcGFyc2luZyBDYzoNCj4gDQo+IFRoaXMgc2hvdWxkIGJlIGZpeGVkIGJ5IGUzZmRi
Y2M4ZSAocGFyc2VfbWFpbGJveGVzOiBhY2NlcHQgZXh0cmEgdGV4dCBhZnRlcg0KPiA8Li4uPiBh
ZGRyZXNzLCAyMDE2LTEwLTEzKSwgd2hpY2ggd2lsbCBiZSByZWxlYXNlZCBuZXh0IHdlZWsgYXMg
cGFydCBvZiB2Mi4xMS4gQXMNCj4gYSB3b3JrYXJvdW5kLCB5b3UgY2FuIGFsc28gaW5zdGFsbCB0
aGUgTWFpbDo6QWRkcmVzcyBwZXJsIG1vZHVsZS4gIFNlZSBbMV0gZm9yDQo+IHRoZSBnb3J5IGRl
dGFpbHMuDQoNClRoYW5rcyBmb3IgdXBkYXRlLCBJIGZhaWxlZCB0byB1bmRlcnN0YW5kIGZyb20g
dGhlIHRocmVhZCB0aG91Z2ggd2hhdCBkZWNpc2lvbiB3YXMgYWN0dWFsbHkgYXBwbGllZCwgSSB3
aWxsIGxvb2sgYXQgdGhlIHBhdGNoIGl0c2VsZi4NCkkndmUgdHJpZWQgdG8gaW5zdGFsbCBNYWls
OjpBZGRyZXNzIGFuZCBpdCBmaXhlcyB0aGUgYWN0dWFsIGFkZHJlc3MsIGJ1dCBpdCBhcHBlbmRz
ICB0aGUgIyA0LjQrIHN1ZmZpeCBpbnRvIHRoZSBuYW1lICANCmFzIGFsc28gbWVudGlvbmVkIGlu
IHRoZSB0aHJlYWQsIHdoaWNoIGRvZXNuJ3QgZml0IHRoZSBzdGFibGUgcnVsZXMgZG9jLg0KDQpT
byBmYXIgSSd2ZSBmaXhlZCB0aGUgcGFydGljdWxhciBpc3N1ZSB3aXRoIHRoZSBzaW1wbGUgc3Vi
c3RpdHV0ZSBhYm92ZSwgdGlsbCB0aGUgcmVhbCBmaXggaXMgcmVsZWFzZWQuDQoNCk1heWJlIHRo
ZSBzdGFibGUga2VybmVsIG1haW50YWluZXJzIHNob3VsZCBhbHNvIGJlIHB1bGxlZCBpbnRvIHRo
ZSBjb252ZXJzYXRpb24uICANCg0KVGhhbmtzDQpUb21hcyANCg0K
