Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2054.outbound.protection.outlook.com [40.107.241.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56AA15A864;
	Fri,  1 Nov 2024 10:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730456588; cv=fail; b=TU79Tbuhre/pJkW8ltqsLeFZ8VcTz+ZE/+ApnHPCQHI2awGp2ovhKcIscRWCT56TRTIViwi+YZXJNBBf89s8X1B8Hgws5P5uyqpPTOReJJXP3YydwwRwfcT4jvH+/MZqWgTEUCDaJQqxjmQ3OyqlMBNXWyvE3ECMQBTT6AX0t2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730456588; c=relaxed/simple;
	bh=LjKkHpHSY52pjtoBc/nUwjF5ABdLAfkqMZdE2K78ZLw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=VZiLnT8vK+uwVT5g/5JkBSzfj3G5SBa0mk0pjyTWOpANI5dc/HsuP1QIWOYVa3DPYG/3fq+68GeMpXE5Y29TmFVdpTAWr4A1oFryhOzT4C0EHKkDouOF5enWEBePTaeKW88RuJplZF89ZXQf71R0LDC62VewcAWE5mKzqH7qkCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=dOdiFv6I; arc=fail smtp.client-ip=40.107.241.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="dOdiFv6I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a6UVQsb31AR+xq6IwAeeRB1ZxBtOA0KlVdIwiUKe2UaTp7S7h/9kGw32p0Oqp1J2wEx3IlyAFsEALkvQCeR+rLhuRjHnKtedTd79+ZuL9ex+RggqDnQc2MeCGlcA9U2qWupUrYt/VPidRbpLFEvFPYjDSfR7btde8i0pSQalGPiw/92hfJhEUlYeeZJy9t31n/pCRtsgssJI/4VPqwoovbbprxdCwc4i6X8vmNbC/WYX7ITLPFwXbTjyTP/Y5QNJxLpn8J6ZaAJ+sZzNLqAuVtvi6+/HTHNVoZI8/9UW9cDE9YV9GgPnFTHZUwMSM6NBGK9XKajYt+HEgWncE9DVvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCAedM2cUW/uWOSWokfoEARL5Py5bnXvQM+PqSHYdf0=;
 b=NjqjaeNAOZsRl7qBnWJ2nox/tVxwIEQU5dXwpSa09kJh7eBP4CfuRQyXnTyeO1RaN93VVWO/dnrUzod4pB7c/riCsG+bZv04jUcj+GTOgG64v3qmDOdDY24gk2SosLFIfwVT2MA1LBd538AQnjFz8fHZusGup8waeClY46rumuplIR2DdP4iDb3F3hBIYq+b28C0qO8GwqwSlxPr5ZbHDEQL1bF2bLYqeBumvOVYgq/CHdLU2jEvcZZCHhIg3xT8HIx98ZQDdIpEUYVI5Kr78nUWITbj3ZFfXSXxqOGbOq/KZOZkLG+M9feMFYzxJlq6pvJpyceiwPnzHdOgYPhWUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCAedM2cUW/uWOSWokfoEARL5Py5bnXvQM+PqSHYdf0=;
 b=dOdiFv6IocCpwa046j2eonkyQIxMRxz9Y06c2Erto/Lw0OgVps32jUABu+azwVPK261fTqwHUrXuilu/76OKAAQOqZxOdMrd7lO+U2XxAODwWrVfanK5fKiG0q+jWlIXK+hql5Fxsnv67WwcMgwztUSfZl49rFgUh8NnlvtZ2yw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DU4PR10MB8321.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:56b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 10:23:00 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%5]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 10:23:00 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Jeff King <peff@peff.net>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,  Masahiro Yamada
 <masahiroy@kernel.org>,  linux-kernel@vger.kernel.org,
  linux-kbuild@vger.kernel.org,  git@vger.kernel.org
Subject: Re: [PATCH] setlocalversion: Add workaround for "git describe"
 performance issue
