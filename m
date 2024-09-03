Received: from fallback2.i.mail.ru (fallback2.i.mail.ru [79.137.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3D718BC11
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725383101; cv=none; b=LcmCT7p9O2E8Rv9stZRvf4IWQygJu6pSBN9quJ7wknqKz1kSiMjJuCwz9LxRZWfPHx0qXdOoSqw9fxsAJGomAg6HFBcseNQ5UlZCJiUwyNovup/aq7yuex+eJTD5ouukpFmM/sgAB8TIROfL3gv8Oew1bGtLCHwtf8jTkoeNMaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725383101; c=relaxed/simple;
	bh=S1267MRsBcVexq99AGXUVmJdqEe/UGwO1WzDW7yR4n8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ip6Odnt1aTv9J9xYimrwXsXDpCzWZvrRD5y21FmDyDF4OrIe0PnjKbnvPPCxNebUUmyj9ztM1O60wJy6Kn5U3fIQksrGI5rMBR68ftt8EUr4ftX9obIuAJmMycS6yHrEuTWS+l4I2EGmDiEFX5iC4H1UYmFCVjZbzn28M6VeZCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru; spf=pass smtp.mailfrom=bswap.ru; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=pDkYQ/K4; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=SK1Z3ayx; arc=none smtp.client-ip=79.137.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bswap.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="pDkYQ/K4";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="SK1Z3ayx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
	h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=S1267MRsBcVexq99AGXUVmJdqEe/UGwO1WzDW7yR4n8=;
	t=1725383096;x=1725473096; 
	b=pDkYQ/K4MiIrerODB9fxzOyBmdic/gq0EvpZQEw5EUU0tRnl+upiV5Xq/ZNDWovFyn2uVwC2vQt0Fb2cBqrNHB2FDUNKxejfKGshUCL2wMzB/0fR8iY/fOn/aCnTk24ylxaqhMImRiqnvMrKPpLPqDdrmxO0bj3dozDKE43eZKA=;
Received: from [10.12.4.30] (port=44358 helo=smtp55.i.mail.ru)
	by fallback2.i.mail.ru with esmtp (envelope-from <kostix@bswap.ru>)
	id 1slWxU-002mw5-3r
	for git@vger.kernel.org; Tue, 03 Sep 2024 20:04:48 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:X-Cloud-Ids
	:Disposition-Notification-To; bh=S1267MRsBcVexq99AGXUVmJdqEe/UGwO1WzDW7yR4n8=
	; t=1725383088; x=1725473088; b=SK1Z3ayxn7OwKgYMwgCRohPQ6uhwDIiqJwc7gpgKmMuDi
	kH6kdYrhqBO5aSbU7u785ESng47/Nn4ntNv93yytCN0g4NAhGY6LXUjwBOxP1Fjp4YITCaSfHBSUo
	bniMuqWqjpXKEAxyxkTB8CNMfBHzJa6JospvrZvR0tQcUBdWg=;
Received: by smtp55.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
	id 1slWxL-0000000Epyb-0IsZ; Tue, 03 Sep 2024 20:04:39 +0300
Date: Tue, 3 Sep 2024 20:04:38 +0300
From: Konstantin Khomoutov <kostix@bswap.ru>
To: Loredana Tralli <loredana.tralli@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Ask for feature on git
Message-ID: <20240903170438.nhcnojx6upsxsj6d@carbon>
Mail-Followup-To: Loredana Tralli <loredana.tralli@gmail.com>,
	git@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEO06G+SLu-LAe0mkR3ZbaL0MZpBm9PhntQjF-YwVPMtnuH=rQ@mail.gmail.com>
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD90E1F90BB1B8DBC185E195D5CBF274B5E06F7ED9A7AE7FEED182A05F538085040D136FBD18365EEA503ED270C30F246C5808C3A02FCB96ADC1AE3731CF2AC1A905228A4F791792464
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7CE4525FFB91B9BBCEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063764345650F0BBEB0B8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8A59AD134455B818D3461217D149197BB5C5E43E81BAABA49CC7F00164DA146DAFE8445B8C89999728AA50765F7900637F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C92349F04B73BB8DAC0837EA9F3D197644AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C388C9C5DC8942283BBA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CFED8438A78DFE0A9E1DD303D21008E298D5E8D9A59859A8B6957A4DEDD2346B4275ECD9A6C639B01B78DA827A17800CE7B0AE13C0AA191EFD731C566533BA786AA5CC5B56E945C8DA
X-87b9d050: 1
X-C1DE0DAB: 0D63561A33F958A5B7CACCBE83C8A8165002B1117B3ED696B7EFC4FCFC48E6FA5D145BB8EF0DE66B823CB91A9FED034534781492E4B8EEADC0A73878EBD0941BBDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D340297C696F996E384294F4947FDA6715DA9DF413628F653DE52334890DB9D9FE736C72CC57870B9511D7E09C32AA3244CE2019D7E00F92E2CB58A6D757C7509E2B7F9181E97CCF4C8EA455F16B58544A2E30DDF7C44BCB90D3871D1C702CBDB0A9665A0FD7AD89E8F722DFA761B3F797A
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojbL9S8ysBdXi8TkMWnV0HOS1c45pcIjTM
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD13852CDE697486E4F83582B80AE0CC32409439BA50FD6B623BCA995754D068CDAB32F0A6AF357119A4D04176AAE5055CC72595A8557D9C981F4633CE835492D9647D182D770C8C7E642B4A721A3011E896F
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4FE2BD235D56E428B42AAA5DBDE56620017046C8F488A27D4049FFFDB7839CE9E299523B7492E8769B3EC2C4817DF3D2276BCFEFD6DF271DB4239A0AAD5A2F459
X-7FA49CB5: 0D63561A33F958A5C6470DD13B931DC3B32992656079ACFF7DDD7C4BC3157C158941B15DA834481FA18204E546F3947CDA7BFA4571439BB2F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F79006372255A60090D554F4389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C3D959F89D3055010035872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojpn6nlaCBY3Rw/jXuThqp2A==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

On 9/3/24 17:18, Loredana Tralli wrote:

> Is it possible to have a git command to find out which is the parent branch?

Please try to specify what you consider to be a "parent branch" in your
workflow. The problem is that there are multiple things in Git which may match
what you are asking for. Even better would be to try to explain your original
problem you're struggling with - which made you want the feature being
discussed.

Still, please consider that in Git, commits do not belong to any
branch: each commit has metadata but that metadata do not record the name of
the branch (if any!) which was checked out at the time the commit was created
(on someone's computer).

