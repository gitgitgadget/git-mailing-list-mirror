Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rageshkrishna.onmicrosoft.com header.i=@rageshkrishna.onmicrosoft.com header.b="SjmtH6ol"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2057.outbound.protection.outlook.com [40.107.117.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD7C10E7
	for <git@vger.kernel.org>; Sat,  9 Dec 2023 09:38:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHUmmvKaqlC6kBpIT2RGu+SVvta8ihpdGhMOI0C4zt3u/eZGB/FMxy7cKbU7gRZ4xZ4cHmC4TQ4XGccNUdQGX7dOphBD9xyB8Sl76dO2AFgDDcovZzCfLpuOXi1YoS4iIRgErvb232jYcsbXLNNXNGp4oq7AArdsJ+3t4xBljJDKpt8YqysP4PsKfDacTX4Lh7WVLZsmh2DO0EybW/H5aobDBWYlMLiBuVZBEFV44cg7FsirlM4Ly62VSegLIen/WxKmwyo5cGWLU8A6EfLopRxTkG1hLA+zEUfDpi8U1W4BmvuPRMN6X5L1Atz96eVtKXko+ZTqZVcPhgha00K0/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UNdRKDOP9MVOWXuMLrG5jKy1eDWs7jbhUv7EIolaYA=;
 b=UbIkQlc0FlOSepiev9p6sG83FCnFr13xnso5YIDuNSbiQLh/zj6KzBXWMakc3mmGIFePJIM1m0hvS9dJqgx0C2fHTLvth/86SC7CEf3tGP7yWMd2KbWdJbkT8CkgtjkbJiaiX4JUQz0YRF1+0qCLdEmEtKXHlpSWMPRgCgBYat9bFqRu2pdKxzyi5ilJi2JkEjRmJ+2nqTEM+UME/XSwBnzKoqaoFpcirEOGLCqGrrdYeuUxies2sRUzcMWLVuI6oHWhsuCSVOMORp44l+iafrmhoKncEhnShTUmyF2/4xR7HEiK/kddJmBK/UKludhj8KbgZqIAzc1ezgipRlU8OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rageshkrishna.com; dmarc=pass action=none
 header.from=rageshkrishna.com; dkim=pass header.d=rageshkrishna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rageshkrishna.onmicrosoft.com; s=selector2-rageshkrishna-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UNdRKDOP9MVOWXuMLrG5jKy1eDWs7jbhUv7EIolaYA=;
 b=SjmtH6olsqIJIAu7bCbSlIejxS5f4+GZigw96+SlD+lsvzYRJ8CdJ+8FqSCrfz28YbomL+Fg6cpH4jgRuViP5FthFSdbe6/NVBgRr37jgMvLXYkec4cTHh/2py9HcPMRi9FveiuONaSQIB+Rp3utISWSdwF212YOo06Xv8SbtFE=
Received: from TY0PR06MB5442.apcprd06.prod.outlook.com (2603:1096:400:31e::11)
 by SI2PR06MB4492.apcprd06.prod.outlook.com (2603:1096:4:13b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.30; Sat, 9 Dec
 2023 17:37:48 +0000
Received: from TY0PR06MB5442.apcprd06.prod.outlook.com
 ([fe80::f8a7:e213:c1b8:dc97]) by TY0PR06MB5442.apcprd06.prod.outlook.com
 ([fe80::f8a7:e213:c1b8:dc97%7]) with mapi id 15.20.7068.029; Sat, 9 Dec 2023
 17:37:48 +0000
From: Ragesh Krishna <ragesh@rageshkrishna.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Problems with Windows + schannel + http.sslCert
Thread-Topic: Problems with Windows + schannel + http.sslCert
Thread-Index: AdoqxlN6hY5l/8FIQF+TIZhwEG8Y/Q==
Date: Sat, 9 Dec 2023 17:37:47 +0000
Message-ID:
 <TY0PR06MB544239787E909DD4EAC1CA42D189A@TY0PR06MB5442.apcprd06.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rageshkrishna.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR06MB5442:EE_|SI2PR06MB4492:EE_
x-ms-office365-filtering-correlation-id: a501390b-5800-40e7-fb29-08dbf8dd8f5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rlYBiSYxXfkA9bMSvQU5/iLwLYdnnu1L/mNR7NZSaTNcXV2h3IinZlmgqTfSIQYlaZi/72d7LY3hbqpxJ1ys+K41K28kKseZzLF1t2o1+p+L7EHXOgrovEOKszGo8rRkqEMUUn9H9fZYgSqPALcxwZFhcnncQVoFMeBd0seEMPez7Bs9iGoRgoH3/mCvoXjde9Eu28e3PAYJygw6nXmqusYjqcTSuicxcxyHTf2OcNj1INnyzBtwqn0cFID943kfjdVg3lW6vI1UBp+qs73NNAoiC6ymzzgS3iKGI60GRKt5wjHJBzuesSJ1vWWMvlFfPLANpL0aZ0iBSA23+ACjYullOjZqTmGhIBX8nccBN8J9PCjbJ6m+7y7p1p0eSDPRTi12+paOlgmChCunJmRdhYeHh2qP2g68KEaq/4n7VwjG9jvCvIiSO6J0/Q2qeNXCMfTlxqlZ48QjTUqDZx2zEWfzMx9V4HKyjYvoTigGShYGQlh0MlTmBY21NGsvO/RQLjXv5McnqGSselxUUzgmHHkOx4j+ICE/sW1KHtXemW0HPO7/PG5o27yMLcJb/UkCjFq7VeaPCFo8ono+chfqB7cxh3MgUu//Ra5MGCYHFmA0IVniu6wRNDREnOL0X/aB
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR06MB5442.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39830400003)(136003)(366004)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(4744005)(2906002)(41300700001)(38100700002)(122000001)(33656002)(86362001)(9686003)(26005)(478600001)(71200400001)(6506007)(7696005)(52536014)(5660300002)(316002)(6916009)(76116006)(66556008)(66476007)(66446008)(64756008)(66946007)(38070700009)(8936002)(8676002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qoVAW0QwWzkzfoKoVkEICQywy1oLqu03tNwQqZaAiBnleXJI4nSbKXITC/He?=
 =?us-ascii?Q?5XWtYrH7H04/hUyxjYjE74Iwti4N+Gmi3WjpqRteIsJ5S7yuseJdmulXiHg8?=
 =?us-ascii?Q?drGHvWGwaZSbk5g+cJITOwLk9t7T5za+ummG6SRkWO+vDgCszzmqVUj3tWaU?=
 =?us-ascii?Q?p6Pr5Qpa07H0ArphveHk6pXi4iIfjQ5u1RCpfdor/ZnYEte6/Lpx1PQG4zCI?=
 =?us-ascii?Q?XHBpH0U2TrGYD9HZN8FYjGsgLVgCC2nRfPO7DEmQDVTVGZLshiww9fPpS9mw?=
 =?us-ascii?Q?M6DTegodapPBQXIR2gqLhzgYcmpjIz9H/fdyCEkxOzJmvrSOGl5jmQvyGTRI?=
 =?us-ascii?Q?JpBpF8u2mVtAJzjojUzL+zArS1PTByfYUZJ7tGv33fSbwjOBCGREw9aaOzEC?=
 =?us-ascii?Q?ZOv3B3QpVZF735LwHdgAr9nHahgxMeNPC5d288kMN4tmQ83/5x2Dv93vVuWh?=
 =?us-ascii?Q?cywAV86GVp9NYdcolsVX3hkCiNv8eglc5ip17clsT5Ygkp4q60JNbcXpmHK3?=
 =?us-ascii?Q?tkM9PAga3+EtIJCJnNYtvkbrpm7iDad7f5n9AZocu6SIqXpdgDlCSIS2nwJ+?=
 =?us-ascii?Q?PsmW12zL2H2H8vb078bkkM1eSdYJzBcfmP0z0OH7aTKHlATKSQJ0ujjEXcrC?=
 =?us-ascii?Q?O+ykldrN/Rc7b2qsiErI/nCkxM+jnHQTT0lrel+jxEx72j7fIyVYyb66zLSv?=
 =?us-ascii?Q?BFK00d8LHUod6cn5ZoOh+FRApRtTHBTR/isVtSZ8Adh5R2Ex8UnSxdzFluU5?=
 =?us-ascii?Q?UXw2xwQ+xp6kb/5B3GwkE+Gv4JwT/QI/Aa5tQg2yTLdgFuDuTgzYfpBfa/sD?=
 =?us-ascii?Q?4rOHH7tok0tAxBsMpONqIDKRifzPG5QI9lmSnrw4CTJcz6AVpiv24QMh01ex?=
 =?us-ascii?Q?Kw6M6FT38lzqcg67ILjyGFFyQ/G9JXwM/XyvWB/ylo+imsfYuqVKFe8mHJFc?=
 =?us-ascii?Q?rKFlVlJ/8RpyGRDDsLWq+U5miJ2Po2SFEhenSRwmpmzRhzMEIJWy8T7uF4mZ?=
 =?us-ascii?Q?TZKgzX9sncE0AlKWLCJBCmaEH3DGEV4652oRX35hNR/wRa8kesM9moV6x8qk?=
 =?us-ascii?Q?iwOBtnBfrPTZ+MnQi/7DGZtaag7MZFMBy3ZuTQd0+l0vldhtVe6dWfsvfI7r?=
 =?us-ascii?Q?s71TxiYiCumT9BvCScoOi9JcQ7W1GD2FMOpCy5Ep2WRZcVotMwyieA447nSC?=
 =?us-ascii?Q?z2XhfFH0cZ9FqMoclZ1/GOn6P+rCn3bF+G8Xpt2C2G0fc7i6+bWTYmjQgFxH?=
 =?us-ascii?Q?u1+RH2NAgr8o6Z+OUIwCNfrSpOCZxGHzvaa53vbQJZUqSfjpn5yNRsgURVFu?=
 =?us-ascii?Q?A+A7vxA6BlVnezUGQb0XAxvzO91Ty8qn70iJXlg6vkfANWI9cjAUTNRlHbHN?=
 =?us-ascii?Q?z/l5Nsi0O0lSmrrC3nvsmrMg3TM6Cg2OkGIEutUkWtLTyYRSEa0wvLj6b7iM?=
 =?us-ascii?Q?sJcCMjv4RMV0v0801v4cBbZTblR8Y1o2APGv/v/Wwa5bSXcLc9s+TAjUSRv+?=
 =?us-ascii?Q?2u3aFb0SQ4gdwcMblYJUPvxCNPxOo8sRvBXRvXg7MEjbyKG4fek1hfc7QsVP?=
 =?us-ascii?Q?6Jun5KrBVnBHwFxunhLvjz8ZTVASMEe2JzrFMI6x?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: rageshkrishna.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5442.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a501390b-5800-40e7-fb29-08dbf8dd8f5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2023 17:37:47.9308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb23b077-6391-471e-8a55-ab9f219e59ad
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c2pIrH1STBI2ECOJLJDZSwD0ZUFwcRCTpHgTFvSRJWV2vDiGfRXpK794txt+K3GKNZllVSPhyCGQotRD3vxfnhBsXU/6/uO2/zLki4KoBFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4492

Hi folks,

I'm trying to use SSL client auth on Windows. My git installation currently=
 lists only schannel as the supported backend. The problem is that this alw=
ays gives me "fatal: refusing to work with credential missing host field". =
I can see from my server at the other end that a connection was attempted a=
nd then terminated unexpectedly. However, I'm not sure what git is expectin=
g me to do to make this work. I suspect it is an schannel vs. openssl diffe=
rence, because the same credentials work fine on a linux machine. Is there =
something I can do to dig deeper and understand why this is failing?

Thanks,
-- Ragesh.