In-Reply-To: <20241031122456.GB593548@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 31 Oct 2024 08:24:56 -0400")
References: <309549cafdcfe50c4fceac3263220cc3d8b109b2.1730337435.git.jpoimboe@kernel.org>
	<87bjz0k17c.fsf@prevas.dk>
	<20241031114210.GA593548@coredump.intra.peff.net>
	<20241031122456.GB593548@coredump.intra.peff.net>
Date: Fri, 01 Nov 2024 11:23:05 +0100
Message-ID: <8734kbjlrq.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0020.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::15) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DU4PR10MB8321:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fc7ad2d-ad65-46aa-a976-08dcfa5f2918
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZCPAcNAXnxf1+neoEGjXUehyCWFypqXXkPnWvxINXncjSNtLByQhkGf0ZCLh?=
 =?us-ascii?Q?7Zu0uIu1bD6cxAnyjELrJSjQ7mPDvDXsssmV3gkX2oNkj6srPwUKMdKiHTzQ?=
 =?us-ascii?Q?7BpqbklK6foBgYF5Kj7ju8e64DDAsNMLt9wOAEEyZ6KdpXjnrSrT2VEL14Q5?=
 =?us-ascii?Q?ko59yanEuheYxp6hjbI4aWQYrRLTJgnSzHDOj1HO2/p+vI3W6/ny+NgOAgbj?=
 =?us-ascii?Q?lTACwHX40XkYU+48afbpFHlyZqJ99edKbLkH1N+RovDLYYEzeqLsCxg+3Rnj?=
 =?us-ascii?Q?UYyzMnwpfMp3TgbIhPCymzi5b2CoX4RetZPDADyMccx6CkHOFmxoC2RJGTpC?=
 =?us-ascii?Q?miS2+tk3CTWV1mfCIYlk93kTKs0n39VJAm+/g6uascJybDLp/vVJecttYov2?=
 =?us-ascii?Q?GWAsSvfDdTib8+WcSB8B0jMWr0E+s8+djyJpMgNLi6B8sLfmRvoPxG+w5Anf?=
 =?us-ascii?Q?EWd1R7f0drqr1/1D6TXph7zg3Pxpotxy2lJA1+0Ez6qQ5OS6gGiPMfSKN0Pq?=
 =?us-ascii?Q?l8AH11Iz7cDV56PuQQvbz+lg4lmUveoy7+j5zuX1STvGc0onQEGHVM73r+gg?=
 =?us-ascii?Q?EIIf6g6nCpN0vOK77P7U9gP2gD+k5r0wXsx9RoZdnxFU/i+z9QF0y1RdTpeu?=
 =?us-ascii?Q?XsHBFUmkUSnIyp+xfJlh21QpN753Co3799gxA9GSwBmprQbYrnne6OwizenB?=
 =?us-ascii?Q?UYnfU90O4n4R3KRJ6s3Ngs3hMGlSpAAxX4VcrsaSLHLCbEXzJpqmFwQB/qaA?=
 =?us-ascii?Q?bbS7Rr9U61MaV4vtf/wI0dDytkllEObjEo3Ye2aLgtvKdiyKCJNXFrBnJhGz?=
 =?us-ascii?Q?WLXFxZ1Qsb0JRPcvPkKiQnLGeV6iHCu6luMJ+AKV1KqhcDLTDbsCG8Mdsl5L?=
 =?us-ascii?Q?oW4WodUE1AkC3o4cgt9cx60RdfG02irjUGmVlk7kqoZi8Qn+33uY3KlUG1ru?=
 =?us-ascii?Q?ebcSJUd5wsOYpFSxIvYjA+FOOBGAbzu2FdhqV3VyYguYgAgWydUYSENbxReM?=
 =?us-ascii?Q?PbsVA2GPYewtJ7MpGgx4ZCAAcYjSA6WRBNy3PIZfV0VA1ZsWZpDT9V/r7OD3?=
 =?us-ascii?Q?kBHKCm/8Xbp2mc7a40XXtDJNwotoZQWyx3m2GxymE50qyb8X0ZhdiJmom0II?=
 =?us-ascii?Q?+wQDvOcLLme2CDddSvX/Sj43clsNR++DvcKESZTR1jso2YI8OxFpQm2Aw3Ei?=
 =?us-ascii?Q?bz9e5JBc38gbHZeWdblSkXU390fLknXg8x8uxi13iQw4/3fSGvlPMGZiu6uJ?=
 =?us-ascii?Q?u8h7cZjbvX1fpOcEr7qeqcwrV5gW6cUc3Rif6FSWrW/KQ9sk85K19MEIu8fH?=
 =?us-ascii?Q?c1arnUHOWfQ7qvg1G5tSbi4UlWb7/0axXclFUQFW54JTnjGF1Y8Qeg0QFyiE?=
 =?us-ascii?Q?jxNrkgY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3zKRgTBnn3txwBLV5El48nFSK8OqyRE+cr4jJzIQZH49V5EQKtHbjUEY7ppR?=
 =?us-ascii?Q?f59UEiHkzMjxc5E/eHtgLqatH0tg/XhmHUsuMKMbkNuSzZ1j5DTh3IWPeQ+i?=
 =?us-ascii?Q?vR49ShXCFTLUSSZrRdEqFnpFwQu1oC45bbOGlM1YUMoU02C9MmJzIGfE68AL?=
 =?us-ascii?Q?NEeiy5KA1UnGk30xAHh6w06dDWmqYa3DMdqVnh40chO7IchgmSbVhF7zwDrF?=
 =?us-ascii?Q?a/7TjpykC9esZNH2MUnYMHsgW8WnLhwOVV9y/dRregNT0YRCqmMdDsphNeda?=
 =?us-ascii?Q?20ttkEH33dITsPuvQFjZl+x23DsXdpyIJixCI+dXVFuMEnjClwT7+V4ujOfu?=
 =?us-ascii?Q?FTnX9XZJCtlUnsZ5xenRLex068IoZsweG2k+DqMs3uGX7iU8eG10BFYro2mS?=
 =?us-ascii?Q?LwU4cq/uaeL7aL212LjfBsYoeG+1VomwUEfLP6K2kIP8UYaLZMLCZRGzD4zo?=
 =?us-ascii?Q?TVshG8XQ/j3Zm+dTu/lUwDP08adl5wPNKce0U9uGwoc4s7kK4CUF2qhEcGYC?=
 =?us-ascii?Q?HmwfmRtixu6lVyTFQXg/P+1E8WRsTz0f5DK2afqh6amdhb5xeHVeiwp3nVMV?=
 =?us-ascii?Q?CKgWFOuMStGQHvlTP6a3qOJLVAz3bImsmwIWk6d1XQFY6KpvwCp5v7rgh5v9?=
 =?us-ascii?Q?klTSJ6jBNxj2PvUSXbelxEu3ZfRwZoX6cKt9rokjzUdpr3ld9GAGDMjPNKV/?=
 =?us-ascii?Q?j0YxU47+PIvku8eCuNjGax3TLOqa6nIL18o1Ue9JmOg04y3Jv42UHxCg0EOs?=
 =?us-ascii?Q?INv/kBlksVuf6uonZFUT9Mxpk9MNXTYC8vTdZlTYPC5wvrxxBJ8a5WUm0nDn?=
 =?us-ascii?Q?ylpkx7obNq6JkSKI1EsnBkQhKoLQrPYdSk5ibPOr8avAN5fUSrkNQQh2UEk+?=
 =?us-ascii?Q?+8NoydztwGre75KU/Ydlll1gap/TOWYIKlPWt8nu2iz3GGjnjjdLW/uA9inu?=
 =?us-ascii?Q?bKdTNtM5yhIbWp//OrxzjtH3CulO6dtBm6kY9CzyFOKRpbSZTHJgXvYeHSe/?=
 =?us-ascii?Q?6VAVHbUo8VxKXObfzUyi1eSdb1zsn1IhpE8n8APSAaQGeQ5bNE0lGePBVq3/?=
 =?us-ascii?Q?hZe3y/3u0mr929nG1N00zGqlrlAC1oRD16QUhRIu3nVJAvNsk5+sYKJfVCCh?=
 =?us-ascii?Q?gya6Prb+dvFDv+TTIomzSoBV74ZWTUISlGlPIqeWiBvGb5+ICl3/YT3P/9w+?=
 =?us-ascii?Q?bRjIKKweHqy0L+EL5T6jWbsk2EqVjXkargDPQDrgR9bjfDd/k/UYNjPjUg7s?=
 =?us-ascii?Q?NiltVyOTqc1WF2iDFX7YaAAatj1jYvswCfwAgh81dampA3QtM81RS9nds0gX?=
 =?us-ascii?Q?5Lq3V4fA6jq3D6o1UAbZwC1RTPn3oGov4wQk/FpWOLQl8wwRn94X4NidsIV5?=
 =?us-ascii?Q?pzzFgd+M120khX+TFKYhZN4BG0Y7p0BQRQz4h9xfHcD9yh7s93VwbqNdxpyw?=
 =?us-ascii?Q?8JDgMFcmOhkEDZU3IJDsA154+qky7yMwgaS0TEIC612GanuslyEdLs7sfN18?=
 =?us-ascii?Q?GbgDhmXPkyCiElvtWSM2NXCxw83RVtciGryHYQux5otv2N7QonjjIV2fS0Ag?=
 =?us-ascii?Q?e4FZ6nuHhhwp+eb1EMOFQZqIV8Y49yU6PIDQuJnRGLFxWPncXNJp06SNbAZ0?=
 =?us-ascii?Q?qQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc7ad2d-ad65-46aa-a976-08dcfa5f2918
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 10:22:59.9632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wGaDzTQP8iDbqBenMiWk1lc5gdJidD5pfhmwSfAXG75R+hc765+cCshS3SCodnCMAntdu2pBRjmmlJDomP33QL350qbMMq3KnFxhRmyVxVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8321

