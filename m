Received: from smtp.rcn.com (mail.rcn.syn-alias.com [129.213.13.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92464F9F5
	for <git@vger.kernel.org>; Sat,  3 Aug 2024 17:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.213.13.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722705887; cv=none; b=CTihd1WBPrpxre2d326pIHsY68p45nCMlfqVk1PIs0UyPlhz3y5i+/7Ycnq+S/MO1M57QYemlg5Dxx/RS6ZU0U2KbB8eYTYob9zfKTNt+UaG9p0zOrg3DvmFtOCFjze8ew5y8Axy0ygndib64DCs8jdIl0a1Nh/g7nmRdfSu7ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722705887; c=relaxed/simple;
	bh=EtpG7BAml7Yt3LGNUaoPtTzyIwndpnqYHiwhdSv0674=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dr7R4LcY1ruCl6Xzcw36lVGeSGu02oCUQ0IkJverfpSKywzH5E9N+x6+VlYwDut1gQRM9TXkp4TafxFcOAXkTmQJMlQwyqFPHv7ghV9euKzkrsyNzbQxedvLniOKiSjpgDh0Mkbsv1yj3lrpcbbVUGIvOhVaiM9fY1CaVCzggl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scarborough.kim; spf=pass smtp.mailfrom=scarborough.kim; arc=none smtp.client-ip=129.213.13.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scarborough.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scarborough.kim
X-Authed-Username: Y2hvd2Jva0ByY24uY29t
Authentication-Results:  smtp01.rcn.email-ash1.sync.lan smtp.user=<hidden>; auth=pass (PLAIN)
Received: from [24.148.58.81] ([24.148.58.81:58928] helo=[172.22.22.107])
	by smtp.rcn.com (envelope-from <kim@scarborough.kim>)
	(ecelerity 4.4.1.20033 r(msys-ecelerity:tags/4.4.1.0^0)) with ESMTPSA (cipher=AES128-GCM-SHA256) 
	id D9/34-20757-CD76EA66; Sat, 03 Aug 2024 13:24:44 -0400
Message-ID: <7d507ea2-08e1-4597-bff8-8a2b40a01747@scarborough.kim>
Date: Sat, 3 Aug 2024 12:24:43 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git and gettext
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
References: <bf5a7771-f616-47d9-a014-f9d3e0afaa08@scarborough.kim>
 <Zq5UFYnWL1jdgDaH@tapette.crustytoothpaste.net>
Content-Language: en-US
From: Kim Scarborough <kim@scarborough.kim>
In-Reply-To: <Zq5UFYnWL1jdgDaH@tapette.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Vade-Verdict: clean
X-Vade-Analysis-1: gggruggvucftvghtrhhoucdtuddrgeeftddrkedvgdduuddtucetufdoteggodetrfdotffvucfrrhho
X-Vade-Analysis-2: fhhilhgvmecuufgjpfetvefqtfdptfevpfdpgffpggdqtfevpfdpqfgfvfenuceurghilhhouhhtmecu
X-Vade-Analysis-3: fedtudenucenucfjughrpefkffggfgfuvfhfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefmihhm
X-Vade-Analysis-4: ucfutggrrhgsohhrohhughhhuceokhhimhesshgtrghrsghorhhouhhghhdrkhhimheqnecuggftrfgr
X-Vade-Analysis-5: thhtvghrnhepiedukefftdeuvdegjeduteehhfetffdvleehudehgeejteegudefhfejveevledtnecu
X-Vade-Analysis-6: kfhppedvgedrudegkedrheekrdekudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhn
X-Vade-Analysis-7: vghtpedvgedrudegkedrheekrdekuddphhgvlhhopegludejvddrvddvrddvvddruddtjegnpdhmrghi
X-Vade-Analysis-8: lhhfrhhomhepkhhimhesshgtrghrsghorhhouhhghhdrkhhimhdprhgtphhtthhopehsrghnuggrlhhs
X-Vade-Analysis-9: segtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
X-Vade-Analysis-10: rhhnvghlrdhorhhgpdhmthgrhhhoshhtpehsmhhtphdtuddrrhgtnhdrvghmrghilhdqrghshhdurdhs
X-Vade-Analysis-11: hihntgdrlhgrnhdpnhgspghrtghpthhtohepvddpihhspghnrgepthhruhgvpdgruhhthhgpuhhsvghr
X-Vade-Analysis-12: pegthhhofigsohhk
X-Vade-Client: RCN

> I believe you can use NO_GETTEXT=1 and NO_MSGFMT=1 (both must be set) to
> remove the need for gettext and msgfmt.  The latter can be omitted if
> you're not building git-gui.  You can see other configuration options at
> the top of the Makefile.

I tried setting both but it still errors out. A little later in the 
build, though.

-- 
Kim Scarborough
