Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12DC81F404
	for <e@80x24.org>; Thu, 26 Apr 2018 10:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754295AbeDZK7f (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 06:59:35 -0400
Received: from ironport.klsmartin.com ([212.211.191.11]:23496 "EHLO
        ironport.klsmartin.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753403AbeDZK7f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 06:59:35 -0400
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Apr 2018 06:59:35 EDT
X-IronPort-AV: E=Sophos;i="5.49,330,1520895600"; 
   d="scan'208";a="16111668"
Received: from unknown (HELO hera.klsmartin.com) ([172.30.5.66])
  by ironport.klsmartin.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 26 Apr 2018 12:49:46 +0200
Received: from SUMMAIL01.UMK.KLS.zentral ([172.25.1.63])
        by hera.klsmartin.com (8.14.3/8.13.1/SuSE Linux 0.7) with ESMTP id w3QAnhh0019010
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 12:49:46 +0200
Received: from SUMMBX01.UMK.KLS.zentral ([172.25.1.64]) by
 SUMMAIL01.UMK.KLS.zentral ([172.25.1.63]) with mapi id 14.03.0351.000; Thu,
 26 Apr 2018 12:49:43 +0200
From:   "Middelschulte, Leif" <Leif.Middelschulte@klsmartin.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git merge banch w/ different submodule revision
Thread-Topic: git merge banch w/ different submodule revision
Thread-Index: AQHT3UxIUeHy1QVy7UGFBG3KFIVVCw==
Date:   Thu, 26 Apr 2018 10:49:42 +0000
Message-ID: <1524739599.20251.17.camel@klsmartin.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.70.68]
x-kse-serverinfo: SUMMAIL01.UMK.KLS.zentral, 9
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 26.04.2018 08:09:00
Content-Type: text/plain; charset="utf-8"
Content-ID: <68CDE578F0AADA43B1AF05FA0E761D4B@klsmartin.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGksDQoNCndlJ3JlIHVzaW5nIGdpdC1mbG93IGFzIGEgYmFzaWMgZGV2ZWxvcG1lbnQgd29ya2Zs
b3cuIEhvd2V2ZXIsIGRvaW5nIHNvIHJldmVhbGVkIHVuZXhwZWN0ZWQgbWVyZ2UtYmVoYXZpb3Ig
YnkgZ2l0Lg0KDQpBc3N1bWUgdGhlIGZvbGxvd2luZyBzZXR1cDoNCg0KLSBSZXBvc2l0b3J5IGBT
YCBpcyBzb3VyY2VkIGJ5IHJlcG9zaXRvcnkgYHBgIGFzIHN1Ym1vZHVsZSBgc2ANCi0gUmVwb3Np
dG9yeSBgcGAgaGFzIHR3byBicmFuY2hlczogYGZlYXR1cmVfeGAgYW5kIGBkZXZlbG9wYA0KLSBU
aGUgcmV2aXNpb25zIHNvdXJjZWQgdmlhIHRoZSBzdWJtb2R1bGUgaGF2ZSBhIGxpbmVhciBoaXN0
b3J5DQoNCg0KKiAxYzFkMzhmIChmZWF0dXJlX3gpIHVwZGF0ZSBzdWJtb2R1bGUgcmV2aXNpb24g
dG8gYjE3ZTlkOQ0KfCAqIDMyOTBlNjkgKEhFQUQgLT4gZGV2ZWxvcCkgdXBkYXRlIHN1Ym1vZHVs
ZSByZXZpc2lvbiB0byAwNTk4Mzk0DQp8LyAgDQoqIGNkNWUxYTUgaW5pdGlhbCBzdWJtb2R1bGUg
cmV2aXNpb24NCg0KDQpQcm9ibGVtIGNhc2U6IE1lcmdlIGVpdGhlciBicmFuY2ggaW50byB0aGUg
b3RoZXINCg0KRXhwZWN0ZWQgYmVoYXZpb3I6IE1lcmdlIGNvbmZsaWN0Lg0KDQpBY3R1YWwgYmVo
YXZpb3I6IEF1dG8gbWVyZ2Ugd2l0aG91dCBjb25mbGljdHMuDQoNCk5vdGUgMTogQSBtZXJnZSBj
b25mbGljdCBkb2VzIG9jY3VyLCBpZiB0aGUgc291cmNlZCByZXZpc2lvbnMgZG8gKm5vdCogaGF2
ZSBhIGxpbmVhciBoaXN0b3J5DQoNCkRpZCBJIGdldCBzb21ldGhpbmcgd3JvbmcgYWJvdXQgaG93
IGdpdCByZXNvbHZlcyBtZXJnZXM/IFNob3VsZG4ndCBnaXQgYmUgbGlrZTogImhleSwgeW91J3Jl
IHRyeWluZyB0byBtZXJnZSB0d28gZGlmZmVyZW50IGNvbnRlbnRzIGZvciB0aGUgc2FtZSBsaW5l
IiAodGhlIHN1Ym1vZHVsZSdzIHJldmlzaW9uKQ0KDQpUaGFua3MgaW4gYWR2YW5jZSwNCg0KTGVp
Zg==
