Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173154C74
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 21:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748987077; cv=none; b=FEhAEmg5gEPcsRR62C4fZjx6DLgpqCqjmwsj1yfgC9ropxSXolNQNmEclVdkcG4Nxnu5H79uUvJP2fT6YYjG5LgrPGrkeN5sZ3iGDN0GtVOIqsUQnYsqetJpNKeT2UlDlkD5F9YxZ/A3KvTix1QCMFMZCezW00hjpXzB/v5fzSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748987077; c=relaxed/simple;
	bh=zZuQ7/iPih16uyqOz1dD2FWpdhiAhjlCXI+CXZ1RfHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZLPeXSVFSNoddnrAOtcDhzfOJHi9u6+vxl/3vl5GPWUTdRf8cIHJFVweYqZBByLv+/XkoLHVM/blE4qaX+H+2zimKzDeadDwSAYtTve27mKYe5V80STBCsG2VOImKwDDImrgBjel+ngflxnHlfPbnDDGMS36juMFKy5gwhwh4AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=hamlin.carlisle@gmx.com header.b=bXax5Ktj; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=hamlin.carlisle@gmx.com header.b="bXax5Ktj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1748987062; x=1749591862; i=hamlin.carlisle@gmx.com;
	bh=zZuQ7/iPih16uyqOz1dD2FWpdhiAhjlCXI+CXZ1RfHM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bXax5KtjOPnVOIAHPzMZicN4SIlhFwiujMns++a7sQjRmiVFErcApk/B5VmMVa0m
	 Yk87FiB0onmqIxbovm85GB0oWeVL4/ae/oEg7t/GIpxn7iBfb3By0cJhCgYGZ/nIK
	 bjyktiHBC0MtHDx56xUtwtErb0HK/CLeynkBRDJ57fE8OCIlt2qv6r5rhOc5oSRIj
	 WZUzYElWrtrHNY6BmryyZ1HfTAeYodWSqJqOA+lA/S9072l1uzXhkFejgzPw0lvML
	 g3ROx4XF0UiPgByfoAsPmdsnR9vsr93q4Dv4ZONyNYgI3MP/wbTtLa7cTmZdBnM9K
	 uXCjHMGcuMTBMwvm3A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.100] ([199.184.15.142]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MDhlf-1uBoJe3buR-00H3eb; Tue, 03
 Jun 2025 23:44:22 +0200
Message-ID: <62393fcb-f824-459b-b7aa-a65192a2c8ca@gmx.com>
Date: Tue, 3 Jun 2025 14:44:14 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Solutions
To: "Shawn A. Hollva" <hollvashawn@icloud.com>, git@vger.kernel.org
References: <11896F33-E812-4013-B3A5-DB4BD3827D24@icloud.com>
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
In-Reply-To: <11896F33-E812-4013-B3A5-DB4BD3827D24@icloud.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------IF8jI3gZjlBmic124hNE5gM1"
X-Provags-ID: V03:K1:+2S4mAsFAgwbGK1Bh0nDpYAp6juaweKEILPsIfMPGo8R9XiINnH
 4hx1XaL7c2jJRkdqK7avmHXzehJs7gS/a8Cg338AGTEE0uQFQdy0ir6BffpNbvpQ2q/xRkN
 hGxt+0OgsXyALoUTq9gAayQtxkZBhUc2uAPPXwF+uXrpc8DzsiCRXUQI1Q+8uPG6d56qu1a
 9x18bQXYPGJCVC+vpkTFg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lDj2cVEVD5g=;Tkwlk9G6nx84iwD3oUIV50mB215
 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
 Oep+hE5prLNyu8QvQsBuQTyhl95TATGgpf

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------IF8jI3gZjlBmic124hNE5gM1
Content-Type: multipart/mixed; boundary="------------HSZmLNYvSo7rvAwyTlmWLnwS";
 protected-headers="v1"
From: "Carlisle T. Hamlin" <hamlin.carlisle@gmx.com>
To: "Shawn A. Hollva" <hollvashawn@icloud.com>, git@vger.kernel.org
Message-ID: <62393fcb-f824-459b-b7aa-a65192a2c8ca@gmx.com>
Subject: Solutions
References: <11896F33-E812-4013-B3A5-DB4BD3827D24@icloud.com>
In-Reply-To: <11896F33-E812-4013-B3A5-DB4BD3827D24@icloud.com>

--------------HSZmLNYvSo7rvAwyTlmWLnwS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNi8xLzI1IDEyOjEwIFBNLCBTaGF3biBBLiBIb2xsdmEgd3JvdGU6DQo+IA0KPiBTZW50
IGZyb20gbXkgaVBob25lIDE2IE1heCBQcm8gUGx1cw0KPiANCj4gDQoNCldlJ2xsIGdldCBy
aWdodCBvbiB0aGlzLiBUaGFua3MgZm9yIGxldHRpbmcgdXMga25vdy4NCg==

--------------HSZmLNYvSo7rvAwyTlmWLnwS--

--------------IF8jI3gZjlBmic124hNE5gM1
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wmMEABEIACMWIQS03Plbjnx/WLb9533IubjJ2sAG9wUCaD9srgUDAAAAAAAKCRDIubjJ2sAG99eI
AJ9HyRlx4PLSWhw75a6ddOalhG17GACgg6iEZyNKSM8JZR4YxQ1aGHyW6bg=
=9xI5
-----END PGP SIGNATURE-----

--------------IF8jI3gZjlBmic124hNE5gM1--
