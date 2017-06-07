Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9C0A1FAEB
	for <e@80x24.org>; Wed,  7 Jun 2017 21:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbdFGVB0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 17:01:26 -0400
Received: from mail-by2nam01on0130.outbound.protection.outlook.com ([104.47.34.130]:32576
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751428AbdFGVBY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 17:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eafit.onmicrosoft.com;
 s=selector1-eafit-edu-co;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=QMibnPLWNmkSlBlaafW80SidKr4MdCrJlsfKxExJfII=;
 b=HLASI4jCsgYepeN2pW8EiOcABwJCwksS72WCJS2bpHZGfV6nzFdh5n/3zQoPypm10jnDTSpw2CJUkpOMmuc8wDfzZK7WxbInEfVRZFJc6AEOvQEFCiSMTdWso6gTPiGUc4oqOcUF3ojUpRS8NQiYC3HnjPoZyLfCXGpzx/Bh1qk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=eafit.edu.co;
Received: from mail-wm0-f54.google.com (74.125.82.54) by
 DM5PR07MB3595.namprd07.prod.outlook.com (10.164.153.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1143.10; Wed, 7 Jun 2017 21:01:22 +0000
Received: by mail-wm0-f54.google.com with SMTP id d73so18995144wma.0
        for <git@vger.kernel.org>; Wed, 07 Jun 2017 14:01:22 -0700 (PDT)
X-Gm-Message-State: AODbwcBfNJzE+04ob/mj9M4cMfW/xavyhPqeG2tfVPpgquqy0BhGLgsc
        4MFJbDbDJu2ZeMun8xuoYpDPbN9khg==
X-Received: by 10.80.140.204 with SMTP id r12mr21762396edr.18.1496869272075;
 Wed, 07 Jun 2017 14:01:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.151.49 with HTTP; Wed, 7 Jun 2017 14:00:31 -0700 (PDT)
From:   =?UTF-8?B?QW5kcsOpcyBTaWNhcmQtUmFtw61yZXo=?= <asr@eafit.edu.co>
Date:   Wed, 7 Jun 2017 16:00:31 -0500
X-Gmail-Original-Message-ID: <CAOUWSGC3z990x_Oehh5=R7jV2no63FGwVyArT9z3pp4zpBzxWg@mail.gmail.com>
Message-ID: <CAOUWSGC3z990x_Oehh5=R7jV2no63FGwVyArT9z3pp4zpBzxWg@mail.gmail.com>
Subject: Missing git-2.13.1.* files in the SHA256 sums
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [74.125.82.54]
X-ClientProxiedBy: HE1PR0301CA0021.eurprd03.prod.outlook.com (10.168.131.31)
 To DM5PR07MB3595.namprd07.prod.outlook.com (10.164.153.157)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR07MB3595:
X-MS-Office365-Filtering-Correlation-Id: 49ef0a74-7ce9-48ce-03a3-08d4ade85a72
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:DM5PR07MB3595;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3595;3:M3X4M3Hl1So4F6xSKmpmaK2Dz4sTQky8vs/t/mvbS6PNsABWaPbWeadpsoF6HY2umg2+6L2y/UW2SZT9wyYQwX4+UuJxJ5tCprGeB4I01oBSmf8lSRX6uwl6+cg4viNul4wdZ5Qehfg19RI2J0ULF8ptpskD6BNyniU/zaz8lBDUIIIpbjCPJi+unwBfD7hrbva9j5r0uneHbIjrZcZ1Pct7mPUPF1NE5K8mNO5xvHrgc1vWueM3fs26y3HIfe0ebOxI49wPVX8JuozEblAtgXJj8WMTcauiXQuKpoSQEJmGXH6XCkz7V2uLqxT4nFSiEASqg+h6WEhIIC4SbKmoOA==;25:EM22lzOTpyQtkb2VpIy+as9zF+at9G92hqDzj0/Pxgs97DwJ/qxiFhO2MdpD6yPAq7lVBrN4GVqKyNpFrLlH4YBS+LHdEDUlYGwUHfcL1JUKBM2X9qZkHOVrx0fNJSGB6U/QI2JVp02C+b+0Qs0qR1MCw9OHSG9XQxwJbTAS1oGlKJN/TboTyw0wujjqfluIfei+cRxDbhS0D2GUgFCnRe0GdJVxHrZNN1SkihOYH+HJl2SXpjMQz79swcFUvvpdF6t+KC4hyEt0JT95KNjb8s9f/lq0apwPKRakWkuNeUrOndX9CNIDhBZSjf01soczC1EzRBcFQkdGTemdv3/q9m5Ss3SlTW1Nt+qScI7MSXHpJpW/ZHKShvRD8u32wdxHYMG2aKE5XlrF0gDpoYOR0azoFUkhaXEZdL1PwMO5mEgzFBI6nzdNB1QelslFTQ63C9GHD6YdKjX8RLMU95hCtgnmCuG0mJiK+MNbcUYIHaY=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3595;31:m68Cal9pZLQFJ1gLa7Cclzsd+gD1rgprbMdo89B9eePUFsMr28iv230amDHJIccIelIlolg7irT/584R8JesfM6j2EsIz+onLa6F58oRFsdXbbX7rU5wzdCwrIYSm+Ui40OIX8oVMymDu/5Sa0UNPYRETii3vWxXXQdMxpCl4oeh1HAiNsKkjtEPuuhdgExZ4gqBS/O4q5JTRl02bik/XmlnS+rga2dBgcCyelv3J9PqsELsVbdPz68z4o3VwaBRanISW46JL/mnm8FPcJx0qg==;20:rZ59cBiDG37KVFwTENTdGTzMVM/XLBZU3fMo8B4jxGMpa8HiBOLsr7fGOyePhFauqbWgL+oMJRt0AkxvaDveNZV1UPMgFAVsldzdaC3KUf4tCRpzotRmvK4ldDU9gF3EQuHdYAsUnAvON4PyWin8UePNQYYXhSjzoRRfRcrJ4/h1pxt7jRvydlyLyd1MT1kLnjAkRiDhmHAeePaNnIHefZxjrd5c0px65rZkiPR7DGwrXQAyg67Cr7ZRFHln4UwaIMyI+/4pDD0aKaUahEDclqZ0Y6DuOw3/4DnLahOdZC8icgbinLZZ6GM01AE9hRmH0Tmit+s5uXTxNnOEiFqmc18nfXnzMVGwuNUISvS+oAC/0cOcJG1Qirp/fjfEKyxl+YYUUsgqDFkeJHLPDxhtXsMpG5XKt7kcLdTvAjPchm4NslGg8iONI76KsXhLMRqGafxoveISrTVHYoVQ9pSfC2XmM4l52EMeSsdGG3FcdN4vXMsUgEvMAV61OkO1UlEh
X-Microsoft-Antispam-PRVS: <DM5PR07MB359516BF8CDF740CD3D1BE639DC80@DM5PR07MB3595.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(100000703101)(100105400095)(10201501046)(6041248)(20161123555025)(20161123558100)(20161123564025)(20161123560025)(20161123562025)(201703131423075)(201702281529075)(201702281528075)(201703061421075)(201703061406153)(6072148)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:DM5PR07MB3595;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:DM5PR07MB3595;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjA3TUIzNTk1OzQ6c3F0UlVPSHBHUm1VU3U0RHVpT0k1OHd4V0pl?=
 =?utf-8?B?VzUrK3BmZG9UcVBLTjNWdk1tZmpvdzRJc1l5UEluY3VkUnQ3UGdndWtSQWFC?=
 =?utf-8?B?K0w5TCtRNWtpZkR3SVNrLzFOSmF0Nkx3OTFITlRzaDVHbTY0WWt2STU4S2Zv?=
 =?utf-8?B?UmZhVFBJaXJkdnpLWU1jazBKcXBkeGVFSEUwTmFDOFRITUNCUGpMb2hsbU82?=
 =?utf-8?B?WUxLOG1raDUxLzREc2tMaU1LSVNJYUlUeG5WQmJsN2JTY2JUL3FJZXBBTEpa?=
 =?utf-8?B?NGVVSDIrVVVLUGxRU3BDVkRHc1RRN3pHZ1V1ZXJTcEFHUEtoZVFpNWNMQTcv?=
 =?utf-8?B?RmpQclVRb0wvRmlyUlJrbFZEbVV6RDBaUmxxRjhSQ3QzYXFkY3JxdkRUZ2pB?=
 =?utf-8?B?N3NXeVQxOFA5WHFhUE9QUlhQcmhHTURZK0FDS3FjOTB2U2tHSnpjUzBCdmRP?=
 =?utf-8?B?cEhqMVFhUjFQRW11THdEYWFJb2g2UzlFZEdHZ2diM2ZPNGpYUEdOTlBmZVhj?=
 =?utf-8?B?RUNEUVVMWFhyTFdlZCtIREwxUEFhc1BoZThMYVBUYmVEa2Zxck9Na1JBM1Jw?=
 =?utf-8?B?NGZwZDhtZUV5K2J3RmFqT3cybW4ydDErVU1kM3kxNUpHTlpJL0g1ZkJQc2ly?=
 =?utf-8?B?ckQyckVDTWpiUW9mSWhBejhNQzNaQnZoRGhrZFhEZE4yQVV0ckpPN0RRMkpC?=
 =?utf-8?B?WUc3dm9qMUlMaURsVWVobDZUZkhMYkZqbmhhUDRYQlFFam9Id2FWWlJ1b1dO?=
 =?utf-8?B?aGxVZ3J5b0pSVVNFUnoyU1FNV1dnRHNRUk1TTHpXU3pNaDZEWXUzQXBTdG95?=
 =?utf-8?B?UGtSMkE3TDdoYTFWQ01FRHU1bGxFNk5OT0s2RlhWV2NtY2NIM2dORDd4aEt3?=
 =?utf-8?B?WER0ZlZMVmdkMnNtVTlFUS9PYTRBQXlNVUx5TGtjOUN3blI5cElKNTE0V2l5?=
 =?utf-8?B?cGpNTGU1QXhsRmhVQWtzMjdhUGwvWkVrNXNPRGFvdnFDQ3VTREFqblNGUjJJ?=
 =?utf-8?B?N3gwOHdGVExmQVpNRkU1TUVWaEpzM01lSG9QdFZVOG5YNkFianBJeDEwSGow?=
 =?utf-8?B?Mzg2VTgwYlcyY1NRcGVIK3A1azFtTlF3V0k2MlpOdit0dFBhSUppSTg5eThU?=
 =?utf-8?B?M3lEcVlVOFIxSHNteWlmRVBTcEFkYk5jeHM4YmFaaFVDeURiMU1NQitmdlBy?=
 =?utf-8?B?WTVuWXVRMlA3OXkyMlZ4MkFaemQ5dTJXQi9DVDA3cklGaVVsMFd6Q3djemlx?=
 =?utf-8?B?bUlYT01sdHp6UXlJOEp6TmsrQUR6OVBXS3BUMzM0RjNVTXVlL0RyNXJSMC9i?=
 =?utf-8?B?b3Q5eUpjLzhSci92S1NCY2tIdjkvenh4Z2ZRV3NXUlgzZzhuTXBPL0hZYWJu?=
 =?utf-8?B?emtWUEJBU1FYK1U5OFZrNU9SL2xvVXRzdGZWSG5LcGtzbk9KQVJzaEpRZExY?=
 =?utf-8?B?VXo0bDVmVDE5Tk9JZVAybmVNb3NyWEVBeE9IVFpZZFZGV0hTT3RYbnoyeDVm?=
 =?utf-8?B?dlBNejRLQmlqYkRNekZSNCtTd1hQTzJwczgrWEdDUDZGaDZIMU8rUmVLYmRE?=
 =?utf-8?Q?+pEpx/bbnkGWYbqWM1GL7OthHM+9wv+dLKqD8xSICkQ=3D?=
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4630300001)(979002)(6009001)(39840400002)(39410400002)(39450400003)(39400400002)(38730400002)(6116002)(55446002)(50466002)(8676002)(81166006)(8746002)(42186005)(54356999)(63696999)(93516999)(88552002)(2906002)(2351001)(6916009)(2361001)(85202003)(42882006)(50986999)(498394004)(122856001)(9896002)(6306002)(110136004)(53936002)(85182001)(61726006)(74482002)(3846002)(23676002)(7736002)(305945005)(61266001)(47776003)(189998001)(9686003)(478600001)(66066001)(966005)(86362001)(5660300001)(98316002)(5820100001)(55456009)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR07MB3595;H:mail-wm0-f54.google.com;FPR:;SPF:None;MLV:ovrnspm;PTR:InfoNoRecords;LANG:es;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjA3TUIzNTk1OzIzOjdHcFNwUmJ3UXB3eEJYSXpobjBiOHFpblVP?=
 =?utf-8?B?SFVkOExUMVlOK1U5Q1RqRk9wbHZ0cE1VeDVsL3lPL0o3OVFQaDV0c0ZET0NI?=
 =?utf-8?B?MXB0V2FIZmd1VFdYcVE5OFpra05iTnA4Z3pxNmExeUI1a0s1QUFtcml2d0NP?=
 =?utf-8?B?NzRhZG1VcE0xdXI3ckRSMHpDb0hEaG5LSThhSUVzRHNxY1l4SDNvcUtJMTJ1?=
 =?utf-8?B?L1U0THBJZUV6dTA0M01BekFacFIvcVJRWWZPK0k2WVBlU21ZSmQ4Q1pYSjFR?=
 =?utf-8?B?ZWZxTnhFTE44a29rcGZ0U0NGRXdjdWdUY0hPVUV6Tmp3YkpNazFpQWtLZ3RE?=
 =?utf-8?B?QzNKdEVMUVJwVkptZnE5LzFMcDhSQ0hCUkZQcjRGeitkYVVxejJpbUxJSjlU?=
 =?utf-8?B?RTRtTis2M0VpZmpEYkNaK0tTbnh5V2J3OXM1dzZYOVVnNlZZVzNvMkgyQThQ?=
 =?utf-8?B?cHMzV3FKVy9RVGRJRkVyTkhGZFJFZWtacno3L1RhUU5OTnFNR09VWHRoaDlv?=
 =?utf-8?B?Y0EwZkFQSnRCcVdJUU10UTRWK3FsVVdmVEdMRG9pRTRZZlRkOXlmcituWUJX?=
 =?utf-8?B?WmUvWDdEcjRoNU1Rdzd3SWlwRHg1UDlBN2l3NWtEUVZzQ29XZVV3K1JxcnZN?=
 =?utf-8?B?b3IxV2l5azI2anMyak44QWZzRGM4ZHd6YlFWUXh2V1FKRFZBejRCbkhjUG1j?=
 =?utf-8?B?TWtNcjlia0M4UnFMajVGaFR0OXJGdmhSTVRxbGZ3akVRZVpHMkFJQjVhSG5C?=
 =?utf-8?B?S3M4bXBMdytPaTVmM2laNWQyYWd0N0hJajNvRGFkQTFYYXFrRnd4Y0MrbXUy?=
 =?utf-8?B?Q3N6SlN3WjQ0ajdrdU1TMUVZbmtreDBMdHhmQnNSTmhlOEYwaGZhVFpKY1hM?=
 =?utf-8?B?RVlyVWFrQWtjSjdqSGplQ0Y2RmJJS0NnS2FUT2dsakVMQis5SEtYY0NzNGdx?=
 =?utf-8?B?M1RVSU03cHVRMjExSndtWlQ2OUV1TTBoOHB2aXVtUG82UkFiYTBQOVQ5enYr?=
 =?utf-8?B?UHp1c3locXlHOUMwLzhESmprM3c4LzBHNEZldWF3R0FLQmRkMmU4UG9lRHZi?=
 =?utf-8?B?QlExZE9rWnY1Q1Z0TmhEQ0piaTQrOUJVcGtVMVJFZHMxTTNnYVZwVmM5Njd6?=
 =?utf-8?B?ai9rK0FvK1Z3YkNJTVREQkp3VGZTd2cxakVmeFBudVl0WXQvWE1Ub29rd0Fp?=
 =?utf-8?B?Uy9FYWN6YUxtR09BMkxpTnJzUXBUZ1g0eVRvV0l1TVRuYXZkL0Nia3BsYnJp?=
 =?utf-8?B?V2gvazJUakpsM3ZBMVZMZWRYUXJLNjJaOWVPelNOMHFabi9kd0ZkQWNDK2tT?=
 =?utf-8?B?REViRFFjb05URVAvc2NJcVpnak9QSTNwRUdoekJjc2d3Ulg3TnllU2NTaW1D?=
 =?utf-8?B?LzBFWStkSnRJVXBOVngxRDIwT25DZnpTaWxKQjliY09CcCtEdDVna0E1OXJL?=
 =?utf-8?B?eG1pV0FPMllyMTdmOFpDaS9yTWpLSms1TzlBUGkxelVYTEcyeHVXRG5zMTlQ?=
 =?utf-8?B?R1dCRmxXdk41TUZjWTliUTZBdjhMRzQxYjN0QkVKYzBhQVMxT2RhbVRKeTYw?=
 =?utf-8?B?ZnZsWU5iOXp1cm5VcmlGSE5Ob1EwVkV6dlBvS0lVaXRlbG9vdTY4c0M5aEhM?=
 =?utf-8?B?L3kxQklWRWdmSVlBNGJJUERiNlVnbktDa3k5REdKTE1WV0tBSGRia1gvc1FE?=
 =?utf-8?B?cTgvbnFlMytyeWV0dnhnVnNQQTI2UU1LOVZpWDIvb0dKUnROVFpHSkNlWDh0?=
 =?utf-8?Q?D89cLdtXJbA3PZ0iZ5pZto/4PDiYEfWcOy+eA=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3595;6:UrHcn1+A6kLk/grMb9dPe+9X3vHMDcrciHq4zeUbIMlb59KGZrDytnpPxDrNXbzFxHuIqFuA8ew4v8VpZqHKXs+sI8upA/JCBQgvl7Jcgmn8JBLpOvOenxsKalgj75+yg8GiN0LekChIcAsEUkThmbQzU39if0IY+N7nsDYw56Yb225AboLv9T6Jdss+CCAgJWj1c/h/JdSy2VlMqUy6QasRfzLQoN/vAq+CqU0iKMk3JGTg2ktrKKJNYP6mi0tCPBGKYOut52Y+BkvOEF+adnGdZT9gjR48l5E600/ZM8KrgCkGhIjWCwADpRDqhhBCwTBVaPUz0x5or+ZGJ229IxIrRVdny7AootoK8FnKZK4AQF4auLw7brJzQkyvCN39TXyHicu6o+YGZAgsgJC+JU2IgJMZOUd3wJhbavft8EDozQ5dXb4we0YwqA2/a9syszAXd9t1E19FRbucQBKSAhVTsSrhUrUrlmALCFyft+9V2djcxfNUZ/pg4GaySo8RyfJX9QshwrXvOEz4sVnXrA==
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3595;5:s65bejlqDWxy3lh5UY4mhjihY0lxBu84WeKcWDyX8zUMKfxJRlO3lCpxKMi8cCCkASlXP1KVjEd4mf9B6tMS+7n0GYCUBwaeNX7GPdBtxOD5AwbRQBZWQmCWa9IEDFkX+rJIML3rtbZv6ymPZCEC3IQ8zlzPBUYD3XqY6s02+SZkJ1bZiZbVL399CDcEfcgc8pMxyUHKrA/uQMHzdFlu1+ZDVgDGQm0CbqCtghRb2BqwkUi98AjdFO3oxyN2XPgNLNjOnpbLrZhRR4pML6tcwihn1Nv10Gu7CZF4LSp1I4/A4jlpkWqDBShxfybLNVeE/eRdkfQERFOYtICIazICihlzCLtnXkAgtj+6Pd6/gewQT7eSmoB4vdTYHqFpGV5U7//zHkZx/+QbjZ23P8+nETvL1g40apEeyf7OEVn4+TrNuYeuBZWvGiEsgW37+phHQiiTd5fppuTez/l7OGO3XgLFTW1irYdt7QVHSkk2ekC8k/AKxP3v4dXwVnRfcTSO;24:BDkwV4SlyV//RKpCwDNARPMRmp7xbGlaQEgRHbgGyBxtJs7kf3Xy+Gm1xdK1CMO4xFVApDObBfsKt5V2LCQ5yWvaXpodTjHDYfGbVb5Z134=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3595;7:LWJS3qkUM4lUSXEzxDvX+eedFXnw/Hxmt96Z2F4gyCAtE09cpRfHlFVD6Ulb5Fp8MicSoIX5O/6pKMO+UxZRWPEz9fYwF6pTF82eT5fzR4KoNhdcrcqcsnYMrxqa6R+9ySus52E0tdWRzyeQFGkfEbzjXGITfIn08QYtqwmnwjc4lFmGzP617RFpW1hsoVEA6L9Icw4zw3UYmDj0I7kT/lYdgbDK78IxJ46xw24H+1lNavZaNQlJTenYhze1rXXIST2De10RoIuVai2y4sTfbjwvcgfxBy5OYGUqJh6fYjTbZw9JJLwKOA6/nYW8WIHTJHqBj9BMkYpbRqphj+Zp/g==
X-OriginatorOrg: eafit.edu.co
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2017 21:01:22.6110 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3595
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear all.

The git-2.13.1.* files are missing in

  https://www.kernel.org/pub/software/scm/git/sha256sums.asc

All the best,

--
Andr=C3=A9s
La informaci=C3=B3n contenida en este correo electr=C3=B3nico est=C3=A1 dir=
igida =C3=BAnicamente a su destinatario y puede contener informaci=C3=B3n c=
onfidencial, material privilegiado o informaci=C3=B3n protegida por derecho=
 de autor. Est=C3=A1 prohibida cualquier copia, utilizaci=C3=B3n, indebida =
retenci=C3=B3n, modificaci=C3=B3n, difusi=C3=B3n, distribuci=C3=B3n o repro=
ducci=C3=B3n total o parcial. Si usted recibe este mensaje por error, por f=
avor contacte al remitente y elim=C3=ADnelo. La informaci=C3=B3n aqu=C3=AD =
contenida es responsabilidad exclusiva de su remitente por lo tanto la Univ=
ersidad EAFIT no se hace responsable de lo que el mensaje contenga. The inf=
ormation contained in this email is addressed to its recipient only and may=
 contain confidential information, privileged material or information prote=
cted by copyright. Its prohibited any copy, use, improper retention, modifi=
cation, dissemination, distribution or total or partial reproduction. If yo=
u receive this message by error, please contact the sender and delete it. T=
he information contained herein is the sole responsibility of the sender th=
erefore Universidad EAFIT is not responsible for what the message contains.
