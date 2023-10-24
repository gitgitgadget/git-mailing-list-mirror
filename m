Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D3415B4
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 20:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJRXOHPJ"
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B529310C3
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 13:40:25 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-27d0a173e61so3379577a91.0
        for <git@vger.kernel.org>; Tue, 24 Oct 2023 13:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698180025; x=1698784825; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f0krgvJ4thU/Jlwk6Fa2lV0GFWgVNkode1wSh18RO/4=;
        b=QJRXOHPJCBtkJY97Ina7ArGuLVxfHZ+V1Ij0WQeRHon1vkX13U5nP1/a0OPMIPUEIT
         iqFzdR+Wyg5up4KRZ1ZkXgh9pXtlWV4gAdv++uyaiuOdcuc78LhDjqOHQYEcwjd71x/2
         34P5fr9enr6SpIdIQ/ZDZXibOqHHXRH0DA9zKt7u9abBgscNiLVNidyxj9b6gcQbjZ8M
         2QQW+sDla3C8j4lnT7yjZpZDJ4aOFsJ2h6glrlxSsS4kk19SaWF/sELUVk1HBSGvs6K7
         FNbmbQyuPjnjKvvPUE82sYCNs68RHvrMph8+ND+UCGMfMV0vYe3IoVaHO482efl+rhoa
         LWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698180025; x=1698784825;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f0krgvJ4thU/Jlwk6Fa2lV0GFWgVNkode1wSh18RO/4=;
        b=vF4YrQ0yLzdLkSNP6dFvBa7GEOoglZ4EYqvDm2n3dW2JVYu2XXvQDSFrkr2TFD+hgr
         GUsRvyL7AVAGI7aiQc+ore9aVUGOr04EpNp7db60MhZeuH0UliNv3JymD34Vptxr9yS2
         pNVk/HRc2MiaXuLe5wXvj6EgNMPZxXqR55RCDoZc0XSFllfGEdFV93z2nXNHZhB0FXyJ
         pWtO6UyJFpJoDWKqldxfSF3STZGWrQ6Nedkiyh81C59Hp620W/WwgYeL2eoqh3OMkqP0
         wd41UUqqkrfwhE4szzYQ0m90VCLIPCoXyS1prvFiLAM/nslhscbA3dE87MNImvTEsFJP
         /0yQ==
X-Gm-Message-State: AOJu0YxLtCP4xv6NWlOUAxx8uFGiIRZ3ufS/daHvVA0s/hAL0p6z3VKS
	MSeZ0Jws3ANo2zXe6P2QJuLgYWXzYQkUuI8hFww0QbrQ
X-Google-Smtp-Source: AGHT+IGV6yYWQpezjuOtsyvX2SLIXSmx73F5ib3OkjPKXCI6BBxlnB0/IU9FaAiXk1mqVe/4HGFDDGB6yPM1XkT1/WI=
X-Received: by 2002:a17:90a:1a04:b0:27e:1ea0:c6fc with SMTP id
 4-20020a17090a1a0400b0027e1ea0c6fcmr9390189pjk.6.1698180024754; Tue, 24 Oct
 2023 13:40:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: galo joel <ilsmaciaszambranogalo@gmail.com>
Date: Tue, 24 Oct 2023 22:40:14 +0200
Message-ID: <CAKh3n_qqMiJL-Mn2MxBmG5MRL36w+v-kxjqb8wUv1i7KOEVaDw@mail.gmail.com>
Subject: bugreport
To: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000023f85506087c590b"

--00000000000023f85506087c590b
Content-Type: multipart/alternative; boundary="00000000000023f85306087c5909"

--00000000000023f85306087c5909
Content-Type: text/plain; charset="UTF-8"



--00000000000023f85306087c5909
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><br></div>

--00000000000023f85306087c5909--
--00000000000023f85506087c590b
Content-Type: text/plain; charset="US-ASCII"; name="git-bugreport-2023-10-24-2215.txt"
Content-Disposition: attachment; 
	filename="git-bugreport-2023-10-24-2215.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lo4sj7uv0>
