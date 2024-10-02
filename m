Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0F37FD
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 01:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727833031; cv=none; b=XgH1No/bvO634d+1eBWY4NARwGq4ZhdMwytMoqG9m3sTeDigOLIumJEH5SYX4rOVKnhzEl+0CRv7ALe9Crg4jkfhYwx3ARgzbI3H/H6D+gIGAohymz3aoblcni+cO0ZmAmCrU+D61Dd49yCcwKqnU6zSoc5rQRpRn+lDeQqP4wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727833031; c=relaxed/simple;
	bh=SmxeSEDtZZ7mdCKvBvfK87uXFGb03ssPseI+gr6SwVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TUOuCR+3z4Ys4+b008u0Q2yAnkV6B9AlcHhCSpN24rWB4aYTWrvSHDXIlqiEilnaoNdHGuYbzSCkqvq9CBm6jCaa6ehWndDrdYC3jsMwBU/uoIuOHHsu9cH1S96WoYmZVJwOkXPNxZ8h1PeEx3OwzYOErdDCylwM4NGloMoS6B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=hamlin.carlisle@gmx.com header.b=hE4jaN4O; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=hamlin.carlisle@gmx.com header.b="hE4jaN4O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727833025; x=1728437825; i=hamlin.carlisle@gmx.com;
	bh=fS/oieP5FlI5TLbV+3h7Cy17d5tpf+8ZxZ4CK9FG5mA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hE4jaN4Oh8y9AX0RccEwRVhm2ON6s9ZCJ1PjbIfMSV2VSF9D2imnHO7JayUV2MF5
	 eqSNuZt+eSs6NheKE2KbJiiamZbafWGD2qOcfg7ylQo/Yk9tZ0lGUsDVO8F8uwDSe
	 SMvPBinXaSPKtCgIgGtFWD9bBjH2BB2baXJTGto/87MkpA0gOxp5HDTZv450N5Slh
	 Au6zyKERyPPwPjoiEtbTGPIgSVBNznJN40x9KpOHAHOrGEBLpVXjRk61CJNPDN79+
	 +4E2LP+/xDcKaWxsBve5t1R+29oiu1H4dZbFicRgoC/ineNZQQFDLKdQRvfHhL4Ui
	 3LJMyjyC076O7kG7MQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.65] ([69.62.178.28]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MIdif-1shlx72XRt-00Ac5Z; Wed, 02
 Oct 2024 03:37:05 +0200
Message-ID: <98470a2b-9a5c-4a22-a913-5098185afb65@gmx.com>
Date: Tue, 1 Oct 2024 18:37:01 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Can a note be pushed to origin?
To: Stephen Steves Linda Smith <ishchis2@gmail.com>, git@vger.kernel.org
References: <20240925122918.1719619615FF@thunderbird.smith.home>
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
In-Reply-To: <20240925122918.1719619615FF@thunderbird.smith.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wVE/b3zOGq/EK2BBjciSij4A2tfpK+2BkN6YV0XmKGjT6v/FCHz
 Y4PACemxgInuXptOS4tOZHCAFpEuzbsIU72UFZ0cPVHbM5BZAsFmaTGgJFjF2QvMBqSlAcx
 82GyObdfpzpEbBFD2lFMV5qfCyN6ZaXj7I+cRVEROWR5hzUQpc/D6pEOrw29A6yaqDvG3PY
 J9NkG9V1YZyMoalO85CFA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ff4rO2iWkoQ=;6xIqVLxq/77KLURo9p4N5Dykj2r
 QZRdjb4k+SLaxoHjpqlsen+dN6dOB02vRv1RKZA1fGdRtF0xUuTDhFfPzJ2mPF7MClqgbxUB7
 8erqhLy5GIXx1Lw3blW3mYmujgZAKwRp2dbRFC5zjr9GC273cKVTzxED1wFBl3SaX5go3Qbkf
 6fT9GTdGbLiPAQ7fTDiL0+nMNyPuhCEzXvOX9p/sgJ2BD/UqQQrkWlvM3/8CaGfy7QsWR6BOS
 6S3BZaS0VXvtYk7kXHFNs9ljBqTN5mFPIjANB5OWKpcAJfLyA+JnKccoK3v1+/w9efS4QWZ8O
 2jOiHkT58EnRABgEyMhkog2RZnxIWtOTM8vUWLT4nyxDDiQT5qAUOflqpEK5R+Btk49rhxWTj
 x5593ZdUh7uzK1NMOQkdiLc65cHdhr/GBA0RpfiJscEyGndL8luzeO3/c3aHjrMfUZ1LJ4Dt3
 GasfmL6A5BP+1OtiOlYdGLbsqx+Il2C6ytUuqB+ZW8msGlx2gUC8gBPaQDYVH9KoqNjPO01yB
 xjoAbIFV5xFwj3ShhDUlN4kJGFhnqNZ88XlXWETaTLY71rEqa7OTnacmfFgfR2Urqt3k/XQ5k
 fUuA7Zgzfb/+j+swcyoY90J5XGXvx3Jnc4iXxpDj6zbbBItojI2heDXOCAiACbx5HLSzN7YId
 KN1PwYDRdByB3Hj/t/d1IlWOH+CzkVCEfxRQ9PHA9Q8Se50yXMLfHr+ZBkiDSFBBgIny+PK9v
 f1Xr/J+CIDRSzhzAUdkguM1VdGGCpIO0lhtRJk4TFDaEL2WxS3eGE0bkS7zk2OVkbVodBEUi/
 ihD1B3ICrNG74qRM/p0MQNBw==

You betcha.

Add to the 'origin' entry in the config file specific to your local
repository:

fetch =3D +refs/notes/*:refs/notes/*
push =3D *refs/notes/*:refs/notes/*

Just be aware that other developers will remain blissfully unaware of
your notes unless they either expressly fetch notes for themselves, or
replicate your config setup as regards notes.

Good luck!

On 9/25/24 05:29, Stephen Steves Linda Smith wrote:
> In a project that I am working on, some metadata is currently embedded i=
n some
> source files.  The question was asked yesterday if there is a way to mov=
e that
> metadata a git specific file and link it to the source file or commit.
>
> I remembered that git has notes which can be used to add such data to a
> commit, but I don't believe that such metadata gets pushed to origin nor
> fetched from origin but another user.
>
> Is there a currently implemented way to do something like this?
>

