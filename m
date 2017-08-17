Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8033C208CD
	for <e@80x24.org>; Thu, 17 Aug 2017 09:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752114AbdHQJDC (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 05:03:02 -0400
Received: from mail-bn3nam01on0132.outbound.protection.outlook.com ([104.47.33.132]:45246
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751844AbdHQJC5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 05:02:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arris.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=YfDqz+m2PxVl1j92rhFY3ADyMrGgdqm5qf8kJCrbZ4o=;
 b=RMbQGIVKwvTdZOh/N+hC/ZqWgFM89O8x9DNIMfsYJdgHLq7pFvosWWy0J92gEpL2CO7y0gqc+LlpOwpOVtWukMGRwra90BynVhspza62mnpwXTqnzHtYy9ENyyhpPPuX4Zaj3pJ5/y44HITmxdmJmGHrylshkK4uHGitQeOi+eM=
Received: from MWHPR01CA0032.prod.exchangelabs.com (10.172.172.146) by
 BLUPR01MB551.prod.exchangelabs.com (10.141.82.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.1.1362.18; Thu, 17 Aug 2017 09:02:55 +0000
Received: from SN1NAM01FT008.eop-nam01.prod.protection.outlook.com
 (2a01:111:f400:7e40::207) by MWHPR01CA0032.outlook.office365.com
 (2603:10b6:300:101::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1362.18 via
 Frontend Transport; Thu, 17 Aug 2017 09:02:54 +0000
Authentication-Results: spf=pass (sender IP is 216.234.144.41)
 smtp.mailfrom=arris.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=arris.com;
Received-SPF: Pass (protection.outlook.com: domain of arris.com designates
 216.234.144.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.234.144.41; helo=webmail.arris.com;
Received: from webmail.arris.com (216.234.144.41) by
 SN1NAM01FT008.mail.protection.outlook.com (10.152.64.199) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.1.1341.15 via Frontend Transport; Thu, 17 Aug 2017 09:02:54 +0000
Received: from ATLEXCH6.ARRS.ARRISI.com (10.2.131.24) by
 ATLOWA2.ARRS.ARRISI.com (10.2.131.253) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 17 Aug 2017 05:02:53 -0400
Received: from ATLEXCH1.ARRS.ARRISI.COM (10.2.195.15) by
 ATLEXCH6.ARRS.ARRISI.com (10.2.131.24) with Microsoft SMTP Server (TLS) id
 15.0.1178.4; Thu, 17 Aug 2017 05:02:52 -0400
Received: from ATLEXCH1.ARRS.ARRISI.COM ([10.2.139.158]) by
 ATLEXCH1.ARRS.ARRISI.com ([10.2.139.158]) with mapi id 15.00.1178.000; Thu,
 17 Aug 2017 05:02:52 -0400
From:   "Carlsson, Magnus" <Magnus.Carlsson@arris.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git fetch with refspec does not include tags?
Thread-Topic: git fetch with refspec does not include tags?
Thread-Index: AQHTFzWFIxXrmJiyxE6IHqi+SjfzH6KIQHfK
Date:   Thu, 17 Aug 2017 09:02:52 +0000
Message-ID: <1502960572292.1402@arris.com>
References: <1502960406180.9006@arris.com>
In-Reply-To: <1502960406180.9006@arris.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.2.159.2]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:216.234.144.41;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(6009001)(39860400002)(2980300002)(438002)(505004003)(199003)(374574003)(189002)(54356999)(76176999)(551944002)(47776003)(8936002)(5660300001)(77096006)(2351001)(246002)(356003)(8676002)(6116002)(1730700003)(3846002)(106466001)(15974865002)(102836003)(14454004)(626005)(50466002)(50986999)(110136004)(23676002)(2950100002)(6916009)(72206003)(2900100001)(36756003)(478600001)(189998001)(97876018)(305945005)(2501003)(117636001)(86362001)(5640700003)(2906002)(7736002)(5890100001);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR01MB551;H:webmail.arris.com;FPR:;SPF:Pass;PTR:vpn.arrisi.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM01FT008;1:vNNK/QTPtz2S5X9mHYwj19NJlBA2DNobzaWkTIgUhrJCGFRXrT6QO5iqqFkkZ2/H0RQWu/LSMIUO1D0m6R/1Z1GyNFx9YryJt8OPQcZ/GbSbCyEqucE1hBW2eeoN1yBi
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 736768bb-2ccc-4e2a-7783-08d4e54ebf33
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(8251501002)(300000503095)(300135400095)(2017052603031)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:BLUPR01MB551;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR01MB551;3:HFC/XYqLmw4wIkAhjPIRAuyss9prJhGCOhOmWZ6lgN9RFDIQ30b+T+cIn442Sj9Dnee9gvYigysXA2VIw17XKbo6rIg2LV1CSMl8Osqr/Fm7bmX/qeNTzg3KC9oTidEvkptwS5MVsRNYoOmlkbmJkcR+NcLNqVZzJ7inJTtuX4R7/S8wMWXMXrYuL6J9FDqA4OwHoh8fcOBo53SZNDTYaDxzK5hyaOlx+S1lxmXyn97TVlf+svXj3UhF7vWXXTeoRng/5lU09bepZbVri/gfdQdcc97tTRp0f2gMmLHwWQkE5zgsUUJwMgRe+ng/UGNXUWc2IvK3ocs4xi5J+9ZTQMtUXLGSMf4gbXSKXl91fzM=;25:sUxGF6+bYM4+Qe/opWjpdgo5DRP763ybvRMNbwqe4lMnV50t5OQjfuBtIL7AFemXxoq9SV59Yv5e2S8s4+R/LSJ4QZ8IQXdIfo7RqPDkJsFr2ViFl1BctU548VmV+mS0l3OIdM1aJ/vufibuoc8OqpUkatDWsd9B7o5l9pwyLKKyUx6vG0EG/SffdRYLimZ+nJVKZ9V5VmXy/r4N2AQrsd1/CzSLSh4WqqUtabHr+AHF2QZvnuU81NanfydasL6mQH9ptXqDjGTBX8nBgnPJubZcs/wHrcp2O0QnDVdSKpSWoDoBib0orX7kpDPswno2iFdruDGo6s3GeBHk8Kp1uQ==
X-MS-TrafficTypeDiagnostic: BLUPR01MB551:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR01MB551;31:dql7aEnUCFOzaZXXps9jFzOt6xaHbZrasNz7RzqvqrlzgcMB4WFncWK5G90E8Wgv1rmm0sb8sxHrHhh8EW/MY/mrOKAepTAqqe4m4U7MiN/P17yyHJmmChPHJTi3RdPshjJ1wsccaMKZ9jyFzaeniAAk6gDxJztZx/KuWfmeBnfo7rLD7vwSmpcI7Xd5sYejYCFa9lyen1SSQALh7tBKSxS4qx3baxXwBnGzmMUV2Gg=;20:Nenx2nlaNWhjs8oTF+LLYhC5fzyfDJrH7ll7TkATXLPdNJcB8XJq7aZvZ7tWuIRQ8HBilDU5Eit1y7g4xW71ueQRZ36GUtGq1abS1rBoEGRad+2O60GCTD3sw3BxdumqDQHmLgxERzYbyhpOxCnkd1ZPRcYWq7OCwqn8oCA7IOBV12YdSUQaYWopurs6OD0ERRCvB2Eo7Etz77NnQ56fugDRBC2+EoQzi2k8VE+Q9AmD0f31q0GQjzru0K0lIBQ9KenGwPk2sSn1A2aLLvTDGA9CAu1VwOVO76PWH5B81AJ6pUBTbyVy7itUIfwebYiKAMS2ZDH/l+GmJcSAB1caU9A7uPmp4wFCzK8bcdWG8rLDVALSUDUH4W1ZhbhH52juYjavXo9EcSd24h5qd+7w8Nu5RczBJWmJ3t6X7LbDcA0WidM98G2bYtXWyW9oJ9xsf/GxD8rCYoFAuDMdK6M7/zFq/zZXA015Ln2+vZorRa2TYk160TxrwD2csrU/vpJx
X-Exchange-Antispam-Report-Test: UriScan:(104657075078662);
X-Microsoft-Antispam-PRVS: <BLUPR01MB5514E2624050472A42F2D85FE830@BLUPR01MB551.prod.exchangelabs.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(13018025)(8121501046)(5005006)(13016025)(10201501046)(100000703101)(100105400095)(93006095)(93004095)(3002001)(6055026)(6041248)(20161123560025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123562025)(20161123555025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:BLUPR01MB551;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:BLUPR01MB551;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR01MB551;4:mk/nfgIg5Gx+l8FNZlrtRhp9YEO4yIF+UYQe4hVqWzam7x73L1cDi2pXiUX7znidQXBzILSgy+G3QokKq96qZsIcElPkDqh5uMjykA1ujoWTtLv+4SCMkjl1OSn4jCBtbT8gDIeVWucMewl1nkVujTaxT2/5OzBtmbp5Y2RYFM8R63KBkIBbh+S/3/Pn+Q9N59r6pNEtUTyDmA6LGoJzlAFT8elmS7VJrHNUMsiU8u44xL9H6T2hEIPIcXQeGUNkwRIcwiA7MFprGyQ+lzAJExKBygax3hTMgoawpoL3i6E=
X-Forefront-PRVS: 0402872DA1
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTFVQUjAxTUI1NTE7MjM6RjFuUFNTb0ZWdE5SOXZxMVVvbUdWdGh3VEdH?=
 =?utf-8?B?bWx3dlRnQWxyWmEyT0J0SnNGc0JpUG41M0VNRklzVm1Ca1c2emd0dGltb2pH?=
 =?utf-8?B?OUFFa2RmMlhpQjFnY0UzSUtiYTEzY2ZRUUFtSlJ5UzdtT0lsb2NjcVNvV1Bp?=
 =?utf-8?B?V0RUOGthTFVWMGEyZFFMTE55TWpHNis0NG52TjZETnQyWDNtL3Rnb05Ud0JX?=
 =?utf-8?B?UW1vM2tWUTBRejJmZlNPTnFna0ZocVFFUFhUTU02bVJjblJ3NzJHTXBWbVB5?=
 =?utf-8?B?WDVKcDJHcy90NmJEakhsS0VrTGlZdm9XYitXd3NjczdkaElPYnF0SDhYYWZl?=
 =?utf-8?B?ZnpDckt4VG9vcW9WNGo0MTNrYXE0Y0duY0pLSFcwTjNSWW9tZ01PZHlLS09o?=
 =?utf-8?B?TmhJcmZBQkxSU1NYbDZtSnJlb1dNaWhwc1VsZHVNcVBhaEhnbFZFcmpZY0dm?=
 =?utf-8?B?YncyYWxxc1NKYkFmVlAyTnlvUUYvcnlKMldLUE56OU5zQXFlL0ErSndWNWs5?=
 =?utf-8?B?dVRxVGg2K3ZvbDNCeWZZOGlpNVBUQ2tKOW8wRHUzNUVuKzhFUjZQaXg3Ni9z?=
 =?utf-8?B?cFRhY21OWk9sWS84cDgvTnI5ZGhVTzUwZGJkTnd0WXZzRDdIRmhPLzZ6dkxC?=
 =?utf-8?B?UlpTdVdlYk1YSDY3ZEhtak5Ub0xybmVUeGFhTWlUakRVRlhZWUFwZ05BQU5h?=
 =?utf-8?B?R2JkK0pYRE5yb1dLZ3BxL1E3VHUvMTFPaXpuaXlGM1d5bkdOU2ovYU9RcUJk?=
 =?utf-8?B?dTh4UlZvMjBXU2NJWjZ2ZzNiQjE5dVNUNHJydkYwd29xZ2hsV2h5VzVVV05M?=
 =?utf-8?B?UnFVUmV1UG9YY3F5czdVek9QVjVuVmlUckRaelRLUzZnRDJZekJrY3k1aFoy?=
 =?utf-8?B?Rkc5aGJnTlVmYXF6MUZyNEN1eDNvOG5BRldjck0vWFQ2QlI2SnpXcjg1WFNG?=
 =?utf-8?B?UE1BbU9TVENpdDUyaFllVEU2RDNNSThWeUFIQm9hdWNyS1pkbU1Wcm1TM2Fq?=
 =?utf-8?B?MFF3UC9DbHF0cEtIS1pCeEVjNVJ1OEZ5a2dSRVV0a1hMSjNoeUNmS1V4YllM?=
 =?utf-8?B?TnBWMEhUZUFVbGdSL3BHL2lSaUlqNDNodVRVNW9tRXVBNUNxWmpSbHVyZ01a?=
 =?utf-8?B?Wm5UV2xOTzU3ZW5Ka3IyZWJXak5rcGxRbEN3dXRETkF2azkzeE96aTVOb3kw?=
 =?utf-8?B?MUQ3a3JHMTNFYXV6WG5LOVJ2YlkzTkR2WEJSOUJRbEI5cUtFdG1rK3pHZGZD?=
 =?utf-8?B?UzhBTmM1eGJpNlFhT21pTFNtVWdKeWFBenZyd0pCcEgyeWZZOTJsdktLK3dN?=
 =?utf-8?B?MzNSMnMyQUdrRDBhbDQzZHNzeVVGejBuOGx4blI3UG5UVXhsU2E2aU4xaGo1?=
 =?utf-8?B?VjFCRXNXTXJmMjF0SXJGR0lHQjdWd3JqK3Y4aTVKemFoT3ZRcGFpNW9yWEZX?=
 =?utf-8?B?SHgzRjJ5c2lJTnFpZ2hrTFFRSFFmL1Q0ekhrU0JodlE5Qk8vaWRGRlNQMllH?=
 =?utf-8?Q?5/Wfb3+ewDbKfZejt3I0PyXftnyycv6QsyR6sobb61wA8?=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR01MB551;6:9AC+krfkJB0HuN9CTVR2PeoyEFO6SPWOaaSb0H/qIEMLJm+Ucf/0h5looG/tXv7WkRM9sUx5rmDaC3Gv3fJasxuMTzPuW4IxTvjWYHH9pZH22GCc7466/pB3C5qcSOtj61F8B6JhbCQ4JRlhYoYP5mnTBhqDLj+KP8kcrYbex3SjVvMdWIQOsate9uH3UQjebb5smv0Q51HF9jHo3sw4a4rQW0hNmA0NsAB390oEHyqurTHoEGrwrjNRHuj50r+0DGzYihukv1AtxaDUsk0Bho1RJFyIbqheykuiMWeWp/s7JJYpU/wF654uZV3wrcCRQmqn6x0K6f+ew/wjVu+JIg==;5:uF5NWUIGrMLKjYAMywEv1hFFQzFNXrxaNBfQt2CDOCYxH/YoXPzYiSpdP+naNCTxwxvOzx16iz8ZIiFRA0UswwSErSTT0AZgQ1ibAsO2p/siEvcVKBMeleP0ruX+UsudUDySSEUPLMe227pe7qvhdw==;24:a2BcbiUgxyEEk/44GvBhRQrMopX38F2TJTiNRVSJcKDFOckPM8qY5OcS9kcNKrEyalTvMm5m20kV2Wwjwz1F/+zHvhN6PWnmm6sxZSeeVPU=;7:vRqn6RAnfmSBuOFm0eC3xKTLdoei71Hv66A9ahtuXxByNN/PLnCO76rsw2uuzXcvLo/TwwJQ8Uy4mc9gvcufx1WXTeKQv+i/VVEyjfpe2E7c0mti30S7i7tGnHapRU7f4jiDQpibhj75qX9qt27IyiwKnSANdN2CN6JnVFnuD4uXv8lt4iyV1EiCmKdiMaD2xmP3mLtQLKhu4nqksuhrf3auzMbTpxVOiSIuzfsFlQ8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arris.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2017 09:02:54.1613
 (UTC)
X-MS-Exchange-CrossTenant-Id: f27929ad-e554-4d55-837a-c561519c3091
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f27929ad-e554-4d55-837a-c561519c3091;Ip=[216.234.144.41];Helo=[webmail.arris.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR01MB551
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGnigIsKCkluIHRoZSBnaXQgZmV0Y2jCoGRvY3VtZW50YXRpb24gaXQgc3RhdGVzIHRoYXQgYnkg
ZGVmYXVsdCB5b3Ugd2lsbCBmZXRjaCBhbGwgdGFncyB0aGF0IHBvaW50IGludG8gdGhlIGhpc3Rv
cnkgdG8gdGhlIGJyYW5jaGVzIGZldGNoZWQuCgoiQnkgZGVmYXVsdCwgYW55IHRhZyB0aGF0IHBv
aW50cyBpbnRvIHRoZSBoaXN0b3JpZXMgYmVpbmcgZmV0Y2hlZCBpcyBhbHNvIGZldGNoZWQ7IHRo
ZSBlZmZlY3QgaXMgdG8gZmV0Y2ggdGFncyB0aGF0IHBvaW50ICBhdCBicmFuY2hlcyB0aGF0IHlv
dSBhcmUgaW50ZXJlc3RlZCBpbi4gVGhpcyBkZWZhdWx0IGJlaGF2aW9yIGNhbiBiZSBjaGFuZ2Vk
IGJ5IHVzaW5nIHRoZSAtLXRhZ3Mgb3IgLS1uby10YWdzIG9wdGlvbnMgb3IgYnkgY29uZmlndXJp
bmcgcmVtb3RlLjxuYW1lPi50YWdPcHQuIEJ5IHVzaW5nIGEgcmVmc3BlYyB0aGF0IGZldGNoZXMg
dGFncyBleHBsaWNpdGx5LCB5b3UgY2FuIGZldGNoIHRhZ3MgdGhhdCBkbyBub3QgcG9pbnQgaW50
byBicmFuY2hlcyAgeW91IGFyZSBpbnRlcmVzdGVkIGluIGFzIHdlbGwuIgoKQnV0IGZvciBtZcKg
SSBnZXQgdGFncyBpZiBJIGRvwqAiZ2l0IGZldGNoIiBvciAiZ2l0IGZldGNoIG9yaWdpbiIgYnV0
IGlmIEkgZG8gImdpdCBmZXRjaCBvcmlnaW4gbWFzdGVyIiBJIGRvbid0IGdldCB0YWdzIHJlbGF0
ZWQgdG8gdGhlIG1hc3RlciBicmFuY2guCgpJIHVuZGVyc3RhbmQgdGhhdCB0aGlzIG1pZ2h0IGJl
IGR1ZSB0byBtZSBzcGVjaWZ5aW5nIGEgcmVmc3BlYyBhbmQgdGhlbiBpdCB3aWxsIG9ubHkgZ2V0
IHRoYXQgZXhhY3QgcmVmc3BlYyzCoGJ1dCBmb3IgbWXCoGl0J3Mgbm90IHRoYXQgY2xlYXIgZnJv
bSB0aGUgZG9jdW1lbnRhdGlvbiB3aGF0IEkgc2hvdWxkIGV4cGVjdC4gSSByZWFkIGl0IGFzIHdo
ZW4gSSBmZXRjaCBzb21ldGhpbmcgYWxsIHJlbGF0ZWQgdGFncyB3aWxsIGNvbWUgYWxvbmcuCgpV
c2luZzrCoGdpdCB2ZXJzaW9uIDIuMTMuMC5yYzEuMTUuZ2QyYmJiN2MKCi0twqBNYWdudXMKCk1B
R05VUyBDQVJMU1NPTgpTdGFmZiBTb2Z0d2FyZSBFbmdpbmVlcgpBUlJJUwoKbzogKzQ2IDEzIDM2
IDc1IDkyCmU6IG1hZ251cy5jYXJsc3NvbkBhcnJpcy5jb20Kdzogd3d3LmFycmlzLmNvbQoKQVJS
SVM6wqAgTGVnYWwgZW50aXR5OiBBcnJpcyBTd2VkZW4gQUIgLSBSZWdpc3RlcmVkIE9mZmljZTog
VGVrbmlrcmluZ2VuIDIsIDU4MyAzMCBMaW5rb3BpbmcsIFN3ZWRlbiAtIFJlZyBObzo1NTY1MTgt
NTgzMSAtIFZBVCBObzpTRSA1NTY1MTgtNTgzCgpUaGlzIGVsZWN0cm9uaWMgdHJhbnNtaXNzaW9u
IChhbmQgYW55IGF0dGFjaGVkIGRvY3VtZW50KSBpcyBmb3IgdGhlIHNvbGUgdXNlIG9mIHRoZSBp
bmRpdmlkdWFsIG9yIGVudGl0eSB0byB3aG9tIGl0IGlzIGFkZHJlc3NlZC7CoCBJdCBpcyBjb25m
aWRlbnRpYWwgYW5kIG1heSBiZSBhdHRvcm5leS1jbGllbnQgcHJpdmlsZWdlZC7CoCBJbiBhbnkg
ZXZlbnQgdGhlIFNlbmRlciByZXNlcnZlcywgdG8gdGhlIGZ1bGxlc3QgZXh0ZW50LCBhbnkgImxl
Z2FsICBhZHZpY2UgcHJpdmlsZWdlIi7CoCBBbnkgZnVydGhlciBkaXN0cmlidXRpb24gb3IgY29w
eWluZyBvZiB0aGlzIG1lc3NhZ2UgaXMgc3RyaWN0bHkgcHJvaGliaXRlZC7CoCBJZiB5b3UgcmVj
ZWl2ZWQgdGhpcyBtZXNzYWdlIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBTZW5kZXIgaW1t
ZWRpYXRlbHkgYW5kIGRlc3Ryb3kgdGhlIGF0dGFjaGVkIG1lc3NhZ2UgKGFuZCBhbGwgYXR0YWNo
ZWQgZG9jdW1lbnRzKS4KICAgICAgIA==
