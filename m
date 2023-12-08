Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=idiomdrottning.org header.i=@idiomdrottning.org header.b="LRs/kk3Y"
Received: from halsen.idiomdrottning.org (halsen.idiomdrottning.org [74.207.231.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2970611F
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 10:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=idiomdrottning.org;
	s=idiomdrottningorg; t=1702061855;
	bh=jQlNkBay/ftY39DvvjZnXbcDbWV9FInJFWPrG2NIUnQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LRs/kk3YZmcaSY9dj31CADMDJM++WrvoTburFSStmmhgtZtJzaHMBgZ8ui0oLZ6X/
	 B0GnaXcoHGVvbZ3FGpOYbTHdmoCKVJmOGlYPRbIA0kmzS0wFwyULMA6v35n1e9zl/m
	 15yIVLp0ZndKE+UMFMExKJ58tVxp8eGQFiymC2pKUFajHXXG5oIt+dkmS0TW7yVnfl
	 m+w4clokwcl2Kp4EEFXlM4QHZroYLyZ9WPS3tiAbKPz7Sfgn5OkxgIdrSijAH0XaN0
	 ZJABP2Ly+9qh0RK4Z+4y0luzgDAPVFzd7tvPqczAJrxwietMs6X37hkVHSMoudhxpU
	 VZfdDA/oX0+EA==
Received: from localhost (31-211-247-254.customers.ownit.se [31.211.247.254])
	by halsen.idiomdrottning.org (Postfix) with ESMTPSA id C67C51FA98;
	Fri,  8 Dec 2023 19:57:34 +0100 (CET)
From: Sandra Snan <sandra.snan@idiomdrottning.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: git@vger.kernel.org
Subject: Re: getting git send-email patches from someone who is behind
In-Reply-To: <20231208-amusing-vengeful-raptor-e71a8b@meerkat>
References: <87h6ksk2hk.fsf@ellen.idiomdrottning.org>
 <20231208-amusing-vengeful-raptor-e71a8b@meerkat>
Autocrypt: addr=sandra.snan@idiomdrottning.org; prefer-encrypt=mutual; keydata=
 mDMEZWEIEhYJKwYBBAHaRw8BAQdAahVPtpoqkiV62AL3GSY4JaPS0i3Bu3fhbe5WIFQG9pa0LFNh
 bmRyYSBTbmFuIDxzYW5kcmEuc25hbkBpZGlvbWRyb3R0bmluZy5vcmc+iJMEExYIADsCGwMFCwkI
 BwIGFQoJCAsCBBYCAwECHgECF4AWIQSM+QwgZjV9IBEt0Difw0TKEvFISgUCZWJbSgIZAQAKCRCf
 w0TKEvFIShsYAPsFMXn+tFcAwdI2hrkqqQY8I5EC9UWYC9t57VjiYv2uYQD+PUNVHVSBGQDycf3V
 /nXqXvZvTfcFMOz0PVMzibPl0AiIkAQTFggAOBYhBIz5DCBmNX0gES3QOJ/DRMoS8UhKBQJlYQgS
 AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEJ/DRMoS8UhK07EA/iV2B5e3r8t8/StJT38d
 x9YbuoSBmbYZJ6JHH9hoyv0hAPwMiH1M8zZUeQK/TQDqkg2Hjk0xL+U7i9ggocLJEAWQDbg4BGVh
 CBISCisGAQQBl1UBBQEBB0BqHjRRmoXeZmeeUZOqL1ebAflzYFA3jHwxl2sLMLlMCgMBCAeIeAQY
 FggAIBYhBIz5DCBmNX0gES3QOJ/DRMoS8UhKBQJlYQgSAhsMAAoJEJ/DRMoS8UhK4o0BAOB7ChkN
 Jc0oxRDg9WvrbUCnpLU/QdjMFcC8ymLRdzxaAP4gZVL0JQfxulc/JAxotCevk1PAF+UXpY8QalTI
 dooaAA==
Date: Fri, 08 Dec 2023 19:57:33 +0100
Message-ID: <87a5qkjzdu.fsf@ellen.idiomdrottning.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:
> Yes, setting base-commit is the right solution here -- it will 
> tell you exactly where in the tree it belongs.

I didn't know that before today and that's good advice when 
sending patches, but if I'm receiving patches without that field 
set, I wonder how people are dealing with that.

> In its absence, tools like b4 will also try to guess where the 
> series might belong by comparing the file index information 
> mentioned in the patches.

Ah, this! https://b4.docs.kernel.org/en/latest/

This looks wonderful, thank you!
