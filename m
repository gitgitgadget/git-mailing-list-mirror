Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9564C18B10
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 11:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="f3OETNNn";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="C7PROogS"
X-Greylist: delayed 3017 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 Oct 2023 04:01:28 PDT
Received: from fallback1.i.mail.ru (fallback1.i.mail.ru [79.137.243.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6832EFA
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 04:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
	h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=8oG15M1G0BnYfNozfbHkkwDFSto6fTM7ESaZZlKyefA=;
	t=1697713288;x=1697803288; 
	b=f3OETNNniWvp+JRvLfF1wRIXoPvlvNdcfOgAu2/yjZD6iQr5LwxD/BiU/Q6onWqqz93U2R9QOzSTf/xIgFEfM8wGrvXoMQUFXGu+ZD7GPKVv99dZI7h+Vb6aDOV5slKfUDGUjntOGLx7l7nSa8uYCJJYKOCkBDzdYUjAT46vUZY=;
Received: from [10.12.4.31] (port=33684 helo=smtp56.i.mail.ru)
	by fallback1.i.mail.ru with esmtp (envelope-from <kostix@bswap.ru>)
	id 1qtPzd-0017Ag-Ft
	for git@vger.kernel.org; Thu, 19 Oct 2023 13:11:05 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:To:From:Date:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=8oG15M1G0BnYfNozfbHkkwDFSto6fTM7ESaZZlKyefA=; t=1697710265; x=1697800265; 
	b=C7PROogSeRwlcixL8530pZxAF0L5K5iM2z08nexEctSNSAwOR2LesMSCNa+wliqEyDtNgcBzmvi
	um1rAF9Yc4kIgIrWMWDj5E/ZUbZ8eCgv4GoeRsGZK0dDAUsuDMRwyhaNpxoGtDoGRusGIyJ0kwvaU
	Q0jOOM6bYQafkCc5E0g=;
Received: by smtp56.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
	id 1qtPzX-0033Xg-1I
	for git@vger.kernel.org; Thu, 19 Oct 2023 13:10:59 +0300
Date: Thu, 19 Oct 2023 13:10:58 +0300
From: Konstantin Khomoutov <kostix@bswap.ru>
To: git@vger.kernel.org
Subject: Re: pygit2 claims repository does not exist on
 GIT_DIR_INVALID_OWNERSHIP
Message-ID: <20231019101058.oxu7o2jxq346zxha@carbon>
Mail-Followup-To: git@vger.kernel.org
References: <20231019093344.GS6241@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231019093344.GS6241@kitsune.suse.cz>
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD978AFEFB3096932CFF026BA05CDB6F6D46C5D78B698F2A6AC182A05F53808504030012A3F5416FDBBB2AD0564D0684B1A2E6A2915EE8FF357A491E648F4C17FDC
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE72267471453D8B600EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637188F5654332B449D8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D85184D369DFA323AA467D274E76686ECE117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC1F8789D36234D406A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F446042972877693876707352026055571C92BF10FF04B652EEC242312D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE0AC5B80A05675ACD9935A1E27F592749D8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE3F8BD4E506CFA3D88C0837EA9F3D19764C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947C6089696B24BB1D192E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89FB26E97DCB74E625257739F23D657EF2BB5C8C57E37DE458BEDA766A37F9254B7
X-87b9d050: 1
X-C1DE0DAB: 0D63561A33F958A5A585747A900ABAB81DCBDB2739B1A22E89DBBB0D4373EFA9F87CCE6106E1FC07E67D4AC08A07B9B06A1CB4668A9CA5FACB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D346B1FF97F6D0959A2EE69562EE226DF4378158A9509A9E86C7540595D862023B50A592FC48A3C72AC1D7E09C32AA3244C407D61601E19D173116E761C00B3FFA081560E2432555DBBBC4AF6B5DE6957CB5DA084F8E80FEBD3B644FBF139BB3089A015563ECF9503F943082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojI+3ahDCNcVbS49kpYUg4bw==
X-Mailru-Sender: 139A7956A63CACCF7216901AE3D43F143D054783240242AEF4BC9E9A4D23CF5F145D9C74A8399FCA2F0A6AF357119A4D04176AAE5055CC72595A8557D9C981F4633CE835492D9647D182D770C8C7E642B4A721A3011E896F
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B4DEDBBC46D76EB2520ED4F58DABF9B69510FDFA31A9459BA5049FFFDB7839CE9E7E8A997835E85111C57CB9C676A5619E3FB5B8B3B7B6BB45CFA259B71927A785
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFdVi+mls5yutriNtwWiTMGnA==
X-Mailru-MI: C000000000000800
X-Mras: Ok

On Thu, Oct 19, 2023 at 11:33:44AM +0200, Michal Suchánek wrote:

> after upgrade from git 2.26 to git 2.35 pygit would claim that my
> repository does not exist:
> 
> :~> git ls-remote /srv/git/kernel-source.git | head -n3
> 41037b9c54949ab7df9d32e8bc753c059b27c66c        HEAD
> 7a68c4c0c640ac07b89722271f866287b9047459        refs/heads/ALP-current
> 4993d1b0a96a0fa7fb0e87d3b1725bc775162283        refs/heads/ALP-current-RT
> :~> python3
> Python 3.6.15 (default, Sep 23 2021, 15:41:43) [GCC] on linux
> Type "help", "copyright", "credits" or "license" for more information.
> >>> import pygit2
> >>> pygit2.Repository("/srv/git/kernel-source.git")
> Traceback (most recent call last):
>   File "<stdin>", line 1, in <module>
>   File "/usr/lib64/python3.6/site-packages/pygit2/repository.py", line 1498, in __init__
>     path_backend = init_file_backend(path, flags)
> _pygit2.GitError: Repository not found at /srv/git/kernel-source.git
> >>> 
> 
> Could a reasonable diagnostic be provided?

It's a bit hard to ask what exactly you are after.

If you meant more diagnistics from Git, then I think they are in place, but
pygit2 does not display them (that is, it reads and possibly parses them
itself).

You can possibly run your Python code while having at least GIT_TRACE=1 in the
environment (see the output of `git help git` for the various environment
variables having the word "TRACE" in their names for ways to get more copious
outputs) and see whether you'll be able to get that trace printed - Git prints
which command it calls and with which arguments; you will then be able to call
them by hand and see exactly how they fail.

If you ask about better diagnistics in pygit2, then this question is
misdirected, I'm afraid, as pygit2 is not being developed using this mailing
list - ask in Discussions or issues tracker at [1] instead.

 1. https://github.com/libgit2/pygit2

