Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DAE1C683
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 15:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EK6eBOdn"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e7c6f0487so11519174e87.3
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 07:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705419051; x=1706023851; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=53lHZUzARlDx1nuJmxlou8EP/+cMsrcpr9Q/LkfSJKg=;
        b=EK6eBOdn5Skxu+/CyCIHox9vHP2HjN2E+G4xvWbjsE2HKapQG7Y7p1lplStWNe6JJG
         No5Ne0z+mArE9u+XDlkJWECUbj5pcXTv5YRiJ86W6Ur8Vf5rNilXaO3N+F7nHAFTusRu
         CISCWcyNZly2I6fVfVN+lOG3oUZgqqButlVpWHBuQFiArR/EJHYMiYGsuzX+hpiIu+bs
         gU6gkav1wLQGg35qnRroTl/IzvWokjw+Whun4X4v+ztOcNSbE8zIr9q5Sbg5zmNgXQBL
         sOnLWpPsTy6m2YnKqpYCLuq0A4+n/F/PceLe4re5XMwAr/qnmI0kz1I1yn3KnwF2SBAB
         rB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705419051; x=1706023851;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=53lHZUzARlDx1nuJmxlou8EP/+cMsrcpr9Q/LkfSJKg=;
        b=p4iqL0WpM8bum5H++34X48WiYfzGOVj36/tCJRF6FeZCIYIfD39Cq0sr/WlUm+i5Mh
         lRo+l2M7iI7uiNVdAMOT8W3v+eD21NF5jhvoTsj5wT+Zb5R11yngK/qQQ+VlS3hGqrlg
         g3/pwmy3OmjITFYcbOVsIy5/hJqqERa9HtOq60FyigkpNMaJmoE5pJkwom/Y6JqVN1Lh
         6BEvf6pSNkj8rm5kY0v1+uFkT4Yjs+lUZysgJFa4i8qBa64x7WphG0w9Qwkz/rKiQU4G
         nJQ2Jg4qZBaoBhMJ4pGoaa7gFfBNmmoXjf8TwRzw2jTsSRJh3sJWKd7JtOwDFS6hAp7m
         MeAg==
X-Gm-Message-State: AOJu0Yxon9T2TG3KkA+pWMSfAzArwp/fLtwro9YenfqiZjq3vRwOheg4
	bQKyXCBFjJEq21p1VMHTH8evM/KnGps39hBgpN/s5zpUDaGRHw==
X-Google-Smtp-Source: AGHT+IGu2Uq0qu7FDFpYXQcMTnQ/4pa50IeaSaPJs5uiX6zFuew6kT+6dkfwyuFODqIWn5PA5nW0DC07IAUKXEcqRDY=
X-Received: by 2002:a05:6512:3b10:b0:50e:3eaf:7405 with SMTP id
 f16-20020a0565123b1000b0050e3eaf7405mr3104550lfv.16.1705419050566; Tue, 16
 Jan 2024 07:30:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vaibhav Naik <vaibhavnaik2004@gmail.com>
Date: Tue, 16 Jan 2024 21:00:12 +0530
Message-ID: <CALZECO2kHf_qPX06kOUPbJT_hNd5Txt9FTh_Pxr+9x_sMJdKOg@mail.gmail.com>
Subject: git-bugreport-2024-01-16-2051
To: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000b3d81e060f11d04d"

--000000000000b3d81e060f11d04d
Content-Type: multipart/alternative; boundary="000000000000b3d81c060f11d04b"

--000000000000b3d81c060f11d04b
Content-Type: text/plain; charset="UTF-8"



--000000000000b3d81c060f11d04b
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div dir="ltr"><br></div></div>

--000000000000b3d81c060f11d04b--
--000000000000b3d81e060f11d04d
Content-Type: text/plain; charset="US-ASCII"; name="git-bugreport-2024-01-16-2051.txt"
Content-Disposition: attachment; 
	filename="git-bugreport-2024-01-16-2051.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lrgig0hp0>
