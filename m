Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954BE24C676
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 20:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770669298; cv=none; b=hjxetewgoVLf0QQWUUzbNIHepoT18IXK1bdjyFU3dDETI8+aHvjDYJioto8Hwo8oWdK5EJp+vmLHF78hf+4dnfQICiVs0WUsumus5rf5bISg/x8Cms0rUOoH3JKdCvN/FOcU+YPM+n/AdlXafVn1QNZ93vVhrdxK7hco0HJmUbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770669298; c=relaxed/simple;
	bh=+Vczv7bUo7T3HFWAQyP1HVdmdp/4pxZssEl9wLDm1GY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=og874SGWBmj3NkPMy3LkMuzLxyde8TqqFFK5h7zIZqSrOLAC7EGleoPPK5tcM2IwKaZiA12cfBpzEV7MijCw83/FSiWTyTbDhtqQx+seYAt5V7c00gZ5e/1DyhqMRSeWrxF/k5sRhHZSzX7nnw8DFNjzfQOcgY0tfURnGkp881o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markusd112@web.de header.b=nwfKVPli; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markusd112@web.de header.b="nwfKVPli"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1770669288; x=1771274088; i=markusd112@web.de;
	bh=+Vczv7bUo7T3HFWAQyP1HVdmdp/4pxZssEl9wLDm1GY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nwfKVPli//eJyyw32fcb7uChN5haXMMaEr2FPvnQHuKGTKqie8TjZFBp7ezYCpgS
	 tpK2xjPRcPTH34U2M7Df8iqLUU5UnEeMjd9BJH5J+WdgDFmGxY6usEPaRbvwvXpBW
	 28TIshsqc/hMjWmCjUbF66P2R7dLX8qASMrHYa/oYqHMPiMRz5mTxrz0R+iyS8W4j
	 kBDiVnlgSCnUMgIs41YNYaDjP7lSBXKDXVF6c97IypBqyGmWL9jm31Opv+meLpOAb
	 JG+aNyQVd0pIyPN9oD1Wea6OJievUy8LIvrIYFf1KJWp0Zb7VhQpZroAFeyz/BCEy
	 zO9sRWqFTAsTdgxBSA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [10.20.0.89] ([93.202.97.228]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTfol-1wF5gz2crF-00HcmK for
 <git@vger.kernel.org>; Mon, 09 Feb 2026 21:34:48 +0100
Message-ID: <ae4cb197-1edc-44c4-afbb-bbb24df509e8@web.de>
Date: Mon, 9 Feb 2026 21:34:48 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: de-DE
From: markusd112@web.de
Subject: missing git documentation for "git clone --recursive"
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zGnz+6VTu60LEYJqUCTdYt0EV4u2lHgaqHjLr4v/wTZiZyrBdQV
 9jDaA8zlg7egR9rSYwY/aMQT9THdnZAi2eZ59lQaSnkONVtkZUEd5617ExRkafwFNk7YY0Q
 O9RZh2pJi/SUwoVaIe4ldkqS6o+uFDuivy9ktqXcah30/WQ/G59rGuSNJbyITZXOdCCcRJj
 VtvLRRE9X3sgzi/82f3sA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ze7ls7JRI74=;y77eSKHE213+S+v3WdIN6JBMQ6Q
 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
 xSudA==

Hi,

I am missing the argument "--recursive" for the git clone command in the=
=20
git-clone documentation

https://git-scm.com/docs/git-clone

Is this --recursive argument outdated? In some projects there is the=20
following command in the documentation that clones the repository=20
including init and update submodules:

git clone --recursive (url)

In the git documentation only "--recurse-submodules" is mentioned as=20
allowed argument, but not "--recursive".

Thanks

Markus

