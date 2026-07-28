Received: from send219.i.mail.ru (send219.i.mail.ru [95.163.59.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AB22DB78B
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.59.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785252861; cv=none; b=LTaO0uSLISumrKhvUxkru0yO6Kz2x+NUXByEpiVDksXsooxgQuo/tQVPdMmVMTBb6E74JqkT0mmJFZsskvml+5oDWbh5kOv6+gW/mc6NHSdftzp3mVzDNdg2XS68UKx0bX6pv9EUIkYVHV0U/lF5vOkFqjpJUWUKTKWAgobh3Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785252861; c=relaxed/simple;
	bh=1DTQEmoAmP3dgEKy5kbHWTafQC6FokQK7/inohmo5Gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Gs+QA/NK0v0IhccXespfWNw9LEJ3BdWoVuIxq/dULFrR7B2i/xnCbXoXQ97LILK2qZMy6IASLVK5W7p5CmQQP+0SLcfw9HjL518ggO/olc6/R+WY5xy7/ufGWn+s2mZq9yVVlHvspq/7L5wi2T8qUEsSbpihXim/dUqQAMoOyV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=NUTzwiHa; arc=none smtp.client-ip=95.163.59.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="NUTzwiHa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References
	:To:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=Ach7HfeCJdkys9U4EaBxTVWdcDKMPTFWAr9StPbDI68=; t=1785252857; x=1785342857; 
	b=NUTzwiHadY5rITk4ej/PQCNL/E6mz30vSEvTokVfTrT9TIM/WLjs4W0dbmNUki6xuD2hO2jRnks
	BxwXq0ihmcdvLAkz5eJwOBwU2j+fHnoB6LLmsWgC3SHiZh6Ufh9W5xOpH6KQ3WIa/Zc3RZoYrNmBR
	tveZAiZLYGdRhZClgYS3MZ3hkR5e4xtIOfNJkxkcY4MEOuu1eF08gPwBG12Cs9cY5BWRJ7DnD6lab
	ufxOKUmWssIXPgxMsBlHdxMcFglgwfN/6UHh6J+eO2hiXTdkETIKgjLYbH7zeIoHcfwUG1nhtB7MI
	DruPdN8fzl6+G/OUU3i++hCobi5OndDpFEqw==;
Received: by exim-smtp-6bc4cc657b-v7qcd with esmtpa (envelope-from <long76.git@mail.ru>)
	id 1wojol-00000000SL9-3oNU; Tue, 28 Jul 2026 18:34:08 +0300
Message-ID: <b19319a0-a248-4213-ab03-b1abb4a42744@mail.ru>
Date: Tue, 28 Jul 2026 18:34:07 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: REBASE_HEAD still exists after success end rebase
To: phillip.wood@dunelm.org.uk, Matt Hunter <m@lfurio.us>, git@vger.kernel.org
References: <edfc868b-6be6-4871-a539-e70791db216d@mail.ru>
 <DKA3RP12A8LU.2VD89MQ7G2KLL@lfurio.us>
 <92a69a99-c56f-4ec5-968f-436bef64ee48@gmail.com>
Content-Language: en-US
From: Long 76 <long76.git@mail.ru>
In-Reply-To: <92a69a99-c56f-4ec5-968f-436bef64ee48@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: exim-smtp-6bc4cc657b-v7qcd; auth=pass smtp.auth=long76.git@mail.ru smtp.mailfrom=long76.git@mail.ru
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD999EC7E29E32078B0D3237E42CA06847C04BCC942C35173F7182A05F538085040C6770728F940DC213DE06ABAFEAF670592DBBDFA39111859C9AE6BEE73B3A4F5BB3D1907BEA9FCEE
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE73B44982FA5E78411EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB553375666E0AFCC7CBCEC7C7A6E05C256B2EAFCC20F65A6F359C252BBA0413F8F7CF56D78EEF46B7454FC60B9742502CCDD46D0D6089696B24BB1D19F6B57BC7E64490618DEB871D839B73339E8FC8737B5C224908988D4D34163C9DCC7F00164DA146DAFE8445B8C89999729449624AB7ADAF37F6B57BC7E64490611E7FA7ABCAF51C92176DF2183F8FC7C0031F16FAD15614698941B15DA834481F9449624AB7ADAF37BA3038C0950A5D3613377AFFFEAFD269176DF2183F8FC7C07D08B698D69CD5617B076A6E789B0E97A8DF7F3B2552694AD5FFEEA1DED7F25D49FD398EE364050F9647ADFADE5905B11133410A2FE6C23AB3661434B16C20ACC84D3B47A649675FE827F84554CEF5019E625A9149C048EE9ECD01F8117BC8BEE2021AF6380DFAD18AA50765F790063735872C767BF85DA227C277FBC8AE2E8B79D6AC9746D9C56775ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-C1DE0DAB: 0D63561A33F958A5DA009CEEBBCDAB305002B1117B3ED696CA25AB057DB830C892212597CCBD6D77823CB91A9FED034534781492E4B8EEADD0953842B444AAC3BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE1918E10F71CB4DF9F9677DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D6593F525BA4340D9CFA60654693B694E1758EE1CC4897E01B278180AD3E4196013C0D6BF86EEF6C0AB9B8341EE9D5BE9A0AC580F43ADCD61A4B160821B20954A7D0BF6DB5A14D38762A6536EB022892E5344C41F94D744909CE06349EBF80BA53DC7F80F8B16B0B4F5BC3981EEBE9DB10F943082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVczkDsfooUjf+CWYgcj/nwg=
X-Mailru-Sender: FA56D3AF5E7ABC7464DC1CE9D819784E4E68FF6DEAC117923DE06ABAFEAF670592DBBDFA39111859B7CBEF92542CD7C86E6763FEFA0584FA91296853BA92DB573F2CD06A13C360CFE5A15ED4F09F547DA6B405093FCEE899451FCD79C64DC368C77752E0C033A69E3453F38A29522196
X-Mras: Ok

> The need for "--force" when pushing is due to you having rebased the 
> branch, it is unrelated to the existence of REBASE_HEAD (other than the 
> fact that it exists indicates you have rebased). Rebasing rewrites the 
> history which means that the remote cannot fast-forward when you push. 
> Rather than using "--force" I'd recommend "--force-with-lease --force- 
> if-includes" instead (see the "git push" man page for more details).

I know it, commit don't the same that was before rebase - because of the 
conflict, it had to be changed.


