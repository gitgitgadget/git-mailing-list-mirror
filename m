Received: from fallback20.i.mail.ru (fallback20.i.mail.ru [79.137.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BFD39FFE
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461767; cv=none; b=LrF/sWibJ0Tyl+V8Fe7F/CG92DMOiOhaw+Gu48ry68otinM2GqxMbnKu0qa+vJWYNpHhzq13662s5iKfC5Zm/bjzN0EaMk5HLJNX8Nyl+oAX3ggK6A0xlHH3sKxHKrtB8jsbqB86192+F1vrQvCTodWxuz93wRRQGbFMFDbG+HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461767; c=relaxed/simple;
	bh=qgMwX9etjv2d48rACetM/nnd0xuDv+ZafqWbVnJgOko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFqQ3A6JZA6+/J8sCv7Imt274mFxsHbhxdqaTzqe8XbydvLLgPWq0gFGyEIsv+KGHfP6N1Aa6WLdzVSAQoQOPIhzi0xSz28Da6UYbAbcy6rcbawlqFzT1nq5IwmZZvBpEi8uHSAh4BACrlWEwosqy1dkkPnDHCGi1u3fWDTGzjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru; spf=pass smtp.mailfrom=bswap.ru; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=QOY/l2XV; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=j6PRToSw; arc=none smtp.client-ip=79.137.243.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bswap.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="QOY/l2XV";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="j6PRToSw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=7+YQhJU1+W9ANEZ2aV+EMHHdfjQmWUxgj41hQmcxf6E=;
	t=1725461762;x=1725551762; 
	b=QOY/l2XVs1kBHShzlJ9T9OhnnWEhspjsbPCwbWbEm2rX3PSwt8eH/GCNtEM/NxOOUw+c7dwjbyGICxN58u7qGEuQzd3T4jkATpCImuINwSY5P3OS6LbRBzZ88H+xFhg/REZXPohv0rfZoZPzMGlDbmzGi64zQFvCIn+LgM8TJl0=;
Received: from [10.12.4.3] (port=52290 helo=smtp17.i.mail.ru)
	by fallback20.i.mail.ru with esmtp (envelope-from <kostix@bswap.ru>)
	id 1slrQH-008e2w-R6
	for git@vger.kernel.org; Wed, 04 Sep 2024 17:55:54 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=7+YQhJU1+W9ANEZ2aV+EMHHdfjQmWUxgj41hQmcxf6E=; t=1725461753; x=1725551753; 
	b=j6PRToSw8yeoPmwdI2STJ2j5Zkgay7MnlB/02GImm/dEy4WKbMH8Ud0a4oIcscQa5YYLzJErb8C
	UdCVAzYt3qlAbx9tQ1NijrDCqAtQr7R0iZWyJeNl2sFGQpwCw9CWbSTwsgY4xLPW0d0MtlMsdXv9Z
	s+EUtv1BhgK3K9bvLZk=;
Received: by smtp17.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
	id 1slrQ9-00000008YKp-22LZ; Wed, 04 Sep 2024 17:55:46 +0300
Date: Wed, 4 Sep 2024 17:55:44 +0300
From: Konstantin Khomoutov <kostix@bswap.ru>
To: Loredana Tralli <loredana.tralli@gmail.com>
Cc: Simon.Richter@hogyros.de, kostix@bswap.ru, git@vger.kernel.org
Subject: Re: Ask for feature on git
Message-ID: <20240904145544.xi7rez4hvbfcx57l@carbon>
Mail-Followup-To: Loredana Tralli <loredana.tralli@gmail.com>,
	Simon.Richter@hogyros.de, git@vger.kernel.org
References: <CAEO06G+SLu-LAe0mkR3ZbaL0MZpBm9PhntQjF-YwVPMtnuH=rQ@mail.gmail.com>
 <20240903170438.nhcnojx6upsxsj6d@carbon>
 <CAEO06GKzQTfm9z8ODCAYdHsWwgfHau0kuFA7WFkVqkPHbsm_1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEO06GKzQTfm9z8ODCAYdHsWwgfHau0kuFA7WFkVqkPHbsm_1g@mail.gmail.com>
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD978F4AA4899E1B8B51E781D7494DFB74F0B65F5AC5B6495CE182A05F5380850407C96613C052CA92FC7A4B249DE6549FD246E3D5D1498E467875BED0E2A18EBC5520E041967C72218
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7B9FBA884A7C9B8BAEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006371E8C7BD479B346ED8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D89819335FBB711EBE738A63906C8176C69748046D08F6B97ACC7F00164DA146DAFE8445B8C89999728AA50765F7900637F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C4AB4081B6A6C2E076E0066C2D8992A164AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C33A8A7B3B8A7BE898BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CFE478A468B35FE7671DD303D21008E298D5E8D9A59859A8B64854413538E1713F75ECD9A6C639B01B78DA827A17800CE76C76551EAF50E908731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A546FB79717C2BAF5F5002B1117B3ED696E1D2D97B9AAAFDEA5D145BB8EF0DE66B823CB91A9FED034534781492E4B8EEAD3CCD70CEBBF18A22BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742424CF958EAFF5D571004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D342F9EE325F82A28A88907BBECB94514725F614C8BAB5158FFC257E1949AB64593EB1A878B2489654C1D7E09C32AA3244C44638BD88653C6063BA3F8B02A6D222B611A6B0CB49CB107EA455F16B58544A21C197AAF4D2E47323871D1C702CBDB0A9665A0FD7AD89E8F722DFA761B3F797A
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojpeIfmLQPsULhVyH0ayWLJw==
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD138E2B2F2EEC811482CD77739F4E260083EA656FFC10733C159B090D92EA22FB7CE2F0A6AF357119A4D04176AAE5055CC72595A8557D9C981F4633CE835492D9647D182D770C8C7E642B4A721A3011E896F
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B48A282D85ADFEAA0C05EB29A623264147D1F0D7890546750B049FFFDB7839CE9E299523B7492E87690BF2654026665D9632CEC1E10F33056310335D4336CE76A6
X-7FA49CB5: 0D63561A33F958A52FA7CC9BF3A8C4E9493A9C535A584D4109B37CD81F458ECF8941B15DA834481FA18204E546F3947C4D3DDB508812D900F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637393CC20B86D473A4389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C31205B1F03D11AAAB35872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojpeIfmLQPsUJk51t7mmk3aQ==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

On Wed, Sep 04, 2024 at 03:59:33PM +0200, Loredana Tralli wrote:

[...]

> and I'd like to know if there is a command through bash to check
> directly "you created branch test from branch release".

This is quite possible: Git has a command, `git merge-base`, which can be used
to figure out the relation between two branches you're interested in.
In particular, a call

  $ git merge-base --fork-point test release

should print the SHA-1 name of the last commit both branches share with each
other (before their histories have diverged) and exits with status code 0.
Otherwise ("test" was not forked off "release") the command would print
nothing and exit with status code 1.

I would suggest to read [1] to get better understanding of what it does.

 1. https://www.git-scm.com/docs/git-merge-base

