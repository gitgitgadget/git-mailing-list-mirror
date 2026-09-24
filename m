Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FAE4252B1
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 07:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790236576; cv=none; b=PsGJNsCXjc3kCLUswrliG26YGmB62fgrKB02v0meepkHHs1ES5pfDMIZqJapDzNVp8U9w5WcigNT7IezBEQeVFlKRFuHOsNydZZu1TuQ1ErgRQ99L5pqNwF2MQpOE922/Bds1b5rb9sA7o9r02WJVBs6Jj471AbHnDpA7t1udo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790236576; c=relaxed/simple;
	bh=1PlN+yAXPPNou6hIB07wzI0XvWhvZILCm+eZxa2/uDw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KyXQoizHezK3SbggIvwO4eeVunSEFNQf/Hj3m9znp5FE7V8UStz6H/+rxuLx8wSKxdr4kWU+4cC8ydhy2oFTeVdQVX5xZq0M/eTX/NdJYsD5ydiSc2zN0Q562spLRc06wsSX2TYRV7TpmrgjCCqPKBM8Kkc6qODnq+8EDwPOBUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=delpeuch.eu; spf=pass smtp.mailfrom=delpeuch.eu; dkim=pass (2048-bit key) header.d=delpeuch.eu header.i=antonin@delpeuch.eu header.b=QWCuMgQt; arc=none smtp.client-ip=212.227.17.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=delpeuch.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delpeuch.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delpeuch.eu header.i=antonin@delpeuch.eu header.b="QWCuMgQt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delpeuch.eu;
	s=s1-ionos; t=1790236562; x=1790841362; i=antonin@delpeuch.eu;
	bh=qS953N4cnkbSap2FArouaBIHl8r4XLStJ4HIWc11L2A=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QWCuMgQt5XERItlOkIXsC8iGyHhTbcmMvI8M4fGH1CkIFovmEUUpC6ciD75CHMG1
	 4YHfX8EfupabMpbtEVhEH3I7f3+UlF/+a49HQYIacB1edEao5AfpAVFqxbby6n4kg
	 9BULZZzaE/ahtM1y9YOnVuNLIOZ9p8Mg9SsR17BbalhI2IIe/EeeqDpxqNTQcI6y6
	 Kkint2JT3x/49kZ51slyMzEWPIouBJKii9AK3zuJuV71xfLA78fFCxOSuLxguhpwk
	 59+a2jEJSVR41RPu5Don8aN20JVmou6rivZOJSYyctaGjGYZoGJ/Q6hOL60hA4hWc
	 ZFq46q4rNaJHgOlBwA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue109
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MEVBc-1wzDvE1sl8-000c15; Thu, 24
 Sep 2026 09:56:02 +0200
Message-ID: <33b3ab6d-b2cc-49c3-9a06-3c4070ede57e@delpeuch.eu>
Date: Thu, 24 Sep 2026 09:56:01 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Antonin Delpeuch <antonin@delpeuch.eu>
Subject: Re: Documenting the governance of the git project?
To: Junio C Hamano <gitster@pobox.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
References: <1aee1829-d7ad-47e2-b7d1-1a946bd59991@delpeuch.eu>
 <xmqq7bkel0i3.fsf@gitster.g>
Content-Language: en-US
Autocrypt: addr=antonin@delpeuch.eu; keydata=
 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
In-Reply-To: <xmqq7bkel0i3.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wVoltiYxIyJ2GLxHYB5EAvLl+AtuougIK4sR2w1z9A9bmoZ+n35
 wq0eLU6SY7qUs8tJOMRSiAsbp7KM4S0JY58qkCzZLFg+IznEE4VTiu1vySj6CgAdXeMstgh
 HlOft0vYc0DRVxLEe5pbfHwYVkSGiBePZGioVokKU/so/iz6UJ1WQpsPU1bFOztQHP6SH20
 sbOQIdNqfn3zNIWg6pDCg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qXCalGQ3Sm8=;AR3mrDuZgbtAegQ0BiihlzkkfMP
 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
 sh5nZN0mkXP2rxRqvY1cjAD+TEw==

Hi Junio,

Thanks for your reply.

On 22/09/2026 00:09, Junio C Hamano wrote:
> Specifically, we do not have an official list of reviewers with an
> approval bit or those with privileges and responsibilities to speak
> of.  Clout in the community, on both technical and non-technical
> matters, is earned through continued contribution over time, and one
> interesting side effect of this is that a totally new person cannot
> even know whose words carry weight before they are accustomed to the
> community.

Yes, I wouldn't try to codify the clout of project members in such a=20
document. But even without that, I don't think we'd run out of things to=
=20
describe. Just by reading the discussion from the Contributor Summit, I=20
identified a few more roles I hadn't thought about: the set of people=20
with access to the git-security list and the maintainer(s) of=20
git-scm.com. I imagine there might be other well delimited hats like=20
those, whose expectations and renewal process we could describe.

>> If there is interest, I would be happy to try and document this. All I
>> need is the confirmation that people see value in maintaining such a
>> piece of documentation, and the readiness of project leadership to
>> answer my questions (which I would try to do in a way that respects
>> their time, using the communication channel they prefer). I would then
>> submit my write-up as a patch in the location/format you prefer. I woul=
d
>> of course be delighted to team up with others in this endeavor.
> I am somewhat indifferent.  I wouldn't oppose it at all. I would
> welcome a descriptive "this is roughly how it currently works"
> document, but it might be hard to come up with a good descriptive
> document.
>
> Once the document starts trying to be prescriptive, it may open a
> big discussion with different "opinions" not backed by any common
> experience from which discussion participants can draw, which would
> lead to a lot of wasted time and effort.  That is the only thing I
> would be a bit worried about.

I think aiming for a descriptive document makes perfect sense=C2=A0(even=
=20
having it state explicitly that it isn't prescriptive). Even without=20
trying to give it any authority, the questions asked in the process of=20
writing the document can be valuable on their own. They can prompt the=20
team to identify some gaps or some things that they want to change. That=
=20
change can happen at its own pace, independently of the documentation=20
effort.

For instance, if the team behind git-security is struggling with a high=20
volume of reports, I wouldn't be surprised if by taking the time to=20
describe who's on the team and how to get in and out of it, we might=20
identify people who'd be fit and willing to serve (for clarity, I am=20
definitely not throwing my hat here - the task sounds absolutely=20
daunting). This is a random example: I'm not (yet) familiar with your=20
existing processes in this area, so it can be that I'm off-base on this=20
one, but I'm sure you get the broad idea.

Best,

Antonin

