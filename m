Received: from 2.mo560.mail-out.ovh.net (2.mo560.mail-out.ovh.net [188.165.53.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B51E14F138
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 07:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.53.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723448052; cv=none; b=tm/YHngEnrWg5s3tegwAHYX1OTX74Hm8kKHpZoQhdcB2N39AjRllqKCE25zaYk0GUiaPcHtJJxEvrzQXRdBAH5juupiYjXU5JD9/9+DcLCuQag4NOJj+pvj1yMJ+BCbs3+rEyEmKp4tQMAHpD1n3GuNauWHmGPBzBekqqA+b3Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723448052; c=relaxed/simple;
	bh=EyjjmdPPV9RTqavhpJQEC7NY4IeZeWbXT80LJiyS+ys=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=FQRfJyq2i2yB7QeJ2QrtwyXnjsjXN00egE/GCzqyXHd02RevRzdl18qH/C1QXJJqpRzxhnBc/omI74wcOMlJ+3NjVozLn00URspX1TjVy2pOEl4yz8sUiZqr2rbPFPCE5Q/iAKA9ufSddSk60liq229+wtD1RvRFKBghUOJHyIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=scantech.com; spf=pass smtp.mailfrom=scantech.com; arc=none smtp.client-ip=188.165.53.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=scantech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scantech.com
Received: from director3.ghost.mail-out.ovh.net (unknown [10.109.140.63])
	by mo560.mail-out.ovh.net (Postfix) with ESMTP id 4Wj48Q0FkFz1Tg2
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 06:18:30 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-vnnm9 (unknown [10.110.118.84])
	by director3.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 884211FE6E;
	Mon, 12 Aug 2024 06:18:29 +0000 (UTC)
Received: from scantech.com ([37.59.142.98])
	by ghost-submission-6684bf9d7b-vnnm9 with ESMTPSA
	id 8WyfHDWpuWbUEwAA5VxwUA
	(envelope-from <jean-noel.avila@scantech.com>); Mon, 12 Aug 2024 06:18:29 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-98R002f024f8e3-32e4-4785-923c-2d9b5c3dd8a6,
                    8E27908D858DFB8506F65EF87B9B1D6D6AE107E6) smtp.auth=jean-noel.avila@scantech.com
X-OVh-ClientIp:92.173.128.58
Content-Type: multipart/mixed; boundary="------------yZYIuLMp4HOwcxfPMDAhLbTC"
Message-ID: <71b427c1-55a3-4f61-bfcb-65f7fe1a02cd@scantech.com>
Date: Mon, 12 Aug 2024 08:18:28 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] doc: update the guidelines to reflect the current
 formatting rules
To: Eric Sunshine <sunshine@sunshineco.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?= <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.1766.v2.git.1721855179.gitgitgadget@gmail.com>
 <pull.1766.v3.git.1723389612.gitgitgadget@gmail.com>
 <92f3121cf4e719d1bd6f85e3af454a3ea7547930.1723389612.git.gitgitgadget@gmail.com>
 <CAPig+cSGeExca0d=o0jewFERTx30+EgR5HccTO_gOsKtnXxuwA@mail.gmail.com>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jean-noel.avila@scantech.com>
Content-Language: fr
In-Reply-To: <CAPig+cSGeExca0d=o0jewFERTx30+EgR5HccTO_gOsKtnXxuwA@mail.gmail.com>
X-Ovh-Tracer-Id: 12192651568032571131
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrleelgddutdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurheptgfkffggfgfuvfevfhfhjgesmhdtreertddvjeenucfhrhhomheplfgvrghnqdfpohotlhcutehvihhlrgcuoehjvggrnhdqnhhovghlrdgrvhhilhgrsehstggrnhhtvggthhdrtghomheqnecuggftrfgrthhtvghrnhepkedvueefvdeitedvfefgieekueeukedvkeffgedvhfegveekvedvudeuteduhfetnecukfhppeduvdejrddtrddtrddupdelvddrudejfedruddvkedrheekpdefjedrheelrddugedvrdelkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepjhgvrghnqdhnohgvlhdrrghvihhlrgesshgtrghnthgvtghhrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheeitddpmhhouggvpehsmhhtphhouhht

This is a multi-part message in MIME format.
--------------yZYIuLMp4HOwcxfPMDAhLbTC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 12/08/2024 à 01:56, Eric Sunshine a écrit :
> On Sun, Aug 11, 2024 at 11:20 AM Jean-Noël Avila via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
>> ---
>> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
>> @@ -746,70 +746,72 @@ Markup:
>>   When literal and placeholders are mixed, each markup is applied for
>> + each sub-entity. If the formatting is becoming too hairy, you can use the
>> + s:["foo"] formatting macro and let it format the groups for you.
>> +   `--jobs` _<n>_ or s:["--jobs <n>"]
>> +   s:["--sort=<key>
>> +   s:["<directory>/.git"]
>> +   s:["remote.<name>.mirror"]
>> +   s:["ssh://[<user>@]<host>[:<port>]/<path-to-git-repo>"]
>> +
>> +Note that the double-quotes are required by the macro.
> 
> The closing `"]` is missing from the --sort example. Is that intentional?

Not at all. Will fix it.

Thanks


--------------yZYIuLMp4HOwcxfPMDAhLbTC
Content-Type: text/vcard; charset=UTF-8; name="jean-noel_avila.vcf"
Content-Disposition: attachment; filename="jean-noel_avila.vcf"
Content-Transfer-Encoding: base64

YmVnaW46dmNhcmQNCmZuO3F1b3RlZC1wcmludGFibGU6SmVhbi1Obz1DMz1BQmwgQXZpbGEN
Cm47cXVvdGVkLXByaW50YWJsZTpBdmlsYTtKZWFuLU5vPUMzPUFCbA0Kb3JnOlNjYW50ZWNo
IFMuQS4NCmFkcjtxdW90ZWQtcHJpbnRhYmxlOlNhdm9pZSBUZWNobm9sYWMgQlAgMjQ0OztC
PUMzPUEydGltZW50IEFuZHJvbT1DMz1BOGRlIC0gMTA4IEF2ZW51ZSBkdSBMYWMgTD1DMz1B
OW1hbiA7IExBIE1PVFRFIFNFUlZPTEVYOzs3MzI5MDtGcmFuY2UNCmVtYWlsO2ludGVybmV0
OmplYW4tbm9lbC5hdmlsYUBzY2FudGVjaC5jb20NCnRpdGxlOkVtYmVkZGVkIHN5c3RlbXMg
bWFuYWdlcg0KdGVsO3dvcms6KzMzIDQ3OSAyNSA1NCA1MA0KdGVsO2NlbGw6KzMzIDYzMyAw
NCA2NCAxOA0KeC1tb3ppbGxhLWh0bWw6RkFMU0UNCnVybDpodHRwOi8vd3d3LnNjYW50ZWNo
LmNvbQ0KdmVyc2lvbjoyLjENCmVuZDp2Y2FyZA0KDQo=

--------------yZYIuLMp4HOwcxfPMDAhLbTC--
