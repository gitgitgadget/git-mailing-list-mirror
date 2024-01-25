Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CDF6EB65
	for <git@vger.kernel.org>; Thu, 25 Jan 2024 15:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706196210; cv=none; b=FaCGKjOd5bJbi7Fc5B0/XZzjkM2yv+vUTPkDl8C1nap0ZFnXo54gXuCjfP8dZQWiJQlcCtUTfOpWEZv3oKJFPTV+7fI1qi9KBSIztKNQSGGwnhWYia2ZnWO5gxfmSogvmeHdt1VwqCEpJbdtBUiA2emSJV3lwu6w9KjP/2mk/dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706196210; c=relaxed/simple;
	bh=w4qOyNxtJ7tZajlll2rDLSPvHSPPiF/7JC+c63rgmis=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=e6wJth8/JXqr8rBIx3vJ6SkXoelcOFwhZ/62c11NRvK5HEcHDKmrp9/H9zimfKVLkWc48Vdf97w+NV4QoHhkyGTC4SwCrD2yW8Ur6QNHdXDL5R1wyf5lvKPd7NHZ20WjRZiZHK2X+5HxWP/n/4WeR06nsjnHwMaRp7VNOHoEwJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=GMX.De; spf=pass smtp.mailfrom=GMX.De; dkim=pass (2048-bit key) header.d=GMX.De header.i=ruege@gmx.de header.b=Tn6Xlr3b; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=GMX.De
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=GMX.De
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=GMX.De header.i=ruege@gmx.de header.b="Tn6Xlr3b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=GMX.De; s=s31663417;
	t=1706196206; x=1706801006; i=ruege@gmx.de;
	bh=w4qOyNxtJ7tZajlll2rDLSPvHSPPiF/7JC+c63rgmis=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=Tn6Xlr3bZx5x7FATB6J/mtLFVeFlMV+uY7aIQ7g/K8JEEhxRKbONXwwnzz6azKos
	 Z9urPTLeKYO1PU3O1fLGWNpHQ+xYyEfX86fDT4tpq7P791rCPULf1iPAfvSi8ane1
	 8ZkcfkVpnCNYZjRXm2JECAs33Q/gz/XVsxdnsrSazvmqORtxu9UDklcbdknrSXFY3
	 tCImUmOUKyVf70e+7r/H2TL1rmBi9rHDyrf1xmqT0wrfupqjb2XQX/N2Isknv73Gq
	 qTWuFxt2bR82W7q8j1E7jmGK+ACFJLh2yzw5EtVFsIyy0UQCW0QkrpdYbQrO/SkbH
	 wgeNxFyCVSy49XQMRw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.240.1.107] ([77.189.146.233]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuDXp-1rF3YZ1UxJ-00ue2s for
 <git@vger.kernel.org>; Thu, 25 Jan 2024 16:23:26 +0100
Message-ID: <a96e6744-c0bb-4f6e-9066-646ca15a353d@GMX.De>
Date: Thu, 25 Jan 2024 16:23:25 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
From: =?UTF-8?B?SHIuIFLDvGdl?= <Ruege@GMX.De>
Subject: Virus detected
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:WF7HWKGR/TB1FXMTGxMIc5AAU4D2JQ+hqcBLSC02KgzLK85CzSF
 +N5nY18yoVbfcaNPjZCiwvhbF4N8WXQHPWXXlOT+qkdwxgkBS9GhNgQ9XD6zyTxxQoEgJvN
 ySt14wPSq0I4iIU+rAMbqHfwLroosnjubwSk1DPe/Rf4+X7mbO5qk+PbOOyo8lpvyHcfaNm
 nfc+52tQGiIxv1XiR2ApA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:y96rXa037BA=;u/XO/Dr1JKkXn/9Bp6Yjy/CqG79
 3wIMlOgAasg3KKXffn9aIStbW3oYmOs9HXptStX9LnrtB41mQzjOEm19kxV2ATZmj0eRJ0q5n
 5WyMMqSamEldNhw09q8u+Qf2pIYgsx5K1lMUOyFXozsQWhFWl0h0SHb0uSSaxhaNJ4fNVqFzY
 a/FZg6yFEFFQvt1AHaa8yjZf5N78op8j6PhjKRxQSZkKZUPkSoT3p2k1vFK8B7WsNjkOdjIOm
 9/qfHAGV8JNS0wnbsytqY4tE/StlcCh2Ui2j6XBh2PJEt1udYidyK17qkL5SxuyM32bWtmC+w
 Xk4xfnREnfl8GbDo2vec9ktU+Mu46r3MiJHeCX9PZupi9fLK1tLGT0bDXFpk8rdX0BpsCxxFO
 q6hcDPEKSZ5d7sKev0K4e3yZNZAH5H1wJT5RWnLIa7olIkpDEwWL/4hNyW8+WdT6IUI6jupUQ
 zKYwrCJY67j7E3N0RU9Jy7YTqvEeHq6r7kYmTcYuWxfs/pIwC8AQMMetWEL26p/pDakvOrCWA
 kvItzymV7GU4nM3ar5fWkDt63dGQf6hwa5PnX6SUK44jczDFsjVsT4Llty0hzSIQjpUBbRpnX
 dJexgZA94MzNxeuRviBG27gqdDMYoCnhnegi2N7MMHXIPh8W8bteoo1j93tpUkNhVcIvAzwQu
 V/yJspnKVY2z+jpJaJFvQC1Ir1F9RGCl0xQkHMNmTVCHpNtj7pgemUlprTIokNL1BGATEnoTM
 6e9kkiKJJCZKqCpdHuc8rvqzgSzTKWWWHljVT0Y1MBRUDqNykrCBPP68ctCNk5slkn4EO/w3O
 7dLUK3eR1PyroPLmYJxOfrDPgUHlKvdmWi2X5QzuSLAgVb29A7ugOQ3H3PicCHZ04Y/l1ysFN
 3dSv8zFfCf+xEDT9d9it/+aLYQ8r4Jf57i8tMKGrUANGEGuxncWM79XQ9mNXibuSQTXHTXsiw
 i/vreQ==

Hello,

trying to use windows version 2.43.0 from https://git-scm.com/downloads
my antivirus software detects it as a virus.
In parallel something wanted to change my hosts-entries.

Ist that normal?

Best regards,
Martin
