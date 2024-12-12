Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFBE20E304
	for <git@vger.kernel.org>; Thu, 12 Dec 2024 10:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734000538; cv=none; b=MLu1hw+VnUd1Y2PpiKL/JJlUCdc3EemgL9zMSkoOTeDSPeqQ6PCjlM7K0EAAZQtnyHwLC+pn32noItXT4rb3BuTPfj8FTMbXTi5gR1AraCZDRtZa+7CMwT5Xj4AByNEMqlDWTVpl/CMf9HNcci4oNSEtvbmgPJcp2o9Z0u+uAho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734000538; c=relaxed/simple;
	bh=UuP44XKoTQMwqQ1ly+87T3vqPJm7jM8rwGlkzbbdP9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TywDDDmc5ihON4Cej6dbq2RKnIt6dyrmKIVKRCNdJWWUV1g8j72UsC7RlrnUcXCVvgK5sF+Q128WkFJjcTzav+L5pJRYHzfukjonzVAbr2LVJcjje3lPrUeQV6qItA93DhNajiGzWvOx4bJOcyScsKPhROTGA3Cqpb+gzqb7qLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=IvK6M+v/; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="IvK6M+v/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1734000516; x=1734605316;
	i=oswald.buddenhagen@gmx.de;
	bh=cpz+9+vSf4Ov/F6GArsYVtdVhECMFOcGc9YdOPIiWHk=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IvK6M+v/eiIVLaNJeN0IC5WVKqd0T9p4Oc/MKizhYtMgWfBnPPVTwBs/7ghuzaMI
	 hPI8P7Ds8JXVbRbJEYB0hksE/aPkh7AcrIPf3Xx07ijdz1427YCg/yjKWsR5+g+wq
	 cXfNzOD1+j9uN3feo0x0S9aFO6kiwPUNY3Qbb4vc4qFTxi7x/h22YS32InzC4VY89
	 Y+V8P7MRmPLgkrQc3js9kyXgKlfKz1YUXMSsMd8SAhbqI2jBWzNeGLgJTsUJ9bdHE
	 6HkHkpNEbxl6kzTM2/gyGy/dilw3PqzUWSbcbYslhlBOewBx63Cv8ji6dDg+PxHnm
	 Nk5va4wZXF8+BxvGqg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.124]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N33ET-1tl91q3SZR-0121Qt; Thu, 12
 Dec 2024 11:48:35 +0100
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1tLgkF-v0Q-00; Thu, 12 Dec 2024 11:48:35 +0100
Date: Thu, 12 Dec 2024 11:48:35 +0100
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Bence Ferdinandy <bence@ferdinandy.com>, git@vger.kernel.org,
	Denton Liu <liu.denton@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: branch description as a note?
Message-ID: <Z1q_gyUlnWiVtc7P@ugly>
References: <D68T28TFNW6N.2W0WV6WOUT6V0@ferdinandy.com>
 <4e8d3a75-0128-4d03-a429-59b7588f80b4@app.fastmail.com>
 <07e3a0a3-7551-4f54-bc3c-afd8dae7da02@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <07e3a0a3-7551-4f54-bc3c-afd8dae7da02@app.fastmail.com>
