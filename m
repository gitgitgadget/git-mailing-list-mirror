From: Andrey Utkin <andrey.utkin@pb.com>
Subject: Don't use PGP/GPG signatures in mail that contains patches
Date: Mon, 18 Jan 2016 03:27:15 +0200
Message-ID: <569C3F73.3090805@pb.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_318f1839-d635-4ec4-8fdb-bc46d33db8ae_"
To: <linux-kernel@vger.kernel.org>, <git@vger.kernel.org>
X-From: linux-kernel-owner@vger.kernel.org Mon Jan 18 02:27:41 2016
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1aKybZ-0004Ea-FW
	for glk-linux-kernel-3@plane.gmane.org; Mon, 18 Jan 2016 02:27:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421AbcARB12 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 17 Jan 2016 20:27:28 -0500
Received: from mail-bn1on0146.outbound.protection.outlook.com ([157.56.110.146]:21680
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753152AbcARB1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jan 2016 20:27:24 -0500
Received: from BY2PR05CA050.namprd05.prod.outlook.com (10.141.250.40) by
 BN1PR05MB121.namprd05.prod.outlook.com (10.255.199.16) with Microsoft SMTP
 Server (TLS) id 15.1.365.19; Mon, 18 Jan 2016 01:27:21 +0000
Received: from BL2FFO11OLC002.protection.gbl (2a01:111:f400:7c09::179) by
 BY2PR05CA050.outlook.office365.com (2a01:111:e400:2c5f::40) with Microsoft
 SMTP Server (TLS) id 15.1.365.19 via Frontend Transport; Mon, 18 Jan 2016
 01:27:21 +0000
Authentication-Results: spf=permerror (sender IP is 23.103.236.4)
 smtp.mailfrom=pb.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=pb.com;
Received-SPF: PermError (protection.outlook.com: domain of pb.com used an
 invalid SPF mechanism)
Received: from 013-smtp-out.pb.com (23.103.236.4) by
 BL2FFO11OLC002.mail.protection.outlook.com (10.173.161.186) with Microsoft
 SMTP Server (TLS) id 15.1.355.15 via Frontend Transport; Mon, 18 Jan 2016
 01:27:20 +0000
Received: from [152.144.157.156] (141.251.156.196) by
 BLUPR72MB0050.MGDPBI.global.pvt (141.251.146.22) with Microsoft SMTP Server
 (TLS) id 15.1.365.19; Mon, 18 Jan 2016 01:27:19 +0000
Openpgp: url=https://pgp.mit.edu/pks/lookup?op=get&search=0x3F6A28D927BDD76D
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
X-Originating-IP: [141.251.156.196]
X-ClientProxiedBy: CY1PR72CA0001.MGDPBI.global.pvt (141.251.156.206) To
 BLUPR72MB0050.MGDPBI.global.pvt (141.251.146.22)
X-MS-Office365-Filtering-Correlation-Id: 4ba7ecf7-c049-4636-6b3c-08d31fa682cf
X-EOPAttributedMessage: 0
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11OLC002;1:/XqrqR96JubIO+Qmp3UeayU6+eBjlvRKcNGjUEvO53E1vqxsqBPtddS9JyvWo2Bz2quXfUJhqWuTaH3QEcB+UUSYah073hqv4503ph56oStgp9d2Td0yNBaZR/HQAyoadL3EeMkBv2t/1/pAXeWz8EIW9c5kc3ehZjoZsV27Vh8+riPARgjxXk5t/+OwZFg7LyJX9EEdkqQCnnfx2BBH/9Voh9+fbv4m3qvbcnQZkyn/R8SMsvOt9+rbXLRVaQnXOmoSWgA9HG7/Z91+TwcLcZcyuh1A3IcHVlfmt8UI3kwB9csRU7ZBqpPvIgx4RiN+4w14gRVpIjGhlI7OdMbBHw==
X-Forefront-Antispam-Report: CIP:23.103.236.4;CTRY:;IPV:NLI;EFV:NLI;SFV:NSPM;SFS:(10019020)(6009001)(2980300002)(448002)(189002)(199003)(6806005)(5004730100002)(104016004)(106466001)(3846002)(84326002)(33656002)(85326001)(77806003)(189998001)(4001350100001)(2906002)(80316001)(36756003)(4610100001)(5000100001)(512954002)(83506001)(5001770100001)(229853001)(59896002)(107886002)(97736004)(65806001)(260700001)(586003)(11100500001)(64126003)(450100001)(87936001)(65816999)(564344004)(5008740100001)(54356999)(66066001)(1096002)(65956001)(87266999)(300700001)(2476003)(86362001)(50986999)(1220700001)(92566002)(6116002)(39530200001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN1PR05MB121;H:013-smtp-out.pb.com;FPR:;SPF:PermError;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1PR05MB121;2:rBPfoFaLTLrkohg32MJ96+B0nLM3BIe4jGTCD4JU0QqR/9NdGvZswoX2kRF7MYEM22qUV5ccFWN6qqyfBxegSsAHTX1qFKGoX28soVINDx+alLDGjEqRQvjWCmlgABCQIbDKBuwNnDH60LSKIGUkTw==;3:avaVTn3Ls3511Emx6hgC0oepS44+l+ZIIkVXplhpmxH1TzmMDbddEFeeijDF4MPf/ehTdFpbL+sFyEsyHcJkdZGWW0IgLyVYnJzGLc2uWWiJQbd+BNgoD5J55Gep/nVCNfRb4atk9a8w+if/YFNaji9dcCLHiU/2Tq7rwgDJbtNyDirhoSOaoegBrEsdZ+1g7cZClEbyhHuWk7acYlvCYEx0RXBibKWrDUWoyqbjuj8=;25:Wiu37E32cKtEne3nex8qb9vbsgC4Vie1RaAMQn9xn0My2uHe96kP16u7g1rq8Vv+NLrHhbmg/+xRq/5PvyN9EFNrCOZsUU7O/yVCqzLLVJ5ub5+fmaz41S/IFXZrnMmd8y/ra8xT5mc/oVgggyhxFA==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BN1PR05MB121;
X-Microsoft-Exchange-Diagnostics: 1;BN1PR05MB121;20:Zea2XOaoCcnjYSrmC/TOrEo3UUSrkO50Mi1jmmSbisJXISui3HH5e9r437HofpM7U/K/qwQp491naS7rJCxyoxDmFFEMX9rOedV4DFBHyFF7ExfND6pm5FjzLHRhnxm9I/3PfpfjQ0A3fgLWvtC/QZ14qbukFcUFPeEjpLh5OVSUcWtA2Hz/tur/ed9ITy5AHSeaCPk96aK/1PSYgtPXZn3q774EXZ9XGBTxKZLwWca+62i7l83ycXMWTiDrAbDtO8mK8f4wQ2IajJaP3uKHgepORg21sBjbUyAQvxiQf1oySxHrFncpUT9GhwLp6lDUMrxP8CuBXtpSzbmA5yrr1x8zsZbzE800Uk2CMUKgRZvmmvGbMVA5zQ0G6L9MDQUmJJC0k8AlD+ZbWiL5Zy4t+j+rNOlKqsDMdyqpPZdOoplp8xuLMKnybZH59uCtFGNTkkoxQtTR5WoXQzSj1WciSdhhUhSTVMDqX08NcNM4TcN6JwYUjYWdOwSfbbLljZma;4:65zQpSdcsltrlKyhgU3jAyJbDi0c6cejjBb+JUM2F70sTqO1EMyNPaFAYQ4ojMF3KC0ejuUgJ48qxfbVLBQMloCX42gry5PxZaHWpfeaGm+tnlREfuMFGY+XERTbdFZvPH4JVWAOIolxsix9j8+Y9q5KEvzNjeXOWT7+EFrjX0UIeCJtQVOn3sBND/IKstqb7eaWx8edvA2QHT0Sx9JsedWoga4IjcoXpxjggAOrA
 37M6/DRPC6ccorkEXb1DPXkYmATyyAIkg8npl9yH5VuHpO30vPaz8RedyVCvrvs1oKopHIiL6x9EVHKKVg6zPCOlDY5NeXg7I/ 
X-Microsoft-Antispam-PRVS: <BN1PR05MB121A761426D9B2991D443F7E1C00@BN1PR05MB121.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(102615245)(601004)(2401047)(5005006)(13016025)(8121501046)(520078)(13018025)(10201501046)(3002001);SRVR:BN1PR05MB121;BCL:0;PCL:0;RULEID:;SRVR:BN1PR05MB121;
X-Forefront-PRVS: 08252193F3
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN1PR05MB121;23:PcpCC+OArGXZcVBzPj697gaX/jKiHy8QLE63hw4AJx?=
 =?us-ascii?Q?ZvBzPrK6nghz8Wwg+qFJyRynRisg1ZW4AYjmhe5+NFFfdZQ8r2zjMObLErXn?=
 =?us-ascii?Q?Fz/6750rjGYjIYsatBS1oFjFtCsH5KWyz0k8wDY/XU1DBL2+NCwX3puv7MAK?=
 =?us-ascii?Q?okmwqqzZA8f+nhdKo7t5r9Ss2BxKGs64bHhIRaTXzjSXrcccUDs/iTB+CngW?=
 =?us-ascii?Q?Vl70qWAEe6BdZnw0e59xW3AaQBKn0WsLcMrXX4kCtTfio+qdxkH3TSU8wBJu?=
 =?us-ascii?Q?9eTCKWMVETo07wHR0m+J4IG5aT5flQD2o2bMdGBeyntYhvTfMw8qMgLMn3eN?=
 =?us-ascii?Q?LYSyjK/GYyjjHTi+HKszoj+YR3IvzGDAdhQpM3aGNTjfw8tLVUxbRBeNxkU3?=
 =?us-ascii?Q?gFsthKCyke9HrsVOiKstUwEF7lUSVFfdfhM8r7AeQD/cNlI7HQMGlDcWV0Cy?=
 =?us-ascii?Q?NBPOFj0blCU8+TVopuiN0xdxdNW2LOP8PY0iyPyWSl3w5rmU6EqmrrIcW6rZ?=
 =?us-ascii?Q?/H4xhQ+hlv0vcsz4h5lv0VIzX2WVzxSdGiL769aEm2iJiDDCY3c6U0ZQmxuu?=
 =?us-ascii?Q?Zsvqm7x8NoN9DJp/7QrTy2zTlGh2E3xm+gMRghp7JPP0kKCwaTODqnXt4gMY?=
 =?us-ascii?Q?aJNZMu 
X-Microsoft-Exchange-Diagnostics: 1;BN1PR05MB121;5:klvV2Sj5WJxBAqcW5j6JjP0ZThjr4YKJPZ5yOYAq6wdTB8iW538AJ3DlEFr6TGxd+qKBLVZdx5jn5Gx8NUdQ7T9nX98TDU9mAUBgZ4QgAk350/4f+fvMd5RcHlE575xlhoRi9SwI+stRAVRXAdjQqA==;24:/vri7CCdF16VuqY1dMP9mljRw6k4Vl2D/JXZa7WYDAc6qVcpNQeEtHVKjvykwrT62g+rpGu50ZMtwmoTlN5sl8y9fdxGVDJ/4tbZHBxtdDY=
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: pb.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2016 01:27:20.8255
 (UTC)
X-MS-Exchange-CrossTenant-Id: 8a4925a9-fd8e-4866-b31c-f719fb05dce6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=8a4925a9-fd8e-4866-b31c-f719fb05dce6;Ip=[23.103.236.4];Helo=[013-smtp-out.pb.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN1PR05MB121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284278>

--_318f1839-d635-4ec4-8fdb-bc46d33db8ae_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


________________________________


--_318f1839-d635-4ec4-8fdb-bc46d33db8ae_
Content-Type: message/rfc822

Received: from [152.144.157.156] (141.251.156.196) by
 BLUPR72MB0050.MGDPBI.global.pvt (141.251.146.22) with Microsoft SMTP Server
 (TLS) id 15.1.365.19; Mon, 18 Jan 2016 01:27:19 +0000
To: <linux-kernel@vger.kernel.org>, <git@vger.kernel.org>
From: Andrey Utkin <andrey.utkin@pb.com>
Subject: Don't use PGP/GPG signatures in mail that contains patches
Openpgp: url=https://pgp.mit.edu/pks/lookup?op=get&search=0x3F6A28D927BDD76D
X-Enigmail-Draft-Status: N1110
Message-ID: <569C3F73.3090805@pb.com>
Date: Mon, 18 Jan 2016 03:27:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="X28Lo8p6DUuRNKFNUv1q0pw0RQUm2NcUq"
Return-Path: andrey.utkin@pb.com
X-MS-Exchange-Organization-OriginalArrivalTime: 18 Jan 2016 01:27:19.3593
 (UTC)
X-MS-Exchange-Forest-ArrivalHubServer: BLUPR72MB0050.MGDPBI.global.pvt
X-MS-Exchange-Organization-Network-Message-Id: b10450a0-fe74-4c67-770c-08d31fa68270
X-MS-Exchange-Organization-OriginalClientIPAddress: 141.251.156.196
X-MS-Exchange-Organization-OriginalServerIPAddress: 141.251.146.22
X-MS-Exchange-Organization-AuthSource: BLUPR72MB0050.MGDPBI.global.pvt
X-MS-Exchange-Organization-AuthAs: Internal
X-MS-Exchange-Organization-AuthMechanism: 06
X-Originating-IP: [141.251.156.196]
X-ClientProxiedBy: CY1PR72CA0001.MGDPBI.global.pvt (141.251.156.206) To
 BLUPR72MB0050.MGDPBI.global.pvt (141.251.146.22)
X-MS-Exchange-Organization-FromEntityHeader: Hosted
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: BLUPR72MB0050.MGDPBI.global.pvt
X-MS-Exchange-Organization-OriginalSize: 2562
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageFingerprint: E826D01E.AD394849.73E7B54A.87E5CDF1.20159
X-MS-Exchange-Organization-Antispam-PreContentFilter-ScanContext: CategorizerOnSubmitted;
X-MS-Office365-Filtering-Correlation-Id: b10450a0-fe74-4c67-770c-08d31fa68270
X-MS-Exchange-Organization-Cross-Session-Cache: 00SL=1;EMSL=1;SCL=0;BL=0;RL=1;PID=0;PL=0;EXPID=
X-MS-Exchange-Organization-AVStamp-Enterprise: 1.0
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 2
X-MS-Exchange-Organization-Transport-Properties: DeliveryPriority=Normal
X-MS-Exchange-Organization-Prioritization: 1
X-MS-Exchange-Organization-Rules-Execution-History: 093951b5-60d6-451e-bdbd-c02315b1688f%%%1ff67a4d-9f2c-4a48-a677-a425aa48658a%%%28104803-15bf-471b-9bb2-b7fe4cc14c37%%%bfd17525-8f95-439d-8c59-163e4bd0b358%%%9fdf2717-51a3-48dc-a97a-ba764fc76d93

--X28Lo8p6DUuRNKFNUv1q0pw0RQUm2NcUq
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

=3D=3D=3D=3D=3D QUOTE =3D=3D=3D=3D=3D
Don't use PGP/GPG signatures in mail that contains patches.
This breaks many scripts that read and apply the patches.
(This should be fixable.)
=3D=3D=3D=3D=3D END QUOTE =3D=3D=3D=3D=3D

This is in Linux' Documentation/email-clients.txt since 2007, and still
almost nobody signs patch submissions. There are few brave people who
do, though, and seems it's not the end of world for any "scripts".
The broken scripts could be an excuse in 2007, but not today.

Proposal:
1. Implement signing option in git-send-email.
2. Figure out if anything fails to interoperate.
3. Drop the quoted statement or change it to appreciate signing.


--X28Lo8p6DUuRNKFNUv1q0pw0RQUm2NcUq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWnD9zAAoJED9qKNknvddtcDAQAKMWj9JI1nDVuMUkTX4Ud7kA
SjZ3clCwV+jI5pSgpppSGQSqJgPI4kWi9XiYOtEJWxZCJOw2go1kiRsn3JVBrzoX
84efgzgFc+16Mh9zEwihloZTREalpzUH45pS4Ni+/ftrOMP5A+ed8gG/e+ef2Mtk
fKwZglBX3COKHOmz7xWWdnHPpGgjMRtUb7bhGaqnf5rgkNfireeupKsYBQdRmlrK
zJFLfI4eTqchHMJwfaEb4M7vgbxqcC6eySUDFWf93VzasRqa4Alu4RswBgXYMnIn
VHiEbIDVJ99pj5L+0XwsY2RcBgO5Al0aeBaITahKHwh9HP+7Ov3Nb5V+lv18TQf8
G+CCfNYbcjYy/kgUg5sHolramXR285DJX8WAgfnP8DlrqaeKCssnBdeIj9zUlXbl
OFwE2bzK3ghXl+gs8Gh+VCODkszgmxVtjYwwGl6xXOQyCDD69mkT97sUVyAiSXeE
SzyS/5Db6C33F1dlQdx4lG7/MiYBHBWDTD/L8zEyUAknvtC1iHivR/uhTJd8v2D/
oytMMlmGbrchqJ6PI71Xkly8DTC3uxqvQpUVAWG5rd7b1aLrEwYOsif444HUHUz+
3sUNhMkGNWjir7SoR760hkLrKDHBXEr6M2WTBcKTIPjpNYr7QeOkOpmXXLH6qq3i
cicy0RtGdE5DTtFUoM+1
=xbOj
-----END PGP SIGNATURE-----

--X28Lo8p6DUuRNKFNUv1q0pw0RQUm2NcUq--

--_318f1839-d635-4ec4-8fdb-bc46d33db8ae_--
