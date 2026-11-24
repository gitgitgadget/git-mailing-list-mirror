Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=172.105.7.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795561065;
	b=5Ziq9sMYCuRg+2w9E8V07s8KjxlOs0TVQ3bMkqGU6okxvQic7KnNbFWHbX3ICz5RCGck
	 KUuU8NdzTM/skwQznqxKIlld92pGbnMUitLgHQYg9pJyq18g817Mh7XX6e0IMOcl6yflJ
	 Batj7Y0mmnTWT9NVNHOhPeIzZk+sof+I8fE7Je780oBzwHcSRHD8jDygb48jzdNTAOFo9
	 BojTLA0IcPBUenkmZm37F8MUBviv58p+j7DNs9P3hAyYufHYtFlcMnv33JE/gN+qPlCRR
	 PYNB00IOHp08zcVY1FTyrjjLm8NUcp6BP14ku/8o1x2iGySpMPOC7JjOlmh5t8ZQm1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795561065;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SfkaZbRu+pV7ouKS/0ao4Yd3AzTCvbHGda3tvYObjB0=;
	b=gScezGKtPGufGt1xujmig4yICB3t0SmPgpoKwtRPKd0Icm+b1VA32EnY9Ham3doHkwzv
	 wS+oiy0/gxrmnYKLlyz2HlwYnSqL9PbIkVGejhvjao/hvrTaDPSjYZt3/E2BOWIb3fPel
	 BQhvydoZCBVDO3v1tUR0lT1VApRv6pkVZoy92JAU39HFV9c5hxHUMri+MMvBQG7RGgann
	 fPMXbhKj5yw1WdOQ9T357QHmr8NDabdaIFi2Z7rTG0xJw5sT+/i2fKra/ICEsjEUX6X8P
	 IM8haR+Ide1iYiUPSJ3ICRrbeT8ODAOYifsjhlpR8ueKJLK6krGwkXUfdVjjGoAHroA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crustytoothpaste.net;
	spf=pass smtp.mailfrom=crustytoothpaste.net;
	dkim=pass header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=M5ubWPjX;
	arc=none smtp.remote-ip=172.105.7.114
Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8050C606A323
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 22:57:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8050C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=M5ubWPjX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1795561063;
	bh=Bo78HOn13eIZRDrz1JvNJnC+A28+gFQN2gXNZxs7rQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=M5ubWPjXEt5Ieem7DqZ/APctE/3bMxqc4hscRzlhn++WhDvTQE1nkpuU54PoEPcqv
	 IpWuPlXOjIvXuOagbianxpmAJriJFc+re/hahNxIFQdUXUAy0f2ggRr/2VYxMyCmqK
	 r0KQywCsp1+2jR4Ug84xUeJsKK1tsQK9Llr4lhZfRey6UKv4TO0jfsGDDsdQ98Hy0b
	 Qq/zVzZiymJUee4R8c6KZ3u4ST4hk820DEV4IIztzwJjoZeeMkt6cI2kC//WJACgah
	 Zl1NIpVsUHlSU69stxWYgSEwaZW8ckV8SjmsMSDkWxTQnUXh6beeD+MeyW8OagA1aG
	 HXUSkIWigt/MrrrpuFMh5GLzzqcntN5guOI60VtWgG4xMboSbqlaCPH5h3CgC3X8GP
	 RmzzqYQdI5Wh/b7akfb72mwEst0nDZYlgnjAVGW+UOzM5yAP/+wp6UOK9hfF/yl2eS
	 JSDAiG1dDdAVCKQpPtseVPJZowDQQDRUGOWmNkBt3E0hnRigA85
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:52b3:5d58:319:ece6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 7A260200B1;
	Tue, 24 Nov 2026 22:57:43 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3] docs: indicate clearly that http.extraHeader is not for creds
Date: Tue, 24 Nov 2026 22:56:56 +0000
Message-ID: <20261124225656.1615821-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.53.0.697.g625c4fb2daa
In-Reply-To: <20261121222723.23714-1-sandals@crustytoothpaste.net>
References: <20261121222723.23714-1-sandals@crustytoothpaste.net>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

People frequently use http.extraHeader for credentials, but it is not
intended for that and is easy to misuse.  People using it for
credentials often do not use the URL-qualified option, exposing their
credentials to every server Git connects to, or they specify it on the
command line or in the config file, potentially exposing it to other
users or to anyone who accesses the repo, respectively.

It's also known that using http.extraHeader for the Authorization header
breaks some uses of Git LFS, where some parts of the protocol can
include their own Authorization header.  This is because that tool does
as Git does and always adds the header, leaving two Authorization
headers which breaks authentication.  However, using a credential helper
works fine, since Git LFS only calls the credential helper if it doesn't
have credentials.

Indicate clearly that http.extraHeader should not be used for
credentials now that we have more robust credential helper support.
Remove text that suggests it might have sensitive information in it,
since it should not.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
Changes since v2:
* Use camelCase for `http.extraHeader`.
* Use backticks for `Authorization`
* Link to gitcredentials(7).

 Documentation/config/http.adoc | 9 +++++++++
 Documentation/git.adoc         | 7 +++----
 Documentation/gitfaq.adoc      | 3 ++-
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/http.adoc b/Documentation/config/http.adoc
index 792a71b413..8f26eed6a4 100644
--- a/Documentation/config/http.adoc
+++ b/Documentation/config/http.adoc
@@ -111,6 +111,15 @@ http.extraHeader::
 	more than one such entry exists, all of them are added as extra
 	headers.  To allow overriding the settings inherited from the system
 	config, an empty value will reset the extra headers to the empty list.
++
+Note that this option should not be used to pass credentials and using it for
+that purpose may cause security issues.  Using this option for the
+`Authorization` header can also break some external tools.
++
+A credential helper is almost always more secure and does not impact external
+tools negatively; note that modern credential helpers can implement any
+reasonable method of authentication, including Bearer. See
+linkgit:gitcredentials[7] for more information.
 
 http.cookieFile::
 	The pathname of a file containing previously stored cookie lines,
diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index 1aa0608bae..d2f56e2f91 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -104,10 +104,9 @@ where other processes might be able to read your command line
 (e.g. `/proc/self/environ`). That behavior is the default on
 Linux, but may not be on your system.
 +
-Note that this might add security for variables such as
-`http.extraHeader` where the sensitive information is part of
-the value, but not e.g. `url.<base>.insteadOf` where the
-sensitive information can be part of the key.
+Note that this might add security for variables where the sensitive
+information is part of the value, but not e.g. `url.<base>.insteadOf`
+where the sensitive information can be part of the key.
 
 --exec-path[=<path>]::
 	Path to wherever your core Git programs are installed.
diff --git a/Documentation/gitfaq.adoc b/Documentation/gitfaq.adoc
index b26e4e3a09..dce40e659b 100644
--- a/Documentation/gitfaq.adoc
+++ b/Documentation/gitfaq.adoc
@@ -120,7 +120,8 @@ them for a certain period of time.
 You can also just enter your password when prompted.  While it is possible to
 place the password (which must be percent-encoded) in the URL, this is not
 particularly secure and can lead to accidental exposure of credentials, so it is
-not recommended.
+not recommended.  For similar reasons, we don't recommend using the
+`http.extraHeader` option for credentials, either.
 
 [[http-credentials-environment]]
 How do I read a password or token from an environment variable?::
