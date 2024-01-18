Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1CD288DC
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 15:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705592588; cv=none; b=KzAp6AacVM20eNxEBI2ndBnVWSG6iDY6pw7mVafRouZtIMJLKoYzXvAzIc5dm40RGiIiR4BGQOasJqlLMZq6XIB+iyPxFagI3EYhsk/BzySkfprJu8Rm1W4zTB1US0YwtHFdZPkliiypUwAcezqptLEAzf6D8f4VA5nj3NCsL8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705592588; c=relaxed/simple;
	bh=VBFOTAYxHkWfyXfmiLqdD/eJ1oQAZ0CWdr78FSxC4e0=;
	h=Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport; b=YxyO5SoVcXqPYnHAEteiKASczFL/96Obc1pACofJgh8+zTaTv4se5NLqWydNi324dD3j7inx0VkhIHOpvx3S44tmmqcue2/jqUXuExuYdZ7RZyNwWiADFH8GuMYY43p1FmC2MInju0J3Si0nouOFPvlxniaND5jyn0b+b1kgJeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=delpeuch.eu; spf=pass smtp.mailfrom=delpeuch.eu; arc=none smtp.client-ip=212.227.126.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=delpeuch.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delpeuch.eu
Received: from [192.168.178.189] ([93.206.14.11]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N8VkX-1r4L2L0QZF-014RAj; Thu, 18 Jan 2024 16:43:00 +0100
Message-ID: <e9ecb4c9-0854-4b8e-87a7-ba66b64b5b1a@delpeuch.eu>
Date: Thu, 18 Jan 2024 16:42:59 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] merge-ll: expose revision names to custom drivers
Content-Language: en-US
To: Kristoffer Haugsbakk <code@khaugsbakk.name>,
 Josh Soref <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.1648.git.git.1705587974840.gitgitgadget@gmail.com>
 <549875d6-b9a8-4b0d-8eaf-e12b72a20e16@app.fastmail.com>
From: Antonin Delpeuch <antonin@delpeuch.eu>
In-Reply-To: <549875d6-b9a8-4b0d-8eaf-e12b72a20e16@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:AhfELDK+8vAWBurcMtG6hj27vj2UgHjkP51089ygrPEPY3TN4Vg
 prLrEFIzPp48Ia0tAIAxJ2Am+Mw3PQasfXWK8WjoIBEjvn1FxBNKB3RjPcpPwuBw2QUbFlg
 qRcU03+PBjku5KkHRjmjp+6BWnYFUuQvbmnPBc9ATDVbDwRfyoBfJ+PELilZYigHCb1U/VP
 SmHL/KVJVOiDx4DsuKcZQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WiRntztaQWw=;p37FZXauhjECuNc66F3BDuUI2nh
 w9Ox+ZRGSRzgs5kzft+3oSbnr6val26uBYu1Z1xlSLKlpDdbKEptCPdDz3wO2S1VFO1Vq4aKs
 bMJozaAAu29L0sjSyXOn1wvHwKIPWWRS+auLvt1sVT2Hdj01Z018WvOUwUGlJ4EOU6Hq/doqK
 fjhGT25KBNT7Zl1nnfnawrldEEsmtjqXD3DSDfZFW5k5oMDGJkFi2gtFhp9/CUfUcc88kG+3/
 9duNyOLCHRRe+1k3C8QByb7Eg7b65Vm6WLyaclQ3SM4Kt5tgwJueN11s6OJvuK07Tr0ifUFqa
 kMZSerST/E+rGAYN63D4OLfI3q/gaapE1UEM9W2AwiPAd+a9na5ElJHfBaaTNU0TtsnRP8B0q
 eSZKB6NZXii9uxUgtcGTkvPJ/cTmdFULvgLdnCmCCPs/AGeN6vmbYU/JnZQg1YK8YPbzcqeZp
 Z8xy3RU4GRrNhW/IJgOheQjKNpohhMXyposhiPyZlDFE5Ri49xwgel3gQcH2LR+etlY9d+0Xr
 +bL6Lavtake5Xpe+Trg37/H9v6Yg4SyDcNavwU516OhmFEZyeGAcD9oqWpBi/FIaNjam+hYBB
 mHGTZUQ5vvOMzVW8k/Qr4D8/EJThE8UeOLq0qagpT11YXjVbuk/299U0wKucbCpGYwc05z/A2
 6dunZAKnsoZq4fvNeIzRTE1Q5VB/KtGrZVdcIWc7Fvv/YWAHmWMDbWD6XmQ5vr0it3qFKqMlo
 E3rzuJ3EdbXOeI8kFS2oF8+2IGqFgy/k/mcxZkfPH5zwFcYpGuRvv+a///DGxVG4+WY53G2Wp
 IQYdgOfHp/UE6mtsVabdWvM3ZhqA+kTCGpAEn8FDoPQhYgM1xhXJmD/F5Ea+DeRyxfc01rQWE
 E35GerCdPEgWTog==

On 18/01/2024 16:25, Kristoffer Haugsbakk wrote:
> This is gitgitgadget but `git send-email` would probably not pick up the
> CC here since it is not part of the trailer section (because there is a
> blank line between the CC line and the signed-off-by line). Maybe
> gitgitgadget works the same way. Also the space between `CC:` and the
> value is a no-break space but I don’t know if that matters.[1]

Thanks a lot for catching that! Let me fix and re-submit.

Antonin

