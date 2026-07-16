Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021122.outbound.protection.outlook.com [40.93.194.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570073AA1BD
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 20:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784235156; cv=fail; b=EO+KpinZFv+R7OQgfE7xhQ2zsUU7tqQgHhRqCoojDRUCQcKVPVoEu4Iw0hxM7ImbIrnSQHk0Z7Wg/ocFko+CoD9EbUS1BhXSM5gtZLI9hJJYQ6YnJG695mYIpw9Cx69YtHheEf/BDjSxlurh88ZUUnhf42MUv3133NUef7Icf8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784235156; c=relaxed/simple;
	bh=8Xg1kPfvKR+/FCEDuWlWwJgdTvSYRWxFtnd3pCrDHxI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uwqzJn/pZq6FAMpLVCONS6YtPTz/NYdM87/PfvjCoHZyJurDH+/pfQHCGCHv4XshZru2MTsoxhjSbKlFrwpLSO3rYGJAp2NuIxZWAQZRLjHiXp7K82QOQofoYQ7x10n1nv9MMNjKL6mC5xizx4iDyKU5kgmju5OMzsgl9uFKdU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cseasy.com; spf=pass smtp.mailfrom=cseasy.com; arc=fail smtp.client-ip=40.93.194.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cseasy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cseasy.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSw6zK29/44/btm6YAFKmn5CUGJWFKzqqvGL0eUg2Hfmw9FkPwi0IP5pTtPjjp6CzzPB63Usc2WVjFqglZB4Npz5MEeB0UnCejrHOXEwfIqaca6NIeyUvdj4Wlmvjer790fLZ6Y+7r/CzGAJDEz8AZU7JPwmL3HBDhJzzPLqHlngKqSUyfnNLEN3nGLkJldvFWDAIpS2JctbMdBypMbSzP8zFzXN/gG/bJiIL8l52rVZIXdJb6gCKLC1Wkn06Fxqjau+SuvaimWccWbOzyCKisgNZSulszsP7sUf/shoF1WJWR4OyhrGzQqQVzX5ihzwpFTlMT1FucmruaJZcmxcGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dG5ED1m1rai8pRg/tPVHLbFYltNzOC+q1bjMD7iSlM=;
 b=RSA1ymFO3dixltPlqCZcjdrXOI9MxXda4yUw4UgxHwhvEf6CsFlvYABsYv1xjXnUvBjRVbmruCpPwsVb+TRdJh3fpG9LXgc9TMuvRRwghesaHaCZjYq1PNLT1pDLCdxCdrObPs0jHTyewY3deMuF3Bc7+I5ObciJHe7T6iMUvfayIFSFZmgyUh/jYhpJoBv4IFQ37B9+C3pPGD7kupQtluxrB0wQuDA90dLlmtQxLm0OSOwLYxRESnfF8nNVTU8t8aBCS4jdchveL9MTLI4ACZGJVHPcr1SlIp8kQSYTDq1DWdawmHn0Pi6lS7RFqOBAcTSHuR56UVZLUle2pNEx2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cseasy.com; dmarc=pass action=none header.from=cseasy.com;
 dkim=pass header.d=cseasy.com; arc=none
Received: from BY5PR06MB6548.namprd06.prod.outlook.com (2603:10b6:a03:235::8)
 by CO1PR06MB8010.namprd06.prod.outlook.com (2603:10b6:303:e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.5; Thu, 16 Jul
 2026 20:52:32 +0000
Received: from BY5PR06MB6548.namprd06.prod.outlook.com
 ([fe80::a1a6:27d9:74f9:8d2c]) by BY5PR06MB6548.namprd06.prod.outlook.com
 ([fe80::a1a6:27d9:74f9:8d2c%4]) with mapi id 15.21.0245.003; Thu, 16 Jul 2026
 20:52:32 +0000
From: Randy Kroeger <kroegerr@cseasy.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Please provide help with how to fix
Thread-Topic: Please provide help with how to fix
Thread-Index: AQHdFWTyKDAQC6hyGkO8jU2+2+Bnig==
Date: Thu, 16 Jul 2026 20:52:32 +0000
Message-ID:
 <BY5PR06MB6548F18EA532E3EF021AA93DBAC72@BY5PR06MB6548.namprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cseasy.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR06MB6548:EE_|CO1PR06MB8010:EE_
x-ms-office365-filtering-correlation-id: 12e2960e-b3b8-4eb1-1856-08dee37c2845
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|38070700021|10067099003|7055299009|56012099006|6133799003;
x-microsoft-antispam-message-info:
 tAH7l+d2Om7yd4hiPJDHfwC0kvzR/iwULOMj9MSnXf2Y0QTxrEEWzPa0L/RxmLOr7vdkID52Lrzdi06fFwqv2a8edgYHW6TFOFlEe6BfBy0rpDeM9+42O/rqLq/56DYdillCLGQmTZTa7ikTLQnvNul0IIqPzP9gw5rr+SY746wQq4tc4qzah8fHdWnWfT4bwIc+dVIE+jp6yLcbvj6A/A3X80h0WM7MFi7edQOIEEhPUyoI9vrqDDOsc7kaXQ7w9vPP03PIsOcvZWDE/l4Nu+uITJKPPQ/7/OCI2ISyM47DlCEJhqMxYLgoHW32LM/VPsP/t1GDs0WeoVdAonXS6lWeRjWHZgRGKuwbnhdiCGIHTA+l6JtPa2dzfdEc6tQEgiXkSJCVi1JELGsY4LKJYX8MmbD2JIpKeAakB+SxMZycXGUgW+cKq5t6a8tsYYlk1vMc7yTVKeuf14VTn7/9QjmhYlatRMUbCrI0C5daLJYj8S5oo7jk5m+LffoHk7lpIXCJ+xPxai5ziPGiuCiu96PGZ6lEuGilueNX5qu10s6gkUCFOw91NlEjtwvyV9RlSMq6Ll37k/lk2G6xIn1QmHmoARnpSZfTk79O4R2i/+inOng//ckzsexrAWnctHFCTiprnrEGND15ATQKqAbhd/kUk+WENTngJ3XK7v00PBvNHuUxWYx0AoXr6c8IBg0DqjyDYqBLquhDUOwVOM+xCk5WnPXGTEVBih60JaDnhKesXEZa8HqGObNQIpXA+dCH
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR06MB6548.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(38070700021)(10067099003)(7055299009)(56012099006)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?5s/Li6XDQlXBUGqf026OLA7TuOqto2zLEskIndl0ukUSNzy261VxnZK11o?=
 =?iso-8859-1?Q?wwrvYAHOs5sPaSj3OF5Hi8ZOComdue1GL+7gZUcplqPznBScuKkcjxf7P7?=
 =?iso-8859-1?Q?sKtkXzDPOL8TnrTTXRpgaq9uKXkJkbMVJlNFEtUacLvrL0VcCdIk+fx3ZG?=
 =?iso-8859-1?Q?Pn8H65vZXzj/4mT6cExcxC0N7ejtKUYipsky01Bu4Pf8fZ62HXz8TYViVR?=
 =?iso-8859-1?Q?gKwlRPyIJDusbj/S/cGMPORrsKtThUiA9Wn2vOoGLUHbDP1+8dl6l5ILtf?=
 =?iso-8859-1?Q?JTtEi8pfk61WMXRRteh9v7slfm7nDJNz3PMRK25PaWoyM4ZPGetXdMVinY?=
 =?iso-8859-1?Q?/qanWU+hwsfvvY5x95/0q3y8Ph+MBntW2Io46PkWRVEhb0hdAb3z8ZHLYy?=
 =?iso-8859-1?Q?jrV5BiXIBLtjLafC7zxqDB2mR+1337AUrrGmLLQbBFpHtEWhEh4akLqOIy?=
 =?iso-8859-1?Q?jPP/NQcgv55L7sNEjqRY+NpNvj2sg+SthD7QxOrSjw4YH7MUnDlsEG5rrs?=
 =?iso-8859-1?Q?P+BldrrHHA1BcOjnCXI7G/zTcMQpSBcura4UXaZvSRXMHuL3CFRcxciyBn?=
 =?iso-8859-1?Q?SRkOQ9FZYomV1FQRMucuPlE4+EO0sIJEtB14AnBLasJHBdAw3fXOZlnoTA?=
 =?iso-8859-1?Q?3DDQ8/e+B3E+S5uc85HbmXHg9w/C1ZMOPLhtIDhYkNUi59f83PEpANN7NT?=
 =?iso-8859-1?Q?lXKD7lVooRnBP+sPJn9Zx3TWuTw3KPN6AWCmgfi0sHQemON1ZEfFn2Zy0Y?=
 =?iso-8859-1?Q?0axoFDTmmbGgV4Kbn3IEhUqJEfUY9x2yqNgR4LnxFJ2sFSihXpV8Di5xON?=
 =?iso-8859-1?Q?skgJrew+KzfyGlDvJQOiPpD2phz9ZQQ2X40AqQL0PTflhWL/yaYSbAitBa?=
 =?iso-8859-1?Q?m4lx74byBJP8w3ZVSz01pfTMcAeegyydW8xe9oghNqQAhr8vrEJdWlDzYh?=
 =?iso-8859-1?Q?T3M7FgNLgAqd6PRCS7Rzdfzvana5J0MWz7MA8mUSzW/n/R2aRfeqlor7IS?=
 =?iso-8859-1?Q?TaiZptBDy5DkLGd6neOeGlX1SuoJ+T5oeIJTWvi0O2ToQxou4Ma2Uo+apH?=
 =?iso-8859-1?Q?YZX/vkuHsVrId7ticSPvnluz6x/opGAy+zQY/FUaArKaSsSmxZwF0cVXHn?=
 =?iso-8859-1?Q?4FitcEKDmGzoWHfS5wRt9km4daQ6IOHpnQN2IM5ZFewZjecUHPBb48iZxG?=
 =?iso-8859-1?Q?8TF6x83c5QJSetYTFnAMvSLJp+0aP6tmX3r+jxbs2FPre+eqv9WStrAZ39?=
 =?iso-8859-1?Q?cwseQmbsi1T8lbLvDWEibqrg6IYUgM9arW8aOSj6tstvBKBbYKZQq2NhuZ?=
 =?iso-8859-1?Q?ui0p33nM3luZ5Wl92upLDIBfl3gesl8xil/7Ja0UGqa/Bwg8ntYPfyONvo?=
 =?iso-8859-1?Q?ToVD2NDVeqTfcfmZf/jajzRvBsMoBWi6CAScAMsj7PXR7ORT3ShGofdJfY?=
 =?iso-8859-1?Q?eg+Ov0X6RmbsimmSicj3KITfIxMdrKdFGBDLLFVJw+pKMUgur+gD+CrO5B?=
 =?iso-8859-1?Q?aSwIm46jML9A4+iyndq/sMvhNknxpQEZx5Nw+aEkn9RoyikIfinZqEfVW9?=
 =?iso-8859-1?Q?XcSxdlhXBGmclqrZHakG9Uv1z7Rl3kczgym87BKakkOokuu4tcrWMTxV0E?=
 =?iso-8859-1?Q?CjtTOLPUpkwMD76pzS0FLjAvO2sXoM1bCrAwA0egtrnOotnQDoihDu7xMS?=
 =?iso-8859-1?Q?vGhB7x2cRkFfyaX/OFUroVTebSWoTY9H3rkOUGYh+k9MoL51b6inBd/IyA?=
 =?iso-8859-1?Q?FId0b7dG8i7Xx0BrFBLxGn+i4W17b1B0oWXz3zZctigvO6?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cseasy.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR06MB6548.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e2960e-b3b8-4eb1-1856-08dee37c2845
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 20:52:32.4023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: de9b6050-2664-45a4-9dec-fde78d7e4237
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5xUhm36UusTpwmGq5cXY1WXBN20OrB7Xp781772OSLMfuVX/IXlhDpL8iwX0Kw28rDvGuxa/DkK+pN+rn8oI4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR06MB8010

=0A=
I am having a bit of an issue trying to figure out the best route in fixing=
 the following.  What happened is on my second machine, in which was out da=
ted (source code), I upgraded to VS 2026 (from 2022), then tried to do  a p=
ull.  What happened was that I received a bunch of modifications, which was=
 confusing. All I want is to pull all changes since I did last on this mach=
ine.  I then had a bit of a problem with the gitignore file, so I decided t=
o just commit it (my train of thought is it is a file being committed to so=
urce control - that is it).  However, what happened is this file took on a =
life and decided to make itself the head and bypass all changes to the head=
 in which it knew about last.  Please see image below where the history sho=
ws a line from this commit to the parent below.  This by passes a bunch of =
chances.=0A=
=0A=
Question: How can I fix this issue?  I would like to restore all my changes=
 again and remove this bypass.   I have been reviewing your documentation, =
but am very hesitant as my understanding, once again, may not match how GIT=
 actually functions.=0A=
=0A=
I greatly appreciate the help!=0A=
=0A=
In this example, Commit 3 was done on July 12 and since it was on a machine=
 that had done its last pull on 6/09/2026, the commit created a new parent =
below Commit 5.  Now when I pull, the changes for Commit4, Commit5 are not =
included in the pull.    I am assuming I need to do a rebase, but am not 10=
0% confident and in reading the documentation, I am still not confident.=0A=
=0A=
--Commit6 7/14/2026=0A=
--Commit5  7/13/2026=0A=
|<-Commit4  7/12/2026  -child=0A=
|  --Commit2  6/11/2026=0A=
|  --Commit1  6/10/2026=0A=
|>-Commit4   7/12/2026  -parent=0A=
=0A=
Randy=0A=
