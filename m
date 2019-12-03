Return-Path: <SRS0=UYkv=ZZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1EEC43215
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 08:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962962068E
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 08:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbfLCI3y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Dec 2019 03:29:54 -0500
Received: from cnshjsmin03.alcatel-sbell.com.cn ([116.246.26.71]:56914 "EHLO
        cnshjsmin03.nokia-sbell.com" rhost-flags-OK-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S1725773AbfLCI3y (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 3 Dec 2019 03:29:54 -0500
X-AuditID: ac189297-567ff7000000639c-eb-5de61ceb4188
Received: from CNSHPPEXCH1608.nsn-intra.net (Unknown_Domain [135.251.51.108])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by cnshjsmin03.nokia-sbell.com (Symantec Messaging Gateway) with SMTP id 67.A7.25500.BEC16ED5; Tue,  3 Dec 2019 16:29:31 +0800 (HKT)
Received: from CNSHPPEXCH1610.nsn-intra.net (135.251.51.110) by
 CNSHPPEXCH1608.nsn-intra.net (135.251.51.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 3 Dec 2019 16:29:31 +0800
Received: from CNSHPPEXCH1610.nsn-intra.net ([135.251.51.110]) by
 CNSHPPEXCH1610.nsn-intra.net ([135.251.51.110]) with mapi id 15.01.1713.007;
 Tue, 3 Dec 2019 16:29:31 +0800
From:   "Lou, Pengfei (NSB - CN/Hangzhou)" <pengfei.lou@nokia-sbell.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: one bug on git
Thread-Topic: one bug on git
Thread-Index: AdWpqKh+Y3gz8IRUTs2wD1ZmDLyXiAACqzigAAAZwpA=
Date:   Tue, 3 Dec 2019 08:29:31 +0000
Message-ID: <1af00173f96243bea760baaddeb15777@nokia-sbell.com>
References: <defeb7be75f54e8483ce529b2571478d@nokia-sbell.com>
 <5e27e2a9f6374742859b4b87d85c56e9@nokia-sbell.com>
In-Reply-To: <5e27e2a9f6374742859b4b87d85c56e9@nokia-sbell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [135.251.51.115]
Content-Type: multipart/mixed;
        boundary="_003_1af00173f96243bea760baaddeb15777nokiasbellcom_"
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsXS/ts4R/e1zLNYg4UflSy6rnQzOTB6fN4k
        F8AYxWWTkpqTWZZapG+XwJWx6f8L9oKZahVvbk9lamC8q9TFyMkhIWAicW7hNZYuRi4OIYFD
        TBKXTi5lhXD+MEpM/dbKBuFsZJS49PgmK0gLm4CbxP6/vcxdjBwcIgL6En0XREHCwgLSEr1/
        N7OD2CICMhJ7D+1jgbCtJO5/uskGYrMIqEhM+faeGcTmFbCT+PN7HVi9kECxxOspm8HGcwrY
        S+w//AushlFATOL7qTVMIDazgLjErSfzmSCuFpF4ePE0G4QtKvHy8T9WkHMkBJQk+jZAlcdL
        HJ/4gR1ilaDEyZlPWCYwisxCMmkWkrJZSMog4noSN6ZOYYOwtSWWLXzNDGGbSVy4sgkqLiNx
        d+pToHouIHsxo8TStdugihQlpnQ/ZIewLSX+nGyEWiYv8XXSIjaIhmWMEtteX2FC1rCAkXcV
        o3RyXnFGVnFuZp6BsV5efnZmom5xUmpOjl5yfu4mRmCEr5GYNH0H47ED3ocYBTgYlXh4M349
        iRViTSwrrsw9xKgCNO3RhtUXGKVY8vLzUpVEeLdJPI0V4k1JrKxKLcqPLyrNSS0+xCjNwaIk
        ztsyeWGskEB6YklqdmpqQWoRTJaJg1OqgVHg/95tH939rt98IKLJ1ztxwwLFhvbFD5kr7zZs
        Ppdl5/lVJMVabI3h+j3THt88FLerqolvc7jxndibDhcNz5lVubLtiz/zWW5b0nI+V+M2Fben
        lxRcGnXL/94oWnGh99W+x/+6753SPVn5ins+U6bXBhnNELVLq77JXFZaUpq7aFtZ5/XA7ROV
        WIozEg21mIuKEwE1+5aF+AIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--_003_1af00173f96243bea760baaddeb15777nokiasbellcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello community=20
=A0=A0=A0=A0=A0One problem I found recently within my working, please check=
 my detail below.=20

=A0=A0=A0=A0 I tried to run my script (check the attached file 'problem.sh'=
) to build one git repository , it can be successful, but the command "git =
log -raw -1 ${revision}^ ${revision}" on that repo would generate some =A0u=
nexpected result, =A0please check the result below

[pelou@hzling29 try_des]$ git --version
git version 2.6.2

[pelou@hzling29 try_des]$ git log --raw -1 164304f48726d31336e2e130a90e42b7=
f1c480f8
commit 164304f48726d31336e2e130a90e42b7f1c480f8
Author: pelou <mailto:pengfei.lou@nokia-sbell.com>
Date:=A0=A0 Tue Dec 3 14:54:33 2019 +0800

=A0=A0=A0 3

:100644 100644 9a7456b... 8148ef7... M=A0 lpf
[pelou@hzling29 try_des]$ git log --raw -1 164304f48726d31336e2e130a90e42b7=
f1c480f8^ 164304f48726d31336e2e130a90e42b7f1c480f8
commit dd1a95338ffd471e5b270a487b585bbfcf9926a5
Author: pelou <mailto:pengfei.lou@nokia-sbell.com>
Date:=A0=A0 Tue Dec 3 14:54:33 2019 +0800

=A0=A0=A0 2

:100644 100644 d474e1b... 9a7456b... M=A0 lpf=20

=A0=A0=A0=A0 Next step I changed my script(check the attached file good.sh)=
 and only add some delays after "git push", everything is normal, check it =
below
[pelou@hzling29 try_des]$ git log --raw -1 2027dc54da1896cf1dfa301c3444b169=
0d6cb1d8
commit 2027dc54da1896cf1dfa301c3444b1690d6cb1d8
Author: pelou <mailto:pengfei.lou@nokia-sbell.com>
Date:=A0=A0 Tue Dec 3 15:00:45 2019 +0800

=A0=A0=A0 3

:100644 100644 9a7456b... 8148ef7... M=A0 lpf
[pelou@hzling29 try_des]$ git log --raw -1 2027dc54da1896cf1dfa301c3444b169=
0d6cb1d8^ 2027dc54da1896cf1dfa301c3444b1690d6cb1d8
commit 2027dc54da1896cf1dfa301c3444b1690d6cb1d8
Author: pelou <mailto:pengfei.lou@nokia-sbell.com>
Date:=A0=A0 Tue Dec 3 15:00:45 2019 +0800

=A0=A0=A0 3

:100644 100644 9a7456b... 8148ef7... M=A0 lpf

So please help me fix it. Please let me know if I was wrong or miss some th=
ing

Br, Hercules

--_003_1af00173f96243bea760baaddeb15777nokiasbellcom_
Content-Type: application/octet-stream; name="good.sh"
Content-Description: good.sh
Content-Disposition: attachment; filename="good.sh"; size=717;
	creation-date="Tue, 03 Dec 2019 08:29:25 GMT";
	modification-date="Tue, 03 Dec 2019 07:08:35 GMT"
Content-Transfer-Encoding: base64

IyEvYmluL2Jhc2gNCg0KZ2l0TWV0YUxheWVyPS92YXIvZnB3b3JrL3BlbG91L3RtcC9GQ0FfUFNf
Q0lfU0NNLTM2OTUvY2lfdGVzdC90cnlfc3JjDQoNCmdpdE1ldGFMYXllcl93b3JrPS92YXIvZnB3
b3JrL3BlbG91L3RtcC9GQ0FfUFNfQ0lfU0NNLTM2OTUvY2lfdGVzdC90cnlfZGVzDQoNCnJtIC1y
ZiAke2dpdE1ldGFMYXllcn0NCnJtIC1yZiAke2dpdE1ldGFMYXllcl93b3JrfQ0KDQpta2RpciAt
cCAke2dpdE1ldGFMYXllcn0NCmNkICR7Z2l0TWV0YUxheWVyfQ0KZ2l0IGluaXQgLXEgLS1iYXJl
DQoNCm1rZGlyIC1wICR7Z2l0TWV0YUxheWVyX3dvcmt9DQpjZCAke2dpdE1ldGFMYXllcl93b3Jr
fQ0KZ2l0IGNsb25lIC1xICR7Z2l0TWV0YUxheWVyfSAke2dpdE1ldGFMYXllcl93b3JrfQ0KDQp0
b3VjaCBscGYNCmdpdCBhZGQgbHBmDQpnaXQgY29tbWl0IC1hIC1tICJpbml0IGdpdCByZXBvIg0K
DQoNCmVjaG8gLWUgIjFcbiIgPiBscGYNCmdpdCBjb21taXQgLWEgLW0gIjEiDQpzbGVlcCAxDQoN
CmVjaG8gLWUgIjJcbiIgPiBscGYNCmdpdCBjb21taXQgLWEgLW0gIjIiDQpzbGVlcCAxDQoNCmVj
aG8gLWUgIjNcbiIgPiBscGYNCmdpdCBjb21taXQgLWEgLW0gIjMiDQpzbGVlcCAxDQoNCmVjaG8g
LWUgIjRcbiIgPiBscGYNCmdpdCBjb21taXQgLWEgLW0gIjQiDQpzbGVlcCAxDQoNCmVjaG8gLWUg
IjVcbiIgPiBscGYNCmdpdCBjb21taXQgLWEgLW0gIjUi

--_003_1af00173f96243bea760baaddeb15777nokiasbellcom_
Content-Type: application/octet-stream; name="problem.sh"
Content-Description: problem.sh
Content-Disposition: attachment; filename="problem.sh"; size=721;
	creation-date="Tue, 03 Dec 2019 08:29:27 GMT";
	modification-date="Tue, 03 Dec 2019 07:07:56 GMT"
Content-Transfer-Encoding: base64

IyEvYmluL2Jhc2gNCg0KZ2l0TWV0YUxheWVyPS92YXIvZnB3b3JrL3BlbG91L3RtcC9GQ0FfUFNf
Q0lfU0NNLTM2OTUvY2lfdGVzdC90cnlfc3JjDQoNCmdpdE1ldGFMYXllcl93b3JrPS92YXIvZnB3
b3JrL3BlbG91L3RtcC9GQ0FfUFNfQ0lfU0NNLTM2OTUvY2lfdGVzdC90cnlfZGVzDQoNCnJtIC1y
ZiAke2dpdE1ldGFMYXllcn0NCnJtIC1yZiAke2dpdE1ldGFMYXllcl93b3JrfQ0KDQpta2RpciAt
cCAke2dpdE1ldGFMYXllcn0NCmNkICR7Z2l0TWV0YUxheWVyfQ0KZ2l0IGluaXQgLXEgLS1iYXJl
DQoNCm1rZGlyIC1wICR7Z2l0TWV0YUxheWVyX3dvcmt9DQpjZCAke2dpdE1ldGFMYXllcl93b3Jr
fQ0KZ2l0IGNsb25lIC1xICR7Z2l0TWV0YUxheWVyfSAke2dpdE1ldGFMYXllcl93b3JrfQ0KDQp0
b3VjaCBscGYNCmdpdCBhZGQgbHBmDQpnaXQgY29tbWl0IC1hIC1tICJpbml0IGdpdCByZXBvIg0K
DQoNCmVjaG8gLWUgIjFcbiIgPiBscGYNCmdpdCBjb21taXQgLWEgLW0gIjEiDQojc2xlZXAgMQ0K
DQplY2hvIC1lICIyXG4iID4gbHBmDQpnaXQgY29tbWl0IC1hIC1tICIyIg0KI3NsZWVwIDENCg0K
ZWNobyAtZSAiM1xuIiA+IGxwZg0KZ2l0IGNvbW1pdCAtYSAtbSAiMyINCiNzbGVlcCAxDQoNCmVj
aG8gLWUgIjRcbiIgPiBscGYNCmdpdCBjb21taXQgLWEgLW0gIjQiDQojc2xlZXAgMQ0KDQplY2hv
IC1lICI1XG4iID4gbHBmDQpnaXQgY29tbWl0IC1hIC1tICI1Ig==

--_003_1af00173f96243bea760baaddeb15777nokiasbellcom_--
