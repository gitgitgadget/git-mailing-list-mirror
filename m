Received: from 7of9.schinagl.nl (7of9.schinagl.nl [185.238.129.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FCE15C8
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 09:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.238.129.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110909; cv=none; b=h/RuePTIOCJfhmdnviNHAvjR0+3P67MiHdIM2tn2HVOgmYHWxBGfKdRoiNkYfeOABmsdkRQ54fIENT+CoEgTKx43U6Iatd6btVuFlXbDjKAuMNLNbnL68GlveSs1g96qXyz8R55pgLZNVpJhpYod92NfVDq7XvxqRm8QYJw9JxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110909; c=relaxed/simple;
	bh=1+naE9xeUB5Y8/mChTG1mvp6h96n5NjY8fIkAKrqA+s=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=T6WXOqySkeH5iYM8jBm24+Y0ihkrhON5ptiXwxMLMeqbzEDSrfR73E0gyj3onpOV9n/FE0FAJrdKlCCLlaxpxGBx/IFw5anxTHydeLNBI++0PJjVSIXrScVziWDEugxYjgAk+fovVMzjUnKKPT0y/EUPRD8SsmJeKGt25LKJ6D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl; spf=pass smtp.mailfrom=schinagl.nl; dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b=Q09ehSe1; arc=none smtp.client-ip=185.238.129.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b="Q09ehSe1"
Received: from [10.2.12.77] (unknown [10.2.12.77])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by 7of9.schinagl.nl (Postfix) with ESMTPSA id 0C36019D2CF9
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 09:54:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
	t=1709110460; bh=1+naE9xeUB5Y8/mChTG1mvp6h96n5NjY8fIkAKrqA+s=;
	h=Date:To:From:Subject;
	b=Q09ehSe1O7RQe76N5qicg0yD1mNA94Bu2aKb1CPk7A2go+/Nn3pWpjtEtGdYPuw/o
	 szYzL79F2oJW145O16voSxlSMlPnBFuWGTwSQCK06yY9s6ou1/jMmZeg1Bh1/UJ01M
	 A55k78l/UnGYschsy1PjF0h02h3BvI8GSabFmkNM=
Message-ID: <a7be415d-5005-4fa7-9b2e-1974b7439a81@schinagl.nl>
Date: Wed, 28 Feb 2024 09:54:19 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: nl
From: Olliver Schinagl <oliver@schinagl.nl>
Subject: Allow setting diff.worddiff=color via gitconfig
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Currently, the only way to set `word-diff=color` is through alias. It 
would be much nicer of course if we could do


[diff]
     worddiff=color


in git-config of course.


Thank you,

Olliver

