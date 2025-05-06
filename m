Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22D4280015
	for <git@vger.kernel.org>; Tue,  6 May 2025 12:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746534742; cv=none; b=kvUaQcCPdLkqJVOM9xa8DE8eUH+jXZxkixae0QhYrqV7cAT4/Lo+c+ownCSggsFABoAbNNjbPpcI/6r+y1ECP/EVe5y7+jx0sO2y6uv2m9THra13Ybk0nStNeuw4eXs6IJ4C1ng25GM4eHbgKaC0eqEv3o7LOkpXiPHpajvywtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746534742; c=relaxed/simple;
	bh=Y7m1cJu9O3O2Jh2HeMAjrE9rDgfrF3E+Xm164wepPdE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=uiBowCKtUmzgQbIKmsH9QSjZlKnno3EL8/XgVqwdZcvWSrXP+M8N6hfEz6w2m6K6Oe4FX53Rarri6j+ulqlP7lQpYlDf9xsyKDM5fOv9PE/KTDINmStbP15ttWZCHKoeJXrZY/TcM27OLJOQyujPtcxbkYdpjjiW0uudnNwy2To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=wDmbwDUj; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="wDmbwDUj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1746534729; x=1747139529; i=tboegi@web.de;
	bh=er+Mox+XMqsj+1qvzv5uBkeerXhvihASkRUu+eogiYg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=wDmbwDUjdxrfFcsEph+qwsLucxkC7atHvnScKV9JMHeRte9/y3VOagtoESYr0LOU
	 k6r6OOzwLcKUCPXDC/4RNBiy0GE4mUFZW4CNYrBqXTjXrhgBCfhmWy7SNJ953IPrA
	 vDu84ATqMDn/fRhr1SokxKEek9RBOSMycgc8BXC3rTQWMXBh3q5jq3rt6hkP23Or8
	 Cih0ftYcfSFDh9SdXZrZqGI4lBzbm6dfulUrGkQEGhAEi18LkymGy/cMnZVJDSSE+
	 Zkdx4FAqiDFhxdIReQ6BaPB/HAX3xhvQt9DWxmtDyq7F3Ju70k+HjVJ1NnrMe1QVx
	 P6cow+u4+SVSD6rzrQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.209.87] ([81.231.143.213]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MdfCN-1ultGa22Eb-00ZzWC; Tue, 06
 May 2025 14:32:09 +0200
Message-ID: <71fcb24d-55e3-40bb-9368-5b47aa180993@web.de>
Date: Tue, 6 May 2025 14:32:04 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org, ps@pks.im
From: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Subject: Problems with t6011
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:0sELQiniZKOjhan/w4VmhG0e8QG6XEbM1L1KyNqCASgb33PDZUd
 PiRFtdjzFJzhHGJ2zFNx6L4wJr6KnvStGqEIsGuYK+d0XRTAqssyiPp40XPZjQgTnYQNCMA
 zGxNLnrOfbATwXlO3LNuNW8KboAH3q352oiplaQtRVAyNKps3q65/TT7xqiqco0wypiAiXn
 9Cj4flSp/9b0qV2p4pY9A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:06T546tXuIQ=;WR1+4vAd4P8Obya+1fHFADdUImu
 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
 aOdnkKpONamyPvudXX3ojs=

Hej Patrick,
in case you have a second:
the mv command here needs a "-f" to overwrite
read-only files:

--- a/t/t6011-rev-list-with-bad-commit.sh
+++ b/t/t6011-rev-list-with-bad-commit.sh
@@ -39,7 +39,7 @@ test_expect_success 'corrupt second commit object' '
         for p in .git/objects/pack/*.pack
         do
                 sed "s/second commit/socond commit/" "$p" >"$p.munged" &&
-               mv "$p.munged" "$p" ||
+               mv -f "$p.munged" "$p" ||
                 return 1