On Thu, Oct 31 2024, Jeff King <peff@peff.net> wrote:

> On Thu, Oct 31, 2024 at 07:42:10AM -0400, Jeff King wrote:
>
>> That works, but I have a feeling that figured out what the heck is going
>> on with gave_up_on might produce a more elegant solution.
>
> OK, I think I might have made some sense of this.
>
> In finish_depth_computation(), we traverse down "list" forever, passing
> flags up to our parents, until we find a commit that is marked with the
> same "within" flag as our candidate. And then if everything left has
> that same "within" flag set, we can bail.
>
> So I _think_ the point is to basically count up what we'd get from this
> traversal:
>
>   $tag..$commit
>
> where "$tag" is the candidate tag we found, and "$commit" is what we're
> trying to describe (so imagine "git describe --match=$tag $commit").

Yeah, so this is really just what the setlocalversion script wants to
know. For a few diffent possible values of $tag (in most cases just 1),
we ask: Is $tag an annotated tag? Is it an ancestor of HEAD? And if so,
how many commits are in $tag..HEAD.

Perhaps we could on the kernel side replace the "git describe --match"
calls with a helper, something like this (needs a lot of polishing):

===
# Produce output similar to what "git describe --match=$tag 2>
# /dev/null" would.  It doesn't have to match exactly as the caller is
# only interested in whether $tag == HEAD, and if not, the number
# between the tag and the short sha1.
describe()
{
    # Is $tag an annotated tag? Could/should probably be written using
    # some plumbing instead of git describe, but with --exact-match,
    # we avoid the walk-to-the-start-of-history behaviour, so fine for
    # this demo.
    git describe --exact-match --match=$tag $tag >/dev/null 2>/dev/null || return 1

    # Can it be used to describe HEAD, i.e. is it an ancestor of HEAD?
    git merge-base --is-ancestor $tag HEAD || return 1

    # Find the number that "git describe" would append.
    count=$(git rev-list --count $tag..HEAD)
    if [ $count -eq 0 ] ; then
        echo "$tag"
    else
        echo "$tag-$count-$head"
    fi
}
===

But if we go this route, we should probably rework the logic
somewhat. There's no point getting the count ourselves, stuffing that
into a string, and then splitting that string with awk to %05d format
the count.

I also don't know if either the --is-ancestor or the rev-list count
could end up doing the same walk-all-commits we're trying to avoid.

Rasmus
