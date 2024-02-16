Received: from fallback13.i.mail.ru (fallback13.i.mail.ru [79.137.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D256A7E784
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708090431; cv=none; b=jQ15093hDe4kLJsQrnDBwo4tIZ/uIYUg9GDoi0s5Lm743mSMLBlZCxaSEs25DZnhfNLAhoPVy7bcejVe6IXb1Fpa480iXez765zv7lsWh6u9HrdNXpBLijViPzO3WlnI+DJ1ygmpaEOgldI4V1qvzsz+Z2aPJMenLi5S0e561lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708090431; c=relaxed/simple;
	bh=H/WHqXdD+59dXhSTabQHU9/6Obzwr3OYfAyPwf25Gv8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lynbMLbpoo9M/Y3MdwG1uoLqabo0uMYL2o+AHOtLDkaPA4T7IrDGAFYAsv9fZ/OTaRRVPCAeFZxhiOv1hhy8zP9nMvhzmbdKyi3sNKQMLnKPJUpPWFZrS8RWNltYdRB/PrPvbgS/eNCtEpkA8Wo8GMchCgUb/pY2z6sLJ8BbqX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru; spf=pass smtp.mailfrom=bswap.ru; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=iUVVhKz8; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=i4ROUceJ; arc=none smtp.client-ip=79.137.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bswap.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="iUVVhKz8";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="i4ROUceJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
	h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=Zokz2RZVBt3818hCOXCjPTVoPFdmRJB5PyNV0PttkuU=;
	t=1708090426;x=1708180426; 
	b=iUVVhKz8GoywD0+MeTOSb6X7MeoKJ9F/XCUJKFFroEWipCyKIrBiMuLkPHVLg6XF4BwaHe5jPvMouou7Dz2ZXneptQsB5q2b5B1fWLJI2rZHd7fi024sGYil/xaayGxLOyK+hzrTUXLQXt86O9P2Crj4vtE3wUzD0FgcC+6Iom4=;
Received: from [10.12.4.7] (port=55432 helo=smtp33.i.mail.ru)
	by fallback13.i.mail.ru with esmtp (envelope-from <kostix@bswap.ru>)
	id 1raxlR-00GTtB-Ap
	for git@vger.kernel.org; Fri, 16 Feb 2024 15:56:25 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:To:From:
	Date:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:X-Cloud-Ids
	:Disposition-Notification-To; bh=Zokz2RZVBt3818hCOXCjPTVoPFdmRJB5PyNV0PttkuU=
	; t=1708088185; x=1708178185; b=i4ROUceJlH1T8tiXsPEbQvUl/R/fpplD6viFPzHYb/o7i
	drSlBk7Gs26UsQT6DqGMEVOFBCC17qwXnInF0ZMrJ97TijdwpbuvYxVYeG5larCotVsVdKyQ0w7rl
	6JMDzRUsQZd69PDa/lAMeJ8KDvEkC81eCeh62oNPXZGM8I4OA=;
Received: by smtp33.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
	id 1raxlI-0000000CMBi-2v0S
	for git@vger.kernel.org; Fri, 16 Feb 2024 15:56:17 +0300
Date: Fri, 16 Feb 2024 15:56:16 +0300
From: Konstantin Khomoutov <kostix@bswap.ru>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Hello question on Git for Windows 2.43.0 - GUID and/or SWID tag
 for this title
Message-ID: <20240216125616.l3iktxfx24vy4jax@carbon>
Mail-Followup-To: "git@vger.kernel.org" <git@vger.kernel.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV8PR13MB65609D60ACB8A6EADFBFE3459C4D2@LV8PR13MB6560.namprd13.prod.outlook.com>
 <20240216110041.dqz2n5dz43mqtq25@carbon>
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9001F8F2F6BAD20219683633117EC1F98F07CF5D5254C816200894C459B0CD1B9CBEF69BBE4C810E7AC22E6FD9DC6B25F5024619D25A89BB04FDFA55F5C77DE2EFA673BDF079014B0
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE74EC61905B8C6A847EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006376473F174BDE74BA48638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D897ACCB3E599DA4197A1F60DE6A731BE26CABD5174BCA2A89CC7F00164DA146DAFE8445B8C89999728AA50765F79006375FFD5C25497261569FA2833FD35BB23D2EF20D2F80756B5F868A13BD56FB6657A471835C12D1D977725E5C173C3A84C3E478A468B35FE767117882F4460429728AD0CFFFB425014E868A13BD56FB6657D81D268191BDAD3DC09775C1D3CA48CF71330ADC0232E4BBBA3038C0950A5D36C8A9BA7A39EFB766D91E3A1F190DE8FDBA3038C0950A5D36D5E8D9A59859A8B68AB5D335AEB894A776E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C22494854413538E1713FE827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B6E5DA268271FB0930089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A518A4651AE2287A515002B1117B3ED696A1EB0D3167EC22421E49B01306B5E3AD823CB91A9FED034534781492E4B8EEAD220496FFA5CD4785BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D34E318F287A436F24CBE21A00379E9A231C3FB466E44616612674D48B2F295FA478D44A74DB95064A11D7E09C32AA3244C1C6C855B936E517D4EB7DF677E51682D5FADF115EE605DF7EA455F16B58544A2C99F59F2F009F0963871D1C702CBDB0A9665A0FD7AD89E8F722DFA761B3F797A
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojQ9gr3ZFpXElqGEcNyXH7Sw==
X-Mailru-Sender: 7E479B994E4F3A2CB1CAA90EF936DBE2B67B3F8CF481B4DEB951B70A5BD4BD8EE4E76A64D75F2DF56A493BF296159046FD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64A0D4ABDE8C577C2ED
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B4A77971E4CF73965D9E271BDE2CCB4C0C1108A30EAE704D8D049FFFDB7839CE9E5B7912486C39222A34417E856A1E41ACBD28FB76B2A1CA8AD5FA1FD18C610307
X-7FA49CB5: 0D63561A33F958A59FCD993AF344D21A89AE3FB5A0D0C01C2A3EE00812EC32268941B15DA834481FA18204E546F3947CCF7CD7A0D5AA5F25F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F790063796D31E89718C7775389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C384C61F09AF66B0A435872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojQ9gr3ZFpXEmclJi+HoAl0Q==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

[...]
> Therefore, please let me know what your role is with Git for Windows so I
> can send this feedback accordingly and continue working on with our software
> inventory vendor on the issue.
[...]
> So, I would recommend to ask on GfW's Github Discussions [2] or on the
> GfW's dedicated mailing list [3].
[...]
>  2. https://github.com/git-for-windows/git/discussions
>  3. https://groups.google.com/g/git-for-windows/

To make things maybe a bit more clear: this very list our discussion is taking
place is dedicated to the development of the "core" Git, and Git-for-Windows
has started years ago as what one would call a continuous friendly fork of
Git. May changes implemented in GfW get upstreamed into the "core" Git,
but GfW still maintains a set of patches atop of Git, as well as a hefty
amount of infrastructure code (because in order to properly function under
Windows, Git requires lots of supporting software which presence is taken for
granted on Unix-like systems but does not normally exist on Windows).
Maintaining a Windows installer binary is also a task.

In other words, GfW has quite specific requirements to still be a separate,
though very close, project, and because of this is has its own separate
supporting infrastructure: a project and issue tracker on Github and its own
communication venues. These venues are what I and someone other earlier in
this discussion have pointed you at.

