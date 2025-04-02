Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346F21EB9EB
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 19:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743622880; cv=none; b=Z5N83wUwQ1tQrEtmpwt4oMYhSEi3Dx7WYOoAj76aWjuXgziDvKdG4+mM828t8HGQNpIjq8spysgzNsTpV9SeuAKn26QmNx898woLkfu0BMJi05CONyMCgZhp8JtiIa76mp//OAY5YAyXFZD4Dh5eoaIQI5CE0/RRlPQr6CgIxnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743622880; c=relaxed/simple;
	bh=pPc2HzBGT1ih4BltaTdJyRFoNsT2zVm8Mfx8rHQh9ak=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=BxQHNrAJrb3zK2fo7NESXrBfifzQJRbcRkMRmAC6f4d2CyL1jMbfWBESPuP6NiaZM3pHQbxVYVS9Qzrykn8RkN++HfwLTHKIUhFlbj0ENliH7zQjEg2aYuTnhCKuGQnLVvd7I+39pgV6+OU8QxmWzM1eBjyOTjis1O/6DVJZ+sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=lYOuAmmy; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="lYOuAmmy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1743622875; x=1744227675;
	i=johannes.schindelin@gmx.de;
	bh=pPc2HzBGT1ih4BltaTdJyRFoNsT2zVm8Mfx8rHQh9ak=;
	h=X-UI-Sender-Class:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=lYOuAmmyFiTQyOSvLlEhy7+7B/Kadk08RMiIeMb6+Q4xEqkCGCL0DJ+AxSC7q2/Y
	 1AvbR9o+vI4EKegKgm/hile3z+dDb//0cBVT5HWQBM31xTO448e9ZUYLgcBobSxUq
	 RivD3RoN2dlB8NXeJJr3a8yOCg0W7/gYQ/xAG/MROmrntubaBlqH5BVX16h0XD86C
	 OfGdCK1S0MCIO1cLM3hy1hzlkY4bzjsslbmZz1zFbU8v8cHSCC+6KROdMXCn9mpBe
	 l2eqIcixlgbyiWyozV+N+Fj6UVmC2ow1vEApNXivdP85i+9uoha3zi1otwYmJGUnG
	 fv437uu/Lm0DMjtSkA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.156]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxUnp-1tB77y0gLR-00vjhO for
 <git@vger.kernel.org>; Wed, 02 Apr 2025 21:41:15 +0200
