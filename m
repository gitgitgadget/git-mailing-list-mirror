Received: from aib29agh123.zrh1.oracleemaildelivery.com (aib29agh123.zrh1.oracleemaildelivery.com [192.29.178.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C43E8F5B
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 21:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728680704; cv=none; b=ff/WDZsF91lIsrcYuw4PM4CCI28S6SKUgihsJ5j1ysCP60gQbfg+X/nLdEuACV05wC9c1v2tL03wtMzucUG3otBqTjkze86aP0Bk5ccJ1aubhag3DA/HKrrwzhiT+kch1ytM2iMR+0GZ9GCocGL8geelHoqBONEucC/uxHbvhSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728680704; c=relaxed/simple;
	bh=6eyiGPlE/X9ni5wQyDdKR3ktoV+vm2DhLbHt+ZzOJf0=;
	h=MIME-version:Content-type:Date:Message-id:To:From:Subject:
	 References:In-reply-to; b=GmBUTnqTqPpT2MUSTR0Og43cj62PYTjZEQDXoSvWoy5jQxkiZ9SHJZwbLA4JBQnUVOJMQ6KEMKpi9xV7kdsg4am1nq6ARDDMnDvTl3U3FX9xmnMkxaPAPHzKTHfbNiXLz40EMR7runJQKzbISqrkLT5b3bl1i444+OE0jrEThdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=aKtGJEDz; arc=none smtp.client-ip=192.29.178.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="aKtGJEDz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=AGPaC42DUftf7z1+7tuEEQjCeaWVuTC7KjFB6iJu/+8=;
 b=aKtGJEDz9vxjkt3BKPs13vigxn7R7wN2WgaQmOnrFhvS6E7xFnI98sw35hRDvKqtskNXlqQnNkcc
   z9hcApso9gbEeDf9xlU5/K+FMydeQ6ef5L8OuqBp257zl5GWXw1qOTRlfKotl4kocLE8AbvV6fOL
   B0St8fc9tuGAhD6rvqQGF0gjBL4S+iIAc6WuzwqYkM2651nVs8AZGY3lBrgJqmG8tlTwDtbtNcGH
   dEeCMgl8GXBTv1aL4pkX2+VIHL7/TGqzyRUViGIK9kqWH2YQsE1f+74EWxPMWUPwTa0IgR8Q5Wv0
   8h1Uwcna0v5k7GAvPD+VbaGl5XoMc9IMfLF4WQ==
Received: by omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SL70054TMKDXD10@omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Fri, 11 Oct 2024 21:05:01 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Fri, 11 Oct 2024 23:04:17 +0200
Message-id: <D4TA5EXQFFA0.1XVEK1RM2Q6VA@ferdinandy.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 <git@vger.kernel.org>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
Subject: Re: with git update-ref?
References: <D4T9VCF8OS6U.1FMB8P6YU7I3S@ferdinandy.com>
 <cb60b7ad-7902-4293-81e9-06d1b1526842@app.fastmail.com>
In-reply-to: <cb60b7ad-7902-4293-81e9-06d1b1526842@app.fastmail.com>
Reporting-Meta:
 AAE9JU+4RyCOgAzz8MaVIdK7uXQOW52i3u0fqX3+ncX6a2+WNYHatMOff650UT5i
 rzrEo9oC5EmHS4ueFoS/UbWPnI7+yC43jvaqyjTsujKC9ScY5HidIdZD0290aBw+
 sfMIdbaiBOtTamt1eWq85KM/IBcF6yF+Ioh5y50/OXja78sUNXOeuJMDT80cS1Sh
 AT4OLg17KNYQYrKAD1/iijHO6oe/Eu2nP5m6YBF7dGybUwV/MAlK1GUQZGKanE7Z
 d1ILuocCM8UdocHtN9MVddWRlUuQ7+6Hb3pHcZUtqadm8bA2+t1QKjOl4lVYHYdc
 uWp5FNCGZpy/gSP2vwkGwxYlxWOSlF10pUY0H8AirZR+dekvgPG7ncyp6OTmHKVl
 aYKgK5TVTRsi05K2hVU8jGR+wmCFT+EgZi5MFIvVfcKLAtCFppwJIa792rHKFOAt
 JHkPIffgx14/z0WcJ/j7fj/Mi6c2rcB3kl/L6vqItMIHd2JPnZfNJvNs


On Fri Oct 11, 2024 at 22:56, Kristoffer Haugsbakk <kristofferhaugsbakk@fas=
tmail.com> wrote:
> `ref: refs/remotes/origin/test`? (space after colon)

I tried a couple of variations and no:

=E2=9D=AF git update-ref --no-deref refs/remotes/origin/HEAD 'ref: refs/rem=
otes/origin/test'
fatal: ref: refs/remotes/origin/test: not a valid SHA1
=E2=9D=AF git update-ref refs/remotes/origin/HEAD 'ref: refs/remotes/origin=
/test'
fatal: ref: refs/remotes/origin/test: not a valid SHA1
=E2=9D=AF git update-ref --no-deref refs/remotes/origin/HEAD 'ref:refs/remo=
tes/origin/test'
fatal: ref:refs/remotes/origin/test: not a valid SHA1
=E2=9D=AF git update-ref  refs/remotes/origin/HEAD 'ref:refs/remotes/origin=
/test'
fatal: ref:refs/remotes/origin/test: not a valid SHA1

I guess the intended way of doing this is via git symbolic-ref anyway, but =
I'm
curious if this should work somehow or I'm misinterpreting the meaning of t=
hat
sentence.

--=20
bence.ferdinandy.com

