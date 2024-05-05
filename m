Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A165CAC
	for <git@vger.kernel.org>; Sun,  5 May 2024 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714926574; cv=none; b=ZbjrU5gDW/zLEYkLAxsrOQk/F7lATPI+PnjzquZocVP1LFXwU3pL88rpOtfg1VJMtj430Fwv8QICbGqlHDhZXQKMMscpH49q5g+GEBMyaofJ/1f9JydiHUF8eZHZfd0otOtkLIOWeGg1H1M3z0umq6OeUFeBxfd7aGnSAMSlOrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714926574; c=relaxed/simple;
	bh=/TmTKaNNwnAGsv363PSM2cd29FBsuS4G1+peR2fsYuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pqekqV/z5XMCmAx8dXLUA5WaRYwHqSCLqVR1//8VgMjd2bMGu/wy0rIwH9EG0OpX8fzkVDG9qdLb65r3YFEYhek0LTi9+83oncJj9C8hbxallYUAtcquPDtsO2bsvaPKAQHZocmWUTIh02ONmjiuajtorUvlwoa/uLdHYjicRVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.104])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4VXTTJ5DdFz5tp1
	for <git@vger.kernel.org>; Sun,  5 May 2024 17:48:04 +0200 (CEST)
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4VXTT70gbQzRnmN;
	Sun,  5 May 2024 17:47:54 +0200 (CEST)
Message-ID: <44cfb9fc-2757-497c-a870-4186d00abbe1@kdbg.org>
Date: Sun, 5 May 2024 17:47:54 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_po=3A_fix_typo_in_French_=22aper=C3=A7u?=
 =?UTF-8?Q?=22?=
Content-Language: en-US
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?L=C3=A9onard_Michelet?=
 <leonard@lebasic.com>
References: <ZjVDhAvfrR8d_Hok@tapette.crustytoothpaste.net>
 <20240503201452.3355520-1-sandals@crustytoothpaste.net>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20240503201452.3355520-1-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 03.05.24 um 22:14 schrieb brian m. carlson:
> -msgstr "* Fichier binaire (pas d'apperçu du contenu)."
> +msgstr "* Fichier binaire (pas d'aperçu du contenu)."

Thanks! While queuing, I amended the subject line with the customary
'git-gui:' prefix.

It'll take a week or so until I've a public repository ready.

-- Hannes

