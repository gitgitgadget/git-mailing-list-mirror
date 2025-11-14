Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E27295D90
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 20:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763151741; cv=none; b=R9KoVFQvm7+Cy7PmJdImZ3fBHI3nvHd857G2FwfWvV6r/2SeRuPI/5tAxkuGPpEP7Ylc7ze9li5rznz928U6qz7tL1N0JhwcD57PHtpDeKKFM/5NLP5HTJ1v2rhKeMuP+bBwjJb4BA0zurYtBJznz0d9jTrqVPhp1AvO1Nr+hug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763151741; c=relaxed/simple;
	bh=UrJmOZLhcOPJearGDJrY6Y7nRX3I4pvH3Bfhcqbx9yA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J1ABV5/fOrW1LfPrDGG9ThRMD0JhN/MNGDzpI+A8q0cxICb0AgY4aSC4X+ZeCX9f05tdVLbSp0Udg4/xNH8AUjNyubSuf0pvw+bLgfO6dhDQ7FmqM0dwo+ykdoPa3h7WgwV2f6NLe7BFzRB0oaDMTdxtqpuEiweobi5tb+Pys5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=hamlin.carlisle@gmx.com header.b=aYUu6SUL; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=hamlin.carlisle@gmx.com header.b="aYUu6SUL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1763151737; x=1763756537; i=hamlin.carlisle@gmx.com;
	bh=UrJmOZLhcOPJearGDJrY6Y7nRX3I4pvH3Bfhcqbx9yA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aYUu6SULkJDamaXF3WgrP9ZF3OhsBHUZD9iW/e5HFI8SmPEeV3OmUP6qJclfVlaP
	 c9w2+coRy9E9woSL2HUqd0GXK2q0DGFiEW550fyK4ud508/BvIGmhfJSNq7xMF4Jp
	 3tIe4dRSRPJPJIb5pUybpgOAbsxURN3nx0YCrfnTdjQvGfYdnQmDqH/CXtuYDsyta
	 +JDEs4GFHhWxA1Uii/SDO5KZ4RJ4/yLCIHNPfYK+mFclQFpXEJ6v4AiJpqQydH3KR
	 3psZOTR47aKVzu5KstcutPEL3O2ap3u/08oRC+Url54WJukMIs4zUox0Dz8KMdbYD
	 r/0dTC1L0HxllsN8DQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [IPV6:2607:fb90:8b63:b357:ed3e:2bdc:f4d3:abde]
 ([172.56.171.74]) by mail.gmx.net (mrgmx005 [212.227.17.184]) with ESMTPSA
 (Nemesis) id 1MLQxN-1vaqL51Y7H-00SnQI; Fri, 14 Nov 2025 21:22:16 +0100
Message-ID: <194b039c-e472-46c3-ae74-3f74d8b81663@gmx.com>
Date: Fri, 14 Nov 2025 12:22:12 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: /Re,
To: harry.schofield@lexcapital-group.com, git@vger.kernel.org
References: <20251110052934.157CD63E55E15F32@virakshop.com>
Content-Language: en-US
From: "Carlisle T. Hamlin" <hamlin.carlisle@gmx.com>
Autocrypt: addr=hamlin.carlisle@gmx.com; keydata=
 xsAiBEfLBpcRAgD8qfOOlcAEezHtcm6xrrZbwjKLXlIfKXUf/YiTeuaLk7TkfnvTVU5fwUam
 iewb7AN+t3mzKxcgwxViDnFQ8spDAKDtjKSLxKSCTYDVT8WR5w0NwOI3dwH9GetPPjCjJvnk
 JOr7yJOcyF0+T0bwR/cEUJ6nuQfbh2eVSNyWSiixsr14dQWphJf7CwGsTfIfv7vsZ+fIwP39
 rgIA+g8d2waPxl76gDjIygL6TrF6hhTt7KUb2yNgSng9IldkMfcdBYlg3dWOpZNNcZrTGOyd
 6xvhvmMuojRRx8r54c0oQ2FybCBULiBIYW1saW4gPGhhbWxpbi5jYXJsaXNsZUBnbXguY29t
 PsJjBBMRAgAjBQJYh9SnAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQyLm4ydrA
 Bve9TgCdGob4qLVTBIOjrTrY+/PmPPGby4AAn21LQfE5TXjJP298WdZNVCmAzXarzsFNBEfL
 B4oBEADbRPe1kVPw4r1YTMTRjRGKz1zF1juy+w7rgYmbwGE7g59jyb2jQYkiuUykupPom63I
 UAiHsTm7rt+GrHqJ2WjgBfDC7rUM0tWst5pKkt9Ma27l/O9J0T4YDr0kRDGhEUJPHI27V2D2
 NX52bDFgKiPl5WyRxtgAtTZC9KOdCPJ4t9c8waUIWlFn/YeWYerC2b15Sf3AB6bKVhP+2v91
 j/vOsTEFIlfg57fbQpEknGsLRIbO1V5Gx5FhFgycNh50zk86LiTz7pzZ19E6UnYuUEgaozru
 UjTQubdqPYOdgCnReTgcwo4ylon12sXjWHBScODgIYooPEUjAyn8H/m5i7jaSV5l2eZOUPvF
 8NPuuGUUWgMmQ+pCah3DnO3ccdaOOjW2z02Skx1XGep7Zyyn4hzV3cZpIhnOP5udwE1D3Pxr
 ljwVKs4uroPo28Eeh1KiYf95kP5KfzYafOpVx3QyykkiqQ4MEd1k61Y1ZoQ4pz+XskOym1DD
 9w6JdoAimsb7YGAqMQbSrtNSVpDMcYIDpXboDDussRmRD+Xoko/mhhQ2ZpUUyeqnlPHHmzSJ
 va0+hvBhw3QEv0QV7or3V1tN9r72o0KGp1un1n9IZv7JA4CKvs2oWPlR593d+pmHzZswK01Y
 ozFV+96kRXULHziVesdtlJCa+/341vc/p9teqKEJSQARAQABwkkEGBECAAkFAkfLB4oCGwwA
 CgkQyLm4ydrABvf1ogCfcujflHLQUSahVKgWtF/qDpK10+gAmwQ6EVxuZ3Z1GO6EbFxyRtm3 kOwI