Date: Wed, 2 Apr 2025 21:41:14 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
Subject: Let's celebrate Git's 20th anniversary this coming Monday!
Message-ID: <89757bec-4d7e-1d90-5697-44651c6128df@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+tw1oLC32WaI0blTH6rK8BMdnzg9Z/b1Vy5r/zDrmTuFBOA4kFr
 0wN1RXYwWOvh9rMcYgRddRnVKBGNwPwQBPBRmsGJ0f0ieDDbdINrBAdChwn24Bizg1FFzJA
 cHrkzmfA4iO9lUYwuyR7E+w9M/v1r5B88eVVE4+9W5vErcuJMa33nYEo+BbDtB28F3eBNM9
 Yr/qUal5jbmlfemlMhlHw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Yp919/oEwkg=;WMaQH4UgPZFjJCnRvGKcDXBTDlE
 Kdozu2seKK3jCYu3AReyWveHy9vbzs5iY289WMaCgXHchpwCVVmi8fzOKJzZPcxk2GyeiD32k
 2oK3cSp5tCYf6KxlNgIY8QeLgX547IlHnRhoj3DGUWLGG6AAJxml3HrMvtqLrIAwJ3FDptKRO
 qkwhjd4COJoc1HwZX83bBYtcc6+zt8pxPbfET/xhEpmvlP37F+dQhGXN8ICiW3+aqGjidn8yM
 90iFipewZrgCTn8ANfgIol5keYX0wFYFTydhtyQLlaTUITWSYUouhiKNffElvMUnwnWiRBFQ2
 qOCuZ+ZkBZZzD890hZ4AY9syej3IGWoXMB9xEE3gWrAeA+qGqvM0vxwG6XNPEIQhHxRvRfLWW
 mtv/50T0vGw/EWjA6SYK+nY55CiGyOEnaITzOJEq34bGfZJ7Cb5P4HX+U1w0eOOww3gxcnC1e
 ajUuQPdN1Bhl98RfOOVCMB6eDXCqtpH9tZQfvkIIdp4XLDckkrulFPpu4jiOYevxJWI8Ri/mz
 Xfisum5wxmY3iObUm9hlEjfdA0KeTXbwurSBRdQIRy3BQNsWBKz9lZ5g/AvRpnjITEwP/dwU3
 AOYH+G1dEVNBIsMNd+R+iYrDc6ANKG5A0pgJS7TAs4/cKCAP2cnkGDqOEJGXVqX3RPhP91Gfk
 aWNI+FvhLzUShbnwGxN+2cTQFxieg8rmy7E0NFQpPIzZSXDLYm5zaDk+Txip/MtvfyUgXs1rE
 bCAMQljx9HGzUFi5UYVrtyird/WhNXN1fryFQqUX9xRg7E+t1B4rpbLEM59+7pjMYG8oqUKwf
 iyzEH+eLQrt7aiV5CNxl7DupSlmJQ3UsvB/6bNmWyYY5csJZiT7hLSpE9IIXjq+jkMwbMUz2Z
 +JxMueaKklAj0TgdD5YQMPo/Dy1iLhdZOagfFjkJqyM8TRI0bfk+fQikXEsdwR8Cp2HPQmOn/
 aJSyjQGSWYx76QQDN6RaXCmwMzevpUx03B2XGCWW4mpicwvzntA/ZyrOnpqe95SdfFROi7Uaa
 v74mBwTZ4F63CNhH2t6WsRgwv7+mI6F/+pwueX/x1f7Hv4hnYzDjUyhOSvEplQX2m1Li4STOo
 wp+OP/RQhHufqU3YVC4qR3HYzp9d3hI4/a7Otwu3zkWGxPzF6wJyDRJtJOSbW4MaII41nah0G
 kQnNOa52Vd9v1WCTPyk01CZUwK4o3airrVdlzNXPjJITV/mLvIuYgZxCtogja1MpOLGdQc6K6
 31rtx2OmudGc/g41ptEDaz8bmsnbtJg//qrzkht9dU1pGQb7Mtjuv2lZi5GZd5CDmrKPNnmq0
 7VpdMbPKH7v8x9OGKOpc/XHxEgkk17Vea4NtxaZHrWgvWHQkdmY3fJ57zqOIZDbKu3GGI/gfN
 cnhtirSoK3LffkzRPNfKEHeokC4KygEjk8et0Q5XrrU5nYMVKNC1+KCMqAKHJJRT1WkC9Ljfz
 XDJaUOmCVihfBceCAxgsEfQHoVaiRCjEZMe7OyIq7Cqee6qyQq7OOyKe8hqdpAZQULIV+2opd
 rUPUECsdro+p6qu02OO6+NnqrM4gT0VH/f77PY9/

Hi all,

according to my research, the oldest Git commit, the one that started
Git's own collaborative development, was performed on April 7th, 2005.
This coming Monday, therefore, is the 20th anniversary of Git!

I thought it would be cool and fun to have a place where Git users and
contributors could celebrate this by sharing their most fun (or
interesting, or scary!) Git stories.

To that end, I created a channel on Git's Discord, called
`#20th-anniversary`: https://discord.gg/UcjvsNQR

Please feel warmly welcome to drop in and tell the rest of us about your
most hilarious encounter with Git!

(Kindly note that if you haven't joined Git's Discord yet, you will need
to self-identify as a user or contributor in the `#roles` channel before
you can post. This is more of an anti-spam measure than anything else, I
believe.)

Ciao,
Johannes

