Received: from fallback2.i.mail.ru (fallback2.i.mail.ru [79.137.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C75E14287
	for <git@vger.kernel.org>; Sun,  4 Feb 2024 08:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707036961; cv=none; b=U8HiG1fvmbTlycpap/+t56aQeN6x9NK6PC5KwM5FwzF/OEcbz9VVd5hvpMk5JQxuWTUm8wOyA9kOCKSRFpc0ppXD6oXN6CmoHF1qas0XLUHx+lBiUCVNRJ1ZdRLtmRtWgq09KDS+vQ7xL/e3tdBx6KxkR10OOPRfDjNAgujZ76E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707036961; c=relaxed/simple;
	bh=+Kd3fzY0jeURw7YMNYm12EmbxqxP0tGltqx6A945TPQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAQgjJgB75DLvIhLcOdgptjCwoz8sIsQxj/dWZDas06JmN54fxf14ctF6KZI0HSVPJPF/THks4F4UyYmQQcQ4df89ggFqjpADCS/v2nouCcmgrAK8XikoOFtNOxJM91sny9l0QAIH003pkfrf7x2wIPtjfprunkjOFHz3BjrKTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru; spf=pass smtp.mailfrom=bswap.ru; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=aY9fV+1e; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=Gy2Za1mF; arc=none smtp.client-ip=79.137.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bswap.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="aY9fV+1e";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="Gy2Za1mF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=jTtFrAEeauXTGwmNZ5XO+THgVrQdhh35n4pn8uPB3yw=;
	t=1707036957;x=1707126957; 
	b=aY9fV+1e+zaDv8D6VNqFchHutvMM4Uo/wLZb6X15dOg9kYsbo7aEfnRYubWK2aOFfxL2ri3hMqcUPINUiEqRkGAkPh9Cr+ae5vFTbrzDs4igbcDB1+CZCVt4FmDy0ZgV/lMWoGcT+cwEujICkVJTbK5KphJucRU77OOQ7tGNVa8=;
Received: from [10.12.4.8] (port=41040 helo=smtp35.i.mail.ru)
	by fallback2.i.mail.ru with esmtp (envelope-from <kostix@bswap.ru>)
	id 1rWY6U-00G1jS-GT
	for git@vger.kernel.org; Sun, 04 Feb 2024 11:43:54 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:To:From:Date:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=jTtFrAEeauXTGwmNZ5XO+THgVrQdhh35n4pn8uPB3yw=; t=1707036234; x=1707126234; 
	b=Gy2Za1mFZxJ2fDEWQiuKGDt0LxZiiorIKZYJDEWxndrfF3+XxuzGX7ICkYLMDdUQaaNI2yX9GwL
	sSid/IgK6pghMmfSvwRNxwkWfpB4QrgjmY2R+0+joLUHcxYFtrVfNkd9r97qvuuqOjaSI5+7V/k0t
	rvr4OD72Z3M+IqvA7so=;
Received: by smtp35.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
	id 1rWY6L-00000007s5k-3EwT
	for git@vger.kernel.org; Sun, 04 Feb 2024 11:43:46 +0300
Date: Sun, 4 Feb 2024 11:43:44 +0300
From: Konstantin Khomoutov <kostix@bswap.ru>
To: git@vger.kernel.org
Subject: Re: git-users: email list has become spam-drowned
Message-ID: <20240204084344.jzu2ciulbrdmxz4u@carbon>
Mail-Followup-To: git@vger.kernel.org
References: <339f17e1-c6a0-4859-aa5b-481dd6e0e91b@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <339f17e1-c6a0-4859-aa5b-481dd6e0e91b@app.fastmail.com>
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD98F777A40C4FF710D92DA1B3EDC015650BFBEC09B36E621D0182A05F538085040F1F7F22266DBA0E191417EB218679B82B3D0F5258DD816F810B17D2A79D0E73A19F33B7625D3E01E
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE72F22E6DC541F75D9EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006376602C647E39EFA3A8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D857DD97A16AF41B73AE64702210EEF529B52C2F2BAB4B5593CC7F00164DA146DAFE8445B8C89999728AA50765F790063753733A85D94CE7A19FA2833FD35BB23D2EF20D2F80756B5F868A13BD56FB6657A471835C12D1D977725E5C173C3A84C3BEC81E4AEBD6D2BF117882F4460429728AD0CFFFB425014E868A13BD56FB6657D81D268191BDAD3DC09775C1D3CA48CF6D163D279239A33FBA3038C0950A5D36C8A9BA7A39EFB766D91E3A1F190DE8FDBA3038C0950A5D36D5E8D9A59859A8B654D2CCFAAAA4606976E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C22494854413538E1713FE827F84554CEF50127C277FBC8AE2E8B2EE5AD8F952D28FBAAAE862A0553A39223F8577A6DFFEA7CA54E1600D0FEB00543847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 0D63561A33F958A561E3DA538BC382B25002B1117B3ED696DFB44D0F3007F159484B8D70797403F6823CB91A9FED034534781492E4B8EEADA367EA73E0D98AADBDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D34951738D4D62E58A436137173FAB0316031B37C915D0666F08943ECD915C86C5FBF2067485F64B1901D7E09C32AA3244C2286940A948F487C0091A80DA37A96F31D21F0ADDBBF4711EA455F16B58544A2C99F59F2F009F0963871D1C702CBDB0A9665A0FD7AD89E8F722DFA761B3F797A
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojYmKAdD5iDVg5D4Ipf6XSiA==
X-Mailru-Sender: DBE5340C3C7EDD872C90EE14D77B612AE613694CEF380DDE582B80AE0CC324097E9E08A0E22E286A2145E1EA7D4D24712F0A6AF357119A4D04176AAE5055CC72595A8557D9C981F4633CE835492D9647D182D770C8C7E642B4A721A3011E896F
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4B4CD5912039A6B98C6861CD4CF7CF41478387C37446D548E68F3CF0E9FE49B69154319C46F023D7F53D2C552345D7E444E2AC94AB4995AAD455EE45224DD2451
X-7FA49CB5: 0D63561A33F958A5CD20908493E0283AF7EB2D6722E4423C15AAA7F213A25D198941B15DA834481FA18204E546F3947CD56D36E97F3F038CF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F79006370A2DD59B67EFEE27389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C37952320C71F5F86735872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojYmKAdD5iDVjybnjf91nQOw==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

On Sat, Feb 03, 2024 at 04:02:49PM +0100, Kristoffer Haugsbakk wrote:

> I know that this list has got nothing to do with git-scm (per se). But I
> was recommended by Dscho to raise the issue here.[1]
> 
> Maybe someone who happens to be affiliated with git-users happens to
> read this.

OK, I've posted to the Google Groups help center [2].
I do not expect this to produce any useful outcome but at least I've tried.
Please feel free to chime in on the issue to that thread.

 2. https://support.google.com/groups/thread/256971101

