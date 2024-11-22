Received: from smtp16.i.mail.ru (smtp16.i.mail.ru [95.163.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC47B1DDA34
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732269830; cv=none; b=H3sxcXCo8IObc2qbpFy5Z651HF7ceiTnDNcj/Tdrmm4bqZZ/SwDnP+YAytl1RP+af6sJGOWTLn/dcPhIePPxLkVYEmZdhcgfxAbhp8Moi3Fgm2o1AG2kTXKNbjwHw04E/6SNGS6kFD6OFivxEGP4DLRKBoNRWg89EC84lFTGpFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732269830; c=relaxed/simple;
	bh=ytEwQMa9wI+WhtFNP1aC2WxjRpP9p3bT+i8oNDpBlro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pV/WOi1QpUzuA4Jc8h/OX1oNjmyIPJgol6PuvxK35eDyOouhY5UJjQd8jMA+2FvTnpRMX+28pUcCvOait8ubJijMjyfmc4septo4pxxFWPmWrY0hdRxVTNfBii3Lu1vwVm1vBshHE9047NUReCmyD9WV1l4nT0iTKGf/NosqaXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru; spf=pass smtp.mailfrom=bswap.ru; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=Q/Ix3TNe; arc=none smtp.client-ip=95.163.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bswap.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="Q/Ix3TNe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=ytEwQMa9wI+WhtFNP1aC2WxjRpP9p3bT+i8oNDpBlro=; t=1732269825; x=1732359825; 
	b=Q/Ix3TNewgUXqIjnmilqKJtKSv9zfsrsmkPDhXYiFPYI7V2rL0fVgm33aJOqyDey3F8jOhzyl+x
	41CWWuetikbnp71s5mg4izcG1Q0/PHnUpdWYAUb+dw52g1guvVX7/21K1DAYzw6aLvLPiDzGVevBq
	6Kl8g8KNcrvX6GkCGSY=;
Received: by exim-smtp-77649746c4-mfn87 with esmtpa (envelope-from <kostix@bswap.ru>)
	id 1tEQVj-00000000IER-3KAt; Fri, 22 Nov 2024 13:03:36 +0300
Date: Fri, 22 Nov 2024 13:03:35 +0300
From: Konstantin Khomoutov <kostix@bswap.ru>
To: Luis Heredia <luis.heredia@tool.es>
Cc: git@vger.kernel.org
Subject: Re: Git problem in windows server
Message-ID: <20241122100335.jz2rku42x42fmgfd@carbon>
Mail-Followup-To: Luis Heredia <luis.heredia@tool.es>, git@vger.kernel.org
References: <e020539e-b66b-4d4d-80da-9f51d4b66683@tool.es>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e020539e-b66b-4d4d-80da-9f51d4b66683@tool.es>
Authentication-Results: exim-smtp-77649746c4-mfn87; auth=pass smtp.auth=kostix@bswap.ru smtp.mailfrom=kostix@bswap.ru
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD96786BF697653C0A3722A362934A6E2D9538D8D4029F99785182A05F5380850404C228DA9ACA6FE2787A69B94F488A4A63DE06ABAFEAF67055F562DA0B1284E9D7BFD93A96B792C416934EFD898326DC2
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE789066434B85BF7C7EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637F28F4AF03526AA8F8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D85CBA8A3C4F4B251EBAB8E81D721CB3473B660312CA5F3C5ACC7F00164DA146DAFE8445B8C89999728AA50765F7900637200F62B2C1E683AF389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC80A6B3CD6EB70C818117882F4460429728AD0CFFFB425014E868A13BD56FB6657D81D268191BDAD3DC09775C1D3CA48CFEAD86A1CE980672ABA3038C0950A5D36C8A9BA7A39EFB766D91E3A1F190DE8FDBA3038C0950A5D36D5E8D9A59859A8B643752FF16CD8C67A76E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C2249EC8D19AE6D49635B68655334FD4449CB9ECD01F8117BC8BEAAAE862A0553A39223F8577A6DFFEA7C789C969B8F27C422C4224003CC83647689D4C264860C145E
X-C1DE0DAB: 0D63561A33F958A57121CBC0BA2CF76D5002B1117B3ED696D43CCDAE010B100219AC5B239BAD4335823CB91A9FED034534781492E4B8EEADC3194D76C41E9723BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742424CF958EAFF5D571004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D34AEC7C2AC3C44791D0CD6DDDC84BEEA215A74524A58A95925995167F6F274DC5219EB3D6D468FB4421D7E09C32AA3244C51977B968676A44C77DD89D51EBB7742C80E8BA76A1CCA05EA455F16B58544A2E30DDF7C44BCB90D3871D1C702CBDB0A9665A0FD7AD89E8F722DFA761B3F797A
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojB5M2t/ETq/1m29mhJyldug==
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD138535DA70C3EDB7EC90841F56765D88C4005A9BF296F2F5EDBD7B12895863D0EAB2F0A6AF357119A4D04176AAE5055CC72595A8557D9C981F4633CE835492D9647D182D770C8C7E642B4A721A3011E896F
X-Mras: Ok

On Thu, Nov 21, 2024 at 11:24:42AM +0100, Luis Heredia wrote:

Cross-posted to the Git-for-Windows mailing list by the OP:
https://groups.google.com/g/git-for-windows/c/4DjhUXPF6t4/m/rEBsAtPYAQAJ

