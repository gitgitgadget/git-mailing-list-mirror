Received: from fallback20.i.mail.ru (fallback20.i.mail.ru [79.137.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5AA10961
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 11:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708082844; cv=none; b=i5Nah6p7boFgdg7FYusRp/W6oE+0jYsJvMMts85GotA2kHq03ajRlfPt0kiGoLxVDwpPUA1O3qpt+Y9FzASqCd55D29ZbYVtp97E00Z5lmOaILUhupCvVNOS+MkFp+wMCipGrdkRV4ATwcQnlH4DBLMKkuR7/f15Nb02OtsAVNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708082844; c=relaxed/simple;
	bh=v5/eDQ7LaVU/+K2xLZQNNnGmgSNrhI7ZwU8OwqeE2EY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfiV4grK/EuxlyfST1r32Do2x4jr6xxs8yBoiuf15ZaTfl97eOWfM2tMqaWkPtiVSn6bteDT+fQiHAmipB7eRl4DtJNcDQQlM/bPLsBEcNUG6whuhzGyu+10vUJ79RL8a8/3Z4a4sUdoHbAGlhXwzBLF1wy9xcpgX6yqYm6KE08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru; spf=pass smtp.mailfrom=bswap.ru; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=uOrgBM8l; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=gMzIgyeS; arc=none smtp.client-ip=79.137.243.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bswap.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="uOrgBM8l";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="gMzIgyeS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=6oVTrpdWGZdMx5L8smMtRepPRGczhrHwxtH8J6gknfU=;
	t=1708082839;x=1708172839; 
	b=uOrgBM8luR9qwjO6j+MHISP4dCS8pVXXKTgNGMxnEflrnOnoRvnnfRr5X3q55S8623Jh4UkytO+tPt3X3pa6WnfUHhfePEsRbGAiPRIQTx5Uv7pYIUVZGyuuzDA+oWwLs578Tt7duKR8JEV+ieo3uPYzMhITAnvoIYIbN4/klrs=;
Received: from [10.12.4.27] (port=49456 helo=smtp53.i.mail.ru)
	by fallback20.i.mail.ru with esmtp (envelope-from <kostix@bswap.ru>)
	id 1ravxb-00EoGJ-3R
	for git@vger.kernel.org; Fri, 16 Feb 2024 14:00:51 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:To:From:Date:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=6oVTrpdWGZdMx5L8smMtRepPRGczhrHwxtH8J6gknfU=; t=1708081251; x=1708171251; 
	b=gMzIgyeSmlpgxuNX7gglYH/629Ot65tadcH7eYQBBdZh88sy2esFgwfqi1s/20/kAVrePt8zaQr
	MavcMXT3rdUnyZOMDTXPTvZZMss2Yg2MPq0U5jmDlY7BFVk1PMehm8Z+pPgaRwqYHT3JNlrr7UXGz
	DcjRAVc7l1PDSio7mxk=;
Received: by smtp53.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
	id 1ravxR-0000000A5xU-3yUW
	for git@vger.kernel.org; Fri, 16 Feb 2024 14:00:42 +0300
Date: Fri, 16 Feb 2024 14:00:41 +0300
From: Konstantin Khomoutov <kostix@bswap.ru>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Hello question on Git for Windows 2.43.0 - GUID and/or SWID tag
 for this title
Message-ID: <20240216110041.dqz2n5dz43mqtq25@carbon>
Mail-Followup-To: "git@vger.kernel.org" <git@vger.kernel.org>
References: <LV8PR13MB6560538530A2A7D1C1FD89C19C422@LV8PR13MB6560.namprd13.prod.outlook.com>
 <DB9P250MB06926B4A6997EF6F866296ADA54A2@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
 <LV8PR13MB65609D60ACB8A6EADFBFE3459C4D2@LV8PR13MB6560.namprd13.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV8PR13MB65609D60ACB8A6EADFBFE3459C4D2@LV8PR13MB6560.namprd13.prod.outlook.com>
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9001F8F2F6BAD202195B11C64672D8A312E46D7C1128A3CAC00894C459B0CD1B94346F03013E83F8075D97F51FC3E644F8CD6EA8E1E89F231DF5E76619776C88FE2602FFE9E909B31
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE751DD1FEBB966604DEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637D24CDE3D695BBBC6EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38B73AB1701401CD8719C4D06E6317B7AF1F95C9EB490295DB10CEFB4565C927C09A471835C12D1D9774AD6D5ED66289B5278DA827A17800CE7820CF4CC0E318EFB9FA2833FD35BB23D2EF20D2F80756B5F868A13BD56FB6657A471835C12D1D977725E5C173C3A84C37EF884183F8E4D67117882F4460429728AD0CFFFB425014E868A13BD56FB6657D81D268191BDAD3DC09775C1D3CA48CF69BF13FED57427F176E601842F6C81A12EF20D2F80756B5FB606B96278B59C4276E601842F6C81A127C277FBC8AE2E8B4AFB60FD1831C04CD81D268191BDAD3D3666184CF4C3C14F3FC91FA280E0CE3D1A620F70A64A45A98AA50765F79006370669898C38A383F16D1867E19FE1407959CC434672EE6371089D37D7C0E48F6C8AA50765F79006372C56F9BC9525AE6AEFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-87b9d050: 1
X-C1DE0DAB: 0D63561A33F958A5AB37AB2628DA72795002B1117B3ED6961FF2D5764A2FA9101A1B8FE1FED62FE8823CB91A9FED034534781492E4B8EEAD37F46C620FF2CAEEBDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D345DE7771146E56B08874E755DA77A5D3786A7E2E7A520F7FA956AF7826526833C1EFBD4CEC0720A741D7E09C32AA3244CEA765100DF3D0342EBBA027F22CEDE666F816563FBE6E417EA455F16B58544A2C99F59F2F009F0963871D1C702CBDB0A9665A0FD7AD89E8F722DFA761B3F797A
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojQ9gr3ZFpXEn6R1l4s8Qxtw==
X-Mailru-Sender: 7E479B994E4F3A2CB1CAA90EF936DBE2951242422E222802B951B70A5BD4BD8E9F6AAB004853A3D046A0A24852759D85FD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64A0D4ABDE8C577C2ED
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4A77971E4CF73965D9E271BDE2CCB4C0C4F4C5A65B84543CD049FFFDB7839CE9E5B7912486C39222A7046DB6DDB342AD299CD6ADBCD4557E2D40475015A86A446
X-7FA49CB5: 0D63561A33F958A5D304385235AA1C64B9D8870020F8B04365BC126D80F7CC548941B15DA834481FA18204E546F3947CDA7BFA4571439BB2F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F79006372255A60090D554F4389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C384C61F09AF66B0A435872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojQ9gr3ZFpXEnL/RwwGig6OQ==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

On Thu, Feb 15, 2024 at 09:40:47PM +0000, Christian Castro wrote:

>>> I have a question on the GUID and/or SWID tag for Git for Windows 2.43.0.

> Question: Are you a Git for Windows developer, open-source contributor or?
> I ask because I will contact the manufacturer of our inventory product and
> provide them your feedback. But I'd like to know what your role is with Git
> for Windows for as of now I just have a reply from someone named Matthias
> from a live.de email domain. I hope you understand. Truly no offense meant
> on my part.
> 
> Therefore, please let me know what your role is with Git for Windows so I
> can send this feedback accordingly and continue working on with our software
> inventory vendor on the issue.

I would say the chief Git-for-Windows maintainer is Johannes Schindelin [1].
But prodding him directly would be impolite: after all, GfW is a F/OSS
project, so none of the folks participating in its development is oblidged to
answer any questions as them are not bound by terms of any contract with the
enterprise you're acting on behalf of - as no such contract exists (please
take no offence - I'm just clearing things up).

So, I would recommend to ask on GfW's Github Discussions [2] or on the
GfW's dedicated mailing list [3].

 1. https://github.com/dscho
 2. https://github.com/git-for-windows/git/discussions
 3. https://groups.google.com/g/git-for-windows/

