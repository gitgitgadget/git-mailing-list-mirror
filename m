Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2A3F1F453
	for <e@80x24.org>; Thu, 17 Jan 2019 20:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbfAQU6V (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 15:58:21 -0500
Received: from mail-eopbgr770118.outbound.protection.outlook.com ([40.107.77.118]:24768
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726913AbfAQU6V (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 15:58:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=garmin.onmicrosoft.com; s=selector1-thisisant-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iC5urx0RVGU6vHrYjY32rlezp101XWf1t/JlBAft2Mw=;
 b=qmO2m5ULyElLGLILGtH7zdWFqidozcmpW7NHQVQC6M+LBCx91G75VQiw4eJe1+drgFdZ42H+tVS/n/MTcujY/y0hZGdnZiqz+fmIe0tdtK7k2JOH/jrXY0BuKiuf0XIxc+UTBmh5bE1iA/w91mKsisUIogMQnEjGJ3KiLZrzK6k=
Received: from CO2PR04CA0076.namprd04.prod.outlook.com (2603:10b6:102:1::44)
 by MN2PR04MB5869.namprd04.prod.outlook.com (2603:10b6:208:a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.24; Thu, 17 Jan
 2019 20:58:02 +0000
Received: from BN1BFFO11FD006.protection.gbl (2a01:111:f400:7c10::1:198) by
 CO2PR04CA0076.outlook.office365.com (2603:10b6:102:1::44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1537.25 via Frontend Transport; Thu, 17 Jan 2019 20:58:02 +0000
Authentication-Results: spf=pass (sender IP is 204.77.163.247)
 smtp.mailfrom=thisisant.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=thisisant.com;
Received-SPF: Pass (protection.outlook.com: domain of thisisant.com designates
 204.77.163.247 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.247; helo=edgetransport.garmin.com;
Received: from edgetransport.garmin.com (204.77.163.247) by
 BN1BFFO11FD006.mail.protection.outlook.com (10.58.144.69) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id
 15.20.1471.13 via Frontend Transport; Thu, 17 Jan 2019 20:58:01 +0000
Received: from OLAWPA-EXMB5.ad.garmin.com (10.5.144.13) by
 edgetransport.garmin.com (192.168.18.222) with Microsoft SMTP Server (TLS) id
 14.3.435.0; Thu, 17 Jan 2019 14:58:11 -0600
Received: from OLAWPA-EXMB6.ad.garmin.com (10.5.144.22) by
 OLAWPA-EXMB5.ad.garmin.com (10.5.144.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1531.3; Thu, 17 Jan 2019 14:57:59 -0600
Received: from OLAWPA-EXMB6.ad.garmin.com ([fe80::8cd:fdb2:3e43:c926]) by
 OLAWPA-EXMB6.ad.garmin.com ([fe80::8cd:fdb2:3e43:c926%23]) with mapi id
 15.01.1531.003; Thu, 17 Jan 2019 14:57:59 -0600
From:   "Khurshid, Beenish" <Beenish.Khurshid@thisisant.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git commits unstaged files
Thread-Topic: git commits unstaged files
Thread-Index: AdSuoTASOBd4JCYsShay0WD8Q+X48w==
Date:   Thu, 17 Jan 2019 20:57:59 +0000
Message-ID: <19f764a20b384e099372921d76ec4f73@thisisant.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.4.6]
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1010-24372.000
X-TM-AS-Result: No-9.622400-8.000000-10
X-TMASE-MatchedRID: 99gdNqugG2Dcx97ZZVZcMlz+axQLnAVB8GRhP/nTHNYUlWIKEoGBmUUW
        SNUeoUM2PI8SZp0SyHN82LSyel7Bro0To7oIUo/i6ivQ8oO6nULT3/zHKVtFfl2IodjcrbyzMq+
        en+OaNus90mznW897yTI9zbgkBmMyOT4ARLG3cJiI9ikmDWZMqS6GDroi1vrl550rfo9dgpZDjW
        rHEn8fHFNFyBXy/Ky1AQ6YnZBAdw03KXWd30Ii3RM0JxSxHjFJ3QfwsVk0UbvdirxFVpmK9bl+z
        CaIE7GwO6mfCPEjx45PYPQ9I86v4y2IJqP+M9x4eNlFmR4VotE=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.622400-8.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1010-24372.000
x-tm-snts-smtp: 3005BFF469E65B89B3D6FA29434BC3E000C46BE56C3E08B5BD4C067F19F2D3F62
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:204.77.163.247;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(396003)(39860400002)(2980300002)(199004)(189003)(336012)(478600001)(476003)(36756003)(126002)(316002)(50466002)(86362001)(14444005)(68736007)(72206003)(5660300001)(6916009)(2501003)(2616005)(26005)(69596002)(486006)(7736002)(5640700003)(305945005)(106002)(1730700003)(102836004)(8936002)(8676002)(23756003)(186003)(24736004)(108616005)(53936002)(47776003)(3846002)(6116002)(81166006)(81156014)(14454004)(8746002)(97736004)(3480700005)(2351001)(2906002)(106466001)(356004);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5869;H:edgetransport.garmin.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD006;1:ZC3ZO6bfYSVxiMXIZPW8sch2xMxd8yVvtbWawjDp6l+LprIvfCN9qMxzdX1CcDfA5/ZUsFAIKH9hrYDY4kdVmuO1I7BYcsbabNXQcttX0WpH4eIzZjwVT3/24bbEIuUG
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f963d281-53ee-4ae3-c2d4-08d67cbe780a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060)(7193020);SRVR:MN2PR04MB5869;
X-Microsoft-Exchange-Diagnostics: 1;MN2PR04MB5869;3:CLyvHpVbAHQ9teUj/2hZDZUS777WotV/Bvon4ya87Dcl3OrZlUNJBOBwfQlbUS4iuJyw1O6UpdTozotmvQ4i3wC0kWpSc+gzSVwmcfT2llD3X1jjhNu2v/OsLIKVDaGFR5N6fbAoZ0S43IBeDG7XT2N24Ejw94Iv9qbKWl8Gux71r3z0lgRFiLVc6WIzJyF/9WMTLbHF89hI8p2UpdO5e5ArBKiJPhvpbmzgk+kZ6Hwm4Ro7MCu50iI0eMwt5ikWqE6BmBRCFi8MuYhMki7NpWbCY8SdqHSTRr5O4YCuarWcjcogHw4BOYDM8vCxZgS48eqUuzVKytswGkmf0aSKaHqgF/gFcg3JvMZ4mBRLiUp3ZcxDQ+jP9PFgRdnuxfmO;25:zBId9JhmxsfEz7F8G/C4/qFuqB/q3oZ5XiKVztP+uYqXqnPngmsQXCZH8GEqrNTloE2WcrlrDuJKGC6twJFWy3MUNRDNXoL4Z7aqJsLb241HtAHZFdqxtLdQRFxbI5uhL40ku4gtwEnzlCzYhAVtpakMsgZzp2UcTLi1cOqfomhwHc+RyVIdhTJMPlqr+FwA81C4oYVB6bUo7u3p8DQlFRwC6PYf755LsWJjBDaJa16D4Sl0SF4X+k56wYo/4Qw6PK5qDnLEOIbD7eTPFSx1hdyYE8ozbXGrtCzlhv39UKAy/DJC885n9mWyooqJSbNITN5uHTSilQvbYHXNQvAx/Q==
X-MS-TrafficTypeDiagnostic: MN2PR04MB5869:
X-Microsoft-Exchange-Diagnostics: 1;MN2PR04MB5869;31:VGyTN/sXcSMSFd2bypoP4Jk3MjxRuCgKgJkhFSdHFhlmx45a4HC0NLRI5rLtTcuauvk8Fx1+J+ngL0lkRz4Q1B5nJ/t9RQ7OMuemclqEdaC21/dpPZIM/PfqGvmcn5c1ePVe1lfNkFEsk3jGizy0scN4Z7whe+annAjz8VxsqHN0NEpbdvemHTZhlU09Y0wmPBL2WfP/TrtNyeSQ1+NqYkndiJnh3NGQY4UySzrjVEQ=;20:O4k0xeW40NSDUYkABmQtiKdGmnJS0+2PaFlxHHvR7rfnn1pvj0/urtOcEsp1RuMqMIc5eQJT2Q5g2xb5ZYAGTpLt92phSrX7ivCmklJ14hhYInYtEZplZfq0b0k+RWcXTHeH9T7L8qG/YY1xbKRcuTEucvWI4kFBcaUeKRfwmrThj4jI5pjoeK41JqxDeLzf0FfcFfU41z96qPmsZ1HKLumkwAZwnTjop35BDZVP7oW+oaYlis/el3DtLwyDXKgdOEhVORIA4E3g9z8OHMSl51p3CiRkU+V47tRYrou60TPx5WucDhuUB6tz6dtI/SSkd78CNi9lauCbnmToruUzr5jtc/OpKMFJriNEjF0kNvUOeq9QuPG5GNw6RSvQdEMuI0gYBWV36Ql61wJRaAOuKjFzZ2c68N1LI/cKdmlDJZkQKmFvg0KBb2EtUz7l8o8TRi3pDeDUb4ctpUz8UD16ZFquwb2jZ6fhr64eMzaRGCa8ow+Gozw3xJyepK14so34
X-Microsoft-Antispam-PRVS: <MN2PR04MB5869F7A8D58C1DB47FD41A7290830@MN2PR04MB5869.namprd04.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;MN2PR04MB5869;4:Rxt3MoMgfWn7ZqPyPHLCj5CsxNeNjqoFuxYP6yWMLxuBXs0SfoGJpICp1JkwsQrnvsWsneZ+O3UGMBXyDKTzmrbSKIFA3f4a4CR6bcBLTcuDJmnsYWaQK9b7txnp4nEvPoh6xDWQuJclYVr47o/RLMqJaoikX0Qedmcoej1JXQGsLPLsfuvzGDVUagktPoVqtzlIiQD5Ud3xJ5BJ10mlIm5pWa10NGErL08EY1yg/n9pWALeJDSTtEySGvpdVhwXXkztmUdwdA/0H6l1/0WhadRW8Ml2qsISC7y3Cl0qHbY=
X-Forefront-PRVS: 0920602B08
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;MN2PR04MB5869;23:cAybRsKZ+5y++ugcTzgTvqvCnoFlu3a+9JLYAxS?=
 =?iso-8859-1?Q?4XhBbR5OugMhkegukUpYHBynteff4Neg+Jn86wxTzaxwPwActvUMbsD51k?=
 =?iso-8859-1?Q?uo7N21ANsoTT0zBzbVyqX8OBnLssqJT8f3HdPIEO5oYVhlT2I2UGLMruZv?=
 =?iso-8859-1?Q?tlVCM5aO5R/C/Y3l8Yxawh2iOdob/Yblnx+hkx6+0zfIwV242q7J5Ra7LT?=
 =?iso-8859-1?Q?P4OP7hOrCbDrGKiw6LAqwAGBHkaNy1TGmgm33KVLf+p397f75ybInKnOaK?=
 =?iso-8859-1?Q?z67QZNa91I9bexPtj5WHe54HfRwAmctsHOnPgSOjxYREuTIByGHSZqY5Pc?=
 =?iso-8859-1?Q?Du0AfiV/WVyJdj8WnjzRKjwt5adXKTWZla5v3lr+P8SEKl6ICGDbG5KJXS?=
 =?iso-8859-1?Q?dj5QiSlpWCm3sMPSeprM1zJUbXHWDW6FrAUV+T3/A/15hZfEEUeuoKrVd0?=
 =?iso-8859-1?Q?EQEl/bgHZLbu3w7FK+u5DkmqvvjUS6ehTYV8XC9zzRkITPOudb9iJA+4x6?=
 =?iso-8859-1?Q?mFEus/UnlcnWE6yZBPlJy9+OVBIjwemk+SmYmsmHzer3JtLCxvw6LTsrsD?=
 =?iso-8859-1?Q?WMynzT5YXcklfSWKd/QULz/RdZxq/1/tZ348WBLde7pfmrfXdAi74SCVi8?=
 =?iso-8859-1?Q?VlirDJfWffTwuWz3LtHGstV6Jk5pplnPT3BnAWue8tVzJSuYQ9CcNdzVLo?=
 =?iso-8859-1?Q?9lAzEhRDKNkdJSDCjcputfN5fBh5XfJABHxKUcZqY6b64PF7NAvPZ0LDZV?=
 =?iso-8859-1?Q?Gba4CvKCxZv2B7asWtxWJLpblsqc1IjfN1E5q2Lga/dwkwYQgVYToJOdvP?=
 =?iso-8859-1?Q?dSeu6/sfB14KNkGQEil9HB1N0DJwZu8pxO58sY33HSqmoAUxUappTOOEqI?=
 =?iso-8859-1?Q?izINP2N6zYk/dzmuEzYq6W1vhYfK/Og2gdlVyFcxZx8apNxdeDCa1FjaVZ?=
 =?iso-8859-1?Q?wjCh/MFCUuC9qV9tKgDhIVbIci1a0C6aTtm8t6CQWjYDIeG+VCcidYIrle?=
 =?iso-8859-1?Q?gTUcOW2Gd5np1XtR62W2F7ySCAw8nqMq6TksG7bSHNYAxp7UDPD5xIexxf?=
 =?iso-8859-1?Q?6vI0ggdm9YFHOvV6/f7D64Fxd37hf3Y+fKQwfSXf1vga4vGWlDCAxfbICm?=
 =?iso-8859-1?Q?kz53bgIBCVi6EyRlZYdbcVKdOD5gywbgjhSlqhHzAhKXvxmfk3XQE5VhmJ?=
 =?iso-8859-1?Q?KqwIFmvFPwaSrSqYesQyIiBPORq7ESsRA=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: J8ZhBo7lra4SjQYFs0G5WHV43xQf61eU+uhpOe5LVDJ8y68Ydd+BNzlcypeNongqAbP1UuwKw3W3EXq/PdStWmdQnWmlopHd7JpkdRT3m1e4qtibK1J79tSgvQIfhFaO/wTSFd0PR1EK8/vJf7+x/fH+CbFTAIuQnB/UGPVwFnEBbjM7U2Y57EffdQy6bsnPUE2pv9y5cRFon8m7CpbV+6K6wvlbNOdc8JFw6k8x92IDnAt0qRChj0XhzmElBCH6hBitqRpuY9IGeWUuXOsL9lQVYVMThaYpBMsr+Ey+8qDQqXrFXLe7Ktve/wcgrP6sgZlAyXNZiHR5LUqs4uV5AW10fOaJ3rd0rqesPjgXcydIIBtmwWMbw+dXcupT8z9efa0eQBj2iJ+0hYNtDbrpXbCNQW42CVOkTIj/fUHeeeA=
X-Microsoft-Exchange-Diagnostics: 1;MN2PR04MB5869;6:7Tdcoahx7KSWjICRH1HHtr6jXXu3MYOPhZeTvCCf0VlUNKUMSinrAffPL132q87vHhKj7Z+9sND8GL5EaY6D7IhYwt5KbX58iOLfbzHQ6T9ScuMI8d0kjdBsto8WPw0WC4jU17ODlFl11r0zsmp7YzOAKXbCwSlimeMpLF6GmnnAEKBmRnZ6LgU/CC4XDrnY4ihWgaT0/ALiPamqV4xni1r8uwIW7vCafmgLMsh1WmM371rb16OLIB+dNakECH6xBM4V10xK9hMJRFyEgWDQdFdw0iMa8wTfXrNR7p+VS+9bvuBacGxrYAL5DcsiUDyTKqFS0/zQTA7Rea42daVIr8jNKyMswmZHm+O5JTyt1gRpHv0xt8TLIklYJ+GvWHxdQAgU58Q7lUkY96Y4AUDquPdGphPJqgNUt86HXLRTmUA5285gldoTn8DaEau/R19AWhiaU6yGxij0Vxe0wlanhw==;5:dQB4h7XHENSYiCEUlRO1OtPGqWOAO9dG+B/THcdYET3FMsxdIDxgYKStFvkTrwHNS4QDjAS2Svl455yHkBq5M4TRXADEDTUEJIlhUJDc4SmW4ig5FtkRK0pOFSOcTYiDgglH/+mkrcZk7mNwsAiRMZqzud7xD5pt5mXHrWmoyj/aJwyOnzZBL64PHYC4vFH85HH0CH3da1+Pb5nRXIg9XQ==;7:1ORA1tZQc70eR7fCb401Ih+76ah22H8LhcAar5DI4zfKb5rb+Te5zKKLgrFFG9sthXsLxRngnJQr87r8hvMJY5hi568Ib1ofTJdBQjJ1ScQx1P5Zkm/NTempc43Z3P6UXdyoN/ZQms2aksmvW89lHA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: thisisant.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2019 20:58:01.6137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f963d281-53ee-4ae3-c2d4-08d67cbe780a
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.247];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5869
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I frequently use 'git add -p' to filter changes before committing. This usu=
ally works, but on many occasions, the use of add and commit results in uns=
taged chunks and files being committed.

Steps to reproduce:
1. Create unstaged changes
2. Use add -p to add some of those changes
3. Use git commit to commit the staged changes

Expectation: Only added chunks are committed.

Result:
1. When editing the commit message, the added files appear staged in the co=
mments at the end of the commit message, and the unstage files appear unsta=
ged. (expected behaviour)
2. All unstaged changes and files are committed.
3. Once git enters this state, even git add produces the same result: Using=
 git add to only add some files (and not chunks), and subsequently committi=
ng, results in unstaged files also being committed.
4. Even after restarting git bash, the behaviour persists.
5. The same behaviour occurs when adding and committing a file, while leavi=
ng other files unstaged, when using Git GUI instead of Git Bash=20

Environment:
Git version 2.12.2.windows.2
Windows 10 enterprise
Hooks: commit-msg, and pre-commit
Changes were being committed, reset, and rebased prior to this add -p attem=
pt

If more information is needed, please do not hesitate to contact me. Since =
this is a significant part of my workflow, the failure of the command to wo=
rk in the expected way is fairly disruptive to my workflow.

Any help or thoughts would be appreciated!

Kind Regards,
Beenish Khurshid, E.I.T I Applications Engineer
ANT Wireless=A0|=A0124 - 30 Bow Street Common, Cochrane, AB, Canada T4C 2N1
P: 587.493.4156 | F: 403.932.6521


=A0


