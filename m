Received: from fallback21.i.mail.ru (fallback21.i.mail.ru [79.137.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60DA10958
	for <git@vger.kernel.org>; Sun,  4 Feb 2024 08:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707034435; cv=none; b=syLcz3jy26DZCJoP1aQWL3JgaqMGY6yR096/09l7YhGQcaIK29hrnwvNo0kKwzhsEzaERVEjtv+Ge8X8Ik+ib36YMS48t21E0/fyCOJXdLolull6uZ0b5WYXO2YiJTTPs2aatc7lgxH4pd4uFbFr0UDOm3jufDxufI/3yNIf8JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707034435; c=relaxed/simple;
	bh=br3KGPsfn0oPM0ETFQkP/ODQibYqnbCLw1Fdv09D9Zk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrUFVe0VwLWZk0evWiSnnV/KpTrmFICNh62SYqjfpcicjAGouhifnC2fbOUyKc5mJ4eYigpTrcRJojrYv+vkwGpwtW/ylYPMYJBikyi/s9bsd+6thTgdfTVLWLg6B76mNIcDjepet5yU4hcy9dc+/EtkgdRi0s9YSqwZhvFQLeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru; spf=pass smtp.mailfrom=bswap.ru; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=WJ/dtOQP; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=EjYjPgKr; arc=none smtp.client-ip=79.137.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bswap.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="WJ/dtOQP";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="EjYjPgKr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
	h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=h2slIBXmWY3rhSWRKJ9OVsI+duLQWVff9PnVHm6ENhc=;
	t=1707034429;x=1707124429; 
	b=WJ/dtOQPqxGQhyUsOO3s8tsHdTCsTzew9cZbkTWCRoCJdn1IOelQ8CBA3utKjpKE+aYxQAQCc9Ukfgl/OdErd7lJJgvcxyD1dTWVH+Em1bGkDbxRZGEYfps8st5dvScRM7vEYPRIaAJ07kq+uxGwyXz3l0voQDribp5BB1aDsI0=;
Received: from [10.12.4.23] (port=42202 helo=smtp49.i.mail.ru)
	by fallback21.i.mail.ru with esmtp (envelope-from <kostix@bswap.ru>)
	id 1rWXdE-008hxr-T3
	for git@vger.kernel.org; Sun, 04 Feb 2024 11:13:41 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:To:From:Date:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=h2slIBXmWY3rhSWRKJ9OVsI+duLQWVff9PnVHm6ENhc=; t=1707034420; x=1707124420; 
	b=EjYjPgKrQwauSu8WU0ETt39JOGQwyzd/WSoKa55f6R/nlMh69VWP+/E9I/xJ2PTYrjMmUY8toQE
	G73IYtzV7nHqC+QX+wTXvMUkFHxdFvq5N7sZx9AYDPJ5EYBiH+tTL8sFCHH1jaTEPPeyhbB3s2pOZ
	MPIePpvtndq16ReE5G8=;
Received: by smtp49.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
	id 1rWXd6-0000000B6Nd-0AiZ
	for git@vger.kernel.org; Sun, 04 Feb 2024 11:13:32 +0300
Date: Sun, 4 Feb 2024 11:13:32 +0300
From: Konstantin Khomoutov <kostix@bswap.ru>
To: git@vger.kernel.org
Subject: Re: git-users: email list has become spam-drowned
Message-ID: <20240204081332.aibexlc3bhvn5pmn@carbon>
Mail-Followup-To: git@vger.kernel.org
References: <339f17e1-c6a0-4859-aa5b-481dd6e0e91b@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <339f17e1-c6a0-4859-aa5b-481dd6e0e91b@app.fastmail.com>
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD98F777A40C4FF710D92DA1B3EDC015650593A6EF8FF1CABF7182A05F538085040C898F36289BA241833594132A326AF8B1E28FCE671E2C4617D056F67C26E434CC9EA4D883D9778ED
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7364F8074C6DFACE2C2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE7876E9C5582D2D91DEA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38B73AB1701401CD871279C5A118101C5631C00CEE5D2889B53AB07EE825D9864C1A471835C12D1D9774AD6D5ED66289B5278DA827A17800CE7D38CA8945C5827839FA2833FD35BB23D2EF20D2F80756B5F868A13BD56FB6657A471835C12D1D977725E5C173C3A84C3C24E78AA85F86F6C117882F4460429728AD0CFFFB425014E868A13BD56FB6657D81D268191BDAD3DC09775C1D3CA48CF856009BA58C5E1BBBA3038C0950A5D36C8A9BA7A39EFB766D91E3A1F190DE8FDBA3038C0950A5D36D5E8D9A59859A8B6EDF998CB16CCEE6976E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C2249AEEA5BB16A939343E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B68A0907C648FB30DE089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A50FAB2ACAB78032C65002B1117B3ED6962FA1DEE37C8BE5B35D145BB8EF0DE66B823CB91A9FED034534781492E4B8EEADFD59DAE6580CC3C3BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D340DAE5B306C240CF59D9E8650A7FF92740A51D4752BEBD99F421DFD70CB719972438D12D51189E4711D7E09C32AA3244CF9CA6C45531C34F77B0DC8E7D22A103A316EEDCC777823C5EA455F16B58544A2C99F59F2F009F0963871D1C702CBDB0A9665A0FD7AD89E8F722DFA761B3F797A
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojYmKAdD5iDVheDqa3KpDlGw==
X-Mailru-Sender: DBE5340C3C7EDD872C90EE14D77B612A74E953CDABFC344D5E07F309F87FFB14A579C8EE0687499F9E58066177F6FD9C2F0A6AF357119A4D04176AAE5055CC72595A8557D9C981F4633CE835492D9647D182D770C8C7E642B4A721A3011E896F
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4B4CD5912039A6B982F6B4A6936D4DF26F0A9C8DF7A2CBDA868F3CF0E9FE49B69E2E7F01AEB7A5103641E14A1A1DEAC94EFD8F5B27F15F660624A1BD6D111A23C
X-7FA49CB5: 0D63561A33F958A5173622A43B219AA2ADD528148091ECD02F1EA2C87ACBC4D08941B15DA834481FA18204E546F3947CA6C7FFFE744CA7FBF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F79006371FEB031537767747389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C3F6A27782D052760535872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-B7AD71C0: 6FEFE4C63DFE2D85718F43753FD9AD21390936EE2A242988633761F9DFDC81E966A7A1CC1E806CCD7B8A98F72AD7161D
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojYmKAdD5iDVjBZsvLgWpNOA==
X-Mailru-MI: 8001000000000800
X-Mras: Ok

On Sat, Feb 03, 2024 at 04:02:49PM +0100, Kristoffer Haugsbakk wrote:

> I know that this list has got nothing to do with git-scm (per se). But I
> was recommended by Dscho to raise the issue here.[1]
> 
> Maybe someone who happens to be affiliated with git-users happens to
> read this.
[...]
> I am not allowed to access it. Just as well because this is apparently
> what it looks like:
> https://www.mail-archive.com/git-users@googlegroups.com/
> 
> The last legitimate thread (except for an email saying “bye, this list
> is too spammy”) was 2023-12-29.

(I was one of the active (answering) folks on that list.)

Unfortunately, the sole owner appears to be AWOL long ago, and honestly I do
not think I have ever seen a sole message from them since I have subscribed to
that list (back in 2013 or even earlier). The list appears to be shut down by
Google - possibly due to the fact I and possibly some other folks dutifully
marked each SPAM message as such using the web interface.

I have searched by failed to find any way to contact any kind of "support"
to have the list unblocked. Unfortunately, so far it looks like a lost cause
to me.

This is sad because the group had tractable traffic - as opposed to, say,
[git] tag on StackOverflow which has no SPAM but is literally drowned in silly
questions so that its signal-to-noise ratio is too low to get interested to
follow. Still, there's a couple of knowledgeable folks following it - namely,
Torek and VonC, so you might have luck asking there, when needed.

