Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B728F2095B
	for <e@80x24.org>; Fri, 17 Mar 2017 08:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751115AbdCQIaw (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 04:30:52 -0400
Received: from mail96.atlas.de ([194.156.172.86]:2288 "EHLO mail96.atlas.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751004AbdCQIav (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 04:30:51 -0400
X-Greylist: delayed 382 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Mar 2017 04:30:50 EDT
X-IPAS-Result: =?us-ascii?q?A2DqDwALnMtY/wXKxApdGwEBAQMBAQEJAQEBhFyEQptIH5d?=
 =?us-ascii?q?Phh4CAgIagzMUAQIBAQEBAQEBgROFFgIBAyMRVQIBCBoCJgICAioGFRACBAEMC?=
 =?us-ascii?q?AEBu0SCJopWAQEBAQYBAQEBASOBC4dICIJihFQXgm+CQB8BBIkbky6dE4ZYi0C?=
 =?us-ascii?q?IEDaBJViHLYpMAQEB?=
Received: from scesrv02.atlas.de ([10.196.202.5])
  by MGW102FE.atlas.de with ESMTP/TLS/DHE-RSA-AES128-GCM-SHA256; 17 Mar 2017 09:21:18 +0100
Received: by SCESRV02.atlas.de (Postfix, from userid 600)
        id 3vkywZ3R15z2yWQg; Fri, 17 Mar 2017 08:20:43 +0000 (UTC)
Received: from MGW201PAR.atlas.de (unknown [10.206.101.60])
        by SCESRV02.atlas.de (Postfix) with ESMTPS id 3vkyvv367mz2yWQl
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 08:20:43 +0000 (UTC)
Received: from msexsrv1.atlas.de ([10.200.102.56])
  by MGW201DAT.atlas.de with ESMTP/TLS/DHE-RSA-AES256-SHA; 17 Mar 2017 09:20:27 +0100
Received: from MSEXSRV6.atlas.de ([169.254.4.156]) by MSEXSRV1.atlas.de
 ([10.200.102.56]) with mapi id 14.03.0319.002; Fri, 17 Mar 2017 09:20:27
 +0100
From:   <stefan.naewe@atlas-elektronik.com>
To:     <okash.khawaja@gmail.com>, <git@vger.kernel.org>
Subject: Re: Viewing untracked+stashed files in git stash show
Thread-Topic: Viewing untracked+stashed files in git stash show
Thread-Index: AQHSnnNcaX81CqGRmEuzdvPqeBcSKKGYoP4A
Date:   Fri, 17 Mar 2017 08:20:27 +0000
Message-ID: <295db01e-6252-6acc-88d8-d2f366397ea0@atlas-elektronik.com>
References: <CAOtcWM3mrQEqDnjMipzea7Kp+VueBFsZDL2zcJ=y0wgj9N4Vjw@mail.gmail.com>
In-Reply-To: <CAOtcWM3mrQEqDnjMipzea7Kp+VueBFsZDL2zcJ=y0wgj9N4Vjw@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Content-Type: text/plain; charset="utf-8"
Content-ID: <9AF520548CF09E4286A1F1FCF55BE096@atlas.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

QW0gMTYuMDMuMjAxNyB1bSAxNzozNCBzY2hyaWViIE9rYXNoIEtoYXdhamE6DQo+IEhpLA0KPiAN
Cj4gSWYgeW91IGhhdmUgc29tZSB1bnRyYWNrZWQgZmlsZXMgYW5kIHlvdXIgcnVuIGBnaXQgc3Rh
c2ggLXVgLiBUaGVuDQo+IGBnaXQgc3Rhc2ggc2hvd2AgZG9lc24ndCBzaG93IHRoZSB1bnRyYWNr
ZWQgZmlsZXMuIElzIHRoZXJlIGEgZmxhZw0KPiB0aGF0IGNhbiBiZSBwYXNzZWQgdG8gZ2l0IHN0
YXNoIHNob3cgdG8gcmVwb3J0IHVudHJhY2tlZCBmaWxlcz8NCg0KTm90IGZvciAnZ2l0IHN0YXNo
JyBidXQgeW91IGNhbiB1c2UgJ2dpdCBzaG93IHN0YXNoQHswfV4zDQoNCihPciwgb2YgY291cnNl
LCAnZ2l0ayBzdGFzaEB7MH0nICkNCg0KSFRIDQoNClN0ZWZhbg0KLS0gDQotLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQovZGV2
L3JhbmRvbSBzYXlzOiBJIGtlZXAgbXkgLkJBVCBmaWxlcyBpbiBEOlxCRUxGUlkNCnB5dGhvbiAt
YyAicHJpbnQgJzczNzQ2NTY2NjE2ZTJlNmU2MTY1Nzc2NTQwNjE3NDZjNjE3MzJkNjU2YzY1NmI3
NDcyNmY2ZTY5NmIyZTYzNmY2ZCcuZGVjb2RlKCdoZXgnKSIgDQpHUEcgS2V5IGZpbmdlcnByaW50
ID0gMkRGNSBFMDFCIDA5QzMgNzUwMSBCQ0E5ICA5NjY2IDgyOUIgNDlDNSA5MjIxIDI3QUY=
