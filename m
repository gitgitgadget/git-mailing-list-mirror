Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=idiomdrottning.org header.i=@idiomdrottning.org header.b="O6D5DUBS"
Received: from halsen.idiomdrottning.org (halsen.idiomdrottning.org [IPv6:2600:3c02:e000:179::7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45030D54
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 09:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=idiomdrottning.org;
	s=idiomdrottningorg; t=1702057835;
	bh=SZtr9dkOhgyCTEiTGuRZ8jE/DdxGwXZLGBGhkZEhHr8=;
	h=From:To:Subject:Date:From;
	b=O6D5DUBS4qWJslubF5fe0kwM43Nks7oIGAXv6AGt13/hxV6mSL2SCbw4T3pfywG4o
	 u6tYVyJeVXNfD0o9bdJ5YHNubu9KKygDrlFsKXo7+gkuq1ivllEM1EkekcD8O2rLn/
	 l+y0wicV+bYoxv5kpmPn2qMueex1OX3lMzaE+STh2F2z1Wu4lzsWRRdT+PIai35Vj6
	 l3TWablx+aMvfn8FqXpHrrymfrTVcHQHTfGjWVA+gE8Ke1VqoHfyCyI0SdYgqczlI6
	 mnvCIHu3WwUYZaGZQXnQwKms01vDyF27CtFCdzU5fY2LL04gTDcxqAlbsmKd8+9qZr
	 vKkcicw1vRSAw==
Received: from localhost (31-211-247-254.customers.ownit.se [31.211.247.254])
	by halsen.idiomdrottning.org (Postfix) with ESMTPSA id E57032057E;
	Fri,  8 Dec 2023 18:50:32 +0100 (CET)
From: Sandra Snan <sandra.snan@idiomdrottning.org>
To: git@vger.kernel.org
Subject: getting git send-email patches from someone who is behind
Autocrypt: addr=sandra.snan@idiomdrottning.org; prefer-encrypt=mutual; keydata=
 mDMEZWEIEhYJKwYBBAHaRw8BAQdAahVPtpoqkiV62AL3GSY4JaPS0i3Bu3fhbe5WIFQG9pa0LFNh
 bmRyYSBTbmFuIDxzYW5kcmEuc25hbkBpZGlvbWRyb3R0bmluZy5vcmc+iJMEExYIADsCGwMFCwkI
 BwIGFQoJCAsCBBYCAwECHgECF4AWIQSM+QwgZjV9IBEt0Difw0TKEvFISgUCZWJbSgIZAQAKCRCf
 w0TKEvFIShsYAPsFMXn+tFcAwdI2hrkqqQY8I5EC9UWYC9t57VjiYv2uYQD+PUNVHVSBGQDycf3V
 /nXqXvZvTfcFMOz0PVMzibPl0Ai4OARlYQgSEgorBgEEAZdVAQUBAQdAah40UZqF3mZnnlGTqi9X
 mwH5c2BQN4x8MZdrCzC5TAoDAQgHiHgEGBYIACAWIQSM+QwgZjV9IBEt0Difw0TKEvFISgUCZWEI
 EgIbDAAKCRCfw0TKEvFISuKNAQDgewoZDSXNKMUQ4PVr621Ap6S1P0HYzBXAvMpi0Xc8WgD+IGVS
 9CUH8bpXPyQMaLQnr5NTwBflF6WPEGpUyHaKGgA=
Date: Fri, 08 Dec 2023 18:50:31 +0100
Message-ID: <87h6ksk2hk.fsf@ellen.idiomdrottning.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed

I have a li'l git send-email question. Someone sent me a patch set 
of six patches today but they were not on most current main. I had 
to guess what version they were sending to so I could git am when 
I was on that particular version. I managed to sort it all out so 
this question is more for future reference.

Isn't there a way inside of the emails that it can show what 
version to apply the patches to?

Because now I was like "OK, I remember talking to them the other 
day and that means they probably are on what for me is HEAD^^" and 
that turned out to be correct, and sorting out the conflicts was 
also easy enough,
but if I hadn't talked to them beforehand I would've been 
completely lost.

I asked another friend about it and he said:

> it's possible to record the base commit: 
> https://git-scm.com/docs/git-format-patch#_base_tree_information
> however, it's a bit finicky to do with git-send-email

I dunno.

I get that one of the fun parts about using patches instead of PRs 
is
that you can be a li'l more loosey goosey about exactly what 
commit
something is supposed to belong to but here I would've been 
completely
lost because the patchset just borked horribly right from the 
first patch.

If others have run into this, what's the solution?
