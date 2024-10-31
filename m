Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646F2199936;
	Thu, 31 Oct 2024 10:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730371052; cv=fail; b=R3Xw4TRSMmvZx8QSCl9Y4/1XEyZX3wOcQxsVkXfdgM8oDgJLebMUPijYXE51uCuvKjt0KGqnCQqRACdtL6EnUBqA1xUZCHCD7gbQ+l0Np5VlmhgZe2G4varLAASLt07/nHKWDUGmeXOeD9GxVvd2anYa1phjsbqevhm+rGLJpXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730371052; c=relaxed/simple;
	bh=Bi4mqm90cRELqC01eTnWdb6YgG6hBySI2oPF1U3kDdI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=kEztHW0swmk/H1PzXWb03ZSE33V7eoYdERA9Y3vw2jTQBp+FVtTNVcDH4R9RA8C0ta6MIw7vgq2XzAxQRr+l/WUQHOZzW0JNpyy8u1YEIwWMzEjRAFv/xz1z3nPG5EDGEPSMEM7xbACUPy/xilg42jl6pnruw7xAQPyiBMuCTvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=gsW3OLou; arc=fail smtp.client-ip=40.107.22.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="gsW3OLou"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cBCfXCmkKII9ChLYVH72EBVhI231mJGKQg7hYPTS4xMVIywIPXU+JGQeABdx6+uTBL9GTxbWenKLIRbF8zQyRL/bf+Qze2Un7dz1GOGySjVscZZ08cY+p5aCeq4R69wUlmZDJR3kwn91GQSIhkvE1XMQ/Y08Cx7yuQuNaC35DGKGC8bx5zOQClEXeZaI2W5jA+1PdzaoKpFBxaA2bFAou+ocTOpOAp8L8DICfcfRYkfkF0nkc+KjX9H9MwSounBHhfd3DFv1eVc4tHD4X+13vK7bjq0C4ezXTcRzW1Ks3fbmwWJ2YV9xvlbsZrpz+IxdMFwZJljqhoA5VC4UMnYc6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irn3rNWkXZ7vAtoIFT5jPXYP+q5EZwGid/1APvTPJlA=;
 b=cF2UNwSbuiY/Ncw3i7DI20LxaAuWlOhVnM04ThngwtD0ut5oxTota4dOanhWsHTfthpldFXy/4syyXJfIHsmhbv3vMHwNsDsK52UgjgtxEq1satGNMrUWo853CQPOo2m60ZsX5haYBki9GDaERQSjFMD+HM7cEZtQKPUqsyuSkWHgsqivK6xeED027SFaJ8cX+u7TCdg32jLY38z4qHi2g6gykaWw/94Zmw/ysWyreY/xQjdF029YSJ32HnRg4UcJHfY2H9Zn+OmH+HbCzHe+ViGC4ZBlhFS6dXx0C0q2ul5XzHxmcMcCXSdIX0gojM/rL7j7lyg8b+xW1ZONyG/EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irn3rNWkXZ7vAtoIFT5jPXYP+q5EZwGid/1APvTPJlA=;
 b=gsW3OLouGLqofRZuBoeuSbHC9i68IUVzYl4xkOdqXPDt0t7h4ZUdEPc30yrwdcYUIeWQt4Dl/Dqb42tjqX99VlbaD2Sy6QoK1fc3KMuXnc3cwrSSdlFNMQKDJfAw+4/ncGUObO9M4TLmf6ZZyc5ZMTA9RND31Vx9HQfWjUvLp0Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by PA2PR10MB8769.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 10:37:23 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%5]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 10:37:23 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>,  linux-kernel@vger.kernel.org,
  linux-kbuild@vger.kernel.org, git@vger.kernel.org
Subject: Re: [PATCH] setlocalversion: Add workaround for "git describe"
 performance issue