X-Provags-ID: V03:K1:qjCwJTsnQ9B3biUlhoJ3wDozx0d9X/FEN8NyVFM2+T/tPV/mFS8
 lV3KAFKqc1LWfAnPUGhbsWtxqulW+Kca3MXz894Sp07fZ8vG0FKTzaU1bkjQPQDvbtIVvdO
 7OGOj5td3hWVnIfxBxOhxpIDcO/ZZC2FzFBC8c++NCXCgEAvWUzijJA0DCv/7UjnGEYNCHB
 ON4sIDWZ2mGwAYO8ePmNQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:h4+EGBXQlqE=;N63nS8eyQnVZrCNdRbFaMPvWw0D
 Isk/joSRf8cU62DJK9PWON99J9E0uncKDCjCZoaGh+di1Y9I487I1xH9fBSy6En8gzeui6zz7
 xj1HttV+uwBvrun1un3Cbq14ZQifw1tXHOoi9eA5//9EK0Wm+0e3qoWpKu8IvBFGXnWUOzZ+i
 GvJMCJ6LdKf+cgbnBsBzmfAkcRoCag54RwfCf2799GJIj2WyHaCvFGN2e+CTAFILLvTlx4CxH
 GZn5AiDweqYgtoDfIqlVBtwb5npcpKOnlCb/F2OmPqOvO9bLHow/tSwZXVOUaCPbIqEdh6C5F
 a83KcexFAmmlfopF3w+P1xk4yjJujJfnIagPPdXXxJERvkfGXeoufFXJjRfyCoqpYrjm5cnVN
 MnyiRsnZbe6AY0S1GkdLn7Ihk81eVBSzZDcwZ9F5mgqHeNzMUFCJhMnYNuk4vRx1NT7AjJwXs
 4Sd8zcfmTN/gcqT66i17I2uB96Ey5TDYTsgmBC9dAek7ufS1IlhZSdesJ56xfrWeL9YmlBM5L
 9ThVhyKij8CupcsA9cigtdAFAuIwGeJCJK6pYOJmZ0QfFmNDkGjwODmDcxF+oIRL+Yn44wVOm
 seBuJtkkUfZNfnAW5SH3FFbaWxKWrlO0H6G6tM618VSv/kxFa/bECFv4m51vxalfBK2HPFQYp
 /uVmlsfyU5wrHCYKo0Y5KFVRzqhDs4WRi7Amd1QgvDWU7CTVCiovgNVvoEi/L1weRPSnmYg6c
 JN2duze2IRkp3DABnYn6dMQi30BtDUkoaNTYSys/L4UutHPE+sclMn6jiBXriW4WUiGcCQMxQ
 1I3Mrw4lWOLvnWu5An+pRZd6KjAQZu++Ahxs9ntFY2UWp27g0nGPoy9OTwjqr6Y/iuLEZbKSC
 07uPTaKuIqsRf9EJqqGxrlNQuBWf+0SM6xrSQLouf6QWDhBH9dFTsJbHue3+OaQGGiOLpneS/
 rAeOkR8z7+XQXf4LoLELGLPF7qkutY9Jx8rPx6iBZAzMycOxbRtw9vughjJg4A9nz+r+MDLSv
 VlJgu8u/yx++Mt0lR77lEcgy7lmXut2i3HYfFI463xY+fOMkV2ihuGZ3OzgdPsTMZ+6ZWpN8A
 VebFnVsYKR3HBCZCIIoLhxaqhb+yTHJoQeN9H5wWCjdTPHboeljI8AzKmscwHuFpberYAoXGQ
 =

On Wed, Dec 11, 2024 at 11:07:55PM +0100, Kristoffer Haugsbakk wrote:
>On Wed, Dec 11, 2024, at 21:13, Kristoffer Haugsbakk wrote:
>> See also this project idea https://github.com/gitgitgadget/git/issues/4=
38
>>
>> Which also links to a 2019 thread.
>>
>> With +CC on the participants. I hope that=E2=80=99s okay.
>
>Reiterating what I wrote there
>
>https://github.com/gitgitgadget/git/issues/438#issuecomment-2381017430
>
>I would store all ref metadata in one ref.  Either divide it
>up into files or have one structured file.  I=E2=80=99ve seen this idea
>floating around.  I haven=E2=80=99t seen any purpose-built tools for it y=
et.
>
https://wiki.qt.io/Git-gpush-scripts does exactly that, but putting a
state file into a special ref.

this script suite can be used to address bence's use case of migrating
wip state between machines, by having a git remote for the "magic" ref
space.

it's not perfect for a patch-based workflow, as i bolted it on as an
afterthought. and it could also use a github-centered mode. patches
welcome.
