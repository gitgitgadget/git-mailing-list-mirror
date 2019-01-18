Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34C2B1F453
	for <e@80x24.org>; Fri, 18 Jan 2019 19:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbfARTDr (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 14:03:47 -0500
Received: from mail-eopbgr710118.outbound.protection.outlook.com ([40.107.71.118]:20544
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728832AbfARTDq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 14:03:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=garmin.onmicrosoft.com; s=selector1-thisisant-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKh2yTnwLX8IbbHl6RVXmCnZP6Mrh8Jo6d429Ltyp/0=;
 b=blUd1FDd2cky/frX/tu+OZN3TcTUlMT811gYfuVkvJGNrzD1/OfJvYgtegS8MzrA3eEeQjzPPOteo+ibRTHBpDoD7IZ1KGE4bwAd7MvocvbqQcMFqDy4hUEs6dbwFc8KtwmCsLGtuF8qNg7CDbWDJSjxuCOqU4Do0vDQBVV5690=
Received: from BN8PR04CA0027.namprd04.prod.outlook.com (2603:10b6:408:70::40)
 by DM6PR04MB4876.namprd04.prod.outlook.com (2603:10b6:5:18::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1516.15; Fri, 18 Jan
 2019 19:03:41 +0000
Received: from BL2FFO11FD019.protection.gbl (2a01:111:f400:7c09::130) by
 BN8PR04CA0027.outlook.office365.com (2603:10b6:408:70::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1537.25 via Frontend Transport; Fri, 18 Jan 2019 19:03:41 +0000
Authentication-Results: spf=pass (sender IP is 204.77.163.247)
 smtp.mailfrom=thisisant.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=thisisant.com;
Received-SPF: Pass (protection.outlook.com: domain of thisisant.com designates
 204.77.163.247 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.247; helo=edgetransport.garmin.com;
Received: from edgetransport.garmin.com (204.77.163.247) by
 BL2FFO11FD019.mail.protection.outlook.com (10.173.161.37) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id
 15.20.1471.13 via Frontend Transport; Fri, 18 Jan 2019 19:03:40 +0000
Received: from OLAWPA-EXMB3.ad.garmin.com (10.5.144.15) by
 edgetransport.garmin.com (192.168.18.220) with Microsoft SMTP Server (TLS) id
 14.3.435.0; Fri, 18 Jan 2019 13:03:29 -0600
Received: from OLAWPA-EXMB6.ad.garmin.com (10.5.144.22) by
 OLAWPA-EXMB3.ad.garmin.com (10.5.144.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1531.3; Fri, 18 Jan 2019 13:03:38 -0600
Received: from OLAWPA-EXMB6.ad.garmin.com ([fe80::8cd:fdb2:3e43:c926]) by
 OLAWPA-EXMB6.ad.garmin.com ([fe80::8cd:fdb2:3e43:c926%23]) with mapi id
 15.01.1531.003; Fri, 18 Jan 2019 13:03:38 -0600
From:   "Khurshid, Beenish" <Beenish.Khurshid@thisisant.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: git commits unstaged files
Thread-Topic: git commits unstaged files
Thread-Index: AdSuoTASOBd4JCYsShay0WD8Q+X48wAqkhwAAACusOA=
Date:   Fri, 18 Jan 2019 19:03:38 +0000
Message-ID: <738f3d692f534c21af34256f391744b4@thisisant.com>
References: <19f764a20b384e099372921d76ec4f73@thisisant.com>
 <nycvar.QRO.7.76.6.1901181129310.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1901181129310.41@tvgsbejvaqbjf.bet>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.4.6]
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1010-24374.001
X-TM-AS-Result: No-23.524100-8.000000-10
X-TMASE-MatchedRID: u6ojmU07PKynykMun0J1wpmug812qIbzju+GX08gELDgooJupf8xr+Ks
        WryGRxHgpEJ5RjVa0d2ph0FCvVDBgDUthFTU1rTGU+OjsPhIWDiUi9wB9gmcSjPolapMwp0I4Gr
        8z3tZHWOq/OdujkbarX3UwFifFlW7llejPjfyabWTeuX4xo2DEFHewY36PuY0EoivowdkUnWQZ9
        GOjckRaKpoI0gyGMJQJxLRRP/OC7RJJDuM6qazTp+EzsRrGT9IUAjrAJWsTe+yD8qnkE3ipGtUy
        gsbhDwBpH6too/u1ZX1zpfbcbo35pYeam+R4okHT7jCYv2QJPFK770EEUlgD+r8Vxzo0nj+p0oh
        ej8/GHEPUKo5SHYVtQ9UNvC1LzvWfMalxiFMN0qd4hCa7xSZoZKLNrbpy/A04q/WXXiA5Hz+ntQ
        pGCC4H6Fy2pk8L/CJfo01VKqUOep679yN6FAQE750lYduDghOf7rvXBvEkWnncv7Q4CrHt/OQxn
        Kt0aTBTKtW0t+i2WFwdzjTbOLWB1el52NZO9XW5DSMPEZQAkNfQn02HI7v0HjwkzrYHfhDO4S34
        Oyd6Ph1WfAcq+YFqz+JNJN7OkFN9DC8qKFrlfGTEgTE0DYkgFo72tn3603tz8YyDF83wfnvUguL
        6+DAURGeuQoYrj88kZOl7WKIImrS77Co4bNJXVZ0V5tYhzdWxEHRux+uk8gVPU8Gz4xVjecjNHN
        ZLY/T
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--23.524100-8.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1010-24374.001
x-tm-snts-smtp: 6A4B0161373E7719F2D78898300285E9802E365219C5D27364B0A83BEAD7D5B82
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:204.77.163.247;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(39860400002)(346002)(2980300002)(189003)(199004)(13464003)(72206003)(966005)(336012)(106466001)(26005)(186003)(6306002)(126002)(476003)(6916009)(4326008)(36756003)(305945005)(7736002)(229853002)(446003)(436003)(2616005)(47776003)(11346002)(68736007)(486006)(53936002)(356004)(81156014)(108616005)(6116002)(3480700005)(5660300001)(6246003)(50466002)(14444005)(5024004)(102836004)(8936002)(8676002)(53546011)(24736004)(2906002)(76176011)(23676004)(2486003)(14454004)(69596002)(86362001)(81166006)(106002)(3846002)(97736004)(316002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR04MB4876;H:edgetransport.garmin.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD019;1:Wg/5Qn9fwHDq0tv44jWMKQeG4RQ88E/Ni20LPK/43k6WXtVZMRS6GKOMBdNpDVBKULb3jy2qFYKQ5lZ69OqqyNWIJErx8ZXDqTE4vlWsauyegeZJnfac8JZ1cLkRuF2N
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80990ced-2552-45c8-b4ee-08d67d77a921
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060)(7193020);SRVR:DM6PR04MB4876;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR04MB4876;3:IAuVJSoi5pQKnH3vzWYk78JsaNDlEG0AHuMbchjAa0L/2i/9QS1VDdgkGbH2ZhB8dHACkvKzQ7VuUqUrqhAZwCTBzLuPVTKrOuMZdGO8EPsd6w2TXhulSQ2w30G4IjMKUb55WdtGGDXdx+DjV295NsHqfoUi10Cevjj3bDSf4pDVYYLLcVTcUcS71CNsODZUYviIQ+clnuivXtpaz2ZocnX/6QIUa70tn1Y2TdswGJ+8T1LDmODguLsC2kMEYRjS/UR451OZ0zbtlyg6D2eHOYz9/CAxMCCqL9bUIPuMXNqfh1l4elvCydEWFIsG74E7mn8E3vKiO7NYqi64la+AbAKvfRbc5jDznXHpYq7TFvyPl1cymk3EKWNz5hDyrUaY;25:bwnn9AgFJ+V4Rh3EWGorxQnWp14vIv2D2YoHAc0Zn6cvPNMUubY+1ghgNQh86az+Gjf1xkdrc6gEWO5SsTtuTkSA4UwtELSGuwEoXmhO41nv9xnDUx3UwKP7H5mfAOqdg9hj/NNeLm4q4SdVwLqc5P+hx29zt3xgIItejgLW3eCkUpvBK0O7BIALT0dCYwbERpgqSlepnhX7cyQT1i+hCpOaFzON6bBZaI7kM2yaIrY50aZDYDyZm2hfmOPWb+sX5RRexfAPEd7pOjeSOZXNlb/ZVf7EUnUshE0xx3p4TYeNW1J4iuAlnTJWRjj/DleSAsYA3yDboGWEDK3tj9h7BQ==
X-MS-TrafficTypeDiagnostic: DM6PR04MB4876:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR04MB4876;31:xU8HJ7Tee8lvLht4MBCs6MyvgtUsNyS5UfV/jX9IENULJT+6zNIGriHQ6NtC7i7ypFUKEMcIGJbqZh6v6nnZrfQnl64ol0qNmT4z+/Z0NaEIkp7d5kg6fQmJGbLr6Uh7Te2WXepTLwjf+qRlKvYfoZAs+jlkf5WfsiOjq9Cgqeo0YgqFhA62yfkfbkfYqg4SGfv7/QB4JVmsn073+AqvEs9Qz/s7uhlpmG2CligkYQc=;20:z4LgebpQj7Ai/9UJFjnYyO1XBSGk1vLQEZo4pfaExteeBGlZLcYERWLh4s/m3D/e/duzYx3UTSsbre8I3lITrCJSGz0iUDqDbiltf9VCAEjUa7/2YU6le3vgXx5gtLcaNPCHHv67F5UQ6eYLHEdIUsHBjd9XijFbfwdMwZVwSjX5nqeNMRQWKLrYgJI1oxswSUEIPQDF+kaSdaBD7CaLefZYA0liIixwFDxuEYzGhOAWmphx7sC0hoQAvv5ZPOuM8dr4AuCkunskmahcg1ljyf2z0jrn+zl8ErdqjvsUsa3jxTJ9s4JjaCn9WekPVzp0us4WuiiKnMER1Gb7qOBX0Tc6MG0zUly07rkroeZRheVnjPk5UjKT+5/TOBL+PYHlSojeN/qXuiUjaFhb1hvvDl3/huMZabLhpKe2DNQ1BrxImUaO2xK6DtVBczwup4AEVPZCtny8uzQSfALERVNNr3s++rlDPTq0+GYMIC3kw4TESngPpCPJKXZH3VZlpCko
X-Microsoft-Antispam-PRVS: <DM6PR04MB4876B3E46E5BBC5781A0AA76909C0@DM6PR04MB4876.namprd04.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;DM6PR04MB4876;4:8vb3ZEFojQT6i96zxAiOp7gUhA0x8X+VKQxPZqvBs/1JIqm2toSpTte/yKhLipJZqV80Cq5tT6wTn+3Knq92xaYzrMFDVDWziFt9VOzKa2O8vHzpER/HQqa3puf4jUJnGf/2CCSm2m+k8HF6eahF2UNsaezeHLFXnFrTynM7lTZZVddwOmlYfr4D3WrbX/9Jy8YscaigwxacJN8ZWUL+EGE56yk15w+Ci82UVCw/+9FbULXWriyxl8Maau23NWum1/Q0GzktvGvraBemeTfR2gQHkIYZJH1eP1JbROPgu/s=
X-Forefront-PRVS: 0921D55E4F
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjA0TUI0ODc2OzIzOjRlME1tbWNFSWJPMmNxZnRsV1g5WEtLMFdn?=
 =?utf-8?B?aVEvcW81Y01Wb3ZqcDYzZlpxZms0cEZoUE9VTW02dlB1NHVmeWloVDM5dUxN?=
 =?utf-8?B?VG9hbWNVN1Urek0vekFBNWNiK0ViOGtSTGw1MjNNZGM4YW13TGp1czBuZlBN?=
 =?utf-8?B?eEh1TncxY3VTMnZRdE93T3RnNUsrdmFza0ZHbGN5eGlkWE9PcG1XMW9iRUNa?=
 =?utf-8?B?ZDZXbk9HZXJkdEtia3pnMWt6aEYzTzJlcDlkeXVCMklLK1JuQ2dYRVk1b3J0?=
 =?utf-8?B?c2I0czVnOFF3M3Z4NDBXaWxMSnlray9qT0pvSjZ2M1VZR29hTlBmQkZUUHNJ?=
 =?utf-8?B?a0hLSGFGcXJ4bGtFK25pSmZDTUJUYU5wNE45YWVmN1BZMUZSL3YrUzlMTnkr?=
 =?utf-8?B?ei9ZcmZMUnVjRE83VjBlWFBNWEMzNWZ5dTFyZktHaHJ1UllPQnMrdzdRVFM4?=
 =?utf-8?B?ZDZHc2NrQUw2SDFndXNNKzk4M3ZVWDNCVmw3NFNwWXFuZUhSdm16R2JMa2sx?=
 =?utf-8?B?VmEyenlSdEppL252MWxyRFpnbXJ5TmJJTjM5Qy9pc0NnUndkSXkyNnRjb3Na?=
 =?utf-8?B?bndUSUNVTVlDZkw4Skg5WVRaenljY0Nsc1BVTlgrZzc5d0xvVDBiZXpucUVH?=
 =?utf-8?B?T3YvbHY3MlhhZGt6ZjZpckkyN2ViSVFjMTNYVHNncCtNK3lXT3B3bmFKeUNH?=
 =?utf-8?B?WHEvcTZIZ3d2L3JJWE80WHpRbXlLR0RRMUlrQW4yNkFTdW1GcEQrTHJJVGYr?=
 =?utf-8?B?Mk1FNkF4a3dMb3ZsT01nRVJqV056TU1xeWZweW4vdzZMQlhJY2tYUUxBelVF?=
 =?utf-8?B?QlRIbm5nNGdQb1IwTHFRWStzYlhhUlg4RmRIRXp2aEQvTlZxc0lGYlNsMmNZ?=
 =?utf-8?B?OFIyaVFSVDlIRS9zeGRuVFg3TzVMeTdXY1ZPT1RCcHZwTjA0UmpTWlFQMW1y?=
 =?utf-8?B?K0cwSFJ4Z3RkMFFVbFk2bGxOTG1XTTBZM2ZRRDhOMVB3dnFUQlZNaEY1L1Nn?=
 =?utf-8?B?TUZvaXVEaHNvb3FReFpScW5OMWJTV2VBTVBLSisvdXBHak1tTTUwWUxCVTRk?=
 =?utf-8?B?VW5DUVpBc1dXaWFXcmJjNjNkbjVST1NkN3JvNjRRL3hMT3lQeGg5bTVOWHpJ?=
 =?utf-8?B?MFJVYlh2MmlkL29USVU1ZUhQN3FRb2lzaThNeDNzcjVBenBxQ3IyNE5MeVlF?=
 =?utf-8?B?VUIwLyszRmhwMEk4QzBDYTVHdDV0M0dtWnh2VUxQaFdpb0JDeTdqNmtiY1BT?=
 =?utf-8?B?QzhqMXl1L09JSU5JcnduUERIbW1NbXlTMSsrcEQ5UlRnVlM5VCtUcWFLdDEx?=
 =?utf-8?B?TkE1bVl4OEhMRkJ5a1BIOWRVbkVQV0FQWVJrOWtYT215b3lEQTNUaTQveS9T?=
 =?utf-8?B?V2p3Z0VWZHlYMFl6aVFpTiswYkhyT2pIRVlPZzVrRENMeG55U3ByRmZwdyt5?=
 =?utf-8?B?dGlvVkNKZXJ4OWRvcnFNOWc1RHdpYVBsdlU0MS9RMEp1NHdkNG54YlVyQi9Q?=
 =?utf-8?B?VmJhNlRJOEVadGxZcDZwUzRRY0drN25xZFdhSEtEMHNkUDUvZEM2OEhkVEdZ?=
 =?utf-8?B?R1JDd3hZNW5IMTg5bWZldSs4allGYVBRbjJyOWQ1eUFwUXlqWVZwRzNwMTdW?=
 =?utf-8?B?RE5RcDV6b1FBbjhaVVA4WHlFR3FxSE9ZTnlJTVRrWnBYSWtzbE5UT2htYjIy?=
 =?utf-8?B?aS81MzRzYkhadEVXdDFpNFg0RWtJSFJ1TGhWM3FPQ04ycERkTUQzaUZRVWVu?=
 =?utf-8?Q?D8RdVCHJwmyLHcPDsA9FEiXbbR8zrPPuYAow8=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Nlcszp1d2I8vpHvcvIlJV3ZCStO+WKgtAHtIgr37lzUD8PrSUDQmGvSPR+6qFqeA1cr0ieiRunozB4WDTzexoDxlE8SiWtmUTltrBq9lBVNm2a+bwaS6OXeY7u9u8cfGCu+OazILqi2Bfk7O4i8rfi2WA2seCptfv13PGaJoY6K0AZEcLV/dfahnATd+F/5BqHcx7GPIVEYbl+t3At3nXbN9RSagVq6ytrITtmbP1QWJcH82oLCBKP2a1bAnnNPNA4dzELtJPBz/Mbxb2jc8eZDccqqLsKWC9O5RzUYFF/MqZELgWO+lgRNn2SiKZTVo5OA/7eDUyKyhCPR9kw6ZUS0Ciu+5c614f5jLQHJr1ofGP1a3ZGPd/7r/pkP0m2NrpmqCTu69+ZwRsfo3vkvFNsb7vAGnrvBTWp/ojfpa42U=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR04MB4876;6:9KB31RU+ft043HeDTKdlvBkgpL5PIhILSgR1wlSmO2mlYBRJcC7rc3BCBFcmb5Njlh+/2K9g1JYLGZTS4I1PSYb5+zlh8IY+SSvJEHz1HewNSUVXC/Z2UB9/M50VfnwKwnLLjs62aXdJa9CLz/7BbYi+Q0pDtpje+NlpGc2cgcXkRYm7mMRu/jztHULY80rlPxvyqYTBrfXlhtZxVfZ3d2HW/cFq3MP9IjnGDj3n2Wq0ykemIbgixxufGBuyOs9teSX1phsatnMNStLtMXUHVulr3E53gsgk6t/H3zdNFu1808AIrFmovUJMluOyvgm+6f9pGniteKyurVCwgUFQgSY2xfxb0HyvqXL4EU7zPJoc9BpS8v65RJWWCXBq/n7VzYkvKukU0Trz/CJ6R/l0u4apKOnrDXd+XkV4PzGISLj2gq/KHPikxwnIwa7cRvkDK8RGqVX/hbYQ03PaWi9Fgg==;5:uO1tZE9TrdfTx8OyL9qQflz4EQo7uAW0xRtdIMmsa5lfP41OFflkhkzlQWsDsHB4hASic6ozo3cBwz/AHvxt5ofFBoIsvO8ZNLXGLXdO0bSQCWy5qk79nWl7vznnv31qqNfq2A7DN6lUy42C9fsH+pM4vWkp5wKnWe9naz4Ko5QRBCPcbeEnB/2K+FoXFDSkmizDEE4RukhUQzKIrbHl7w==;7:nNbwdmHjT0jAo/BUUhLHBC2+UCJsDDl9dV7HPJMRbwUSW0RQWnLYot7/Q902aCl7AQIc/Fb0PtYLEdt6mFiUNnIH62CTWv1bl1leQi+Aw6KbDRO4YIgsh7JXFkWE4Vxnk0WRmqZwjm7wwWbkMDMcmw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: thisisant.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2019 19:03:40.8673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80990ced-2552-45c8-b4ee-08d67d77a921
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.247];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4876
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGkgSm9oYW5uZXMsDQoNClRoYW5rcyBzbyBtdWNoIGZvciB5b3VyIHJlc3BvbnNlIQ0KDQpBcyBJ
IHdlbnQgZG93biB0aGUgcGF0aCBvZiB0cnlpbmcgdG8gcHJvdmUgdGhlIHByb2JsZW0gdmlhIGFu
IE1DVkUsIGFuZCBmb3VuZCB0aGF0IHRoZSBwcm9ibGVtIHdhcyBub3QgcmVwcm9kdWNpbmcgYXMg
SSB3YXMgZXhwZWN0aW5nLCBJIGZvdW5kIG91dCB0aGF0IG9uZSBvZiB0aGUgcHJlLWNvbW1pdCBo
b29rcyBoYWQgYSBidWcgZm9yIGEgY29ybmVyIGNhc2UgdGhhdCBJIHJlZ3VsYXJseSB0cmF2ZXJz
ZSwgYW5kIHRoYXQgdGhlIGJ1ZyBoYWQgYmVlbiBmaXhlZCBpbiBhbiB1cGRhdGVkIHZlcnNpb24g
b2YgdGhlIGhvb2suDQoNCkFwcHJlY2lhdGUgeW91ciBndWlkYW5jZSwgYW5kIG15IHNpbmNlcmUg
YXBvbG9naWVzIGZvciB3YXN0aW5nIHlvdXIgdGltZSBvbiB0aGlzIGlzc3VlIQ0KDQpTaW5jZXJl
IHJlc3BlY3QgZm9yIGFsbCB0aGUgd29yayB5b3UgZG8gZm9yIEdpdCBmb3IgV2luZG93cywgYW5k
IHRodXMgc29mdHdhcmUgZGV2cyB0aGUgd29ybGQgb3Zlci4NCg0KS2luZCBSZWdhcmRzLA0KQmVl
bmlzaA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogSm9oYW5uZXMgU2NoaW5k
ZWxpbiA8Sm9oYW5uZXMuU2NoaW5kZWxpbkBnbXguZGU+DQpTZW50OiBKYW51YXJ5IDE4LCAyMDE5
IDM6MzMgQU0NClRvOiBLaHVyc2hpZCwgQmVlbmlzaCA8QmVlbmlzaC5LaHVyc2hpZEB0aGlzaXNh
bnQuY29tPg0KQ2M6IGdpdEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBnaXQgY29tbWl0
cyB1bnN0YWdlZCBmaWxlcw0KDQpIaSBCZWVuaXNoLA0KDQpPbiBUaHUsIDE3IEphbiAyMDE5LCBL
aHVyc2hpZCwgQmVlbmlzaCB3cm90ZToNCg0KPiBJIGZyZXF1ZW50bHkgdXNlICdnaXQgYWRkIC1w
JyB0byBmaWx0ZXIgY2hhbmdlcyBiZWZvcmUgY29tbWl0dGluZy4NCj4gVGhpcyB1c3VhbGx5IHdv
cmtzLCBidXQgb24gbWFueSBvY2Nhc2lvbnMsIHRoZSB1c2Ugb2YgYWRkIGFuZCBjb21taXQNCj4g
cmVzdWx0cyBpbiB1bnN0YWdlZCBjaHVua3MgYW5kIGZpbGVzIGJlaW5nIGNvbW1pdHRlZC4NCj4N
Cj4gU3RlcHMgdG8gcmVwcm9kdWNlOg0KPiAxLiBDcmVhdGUgdW5zdGFnZWQgY2hhbmdlcw0KPiAy
LiBVc2UgYWRkIC1wIHRvIGFkZCBzb21lIG9mIHRob3NlIGNoYW5nZXMgMy4gVXNlIGdpdCBjb21t
aXQgdG8gY29tbWl0DQo+IHRoZSBzdGFnZWQgY2hhbmdlcw0KPg0KPiBFeHBlY3RhdGlvbjogT25s
eSBhZGRlZCBjaHVua3MgYXJlIGNvbW1pdHRlZC4NCj4NCj4gUmVzdWx0Og0KPiAxLiBXaGVuIGVk
aXRpbmcgdGhlIGNvbW1pdCBtZXNzYWdlLCB0aGUgYWRkZWQgZmlsZXMgYXBwZWFyIHN0YWdlZCBp
bg0KPiB0aGUgY29tbWVudHMgYXQgdGhlIGVuZCBvZiB0aGUgY29tbWl0IG1lc3NhZ2UsIGFuZCB0
aGUgdW5zdGFnZSBmaWxlcyBhcHBlYXIgdW5zdGFnZWQuIChleHBlY3RlZCBiZWhhdmlvdXIpIDIu
IEFsbCB1bnN0YWdlZCBjaGFuZ2VzIGFuZCBmaWxlcyBhcmUgY29tbWl0dGVkLg0KPiAzLiBPbmNl
IGdpdCBlbnRlcnMgdGhpcyBzdGF0ZSwgZXZlbiBnaXQgYWRkIHByb2R1Y2VzIHRoZSBzYW1lIHJl
c3VsdDogVXNpbmcgZ2l0IGFkZCB0byBvbmx5IGFkZCBzb21lIGZpbGVzIChhbmQgbm90IGNodW5r
cyksIGFuZCBzdWJzZXF1ZW50bHkgY29tbWl0dGluZywgcmVzdWx0cyBpbiB1bnN0YWdlZCBmaWxl
cyBhbHNvIGJlaW5nIGNvbW1pdHRlZC4NCj4gNC4gRXZlbiBhZnRlciByZXN0YXJ0aW5nIGdpdCBi
YXNoLCB0aGUgYmVoYXZpb3VyIHBlcnNpc3RzLg0KPiA1LiBUaGUgc2FtZSBiZWhhdmlvdXIgb2Nj
dXJzIHdoZW4gYWRkaW5nIGFuZCBjb21taXR0aW5nIGEgZmlsZSwgd2hpbGUNCj4gbGVhdmluZyBv
dGhlciBmaWxlcyB1bnN0YWdlZCwgd2hlbiB1c2luZyBHaXQgR1VJIGluc3RlYWQgb2YgR2l0IEJh
c2gNCj4NCj4gRW52aXJvbm1lbnQ6DQo+IEdpdCB2ZXJzaW9uIDIuMTIuMi53aW5kb3dzLjINCg0K
VGhhdCdzIGFsbW9zdCB0d28geWVhcnMgb2xkLiBXZSdyZSBhdCB2Mi4yMC4xLndpbmRvd3MuMSBu
b3cuDQoNCj4gV2luZG93cyAxMCBlbnRlcnByaXNlDQo+IEhvb2tzOiBjb21taXQtbXNnLCBhbmQg
cHJlLWNvbW1pdA0KPiBDaGFuZ2VzIHdlcmUgYmVpbmcgY29tbWl0dGVkLCByZXNldCwgYW5kIHJl
YmFzZWQgcHJpb3IgdG8gdGhpcyBhZGQgLXANCj4gYXR0ZW1wdA0KDQpJIGNhbm5vdCByZXByb2R1
Y2UuDQoNCkZXSVcgSSBzb21ldGltZXMgaGF2ZSB0aGUgc2FtZSBwcm9ibGVtLCBidXQgaW4gYWxs
IHRob3NlIGNhc2VzIHRoZSBwcm9ibGVtIGlzIG15IG11c2NsZSBtZW1vcnkgdGhhdCBtYWtlcyBt
ZSBhZGQgdGhlIGAtYWAgb3B0aW9uIHRvIGBnaXQgY29tbWl0YCBiZWZvcmUgSSBjYW4gc3RvcCBt
eXNlbGYuDQoNCj4gSWYgbW9yZSBpbmZvcm1hdGlvbiBpcyBuZWVkZWQsIHBsZWFzZSBkbyBub3Qg
aGVzaXRhdGUgdG8gY29udGFjdCBtZS4NCj4gU2luY2UgdGhpcyBpcyBhIHNpZ25pZmljYW50IHBh
cnQgb2YgbXkgd29ya2Zsb3csIHRoZSBmYWlsdXJlIG9mIHRoZQ0KPiBjb21tYW5kIHRvIHdvcmsg
aW4gdGhlIGV4cGVjdGVkIHdheSBpcyBmYWlybHkgZGlzcnVwdGl2ZSB0byBteSB3b3JrZmxvdy4N
Cg0KWW91IGNvdWxkIGludmVzdGlnYXRlIGZ1cnRoZXIgYnkgc2V0dGluZyBHSVRfVFJBQ0U9MSB0
byBzZWUgd2hldGhlciBhbnkgb3RoZXIgR2l0IGNvbW1hbmQgaXMgcnVuIGZyb20geW91ciBob29r
cy4NCg0KSW4gYW55IGNhc2UsIGlmIHlvdSBkZXNpcmUgaGVscCwgdGhlIGJlc3Qgd2F5IGZvcndh
cmQgd291bGQgYmUgdG8gZ2VuZXJhdGUgYSBNaW5pbWFsLCBDb21wbGV0ZSAmIFZlcmlmaWFibGUg
RXhhbXBsZSAoTUNWRSwNCmh0dHBzOi8vc3RhY2tvdmVyZmxvdy5jb20vaGVscC9tY3ZlKSB0aGF0
IGluIHBhcnRpY3VsYXIgZG9lcyBub3QgcmVxdWlyZSB5b3VyIHBhcnRpY3VsYXIgc2V0dXAgc3Vj
aCBhcyBob29rcywgc3BlY2lmaWMgR2l0IHZlcnNpb24sIGV0Yy4NCg0KQ2lhbywNCkpvaGFubmVz
DQoNCj4NCj4gQW55IGhlbHAgb3IgdGhvdWdodHMgd291bGQgYmUgYXBwcmVjaWF0ZWQhDQo+DQo+
IEtpbmQgUmVnYXJkcywNCj4gQmVlbmlzaCBLaHVyc2hpZCwgRS5JLlQgSSBBcHBsaWNhdGlvbnMg
RW5naW5lZXIgQU5UIFdpcmVsZXNzIHwgMTI0IC0NCj4gMzAgQm93IFN0cmVldCBDb21tb24sIENv
Y2hyYW5lLCBBQiwgQ2FuYWRhIFQ0QyAyTjENCj4gUDogNTg3LjQ5My40MTU2IHwgRjogNDAzLjkz
Mi42NTIxDQo+DQo+DQo+DQo+DQo+DQo+DQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fDQoNCkNPTkZJREVOVElBTElUWSBOT1RJQ0U6IFRoaXMgZW1haWwgYW5kIGFueSBhdHRhY2ht
ZW50cyBhcmUgZm9yIHRoZSBzb2xlIHVzZSBvZiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMpIGFu
ZCBjb250YWluIGluZm9ybWF0aW9uIHRoYXQgbWF5IGJlIEdhcm1pbiBjb25maWRlbnRpYWwgYW5k
L29yIEdhcm1pbiBsZWdhbGx5IHByaXZpbGVnZWQuIElmIHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMg
ZW1haWwgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBieSByZXBseSBlbWFpbCBh
bmQgZGVsZXRlIHRoZSBtZXNzYWdlLiBBbnkgZGlzY2xvc3VyZSwgY29weWluZywgZGlzdHJpYnV0
aW9uIG9yIHVzZSBvZiB0aGlzIGNvbW11bmljYXRpb24gKGluY2x1ZGluZyBhdHRhY2htZW50cykg
Ynkgc29tZW9uZSBvdGhlciB0aGFuIHRoZSBpbnRlbmRlZCByZWNpcGllbnQgaXMgcHJvaGliaXRl
ZC4gVGhhbmsgeW91Lg0K
