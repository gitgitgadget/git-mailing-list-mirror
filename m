Received: from fallback13.i.mail.ru (fallback13.i.mail.ru [79.137.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C497D4176C
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 12:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710419790; cv=none; b=USejn83IMGQIfJP4R+n4h2pHc43oOT/aC8QPE/IanMXxed/OCSDGB3tdMfaxV5VyAW9kIisqCazZdy2CPjwTMCEn9cxhtjILeLfqv0LS1mCO8ujcLYvqk6iWvAQC00BbEcqjrvAUE5EJpS+bT4/h6ti+YM/SLUj/hwJ3+2lrXpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710419790; c=relaxed/simple;
	bh=0NA4RAzNn7JB/xVB5o1ZCAkTENnTxN7EZUFIBp8m3CY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFcTNRNsL17lgJTTU1WZko3/BeLlygPc7l79CjYPbV52Ogv2FFlbyj9kc3nJ6b1kLZ7wlEpP35olwmR5DmNFv7Or1/suIyEv9Ya0Igx6N0CpCQv3Ju+28qRJ9G0jzkk4zzNElHVe0Adb1AoouqqiJR0WRRzgPkI/7/VPmjo9eik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru; spf=pass smtp.mailfrom=bswap.ru; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=Jb0quSh+; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=1dexnoI3; arc=none smtp.client-ip=79.137.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bswap.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="Jb0quSh+";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="1dexnoI3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=QQbG8JgOizCQizW0m3u453IxDgoONhU8eJglv1Xx/ss=;
	t=1710419784;x=1710509784; 
	b=Jb0quSh+YePQPnoVUqI5760K9qRiNWuTUzctCsAAQw+z8yDvMkhAvzn3GcKcdceIaJwxpBMYEqb+iYZw+ETLs7evqZFPGzLSr2ygr0sy2PWMvwGCd/X5exyPqESDJyWEcMz0LlBFGDLI5t+ng+fjQsarJTXl5RfpLvj7T3Pr+IY=;
Received: from [10.12.4.17] (port=46752 helo=smtp46.i.mail.ru)
	by fallback13.i.mail.ru with esmtp (envelope-from <kostix@bswap.ru>)
	id 1rkjgG-002vN8-Jl
	for git@vger.kernel.org; Thu, 14 Mar 2024 14:55:28 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:To:From:Date:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=QQbG8JgOizCQizW0m3u453IxDgoONhU8eJglv1Xx/ss=; t=1710417328; x=1710507328; 
	b=1dexnoI3uBL8VuJxVvXCcES25S63XVedNEcOOcU2+vF6qZ3w2eAKrAulX59tXKuMj3uwuNe8QfR
	3kIDg0liHVuC/usJS/2Dv4QHYECXKrzMoRH/2IoC3pDPUOHDz6SJ9jGB7xbZMWUTg66p/n2AGmyXC
	54/d1cejrzRHBcl/WbU=;
Received: by smtp46.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
	id 1rkjg7-00000003UnM-24oJ
	for git@vger.kernel.org; Thu, 14 Mar 2024 14:55:20 +0300
Date: Thu, 14 Mar 2024 14:55:18 +0300
From: Konstantin Khomoutov <kostix@bswap.ru>
To: git@vger.kernel.org
Subject: Re: Graphical glitches in GUI client
Message-ID: <20240314115518.laue5pzqkwav7mt6@carbon>
Mail-Followup-To: git@vger.kernel.org
References: <CA+YBzKpJACd3NARYcRufDN_4Yq+CsA-rKx1_7uquZWRnihS6-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+YBzKpJACd3NARYcRufDN_4Yq+CsA-rKx1_7uquZWRnihS6-A@mail.gmail.com>
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD987C0EE6E7F0A597DDF776407DD463AED7AC1984F64828CE8182A05F538085040A34E61AF4E76B323A6D5EE0DB6E1EC8DD11F95E15C419FACED23FBFDBACB816C02697C06172A46EA
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE77E216A0E97507353EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006377E85B0EC44E8FD73EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38B73AB1701401CD8712DF9618482C63110A261A5D1E031FB8FB14F0253E1A950F4A471835C12D1D9774AD6D5ED66289B5278DA827A17800CE71AE4D56B06699BBC9FA2833FD35BB23D2EF20D2F80756B5F868A13BD56FB6657A471835C12D1D977725E5C173C3A84C317B107DEF921CE79117882F4460429728AD0CFFFB425014E868A13BD56FB6657D81D268191BDAD3DC09775C1D3CA48CFF7925326FBF3642CBA3038C0950A5D36C8A9BA7A39EFB766D91E3A1F190DE8FDBA3038C0950A5D36D5E8D9A59859A8B6E6B67F0F38050C1976E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C2249D52CD31C43BF465FE827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B608F55DA9FB1C18C0089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A5679CD90E43805FC05002B1117B3ED696572EAC60642EF14B72305013E4AE841E823CB91A9FED034534781492E4B8EEADC0A73878EBD0941BBDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D347215713CF3EEE9D13AB831A37A33609E6849930ED74F129F6C4CFB36F26C1280851C164F6333DD0F1D7E09C32AA3244C648E56B8381091ED921CC9A31F9C47818FB075A181FAB5FEEA455F16B58544A2C99F59F2F009F0963871D1C702CBDB0A9665A0FD7AD89E8F722DFA761B3F797A
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojXiTM5LlaqzLLWA8ReKDznA==
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD1383A12A4F11380E8BF601A8E04A89F3FFC7E93AA45440C3F9F8D1504C19F1C9C4F2F0A6AF357119A4D04176AAE5055CC72595A8557D9C981F4633CE835492D9647D182D770C8C7E642B4A721A3011E896F
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B485448333635D8AFAF2FD4A3C9FF394F53731507968CA6C83049FFFDB7839CE9E436D59F16A22D1104D5A83FF48C9EFAACF92505588B0064880604DDEAB56D8FE
X-7FA49CB5: 0D63561A33F958A53A5AF0F62DF0050C5982FC2B5B670AFE116B91C87A47C9578941B15DA834481FA18204E546F3947CD95D32202655EC45F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637B936CAE925EBC817389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C384C61F09AF66B0A435872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojXiTM5LlaqzJQeLrC7Px1lA==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

On Wed, Mar 13, 2024 at 12:06:03PM -0400, Nathan Yinger wrote:

[...]
> About 80% of the time the git gui client opens correctly. About 20% of the
> time I get a window covered in graphical glitches: parts of the window
> covered in flashing black rectangles, text missing or distorted. In rare
> cases the OS crashes as well (it's been a while since I saw the OS crash
> from this, I don't remember further details about the crash).
[...]
> The gui client was rendered unusable by graphical glitches.
[...]
> Fedora has Wayland enabled by default, though I'm not sure if the git gui
> client uses it directly or if there's some sort of X emulation involved.

git gui (and gitk) are written in Tcl and use the Tk GUI toolkit.
AFAIK, Tk does not yet have a Wayland backend, so git gui should rely on
XWayland [1].

I'm afraid, there's nothing Git devs could sensibly do to help with this
problem: it's not a bug in git gui; the problem most probably exists in
XWayland, or somewhere between XWayland and Wayland; it may be triggered
by certain patterns of how Tk uses the X11 protocol [2], and even there may
be an issue with the combination of all the stuff above and the graphic
card drivers.

So, I would suggest to explore two routes:

 - Try to solicit insights from the Tclers [3].

 - Try to search for similar problems in the Fedora issue tracker
   and also maybe ask questions using discussion venues dedicated to
   this distro.

Footnotes:

 1. There's an easy way to verify: start xkill and hover its cursor over
    a window of the app of interest: if it changes its shape to a
    characteristic cross, the window is not rendered by Wayland directly
    and uses the X11 protocol.

 2. Note that Tk is old, and it's unreasonable to expect it to use the X11
    protocol flat-out improperly.

  3. https://groups.google.com/g/comp.lang.tcl/
     This list is known to be frequented by the Tcl/Tk core devs.

