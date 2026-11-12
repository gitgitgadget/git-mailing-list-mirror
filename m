Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794497952;
	b=bkdQXOcCF1uiIpcvB+6ZanRqxToWnFfE5Qf7iS3OIo3+4t3PbGcPaSbTzt2ZA3JQ6Egq
	 vCRs6AH9iCBCRU/3oIGPRbKTPKuuc+Uw8jfxH1m3cOzqhUReG5jS/03iArhiG5BGG9/4t
	 qC7oTeIdf/c3V10y1FzHk9Nhbfy5KbmOQTtH8ZQsDdSfAAXtgA44oNrzGpKtqXloAnkQl
	 y8ZS3LkLlMq+IbkBVNNETFUI8Xv+HrZHXZtNJnnQRR0Uu9v/5Uqizg62OQU0bcy+UBbSA
	 dsHaI460i40ypxBgJ1N/Emab9XnvG+kdh4dUxNHfFuLtGblprZmBccVkFrZCAp15yCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794497952;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:From:To:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID;
	bh=wpKDgER2jbwqrBjg0KDt8VNfoqHV2FpFMbJbtPAuurA=;
	b=0PM7qXMaHl1UqJJqx5vKZTLZ7p5Km0YBmjrOYAhImu0xOZYHGTJ1bVRqPKpznclSmVmw
	 +PTjNSIUYktwV23Wcr0A7D3gl+dni2evNwa0NPqKacOpOfgtMEKBkoNmbUAgPzkJ8BVai
	 D5qHvdGHIR94kgdQ2i4s+aaiDkad2loaCTkoiiMpx+CALzI7yjTtuJl5rbstHQ15T2rxU
	 O+RWu9A+MV3gqkjLgL8BklkoqXx7P8+nwgMfvwY2/PzKcZ02qFOSur5X7V3BEp6MSA0An
	 IFM4p6KukegeNdvpO+qV4rGy13YGFkxqrXiAUuv2CcBRjTGYnl0JtFsDdruwigolDnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b="S/2aKPYf";
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=qhdDf8bN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C26B606A883
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 15:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C26B606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=S/2aKPYf;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=qhdDf8bN
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACEO83T3443057
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 15:39:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=wpKDgER2jbwqrBjg
	0KDt8VNfoqHV2FpFMbJbtPAuurA=; b=S/2aKPYfbz39RH3NSqaZskQjg7JoC+A8
	epSKWrJBtRZKf04B1v4w2fA4RAOZWShq0LSuVmUfo+QnLiZQPkf75wJ0FG7N93v0
	UAJj4anQwkyB1ZFDDfWw0jMTwmhzduxZcjGdE4eHPNKw9hdbFIPxB+im4EkB+Ke2
	Xw21lHXcfmBB3yxyQJhlNCyfItrqox6yRMjWpsnwymiqMwbnXblQOdEJP/QoSgys
	rpGCCLf9VOIfbJn7Vheq9ZNgntSrUNYImzyTjifqA7QAiU8Hmelatv4vrTJ51wm5
	xpkJeUhWA4z2YSLFYeOu5OC1mQd9cUbhzoOp/WCFRXNZbVm7WFxSvQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hsvhs7sgr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 15:39:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACFbvc63774694
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 15:39:04 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012003.outbound.protection.outlook.com [52.101.48.3])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4hwew4v3j3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL)
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 15:39:04 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+xDnOg7+sm1KuJUJEs4DqJtpIbmOWSOO0tMYyQUkygcaMzImKzXX8TrvDRE37Q7S1AZuc5yzHgG8MFqs+ZfpBatYwTuGXnU+HprdQiWpqm5XZmaGTdgsTx40jPi5URG+Z9R/8CFoZqfXn4KpjL0BXq4cpG8i7rDRcaBCuq9qrSC008m//RWcGgiGcE0Ksdv+PS5j1YYh/9eHrmHtNHYa44O1L8CUyuCFM8LZWD7N+lmJqFjI7z6O7ZQJGUfXZwSLgYLzTE0TAesUsvv1Zj4diSEuo8/reINYIovlPi+TBkJHXYUuYSaO5eIKIp2MTi5q1IbNGjE15FzzL+I8lfC+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpKDgER2jbwqrBjg0KDt8VNfoqHV2FpFMbJbtPAuurA=;
 b=PbbjfNqK934/fhZHTQDxI3+Y3FoVe9emwq4aQCI7g0XyuvwwWPr3sJqutZJrwJ/uck3xVpnSK+aDehMfTBR7LUg9QQiqqeNQaUrUbKc88i9TTZtHYQ7ep3EwC/f7PO6oY6uXF1Ck2+wBM54i+i/4JzoT198ekiuIyPlpWKJ/mejoIZ8uxxSw+a0mRqjGArJY1GhpVJCJYaLUiW+6etD7miRlE3Rl3NhKG7BXh64BpmZbM3DXg2VJvX5SGDv/o2APhCTyHB4gB19MxtdsyVl/u9Rc5+T/YApSMOceEdDiFSo/gbFcKTys0NHv6jERAL4i98zGjtPZg3PG6XHUZEOUZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpKDgER2jbwqrBjg0KDt8VNfoqHV2FpFMbJbtPAuurA=;
 b=qhdDf8bNXsLhrXZPbuzbdGhTbD0xF4yvlSDfrjKEWkm+/1gcpYUOsugi8J5btxb38ruAvxBYJE9Z1XeQumbWY+fQPpRZToMeDy24UEu+fFE5wRX2csAN8bV0d9HOrfAlIqmawhNJDqbnM1XxpUFAHpqGkkmGUB9eZMM9AtbrFU4=