In-Reply-To: <309549cafdcfe50c4fceac3263220cc3d8b109b2.1730337435.git.jpoimboe@kernel.org>
	(Josh Poimboeuf's message of "Wed, 30 Oct 2024 18:20:21 -0700")
References: <309549cafdcfe50c4fceac3263220cc3d8b109b2.1730337435.git.jpoimboe@kernel.org>
Date: Thu, 31 Oct 2024 11:37:27 +0100
Message-ID: <87bjz0k17c.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0063.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::27) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|PA2PR10MB8769:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ac7a5b6-e243-46c8-f7d5-08dcf9980169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zQEAo/UxZ1GmlJgzad0nBBtpLAKzdUtVle0JuGEs7dYl4L2EzEPFC6bc56lD?=
 =?us-ascii?Q?MNC8sV+5Lgv2GgyWW0vMZBJYWlDZSBySrGAF3pMpadCIAbUmDh8h3HmLYmSL?=
 =?us-ascii?Q?JPSukYyvKrg0o/G0aEe0WFSfkdV3v5uFi6jy71c3eQ0OsISzX4nfTWlMLmpw?=
 =?us-ascii?Q?jAtyF4J3rXCTbAZ4nZ2o7d8H9XvRGzR+ipbkP35ZjHGTMXs7vEWxFxplQYBd?=
 =?us-ascii?Q?n3UbLfCMghdNDqRgThULUXjDP0iMDwVJ1ALVN5k06Gb801omhETXTh79w/9+?=
 =?us-ascii?Q?+w04kt4BiPi52IPwuRURrBFYOVdt+nlsGOdMCl/Nu66uqL9fdYetTeqgIsL/?=
 =?us-ascii?Q?CxgPlYsQOrOjhTc0ZE3SA2sUcSiwth/0Kh0lYKq8iDO5HqLxTl/UR/bP8BsU?=
 =?us-ascii?Q?ykEpx4z8wzk5pRCZrSvpSXXAcB2ExtqF99BC4Fm/N6OOMcUb4MtMSmtUyAzb?=
 =?us-ascii?Q?uvtW+xMHEODpqFJb4SEM1Fc1fGv27oof+zv2XAklwybrVOaVkxlEU9+Bp+dy?=
 =?us-ascii?Q?FtTOpSb7U4HkBntlkGr6nZkmJGKEUEnD9fTgvgWDiA3rTDRpJIWyEGU0v6Ne?=
 =?us-ascii?Q?mB2tXzSYh7ZcW7USm4I+bi2YCzPb1FlINHC3uebAqAPxWLJdmelB+rf/lb5F?=
 =?us-ascii?Q?3cg5iqX3V3m0/gtV/FzEvOsvDZlQC1PdMPZvASE85Ton34aFDuuczyFYJ05k?=
 =?us-ascii?Q?bJa2JdzWKfuQJnlyxO8aCENrBuEXWL+aH4vSxhEfMYzEc/HVVRyFIU/yKuQt?=
 =?us-ascii?Q?WKkRFvCKALSmDbGVF2L6A+8JGcQoKyIe3NkU7qqKlE5BBlEAtbelIXLiWdxO?=
 =?us-ascii?Q?A3ck9YjSv7Oob21KikA0/IPpZkr6umVlLBuQ8FKXlI6Tuw7Srm9nUAe3dNCC?=
 =?us-ascii?Q?HryA95fW339aObI+/n6EZgg2VHjfdBvRuFxrKpdLoJ1OmeVkgMiw5EBvOdNf?=
 =?us-ascii?Q?uw2kRrVh5D5+btJN80LcS8GtMPQB7vKRgYWnWjqQMHSewRGplj+jiFXPwI9x?=
 =?us-ascii?Q?oa5IniIX49iO3MrFWviHHjCeg55nDNSNg3S4NdZpAFgUpr5K1eOAnL5vYhn+?=
 =?us-ascii?Q?3zNO6CSZoZf+plyVg3teBa/L56YI1xt2M//QBloJ0d0LYUJQIm3jBbkWvof5?=
 =?us-ascii?Q?Ez1iFJJ3e7VaeZWK6CcKZNW68G37qXBPuORJuXZeILPNpCh11gFatOuRAj5f?=
 =?us-ascii?Q?dIEUvIUsqGbQyJzuDQl/Nu9ZFEvUmgO/EOEZNYiCSEwhMeveXBaf3Qd69jq3?=
 =?us-ascii?Q?4If+QphmQN/lmIwIhgr054VBTOpNDNWi/yiyzCYkhua1MQxKxJFI8+H/QB5v?=
 =?us-ascii?Q?afnyLHiNR/qSM1dsa1WvBkQ9NpE7kttmh4EF/BidULVHhsUNLSoC2X24+VPM?=
 =?us-ascii?Q?CRWoTl8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o1HpGaXHAx7oFHA8leaa7vu7dlI2hhgqqpSS1Wj1KxhN8WwPp6ZysDf2fXPi?=
 =?us-ascii?Q?yUNAd23jAysONNAHOYYqGkJ5qvttGnLw6wnNqwkLYnR/HMdjTDEKieQ+fR8m?=
 =?us-ascii?Q?5eVoGgjpDL5Oa2f9x/IApvBkzca4BOxIy/RXxz3k5mdP0ZkeqW2JYugwAOjx?=
 =?us-ascii?Q?2vo79TO4AEXGGleVMSCKwD1YITSA59jwroAZ+Ub0XFH3NK8kxQU/L+S0rncX?=
 =?us-ascii?Q?zoxvp65sTrrj0kBy8l9p7Tp64u6ZWmVKIQLZULui/JRf84xkOejjfVVBuK7m?=
 =?us-ascii?Q?bYgJ54QzF4+MeQpQ5+VcA0q24y+FHCLcos9kgzB/5GiPfakbvZFFPqJ1+g5X?=
 =?us-ascii?Q?vMhuhzUDmefklVkEAbFLgP7ZtLjulw7KX1GMvZAGPfE6AyeKKWVhNIcEcwjs?=
 =?us-ascii?Q?djyjopq1b/lkNPM4racJSy20v8YLi4R24bYZho2v5nNVd90uIA3GSgYtEPFN?=
 =?us-ascii?Q?FJBLA9TkAIjT46rcT9VWfAFx9tbARJltDy4THkDg+n0x2hKErvbRywhXvVb9?=
 =?us-ascii?Q?9meGWCessQLZeeU0qpuxGt0zCx+y9UF+fELGqUD0G5jZ3xBZIf3YjlDfTx+A?=
 =?us-ascii?Q?uUIH7j0MIcoNepTjNAaO65GAKqeLn53Q1DWJMIbk3hP9ILwxAulVwQFcBY4f?=
 =?us-ascii?Q?ra/ZagvYgG6mfmf9Mh1HGWjU5d21ItIxgcQyMOJ30nh0p+p4/C0vwpPw6nSK?=
 =?us-ascii?Q?Bg0U7eo1KuFd+IaRnuSOQ0QcfanEMZJFW34EC1/AOb8lmIiSmu5PcU5T3haH?=
 =?us-ascii?Q?wSZi+exi200HByzpAvKHTlJObnQyMQfETwksII8mAHlO3QDQrBG8HT7zAF/M?=
 =?us-ascii?Q?sxcakDRlzDXwi8MzlpzO6dNnHRpTZ3b3YHWO1Q9Qvxq6ESLJt+3l7MB6J0ZM?=
 =?us-ascii?Q?TvaqOn9eB5wI1pghJPdKGcWMss99o+oFaTojhRjIi922Mvts1tDwIl7bF6up?=
 =?us-ascii?Q?Rimn0NMr9egkKm2VwYwvNSr5fEu8zbhXe4S7J85yceY6QaYY48StSwyrmFQ2?=
 =?us-ascii?Q?dDEccUabmhCqF5l2YgXUEu++4Y3xKU9G1shqOISBwb/EdnNEHzAXFgDldJPM?=
 =?us-ascii?Q?DVBkmbvR6YFD5efFBpvfoV+75+2/gIGD0dJ6RpHg/fbSMi5Kb9PE/wrvvSp2?=
 =?us-ascii?Q?l94HewvP7Lr7F3a4eeQyAi2KtYqqJ03FBXsNPibp8rGcqw4kHX684aD3+xB4?=
 =?us-ascii?Q?mT6pAc8RiL4lJUewMV32KWNNoJJh1Uat/TJuwwNRO/Jw5lU2klFU4hD5hpPG?=
 =?us-ascii?Q?oBC8dNgCMsfCT5nP7wBBY2PIKc+qjCNH/INGLYST0UczUwnyloAis0eAtf0T?=
 =?us-ascii?Q?9I9SEDYIb6lvsOfouGfBVREPotC6FdFRlsVu8B/ukvEyj4yLsKEE45E/Ex3u?=
 =?us-ascii?Q?wmdvcGwsf/647GSjgxCPLEsZGk9LNPsP5xiZjsOmV1yaQUvx/tw9tVeaOKlf?=
 =?us-ascii?Q?cv8/yL7z/a5x52wXczioSJ1/bEjyJp8aewvyNpeAYzaxLW/TNyH0gUkK1wZW?=
 =?us-ascii?Q?PMN3hYdT0FzgfD5Vd8e/ld9HHeZ5bsuYcGIHiVbL1YyfKaGdeGEX5mo9COps?=
 =?us-ascii?Q?VTlODulMC9spniJrrzr/8yHAiVbdfT9UQR8HOqLVFFduAMdNTOtlTuLvS5pM?=
 =?us-ascii?Q?4Q=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac7a5b6-e243-46c8-f7d5-08dcf9980169
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 10:37:23.6005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ULuPWDJIEqSoCT7eR7UbWB28kP2VuUr9jClWz/kiFU94768cGffOKxaFoze33yeW/1uf34AvgM2CDabY28chjKFnRlWMaEVOT9KVh1Sv7sg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8769