X-Attachment-Id: f_lrgig0hp0

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQpQbGVhc2UgYW5zd2Vy
IHRoZSBmb2xsb3dpbmcgcXVlc3Rpb25zIHRvIGhlbHAgdXMgdW5kZXJzdGFuZCB5b3VyIGlzc3Vl
LgoKV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8gcmVw
cm9kdWNlIHlvdXIgaXNzdWUpCmkgdHlwZWQgdGhpcyBjb21tYW5kIGluIG9yZGVyOgpnaXQgY2hl
Y2tvdXQgY2EzNWQ1MwpnaXQgdGFnIDEuMS4yCmdpdCBjb21taXQgLS1hbGxvdy1lbXB0eSAtbSAi
d2FudCB0byBjb21taXQgYXQgYW55IGNvc3QiCihpIGp1c3Qgd2FudGVkIHRvIGNvbW1pdCB0byBj
YXRjaCB0aGUgYnVnKQoKV2hhdCBkaWQgeW91IGV4cGVjdCB0byBoYXBwZW4/IChFeHBlY3RlZCBi
ZWhhdmlvcikKd2hlbiBJIGNoZWNrb3V0LCBpdCB3YXMgc2hvd2luZyB0aGUgY29tbWl0IGlkIGF0
IHRoZSBwbGFjZSBvZiBIRUFEIFBvaW50Ogp2YWliaEBWYWliaGF2TmFpayBNSU5HVzY0IC9kL0Ug
RHJpdmUvTXlDb2Rlcy9HaXQtVGVzdGluZyAoKGNhMzVkNTMuLi4pKQphbmQgdGhlbiBhZnRlciBj
cmVhdGluZyBhIG5ldyB0YWcgaXQgd2FzIHNob3dpbmcgdGhlIHRhZyBuYW1lIGF0IHRoZSBwbGFj
ZSBvZiBIRUFEIFBvaW50Ogp2YWliaEBWYWliaGF2TmFpayBNSU5HVzY0IC9kL0UgRHJpdmUvTXlD
b2Rlcy9HaXQtVGVzdGluZyAoKDEuMS4yKSkKd2hpY2ggaXMgd3JvbmcsIHRoYXQgcGxhY2UgaXMg
dG8gc2hvdyB3aGVyZSB0aGUgSEVBRCBpcyBwb2ludGluZyBhdCBhbmQgbm90IHRoZSBuZXdseSBj
cmVhdGVkIHRhZyBuYW1lCgpXaGF0IGhhcHBlbmVkIGluc3RlYWQ/IChBY3R1YWwgYmVoYXZpb3Ip
Ckl0IHNob3dlZCB0aGUgbmV3bHkgY3JlYXRlZCB0YWcgbmFtZSBhdCB0aGUgcGxhY2Ugb2YgdGhl
IEhFQUQgUG9pbnQ6CnZhaWJoQFZhaWJoYXZOYWlrIE1JTkdXNjQgL2QvRSBEcml2ZS9NeUNvZGVz
L0dpdC1UZXN0aW5nICgoMS4xLjIpKQoKV2hhdCdzIGRpZmZlcmVudCBiZXR3ZWVuIHdoYXQgeW91
IGV4cGVjdGVkIGFuZCB3aGF0IGFjdHVhbGx5IGhhcHBlbmVkPwpJdCBzaG91bGQgc2hvdyB0aGUg
dGhlIGRldGFjaGVkIEhFQUQgY29tbWl0IGlkIGF0IHRoZSBwbGFjZSBvZiBIRUFEIFBvaW50IGFu
ZCBub3QgdGhlIG5ld2x5IGNyZWF0ZWQgdGFnIG5hbWUKSSBwcm92ZWQgdGhpcyB3cm9uZyBieSBk
b2luZyBhIGNvbW1pdCB3aGljaCBkaWRuJ3QgZ290IGNvbW1pdHRlZCB0byBhbnkgYnJhbmNoIG9y
IHRhZyBidXQgaXQgbW92ZWQgdGhlIEhFQUQ6Cgp2YWliaEBWYWliaGF2TmFpayBNSU5HVzY0IC9k
L0UgRHJpdmUvTXlDb2Rlcy9HaXQtVGVzdGluZyAoKG5ld3QpKQokIGdpdCBjb21taXQgLS1hbGxv
dy1lbXB0eSAtbSAid2FudCB0byBjb21taXQgYXQgYW55IGNvc3QiCltkZXRhY2hlZCBIRUFEIGNh
YWQ4ZWZdIHdhbnQgdG8gY29tbWl0IGF0IGFueSBjb3N0Cgp2YWliaEBWYWliaGF2TmFpayBNSU5H
VzY0IC9kL0UgRHJpdmUvTXlDb2Rlcy9HaXQtVGVzdGluZyAoKGNhYWQ4ZWYuLi4pKQokIGdpdCBz
dGF0dXMKSEVBRCBkZXRhY2hlZCBmcm9tIGNhMzVkNTMKbm90aGluZyB0byBjb21taXQsIHdvcmtp
bmcgdHJlZSBjbGVhbgoKaXQgc2hvd2VkIHRoZSB0YWcgbmFtZSBpbiB0aGUgYnJhY2tldHMKCkFu
eXRoaW5nIGVsc2UgeW91IHdhbnQgdG8gYWRkOgoKUGxlYXNlIHJldmlldyB0aGUgcmVzdCBvZiB0
aGUgYnVnIHJlcG9ydCBiZWxvdy4KWW91IGNhbiBkZWxldGUgYW55IGxpbmVzIHlvdSBkb24ndCB3
aXNoIHRvIHNoYXJlLgoKCltTeXN0ZW0gSW5mb10KZ2l0IHZlcnNpb246CmdpdCB2ZXJzaW9uIDIu
NDMuMC53aW5kb3dzLjEKY3B1OiB4ODZfNjQKYnVpbHQgZnJvbSBjb21taXQ6IDRiOTY4ZjNlYTNi
MzJhN2JjNTA4NDZiYWI0OWYzZjM4MTg0MWQyOTcKc2l6ZW9mLWxvbmc6IDQKc2l6ZW9mLXNpemVf
dDogOApzaGVsbC1wYXRoOiAvYmluL3NoCmZlYXR1cmU6IGZzbW9uaXRvci0tZGFlbW9uCnVuYW1l
OiBXaW5kb3dzIDEwLjAgMjI2MzEgCmNvbXBpbGVyIGluZm86IGdudWM6IDEzLjIKbGliYyBpbmZv
OiBubyBsaWJjIGluZm9ybWF0aW9uIGF2YWlsYWJsZQokU0hFTEwgKHR5cGljYWxseSwgaW50ZXJh
Y3RpdmUgc2hlbGwpOiBDOlxQcm9ncmFtIEZpbGVzXEdpdFx1c3JcYmluXGJhc2guZXhlCgoKW0Vu
YWJsZWQgSG9va3NdCg==
--000000000000b3d81e060f11d04d--