Received: from SJ0PR10MB5785.namprd10.prod.outlook.com (2603:10b6:a03:3d1::7)
 by IA1PR10MB7448.namprd10.prod.outlook.com (2603:10b6:208:44d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 15:39:02 +0000
Received: from SJ0PR10MB5785.namprd10.prod.outlook.com
 ([fe80::75ac:f00f:4fe:d1de]) by SJ0PR10MB5785.namprd10.prod.outlook.com
 ([fe80::75ac:f00f:4fe:d1de%3]) with mapi id 15.21.0592.010; Thu, 12 Nov 2026
 15:39:01 +0000
From: Jakub Kulik <jakub.kulik@oracle.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: several unquoted shell variables causing test failures on Solaris
Thread-Topic: several unquoted shell variables causing test failures on
 Solaris
Thread-Index: AQHdcrvOK7e/aL2R+E6OdsSDSqphfA==
Date: Thu, 12 Nov 2026 15:39:01 +0000
Message-ID:
 <SJ0PR10MB5785807828F81EAC8CA165E78A702@SJ0PR10MB5785.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_3c76ce46-357f-46de-88d6-77b9bbb83c46_Enabled=True;MSIP_Label_3c76ce46-357f-46de-88d6-77b9bbb83c46_SiteId=4e2c6054-71cb-48f1-bd6c-3a9705aca71b;MSIP_Label_3c76ce46-357f-46de-88d6-77b9bbb83c46_SetDate=2026-11-12T15:39:01.544Z;MSIP_Label_3c76ce46-357f-46de-88d6-77b9bbb83c46_Name=Public;MSIP_Label_3c76ce46-357f-46de-88d6-77b9bbb83c46_ContentBits=1;MSIP_Label_3c76ce46-357f-46de-88d6-77b9bbb83c46_Method=Privileged;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB5785:EE_|IA1PR10MB7448:EE_
x-ms-office365-filtering-correlation-id: fbb34c09-473e-464e-aa3d-08df40d31377
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|38070700021|10067099003|56012099006|261021135927099003|261022113327099003|261022105027099003|261022075727099003|261022115727099003|261028144727099003|261026135527099003|261026121527099003|261026130827099003|261026140227099003|261021133027099003|261021121427099003|261021123027099003|261021130227099003|261102123227099003|261009223027099003|18002099003;
x-microsoft-antispam-message-info:
 a+dUjI7Y3605IUe0qPd8UswWIh9xWHKtt30YWshyJRDcql8BsmDPV2RaCTNX9/oZVXzaJOdOaBLNO+sdeKF8EOXwVuOSEXWqsGbWkjL+tItjWCKte374qdEe38tFjyxuyx2M2NL08d7MYtVmzsWpedHbmhNtOL89YVFXFzqJKvMaOeh+PxhxdMaHCwc0oXuI8705gF+DIQhaDBnLB7sqiUzOLZSu3P8yPFVZIBjP+DMBjDli/Kx2ouulzTx2DL1Fiag/LMQ25QVr99MghvxzP4Fs7tLAKX3Wl7SYudL/azoMrL7Z5hsrhpn2qMWJNUj7diqMtVzAYxYLMi616bFZx1QqLy5XeyJ+U7sDdvCeYEGrNljTucpIaf7I9kCYnUFLroxD8HDM3tKxrgd0Zugyyje+c5+UtM7DuU5DLXGIjkqAdg5y8HVUxo1i0sX0rjBWHDRJi5zUVCeJJeoEMeQjFnO75RazENGrbhrrDoBhkMuVnORH+nx6PrQp1yZRxj3jwL2VymLMpcQCTzXVPuPoVg66vz+XoahoefGtPPlJA/NnZz0sRUxcI3/+yX+983JOFSsT3fzZ/hGBJfQG3d5KgWCIeDJmAY/F1lrN9msUXv6ChubJMKZtpzHF3Zt8G+/5ztGSJ8hZi7OAj/Gn30cGSmnTvU8WcZwvALbEHf6fZ8PsH20renMdaTsf1NLHY3WGNs0NCRa7aH3dzKVxXjE0FIdF2f7WUvl+T1tMBj9Lepg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5785.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(10067099003)(56012099006)(261021135927099003)(261022113327099003)(261022105027099003)(261022075727099003)(261022115727099003)(261028144727099003)(261026135527099003)(261026121527099003)(261026130827099003)(261026140227099003)(261021133027099003)(261021121427099003)(261021123027099003)(261021130227099003)(261102123227099003)(261009223027099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Gfnta28UIlm2d5Xj9bNs8Txh3ApuUza0ijTLJBx7H34SLyyx6jNgEw1w5h?=
 =?iso-8859-1?Q?ENXyJgFAdq2oUGAsRi6jDgp83xOZcHzLVwL4eqh0sQBNf8GikPI8dNr/AK?=
 =?iso-8859-1?Q?sNUFBBb2gCWd4R3/OnrzXX8/8SvuO3EelSEs7lmjBJ0VgQE3pGXnvYMuAJ?=
 =?iso-8859-1?Q?geGQ8IrCSBSsV3AMAwCOkHk1F1crI9tnlI5xk5pHvumiwpb1AmEZl1EJIL?=
 =?iso-8859-1?Q?Rhz1BfkT8mttRlT7mwTkWqgyepc/Et3wy/3/4H9mdp5uhHwVYDSKfs4bFO?=
 =?iso-8859-1?Q?f4GUwUQ4UCA1GEszPMNwgmiYx4+U/l4MItRT2D7HILImtzwvOwFLwd+M2L?=
 =?iso-8859-1?Q?HupQjaipMPAnFbD8fgl2miK7LCGAS0CwQAV76WWdNDTVKw4xc5sqp+/BXA?=
 =?iso-8859-1?Q?pVmvwTqILoL6lXH188uXZPnGI65wsUCwfy7g83UI7vUajBQeQsw+zUdjAR?=
 =?iso-8859-1?Q?/xQKalnOwriDdiohPzexN+83QTzppL9ujqXV2UEYJKfl/knJsi/8DjegNA?=
 =?iso-8859-1?Q?t3/4KEURKbyB09xeXzxJRknQUcCt1mLhHHv+ragr5EhaH7gESs9Wrz3/xb?=
 =?iso-8859-1?Q?RFqLJoCbf9kZ6wlMa2EFjNuqmHzy+yZxp4e+PfcAczqeYkkciN4vDAgooi?=
 =?iso-8859-1?Q?rJ5WQN+WGDtpjW4G/DXnyvlqEI9aDNTLXQ9S1E453g4KwtT0muOcLDpHhp?=
 =?iso-8859-1?Q?qMYD/8f8M1inKUZYvgfDz7opnuuDS0EveatQ6UejVnh7nr6sdjkYPFvnqv?=
 =?iso-8859-1?Q?CNBRKCKAqTIBduH7tCxX51wsJOCKyEi0y2oX1QxLqx0MQJrxSUm/tAc4WM?=
 =?iso-8859-1?Q?68BvoXZ374WTQ/lMM8Q+wj0XpkbdC60+3kN5v+fKlAiBey910U6fEIMBhy?=
 =?iso-8859-1?Q?r+m+tv011INxjVkeGDV+q+xa+WYEVRypGgVTcjs0XXP6lHsMGRzZDbSech?=
 =?iso-8859-1?Q?8u4HhtgBIUt6aBVYNl6R/Uru0zoj+wuUZo/AAxov+uEO82bBJT7uWlMFOA?=
 =?iso-8859-1?Q?8WWxa5mn1RYiIUi7iTQhDOL/cbjgM0lz9adDnpfh2/vgx7ZdNpcUifmy1N?=
 =?iso-8859-1?Q?JP+0B2wPFKBNlEkdr7GSmWWtgZwvIunG9I0FdMARKQ6ZxqP3QY8G02aBzf?=
 =?iso-8859-1?Q?dv/3Zr6V17E93u+cFOCEwnn0Z+6yEYXyUK3RFZlQu1gYoBmIg1f8KeV70G?=
 =?iso-8859-1?Q?zFPCVE3sVSdjol04Apdrla11VrB7aaFnlmAj/o+ZEwNqyI60/4qPqYxv5J?=
 =?iso-8859-1?Q?1wJt1+vZBNCxcl3x3to3ERXj74W9teZ9J8pCfejp8epdVEjK2lEP+XSDgK?=
 =?iso-8859-1?Q?Q1rYPVKI/zKcPmKnwVuhUqOYsy5KFRIJygz8MyNBd2hIhVDz/017H7gH0o?=
 =?iso-8859-1?Q?Kk6XC0Gqw5bVzzLgIrmw+ZxkESzbLhlLn4xJyS3vLSDugLcUQNuDHCy7BC?=
 =?iso-8859-1?Q?RZ/MKR6MmPRVwgXWrDY1WJz7erqfwQ4TGlGNRHBOBGTyjh4rIaoaSrDVB1?=
 =?iso-8859-1?Q?SmeYsVptYgAG2CRPWWYpRNKx+iUlQhthg0MdKH0mm9IH6bnjBrlWMkK4hM?=
 =?iso-8859-1?Q?jWUvRnwvAa5JtCq6c0jHs5MTJj9Ucxo26r+DFgMpr9mO9DSHvplZ6ainnM?=
 =?iso-8859-1?Q?W0KTd8yG18f+zo0Z+o16JZw/DMtEgYJQtGG0XLbst1lDh8JJ4iSNdjO7x2?=
 =?iso-8859-1?Q?9EADtr5ZHAReKJN2vBV0LU75o7ekkHY8PalJGZzieYwsOqhjCPqfw+FbW3?=
 =?iso-8859-1?Q?BiVp53uIgaH2j1CBM/aifZFSdDkqNdCRmuDJuIpqJcC0PM1YYPFWeOnSgI?=
 =?iso-8859-1?Q?Z6at1X0X7A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	WeQK/NMLSGf86GnbvCQGFQCWjmioY6ST3g4QOz1Yle2yLZ2OZ3QJi4RyjSSJEvHS/3hQc6GjjJ45dc/MKVtDOx+KhxUP0muIY6lZ30UMvKLsqktuFK5hKbAmyl/aLV22f71xp3jBLk+nDEAgH/Sndw0pC/YSNlbfmjfp6dQVCsmgeWc0+mSJD8o0uOlxflJtOfigJzxvUrL4wB+b+eaHUBNM2ioVsihLb15r3IWOzGsZQf2xXtTSeHYeTpFfPaKfI6iC/628iSnO8M0eoKqaHZDwEkV2nVktHjUIACYk/7Or5iJWaVgPm3+Y7XqI/CC7WO9PS8pI2CvQMZYHHcSp1w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wpfOAoyupX6vMknD/160hZd1LorZtnCS2KViWP/oGdPQBlizZticOPqQhy2u/A0rtRRFwi3BUYX1DosZJ7QJCaJMBk9fl3+9Z5eK30hp1CCCek+ECIi8vsze+sXYccngAcVk3xCnwqNaDq7vyIYUqEEEeFIsY0v4MDZS5mpJlbkQrpmdZSpIvnmlueuZr/TsnBISmNQFk3mpihgWtzEFv5Q8EyiUgfFWrru/wDj7wATj2A2I46XHwRMpi10QGhs/OlglytW6JpTysGUpUlYUkc55TgdukYxC/0EbTM+j+PQBON6Ks1S0U79bdKAVV4yynrmu9mzz0Mjk7NEDuH53DAG8SxlbP8MgIF8iPIl1e82XcgnMfHZ4uD+1jbhZ1vyoh62xI0txjtivNSv9F3acTQ4ZibS+CZvfAS+tf/eqTnHL46buXfcB/cItw96N4UN1AeeSYxuzv7gTRqKrI3iaRtKpSnP/CMUFKvoGCSlOlTLDJol8EBNThn75GHH881Sugo1pObEPzvEydChuk5pmWlz7EcbgkFKh/ojXzqhaaWImddQtK1Qnu6lKn+kct9RBnIYEZuypK440cB4TnwJJrj24+EBorBbq7iJAVgot3YM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5785.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb34c09-473e-464e-aa3d-08df40d31377
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 15:39:01.8585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p2kFiuIHkfJk24vxzLHXVA2r8gBjjjWI0CCNlpKA4PwCIZMp1zAlRJmurJJPOk99TepSLvW5mxfEXuRoZyfVgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7448
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2611040001 definitions=main-2611120062
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA2MiBTYWx0ZWRfX8PPCHcplWmz8
 vAgmEbbD0FGA0S0D7+VLDHBW/3IiA7amtfB0tOkPL3U9X4xc1A2hq6XOvMNXXnd3LCDZTe8h1Pk
 pgrHWNKjgNiiMdbRlQWZ2jStS7KEWSRNV8N7SpOYElDkT1k0X/8H
X-Proofpoint-GUID: xw9jkPwVAM9K0oUeX-rOqLoX81hf28Xv
X-Authority-Analysis: v=2.4 cv=B6EsQ+tM c=1 sm=1 tr=0 ts=6af5dd98 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=zJRp6_cAMcgA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22
 a=4TrZ4asytSZga1RBp3kA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA2MiBTYWx0ZWRfXzNhmYCxMJrXq
 J7pEosszp0bq1Tw5hvxkG93nmoZfzuwIcdRHc7JKdIOHPyLS0wv5SN72nq9dEl2Mg744QhLNV4j
 Nn5P9i+aKjT/GHd/o6ZJYad12EALGlJMZuHfCosg5ySM6ichYUmEcjxkCf83ROBTRdtmTb8gggt
 a44JAcY1hPGqlwLfQ0DGm2XvOWCLDXggyEXNqFz1eWvztw2A3Ft6e/wu7xp/oJxggiFJrX6eYbT
 i6nFxdMtpo017RfLkmvrXYe+a8by89Qniiz+A/NltK5t5uBPgUd56eVsXJX6l+fN7/Zrh8f2Vfh
 wY2uX5EVp2W24qFvcqPamzHTy6KL7El/qMxemA5iJirXde8VzuzvTfvvUWo6LfGGyf3WIZ0sJMR
 2MxAldhvEp3X4j2n2jiQaiYdViJS+mgNhmM03GWbOlfrXj2hjCgW448FjpU4W6ulyR8cuuOa5u/
 MVimWrkPIk/BYMTMfmA==
X-Proofpoint-ORIG-GUID: xw9jkPwVAM9K0oUeX-rOqLoX81hf28Xv

Hi, when running tests on Solaris, I encountered several test failures in '=
t1017-cat-file-remote-object-info.sh' which look like this:=0A=
=0A=
./test-lib.sh: line 1040: cd: /builds/components/git/build/amd64/t/trash di=
rectory.t1017-cat-file-remote-object-info/repo/parent/daemon_client_empty: =
No such file or directory=0A=
not ok 12 - requesting only objectname echoes back=0A=
=0A=
The reason seems to be several unquoted variables (needed because of the sp=
ace in path), and with the following change, the test is fixed again:=0A=
=0A=
--- git-2.56.0/t/t1017-cat-file-remote-object-info.sh=0A=
+++ git-2.56.0/t/t1017-cat-file-remote-object-info.sh=0A=
@@ -69,7 +69,7 @@ daemon_parent=3D$GIT_DAEMON_DOCUMENT_ROOT_=0A=
=A0=0A=
=A0test_expect_success 'create repo to be served by git-daemon' '=0A=
=A0 =A0 =A0 git init "$daemon_parent" &&=0A=
- =A0 =A0 echo_without_newline "$hello_content" > $daemon_parent/hello &&=
=0A=
+ =A0 =A0 echo_without_newline "$hello_content" > "$daemon_parent/hello" &&=
=0A=
=A0 =A0 =A0 git -C "$daemon_parent" update-index --add hello &&=0A=
=A0 =A0 =A0 git -C "$daemon_parent" config transfer.advertiseobjectinfo tru=
e &&=0A=
=A0 =A0 =A0 git clone "$GIT_DAEMON_URL/parent" -n "$daemon_parent/daemon_cl=
ient_empty"=0A=
@@ -519,7 +519,7 @@ test_expect_success 'create repo to be s=0A=
=A0 =A0 =A0 git init "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&=0A=
=A0 =A0 =A0 git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" config http.rece=
ivepack true &&=0A=
=A0 =A0 =A0 git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" config transfer.=
advertiseobjectinfo true &&=0A=
- =A0 =A0 echo_without_newline "$hello_content" > $HTTPD_DOCUMENT_ROOT_PATH=
/http_parent/hello &&=0A=
+ =A0 =A0 echo_without_newline "$hello_content" > "$HTTPD_DOCUMENT_ROOT_PAT=
H/http_parent/hello" &&=0A=
=A0 =A0 =A0 git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" update-index --a=
dd hello &&=0A=
=A0 =A0 =A0 git clone "$HTTPD_URL/smart/http_parent" -n "$HTTPD_DOCUMENT_RO=
OT_PATH/http_client_empty"=0A=
=A0'=0A=
=0A=
Best Regards,=0A=
Jakub=0A=