On Wed, Oct 30 2024, Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> If HEAD isn't associated with an annotated tag, a bug (or feature?) in
> "git describe --match" causes it to search every commit in the entire
> repository looking for additional match candidates.  Instead of it
> taking a fraction of a second, it adds 10-15 seconds to the beginning of
> every kernel build.
>
> Fix it by adding an additional dummy match which is slightly further
> away from the most recent one, along with setting the max candidate
> count to 1 (not 2, apparently another bug).
>

cc += git list

Hm, I tried looking at the git describe source code, and while I can't
claim I understand it very well, I think the main problem is around
this part:

			if (!tags && !all && n->prio < 2) {
				unannotated_cnt++;
			} else if (match_cnt < max_candidates) {
				struct possible_tag *t = &all_matches[match_cnt++];
				t->name = n;
				t->depth = seen_commits - 1;
				t->flag_within = 1u << match_cnt;
				t->found_order = match_cnt;
				c->object.flags |= t->flag_within;
				if (n->prio == 2)
					annotated_cnt++;
			}
			else {
				gave_up_on = c;
				break;
			}

So in the case where one doesn't pass any --match, we get something like

git describe --debug 5f78aec0d7e9
describe 5f78aec0d7e9
No exact match on refs or tags, searching to describe
 annotated        243 v4.19-rc5
 annotated        485 v4.19-rc4
 annotated        814 v4.19-rc3
 annotated       1124 v4.19-rc2
 annotated       1391 v4.19-rc1
 annotated      10546 v4.18
 annotated      10611 v4.18-rc8
 annotated      10819 v4.18-rc7
 annotated      11029 v4.18-rc6
 annotated      11299 v4.18-rc5
traversed 11400 commits
more than 10 tags found; listed 10 most recent
gave up search at 1e4b044d22517cae7047c99038abb444423243ca
v4.19-rc5-243-g5f78aec0d7e9

and that "gave up" commit is v4.18-rc4, the eleventh commit
encountered. That also explains why you have to add a "dummy" second
--match to make --candidates=1 have the expected behaviour.

Perhaps the logic should instead be that as soon as match_cnt hits
max_candidates (i.e. all the tags we're going to consider have actually
been visited), we break out. That is, the last "else" above should
instead be replaced by

  if (match_cnt == max_candidates) {
    ... /* ? , gave_up_on is now a misnomer */
    break;
  }

Then as a further DWIM aid, wherever the initialization logic is could
be updated so that, after expanding all the --match= wildcards, if the
number of tags is less than max_candidates, automatically lower
max_candidates to that number (which in the setlocalversion case will
always be 1 because we're not actually passing a wildcard).

Or, we could explicitly on the kernel side pass that --candidates=1, but
yes, I agree it looks like a bug that the loop requires encountering +1
tag to hit that break;.

Rasmus
