Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718B41EB4A
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 12:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="0QiVY4eD";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="MHau1V2M"
Received: from fallback3.i.mail.ru (fallback3.i.mail.ru [79.137.243.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3903C1A1
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 05:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
	h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=/BZLLiT48+MCvQLvUoO0Zwe8aPiNSmXA06VPeqDMU9k=;
	t=1698409804;x=1698499804; 
	b=0QiVY4eDlCTRjhL1X/faDKGB2iVO9lTjXBsxieovnDdFhqq2jFzsyh3zp47outGdbuRm4Ew66RQdvpLs+PxUL7zf3O5DmnG8rujYOduP5pcKJMHX8QrqhLjl51+K0+abLqxAj6g5QQTCAHHeqAWtVJmQsO3pVrzSng0aGDYEdnw=;
Received: from [10.12.4.20] (port=38158 helo=smtp44.i.mail.ru)
	by fallback3.i.mail.ru with esmtp (envelope-from <kostix@bswap.ru>)
	id 1qwLyT-008vr9-QI
	for git@vger.kernel.org; Fri, 27 Oct 2023 15:30:02 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:To:From:Date:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=/BZLLiT48+MCvQLvUoO0Zwe8aPiNSmXA06VPeqDMU9k=; t=1698409801; x=1698499801; 
	b=MHau1V2M6pIZDQEDc5nU4y/6yoyoKfaPONJmuf6/8hJLFd3C5y6slkY+dwlyvYzM8fKE2xWWiGD
	wHC7pCsFJXkClmg0LllJuyPGwnrCHapez3ZKqDHI7WcCjHOKm/3vZbZWJH6OeXpOb6p22y2uaUpJM
	2ll9E1PMAVyFAK9XZm0=;
Received: by smtp44.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
	id 1qwLyP-008URx-21
	for git@vger.kernel.org; Fri, 27 Oct 2023 15:29:58 +0300
Date: Fri, 27 Oct 2023 15:29:57 +0300
From: Konstantin Khomoutov <kostix@bswap.ru>
To: git@vger.kernel.org
Subject: Re: GFW fails with ST3 on Windows 11
Message-ID: <20231027122957.6mb6vyrqhnlwit6q@carbon>
Mail-Followup-To: git@vger.kernel.org
References: <cd248c66-fc71-4783-9195-02c8811744b8@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd248c66-fc71-4783-9195-02c8811744b8@app.fastmail.com>
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9C931D0C4A91E7130CD35F81D4A23E55E86190132D2C6D94300894C459B0CD1B9203818C17287BBE0D437EB8FD52CA21B50EC853053193E02E7694E8F3D0DC831
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE78E8764B5BC580342EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637F907CB39E8CA2E228638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D83A0991F03C23E3849B88C9DCD5DF06AA117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC1BE95B8C87527B4BA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F44604297287769387670735201E561CDFBCA1751FE5D25F19253116ADD2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE0AC5B80A05675ACD4782AAF36435267CD8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE3F8BD4E506CFA3D8803F1AB874ED89028C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947CB861051D4BA689FC2E808ACE2090B5E1725E5C173C3A84C317B107DEF921CE79089D37D7C0E48F6C8AA50765F7900637B8F435DEDE9E76EBEFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-87b9d050: 1
X-C1DE0DAB: 0D63561A33F958A5838074E5673B29BBB47AC39B92F8B79B9BB1E11B2305983AF87CCE6106E1FC07E67D4AC08A07B9B01DAA61796BF5227BCB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D341776B9FDE05FBA7A28A81C870854E1309BD0E89C969876B20644664935D2F64179A27F812FF202251D7E09C32AA3244C516AF8AD822235F68ABC14CE0610ADE733C9DC155518937FBC4AF6B5DE6957CB5DA084F8E80FEBD3B644FBF139BB3089A015563ECF9503F943082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojf8RueeX2DcsNldnxCKB4hg==
X-Mailru-Sender: 2765FF0E0CDDFF58F03FEFFD311CBBE8C3004FA2A8AD3C5912D8F4FB6E3078721752C749FAB18CA32F0A6AF357119A4D04176AAE5055CC72595A8557D9C981F4633CE835492D9647D182D770C8C7E642B4A721A3011E896F
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B4B09DFC738A27773C0AADAB31483B3DEE66B7C3446E6DE20E049FFFDB7839CE9E2955125F65856E4FE470A4A8EF72AFC0A7835E058F09D1FCB4CF5CCD496605AD
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFd/ps9sdOGr8guy/xkKgLg0Q==
X-Mailru-MI: C000000000000800
X-Mras: Ok

On Fri, Oct 27, 2023 at 02:31:32PM +0700, John wrote:

> I have been using Sublime Text 3 as the editor on Git for Windows for years,
> on Windows 10. I recently purchased a Windows 11 machine. On that machine,
> when I give GFW the following command, I get the response shown:
> 
> $ git commit -a
> […]
> hint: Waiting for your editor to close the file… C:\Program Files\Sublime Text 3\sublime_text.exe: C:Program: command not found
> error: There was a problem with the editor ‘C:\Program Files\Sublime Text 3\sublime_text.exe’.
> Please supply the message using either -m or -F option.
> 
> Does anyone know of a fix? To repeat, it’s only a problem on Windows 11.

What if you change the contents of the GIT_EDITOR (or EDITOR - whichever is
set) environment variable to contain forward slashes? That is, for the
pathname to read "C:/Program Files/..."?

If that does not work, what if you replace "C:/" with "/c/" - that is, for the
pathname to read "/c/Program files/..."?

Please note that depending on where this variable is set (in the "System"
block of setting or "User") you might need to reboot or relogin,
correspondingly in order for the setting to be applied to your environment.

Also please check the core.editor configuration setting - it might be set,
and then you should try to modify it instead [3].

While we're at it, such issues are better discussed on the dedicated mailing
list for GfW [1]. Also check the project's issue tracker [2].

 1. https://groups.google.com/g/git-for-windows/
 2. https://github.com/git-for-windows/git/issues/
 3. https://github.com/git-for-windows/git/issues/782