X-Attachment-Id: f_lo4sj7uv0

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQpQbGVhc2UgYW5zd2Vy
IHRoZSBmb2xsb3dpbmcgcXVlc3Rpb25zIHRvIGhlbHAgdXMgdW5kZXJzdGFuZCB5b3VyIGlzc3Vl
LgoKV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8gcmVw
cm9kdWNlIHlvdXIgaXNzdWUpCgpleGVjdXRlIGFzIGFkbWluIGdpdCBiYXNoIGFuZCwoaW4gY21k
IFcxMCwgc2FtZS4gb3BlbiBnaXQtYmFzaC5leGUgYXMgc3lzdGVtLTMyKS4KdHJ5IGNobW9kIDc1
NSwgNzc3Li4uIGRvZXMgbm90IHdvcmsgJ2NhdXNlIGltIHVzZXIgKCQpIGFuZCBub3QgYWRtaW4g
KCMpCgpXaGEgZGlkIHlvdSBleHBlY3QgdG8gaGFwcGVuPyAoRXhwZWN0ZWQgYmVoYXZpb3IpCgpj
aGFuZ2UgLnNoIHRvIGNobW9kIDc1NSBmb3IgZXhlY3V0ZSBiYXNoCgpXaGF0IGhhcHBlbmVkIGlu
c3RlYWQ/IChBY3R1YWwgYmVoYXZpb3IpCgpub3RoaW5nIC5fLgoKV2hhdCdzIGRpZmZlcmVudCBi
ZXR3ZWVuIHdoYXQgeW91IGV4cGVjdGVkIGFuZCB3aGF0IGFjdHVhbGx5IGhhcHBlbmVkPwoKaSBl
eHBlY3RlZCBhIGdvb2Qgc3JpcHQgaW4gYmFzaC4gbm93IGknbSBzYWQKCkFueXRoaW5nIGVsc2Ug
eW91IHdhbnQgdG8gYWRkOgoKUGxlYXNlIHRlbGwgbWUgd2hhdCBoYXBwZW4sIG1heWJlIGknbSB3
cm9uZyBidXQgY2hhdEdQVCBhbHNvIG5vIGhhdmUgaWRlYSB3aHkgCmkgY2Fubm90IGJlIGFkbWlu
IGluIG15IG93biBsYXB0b3AgeEQsIG9yIG1heWJlIGkgbmVlZCBzb21lIGxpYnJhcmllcyB0aGF0
IGkgZGlkbm90Cmluc3RhbGwuIEkgc2VsbCBhbGwgbXkgaW5mb3JtYXRpb24gc28gcGxlYXNlIGhl
bHAgbWUgdG8gdW5kZXJzdGFuZCB3aHkgZG9lcyBub3Qgd29yayA6KQoKUGxlYXNlIHJldmlldyB0
aGUgcmVzdCBvZiB0aGUgYnVnIHJlcG9ydCBiZWxvdy4KWW91IGNhbiBkZWxldGUgYW55IGxpbmVz
IHlvdSBkb24ndCB3aXNoIHRvIHNoYXJlLgoKCltTeXN0ZW0gSW5mb10KZ2l0IHZlcnNpb246Cmdp
dCB2ZXJzaW9uIDIuNDIuMC53aW5kb3dzLjIKY3B1OiB4ODZfNjQKYnVpbHQgZnJvbSBjb21taXQ6
IDJmODE5ZDE2NzBmZmY5YTE4MThmNjNiNjcyMmU5OTU5NDA1Mzc4ZTMKc2l6ZW9mLWxvbmc6IDQK
c2l6ZW9mLXNpemVfdDogOApzaGVsbC1wYXRoOiAvYmluL3NoCmZlYXR1cmU6IGZzbW9uaXRvci0t
ZGFlbW9uCnVuYW1lOiBXaW5kb3dzIDEwLjAgMTkwNDUgCmNvbXBpbGVyIGluZm86IGdudWM6IDEz
LjIKbGliYyBpbmZvOiBubyBsaWJjIGluZm9ybWF0aW9uIGF2YWlsYWJsZQokU0hFTEwgKHR5cGlj
YWxseSwgaW50ZXJhY3RpdmUgc2hlbGwpOiBDOlxQcm9ncmFtIEZpbGVzXEdpdFx1c3JcYmluXGJh
c2guZXhlCgoKW0VuYWJsZWQgSG9va3NdCm5vdCBydW4gZnJvbSBhIGdpdCByZXBvc2l0b3J5IC0g
bm8gaG9va3MgdG8gc2hvdwo=
--00000000000023f85506087c590b--
