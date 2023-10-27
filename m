Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6DE1EB48
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 12:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="10aGnv5r"
X-Greylist: delayed 456 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 Oct 2023 05:37:37 PDT
Received: from smtp43.i.mail.ru (smtp43.i.mail.ru [95.163.41.66])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CA7FA
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 05:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:To:From:
	Date:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:X-Cloud-Ids
	:Disposition-Notification-To; bh=O0SpRcK20IRCej7OaEjsnHKIqCHg7xeXDMGjcaTbvh0=
	; t=1698410257; x=1698500257; b=10aGnv5re1rT6prh7huk555ZGWTy7qDvCo/G1M3BzNpGs
	uFiybhYiO0xqbhvhROwiZNyewBX+GXSehjhXz8IZW8LHYfvHDyYBypVHnoryrH0AwJR6T9dtZurQS
	VJAwPP3q5nkRoyGwFYCvayhdwSQ9k7oP9TwvcbYQqX0P4Vuwg=;
Received: by smtp43.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
	id 1qwM5n-001Ox9-0V
	for git@vger.kernel.org; Fri, 27 Oct 2023 15:37:35 +0300
Date: Fri, 27 Oct 2023 15:37:34 +0300
From: Konstantin Khomoutov <kostix@bswap.ru>
To: git@vger.kernel.org
Subject: Re: GFW fails with ST3 on Windows 11
Message-ID: <20231027123734.x4ziimecgj6isfsa@carbon>
Mail-Followup-To: git@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd248c66-fc71-4783-9195-02c8811744b8@app.fastmail.com>
Authentication-Results: smtp43.i.mail.ru; auth=pass smtp.auth=kostix@bswap.ru smtp.mailfrom=kostix@bswap.ru
X-Mailru-Src: smtp
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD9C931D0C4A91E7130A733B0074C8BDE7E63FE4C20E82C5CEB00894C459B0CD1B9AF8177B53E9029F9A7C7D1BC369376E0566B1CFE0B5DCA9015B839EAEBA98067
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7CA8E915ACC910FBDEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063750E64749F09C4ED58638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8A5422778ADE4BF523898253BFDB07321117882F4460429724CE54428C33FAD305F5C1EE8F4F765FCF80095D1E57F4578A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F4460429728776938767073520140C956E756FBB7AF04B652EEC242312D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EEB28585415E75ADA93DBBCB839D0549ACD8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE367F1C1C3ABB44F3A040F9FF01DFDA4A8C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947CB861051D4BA689FC2E808ACE2090B5E1725E5C173C3A84C317B107DEF921CE79089D37D7C0E48F6C8AA50765F79006373BC478629CBEC79DEFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A50B9145C1632A8236FE93C14C9A85993DD14640B0C5C926F4F87CCE6106E1FC07E67D4AC08A07B9B064E7220B7C550592CB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D348E5EF936B2E46EBA9E1C425E2044F95A5303B514120969342862A57733B76D18A7B60DE63B159E1A1D7E09C32AA3244CC91C0D27F551FDB5D6728AB17D95E8BDF2F5F14F68F1805BBC4AF6B5DE6957CB5DA084F8E80FEBD3B644FBF139BB3089A015563ECF9503F943082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojbL9S8ysBdXjvLO52BZK6m9J5V/JR7lb6
X-Mailru-Sender: 2765FF0E0CDDFF58F03FEFFD311CBBE89CD3DF36A56795F3BAF744416C57014BA45CECB847E7C5432F0A6AF357119A4D04176AAE5055CC72595A8557D9C981F4633CE835492D9647D182D770C8C7E642B4A721A3011E896F
X-Mras: Ok
X-Spam-Level: *

On Fri, Oct 27, 2023 at 03:29:58PM +0300, Konstantin Khomoutov wrote:

[...]
> Also please check the core.editor configuration setting - it might be set,
> and then you should try to modify it instead.
[...]

This means Git's configuration setting.

You might run

  git config --get-all --show-scope core.editor

in your shell to get the values of this setting printed, if set, prefixed with
the scope these values are defined in (see `git help config` or [1] for more
info).

 1. https://www.git-scm.com/docs/git-config

