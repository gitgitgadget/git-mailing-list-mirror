Received: from smtp.rcn.com (mail.rcn.syn-alias.com [129.213.13.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A83F4FA
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 09:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.213.13.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722937969; cv=none; b=B0o8jWhSuRaPNnGAM2AcJXM/qve0lGJAppzPRxwF/8OKrPX6lqWIl2BkqS99u3WH3jIZt9G629v1DlSt/iyHxTuE8G6tcFzfeDyD6+hslhN4iV0+FuX9MmTIvxTTM0hTe0WRpbsKP2eglK39vmuTktfTaP4leGlgvPEp/zWAXZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722937969; c=relaxed/simple;
	bh=o5oJVK0aD2WBhsRvscoSS69RezFME3geyAwl5+jF0zE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YXeNUc8TGX725+csbZLhHFL2bHYZeXE4WpCvmJk+6aoUPbzTB/JR0kIezuB9Si3uRopxfTcxrEuAjgxv4jQPfCDt1Ui7TKcsukkPgwBu6r8ka8HAZmKhfeT6Rd/ZRv0vz8D1dbNIWjS75XlSo2UBPrtbWItgGmHY6HuwRAehdHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scarborough.kim; spf=pass smtp.mailfrom=scarborough.kim; arc=none smtp.client-ip=129.213.13.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scarborough.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scarborough.kim
X-Authed-Username: Y2hvd2Jva0ByY24uY29t
Authentication-Results:  smtp02.rcn.email-ash1.sync.lan smtp.user=<hidden>; auth=pass (PLAIN)
Received: from [24.148.58.81] ([24.148.58.81:41652] helo=[172.22.22.107])
	by smtp.rcn.com (envelope-from <kim@scarborough.kim>)
	(ecelerity 4.4.1.20033 r(msys-ecelerity:tags/4.4.1.0^0)) with ESMTPSA (cipher=AES128-GCM-SHA256) 
	id 7F/93-00700-862F1B66; Tue, 06 Aug 2024 05:52:40 -0400
Message-ID: <97f1ca52-85b1-443d-a52c-67fce2e25f98@scarborough.kim>
Date: Tue, 6 Aug 2024 04:52:39 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git and gettext
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
References: <bf5a7771-f616-47d9-a014-f9d3e0afaa08@scarborough.kim>
 <Zq5UFYnWL1jdgDaH@tapette.crustytoothpaste.net>
 <7d507ea2-08e1-4597-bff8-8a2b40a01747@scarborough.kim>
 <Zq5qNwmTpL1H5LH0@tapette.crustytoothpaste.net>
 <1d6e0fef-9b9a-4239-aced-d20cd5c3434c@scarborough.kim>
 <20240805005311.GA66003@coredump.intra.peff.net>
Content-Language: en-US
From: Kim Scarborough <kim@scarborough.kim>
In-Reply-To: <20240805005311.GA66003@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Vade-Verdict: clean
X-Vade-Analysis-1: gggruggvucftvghtrhhoucdtuddrgeeftddrkeekgddukecutefuodetggdotefrodftvfcurfhrohhf
X-Vade-Analysis-2: ihhlvgemucfujgfpteevqfftpdftvefppdfgpfggqdftvefppdfqfgfvnecuuegrihhlohhuthemucef
X-Vade-Analysis-3: tddunecunecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefmihhm
X-Vade-Analysis-4: ucfutggrrhgsohhrohhughhhuceokhhimhesshgtrghrsghorhhouhhghhdrkhhimheqnecuggftrfgr
X-Vade-Analysis-5: thhtvghrnhephfffueelvdeghfevtdegvdffteeuveffteduudfhtedtffethffgvdejveelhfevnecu
X-Vade-Analysis-6: kfhppedvgedrudegkedrheekrdekudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhn
X-Vade-Analysis-7: vghtpedvgedrudegkedrheekrdekuddphhgvlhhopegludejvddrvddvrddvvddruddtjegnpdhmrghi
X-Vade-Analysis-8: lhhfrhhomhepkhhimhesshgtrghrsghorhhouhhghhdrkhhimhdprhgtphhtthhopehpvghffhesphgv
X-Vade-Analysis-9: fhhfrdhnvghtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhn
X-Vade-Analysis-10: vghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhhtrghhohhsthepshhm
X-Vade-Analysis-11: thhptddvrdhrtghnrdgvmhgrihhlqdgrshhhuddrshihnhgtrdhlrghnpdhnsggprhgtphhtthhopeef
X-Vade-Analysis-12: pdhishgpnhgrpehtrhhuvgdprghuthhhpghushgvrheptghhohifsghokh
X-Vade-Client: RCN

On 8/4/24 7:53 PM, Jeff King wrote:
> If we don't have msgfmt, I think git-gui invokes a custom script via
> tclsh. If you also don't have that, it will fail. Running with "make
> V=1" makes this more obvious, since it shows the fallback command name
> instead of "MSGFMT".
> 
> If you don't need git-gui at all, the simplest thing is to just run
> "make NO_GETTEXT=1 NO_TCLTK=1". That's what I do, and I have neither
> msgfmt nor gettext on my system.

That did it. Thanks!

Would it be possible to modify the configure script so that it checks 
for this stuff?

-- 
Kim Scarborough
