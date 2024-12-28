Received: from mail-40138.protonmail.ch (mail-40138.protonmail.ch [185.70.40.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F531B644
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 03:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735354813; cv=none; b=OqOSXhiPoPz9azC0wTCIV3bX1+qOQH8rWCVi3ZIdTGRawIEpFePVSUvcSMAUVHOKCP/bo1+qUuHFqTi0J+YPAlazA3n4cx/xU/7R0pwkOzo3HOhsTIHRSKtIhfWLnl423JIxYeyF1gmRz8PK86BvmBKpZx9G/0f7NQt896Izs88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735354813; c=relaxed/simple;
	bh=NgX124pTAQJQOM7+u20Yk6c9cMoBzzLZSthkDbkWDkQ=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=i6Wo6RQ8hlX9+lSuvn7fsvlWyfEftBW3B4Y/hGYdRu/IGKD6m4uo9iZDP2x4pKTwIOZPpXZSNgKZVdAPqunfOrRNV2GI7w8NwMcDJQkEMxcLXisNLHrR6dek23D5tTB3cBFIAhLTXAk5StXHprM7a/4Ce4y+zbDJzbp7FtVAxsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=TwtdLiyS; arc=none smtp.client-ip=185.70.40.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="TwtdLiyS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1735354809; x=1735614009;
	bh=g8MwTbkjNxULwD2DXR4VJHxARHHi+ePQlFu5ryXhs4A=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=TwtdLiySR/lqxaRaHXF53NwX3fOH8F55CBUCoqnx2IPzezPIOsr0qQ3b3PvhYxiLN
	 hQxNUHFDQ6IT2fXzyoAdSEZ7hr5GlJPBzWjy3m11CsxFM1aZWVA31qPxz6KFLyuxCY
	 zoieNLZkgahUbiYHY2YkqcXw9Z95eVO2FcmV2LX0T67iDphl+u/jVd7qgao/pbAvvH
	 vR0uJsOou9P9h9mS0j4yVflBux5xH/qQvW0NWX1uiYwuw85Y0DWXfAIC7B9WxObeyg
	 Ovo6MwOf6PIIkkawoYGD5r4iwrcZg8la8TXocU8v+5mmLBlJpuHW398OiEfSzbba+6
	 bBfmPTOBoAAXA==
Date: Sat, 28 Dec 2024 03:00:05 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: A bughunter <A_bughunter@proton.me>
Subject: [help] delivery failed
Message-ID: <VqcnQSQNgB_uv7-hDdfxrajqMM1GxbWcWh1iS0jgsAynZrIV06hpHn03LNg3obBw54uBTxtmxPpyCeWO3HIxmrkm4qkS5TOdHmjuUXc5L0I=@proton.me>
Feedback-ID: 120910843:user:proton
X-Pm-Message-ID: 002e8bd2333527a2442e86f8e3118c32570feebb
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------5b4dea096f0fe22f11689928ef453bd3959f352f365b377cb0a20fa552ebb6b1"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------5b4dea096f0fe22f11689928ef453bd3959f352f365b377cb0a20fa552ebb6b1
Content-Type: multipart/mixed; boundary=-------------------980ea2a6a9828602d60ad9354381b169

---------------------980ea2a6a9828602d60ad9354381b169
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=utf-8

=0AThe ML is rejecting all of my posts from another email.=0A=0A=0A=0A=0AR=
e: Fw: [help] How to find the (N)umber=0A=0Afrom A_bughunter@proton.me=0A=0A=
Sent from Proton Mail Android=0A=0A-------- Original Message -------- =0AO=
n 12/27/24 8:42 PM, Google Account wrote: =0A=0A=0ASent from Outlook for A=
ndroid =0AFrom: Mail Delivery Subsystem <mailer-daemon@googlemail.com>=0AS=
ent: Friday, December 27, 2024 8:39:23 PM=0ATo: git@vger.kernel.org <git@v=
ger.kernel.org>=0ASubject: Undeliverable: [help] How to find the (N)umber =
=0A=C2=A0 =0ADelivery has failed to these recipients or groups:=0Agit@vger=
.kernel.org=0AYour message wasn't delivered because the destination email =
system rejected your message for security or policy reasons. For example, =
the email address might only accept messages from certain senders, or it m=
ight not accept certain types of messages, like those larger than a specif=
ic size.=0AContact the recipient (by phone, for example) and work with the=
m and their email admin to determine what policy or setting blocked your m=
essage and what you should do to make sure that future messages from you w=
on't be rejected.=0AFor more information, see Status code 5.7.1.=0A=0A=0AT=
he following organization rejected your message: smtp.subspace.kernel.org. =
(44.238.234.78, the server for the domain vger.kernel.org.).=0A=0A=0A=0A=0A=
=0A=0ADiagnostic information for administrators:=0AGenerating server: goog=
lemail.com=0Agit@vger.kernel.org=0Asmtp.subspace.kernel.org. (44.238.234.7=
8, the server for the domain vger.kernel.org.)=0ARemote server returned '5=
54 5.7.1 <smtp.subspace.kernel.org. (44.238.234.78, the server for the dom=
ain vger.kernel.org.) #5.7.1 smtp; 550 5.7.1 Your message looked spammy to =
us. Please check https://subspace.kernel.org/etiquette.html and resend.>'=0A=
Original message headers:=0ADKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drel=
axed/relaxed; d=3Dgmail.com; s=3D20230601; t=3D1735353560; x=3D1735958360; =
darn=3Dvger.kernel.org; h=3Dmime-version:content-language:accept-language:=
message-id:date :thread-index:thread-topic:subject:to:from:from:to:cc:subj=
ect:date :message-id:reply-to; bh=3DTCx7x/ldc03G2uS42fQiHc9XsLTN74zwVhUryq=
sn7CQ=3D; b=3DUSW/MlEbGAgx1DVVpynGNi7ruER+hLOeI9mce1NVd7HOJ+ClSuN10bw/Uhxs=
n43kYU tP4hzsl9e8FKVfY4ehYZELCNnPPBb/a+vJmthv5/Hf6sXb8B6GNudK7/XOSQTPcEWYa=
A ucpsfvqDeZCy5LVTEc7QttmgjKuNRTu1ALJQOkp8Ojl+EfwjX6ddstDrQwMnz9IF8H8v sO7=
JhOOehCav4bnJ2dX21aGZOE20glK17N9wX+5VhmcHTNmHUKnt0K5Y00Y4NLF4Hvwf 00azaXxR=
VWOlhqqTVq81BvwFJPvez9eKVcjYjmWZzh6EB3A95nvqCf3hvH1wIeX1krEE ZLKQ=3D=3D X-=
Google-DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed; d=3D1e1=
00.net; s=3D20230601; t=3D1735353560; x=3D1735958360; h=3Dmime-version:con=
tent-language:accept-language:message-id:date :thread-index:thread-topic:s=
ubject:to:from:x-gm-message-state:from :to:cc:subject:date:message-id:repl=
y-to; bh=3DTCx7x/ldc03G2uS42fQiHc9XsLTN74zwVhUryqsn7CQ=3D; b=3DZ31QIJOtoJ0=
ewiQqk9t2t/IBR28/tBcDQ2XKahgM8D10P9G+iWwSRw32zEY37dBsQ6 whXqpnF7TQsExAmSZJ=
UpNl1Ft0rIMF8u73BBEusq6oespW0e7BetadarMH6wJDH8MXuE 91liTr0rCETw9bdfTTNWOML=
MGLtCFzqO2fbfQ2R++u1rJkqYqbnxEP/EECVebfj0ZcpH 3aLSfOY8SVeJQXIIgsvewjnn2CUC=
vmOqwZng8R34QuPflEIcrgr5POp/eTmZL92TCQ/v /RyyumcKUYWdAA6vfzjVJWceoLato9TDY=
TlCYCjhqN6y1ARRUT1Pq9AtMHbbozATx8sf PApA=3D=3D X-Gm-Message-State: AOJu0Yx=
wtqtAt2SAzDCdcrINL7VdnAvhSnPQwGvNMka0kXTEGiyOupA1 	PHHvRaWS1TVSNSAmWXzqs1U=
18HsVo47CSJ0kPpZ5WQkWCI6DOfDE8K0pegad X-Gm-Gg: ASbGncsECFKdHael8AQ4976JPVa=
Rhb58L0RoLh5L9T6V/PgfiJHXrSZDkkRdAivRABn 	YqzkPYq20jJwx/z7kqcz2YksaV3Eo6lZ=
bg3/nDCMwrEeFPJc2ynfU6HXyj5B/9pqw+oU38KNniv 	+9nAvceBWSZncyF0BOcVByuiWettP=
KAPQFmTXRwkpuFAMaSd+rMtTxRX29Nll7L9/CSZuFtz1Q5 	BEAdaGpfR7V6zdTABYhjsmHFz8=
/zUalLLxZFLpWW/181FPKxFm9oVtEfzzqkmbcDvZeVOEu36Nl 	sZwlPOzAX7pL2HXSshxEA5R=
GSd2HByhq8wsPWbGWualGIW1aWFVJ08QW5w5dZf0bENMwQw=3D=3D X-Google-Smtp-Source=
: AGHT+IENX7yH6COKVlyIYnsrDXcVINSTLA7Kdd2kDIY4N+cVQM+4OZxMriRRVOYIfH8RbxqU=
4ex+4Q=3D=3D X-Received: by 2002:ad4:5d61:0:b0:6d8:7e03:c434 with SMTP id =
6a1803df08f44-6dd2332e43bmr473191316d6.20.1735353560291; Fri, 27 Dec 2024 =
18:39:20 -0800 (PST) Return-Path: <rtqenh5emx3s7o5vmnxtasgr3pgciy@gmail.co=
m> Received: from CH3PR12MB8075.namprd12.prod.outlook.com ([2603:1036:304:=
3002::5]) by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181c1e99sm832=
90266d6.93.2024.12.27.18.39.19 for <git@vger.kernel.org> (version=3DTLS1_3 =
cipher=3DTLS_AES_256_GCM_SHA384 bits=3D256/256); Fri, 27 Dec 2024 18:39:20 =
-0800 (PST) From: Google Account <rtqenh5emx3s7o5vmnxtasgr3pgciy@gmail.com=
> To: "git@vger.kernel.org" <git@vger.kernel.org> Subject: [help] How to f=
ind the (N)umber Thread-Topic: [help] How to find the (N)umber Thread-Inde=
x: AQHbWNFqAKvIp8oV2UueEeJKXXvP+w=3D=3D X-MS-Exchange-MessageSentRepresent=
ingType: 1 Date: Sat, 28 Dec 2024 02:39:19 +0000 Message-ID: <CH3PR12MB807=
5D30FB480C67B6059659DF00F2@CH3PR12MB8075.namprd12.prod.outlook.com> Accept=
-Language: en-US Content-Language: en-US X-MS-Has-Attach: X-MS-Exchange-Or=
ganization-SCL: -1 X-MS-TNEF-Correlator: X-MS-Exchange-Organization-Record=
ReviewCfmType: 0 x-ms-reactions: allow Content-Type: multipart/alternative=
; 	boundary=3D"_000_CH3PR12MB8075D30FB480C67B6059659DF00F2CH3PR12MB8075nam=
p_" MIME-Version: 1.0 =0A
---------------------980ea2a6a9828602d60ad9354381b169
Content-Transfer-Encoding: base64
Content-Type: application/pgp-keys; filename="=?UTF-8?B?cHVibGlja2V5IC0gQV9
 idWdodW50ZXJAcHJvdG9uLm1lIC0gMHg2NjU0MDgwNS5hc2M=?="; name="=?UTF-8?B?cHVi
 bGlja2V5IC0gQV9idWdodW50ZXJAcHJvdG9uLm1lIC0gMHg2NjU0MDgwNS5hc2M=?="
Content-Disposition: attachment; filename="=?UTF-8?B?cHVibGlja2V5IC0gQV9idW
 dodW50ZXJAcHJvdG9uLm1lIC0gMHg2NjU0MDgwNS5hc2M=?="; name="=?UTF-8?B?cHVibGl
 ja2V5IC0gQV9idWdodW50ZXJAcHJvdG9uLm1lIC0gMHg2NjU0MDgwNS5hc2M=?="

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tClZlcnNpb246IEdvcGVuUEdQIDI
 uOC4wCkNvbW1lbnQ6IGh0dHBzOi8vZ29wZW5wZ3Aub3JnCgp4ak1FWnUwWDF4WUpLd1lCQkFIY
 VJ3OEJBUWRBSDBJNDdqRHNQWjZndmIrWVVHQm5BeDdKeWYxNEFWT0h4YTh5CjArZG1ONWJOTFV
 GZlluVm5hSFZ1ZEdWeVFIQnliM1J2Ymk1dFpTQThRVjlpZFdkb2RXNTBaWEpBY0hKdmRHOXUKT
 G0xbFBzS01CQkFXQ2dBK0JZSm03UmZYQkFzSkJ3Z0prS2tXWlRsUXJ2S1pBeFVJQ2dRV0FBSUJ
 BaGtCQXBzRApBaDRCRmlFRVpsUUlCY0F5Y1oybE85ejJxUlpsT1ZDdThwa0FBRDlGQVA5L2RkV
 DY1NkdrYTlOdE12bWRvWTVrCnROZ3FiWTVYYmQ5Zng2a1BFNS80dFFEL1hpaWFsS1FIam13QXR
 iY1NlMVErM2N4WUx4TmhqVTdteW5Rc3B2OWQKeEFET09BUm03UmZYRWdvckJnRUVBWmRWQVFVQ
 kFRZEFuZnAvejJGd1JrcHZVZ2Y3bXFZSTlSS25UVmFkd0dmZwphUUxobXdnM0x4TURBUWdId25
 nRUdCWUtBQ29GZ21idEY5Y0prS2tXWlRsUXJ2S1pBcHNNRmlFRVpsUUlCY0F5CmNaMmxPOXoyc
 VJabE9WQ3U4cGtBQUppOEFRQytmbk9tNFZqOVFtSDRIMEdWdDdSdU9RSyt3T1ExUFJ2cHltU2o
 KZXlCSk93RDlHWXV2eE9BVks4aUF1cEorcHB3TXIzNlZ1a0llMXBYdUhvOVJoanZlQXcwPQo9R
 lFGdwotLS0tLUVORCBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0t
---------------------980ea2a6a9828602d60ad9354381b169--
--------5b4dea096f0fe22f11689928ef453bd3959f352f365b377cb0a20fa552ebb6b1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0FgmdvabQJkKkWZTlQrvKZNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmeEgpIOao2cvcmEhD3bb/HKFiEEZlQIBcAycZ2l
O9z2qRZlOVCu8pkAAOBlAQCHtfQYRcTLs0yIcdXaK+5ismneVBwIi+kl/oC3
nDLUhwEA1nR/YKI4CUcrvLm6TcNJEg08Im1FEM1YDzzt2EITuwM=
=MqGN
-----END PGP SIGNATURE-----


--------5b4dea096f0fe22f11689928ef453bd3959f352f365b377cb0a20fa552ebb6b1--