In-Reply-To: <20251110052934.157CD63E55E15F32@virakshop.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------vXnuGsiWKsQpR0KxfkBzKwMF"
X-Provags-ID: V03:K1:/m/ZZOUiS9nyp7BXagKNHDIZ7twadCbDj5iFGe+rA8u1Ws+x4nR
 4VBnKN1ySqsj//f9RZpESe7iAOtUUK2BLqr2hbuaOOBt9g25UW6kamrIrNz86KxiQEzEInD
 aPV0mHMczZ7wasGo/oC0OBa5R4S6soRBq7YygLLXRBMZqt1eyK5ytnW+3wnTqoh9+52Vnbt
 Jxmgfr1BkzzHfKG5cDjtg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hxgzLYIXzO8=;5cU89yFm59ssZwDAkHFg4Zipbba
 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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------vXnuGsiWKsQpR0KxfkBzKwMF
Content-Type: multipart/mixed; boundary="------------AdqR0X1o9opMeOExzJEkukFG";
 protected-headers="v1"
From: "Carlisle T. Hamlin" <hamlin.carlisle@gmx.com>
To: harry.schofield@lexcapital-group.com, git@vger.kernel.org
Message-ID: <194b039c-e472-46c3-ae74-3f74d8b81663@gmx.com>
Subject: Re: /Re,
References: <20251110052934.157CD63E55E15F32@virakshop.com>
In-Reply-To: <20251110052934.157CD63E55E15F32@virakshop.com>

--------------AdqR0X1o9opMeOExzJEkukFG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTEvMTAvMjUgNToyOSBBTSwgSGFycnkgU2Nob2ZpZWxkIEVTUSB3cm90ZToNCj4gUmU6
IEdvb2QgZGF5LA0KPiBIb3BlIHlvdSBhcmUgd2VsbCwgbXkgZmlyc3QgZW1haWwgcmV0dXJu
ZWQgdW5kZWxpdmVyZWQsIHBsZWFzZQ0KPiBjYW4gSSBwcm92aWRlIHlvdSB3aXRoIG1vcmUg
aW5mb3JtYXRpb24gdGhyb3VnaCB0aGlzIGVtYWlsPy4NCj4gQmVzdCByZWdhcmRzLA0KPiBI
YXJyeSBTY2hvZmllbGQNCg0KSGl5YSwgSGFycnkhDQoNCllvdSd2ZSByZWFjaGVkIGEgbWFp
bGluZyBsaXN0IGZvciB0aGUgZGV2ZWxvcG1lbnQgb2YgR2l0LCBhIHBpZWNlIG9mIA0Kc29m
dHdhcmUgdXNlZCBmb3IgcmV2aXNpb24gY29udHJvbC4gV2hhdGV2ZXIgaXQgaXMgeW91J3Jl
IGhhd2tpbmcsIA0KeW91J3JlIGFsbW9zdCAqY2VydGFpbmx5KiBpbiB0aGUgd3JvbmcgcGxh
Y2UuDQoNClRoYXQgaGF2aW5nIGJlZW4gc2FpZCwgaWYgeW91IHdpc2ggdG8gcHJvY2VlZCwg
SSdtIHN1cmUgbWFueSBvZiB1cyB3aWxsIA0KZmluZCB5b3VyIHNwaWVsIGFtdXNpbmcsIGVz
cGVjaWFsbHkgaWYgdGhpcyBpbnZvbHZlcyBoZWxwaW5nIHNvbWVvbmUgZ2V0IA0KYSBsYXJn
ZSBhbW91bnQgb2YgdW5kb2N1bWVudGVkIGZ1bmRzIHRocm91Z2ggY3VzdG9tcywgZXRjLi4u
DQoNCkksIGZvciBvbmUsICpyZWFsbHkqIGhvcGUgeW91IHByZXNlbnQgdG8gdGhlIGdyb3Vw
IGFzIGEgd2hvbGUuDQoNCg0K

--------------AdqR0X1o9opMeOExzJEkukFG--

--------------vXnuGsiWKsQpR0KxfkBzKwMF
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wmMEABEIACMWIQS03Plbjnx/WLb9533IubjJ2sAG9wUCaRePdQUDAAAAAAAKCRDIubjJ2sAG96YW
AJ489WykRwYcNSd7vnlExnIGsbzXmQCaAwaZqVnwT0dYoG0XkC08SF2O/eU=
=vOYH
-----END PGP SIGNATURE-----

--------------vXnuGsiWKsQpR0KxfkBzKwMF--
