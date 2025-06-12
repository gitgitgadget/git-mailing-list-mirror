Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EB253365
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 13:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749735367; cv=none; b=RtV8I7UX6xZ/k3HU0UpFw/wTQXmB90Rq6238KC/pa+drcIT1buVxYo/sVUFIx4PL4tmcIAb81XIPIiEvFSSgrkAPwKxOONOixOvmN2+sgr0Vm2oFoA4+6ENQ+tLR7ZjSuMbfR1+dwyOUYbSKN0uxLkYgoZpshAXO1fJJuzRWKw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749735367; c=relaxed/simple;
	bh=wxMylca+SN0UwJwEcto57CuF4nYnAQpCnSNOcDnoAfE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JGxr37XCevC5ovbIPYNIFpA/qckuemH4i8zok0zHl/8YId5dp0yC2cDtsgME74AiBc9Hc/xYY9CA1sV01OJolsrqjCzLUF8Tp2ZwWM4WcGZ9cXijWIGsR4NwWHBj1ewiwonT2E40/ycN0tptLpSmsIPh/Ys5u1jz6FmtzXCbh5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mad-scientist.net; spf=pass smtp.mailfrom=mad-scientist.net; dkim=policy (768-bit key) header.d=mad-scientist.us header.i=@mad-scientist.us header.b=ZVxIkKN8 reason="signing key too small"; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mad-scientist.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mad-scientist.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=policy reason="signing key too small" (768-bit key) header.d=mad-scientist.us header.i=@mad-scientist.us header.b="ZVxIkKN8"
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
	by cmsmtp with ESMTPS
	id Pcl9u7C8mbmnlPi61uP8OZ; Thu, 12 Jun 2025 13:35:57 +0000
Received: from box5922.bluehost.com ([162.241.30.80])
	by cmsmtp with ESMTPS
	id Pi60uLHGou7xjPi60uuEvP; Thu, 12 Jun 2025 13:35:56 +0000
X-Authority-Analysis: v=2.4 cv=IIkECBvG c=1 sm=1 tr=0 ts=684ad7bc
 a=u+82WREdhvUKZ7QTvcqjvQ==:117 a=u+82WREdhvUKZ7QTvcqjvQ==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=e_eVUG9BRDgA:10
 a=FkpazqlwEZeR9lt1bWEA:9 a=QEXdDO2ut3YA:10 a=zJEHElnSJ-yMYEcKvQ7e:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mad-scientist.us; s=default; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:Reply-To:From:Subject:Message-ID:
	Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5dzEeoenw6D/iXIWun727q1ULj6oAbxR74Q0baDWPF0=; b=ZVxIkKN8n5heWin3iK4mfJG2IK
	iUnz6GXm4vydLVrECGIDQPHJ7gaBpCjx6nU1BcWjbhMS5kdbdx1Tww96LlhfjmllsXcwpFpBY+wMa
	5H7LX+jGIm4XeCN9IJ9Iz5L19;
Received: from [160.231.220.149] (port=34178 helo=llin-psh13-dsa.dsone.3ds.com)
	by box5922.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <paul@mad-scientist.net>)
	id 1uPi60-00000002IBO-0Wq0
	for git@vger.kernel.org;
	Thu, 12 Jun 2025 07:35:56 -0600
Message-ID: <b2d23be73902c8433295e2a5f30b051d044e227c.camel@mad-scientist.net>
Subject: Re: Solaris sed
From: Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To: git@vger.kernel.org
Date: Thu, 12 Jun 2025 09:35:54 -0400
In-Reply-To: <CAPig+cROcMt1crKjvqcetFNGdE4ywmD1+NO+q+MnDzctx8ewag@mail.gmail.com>
References: <09f954b8-d9c3-418f-ad4b-9cb9b063f4ae@comstyle.com>
	 <xmqqo6utfvxu.fsf@gitster.g>
	 <CAPig+cROcMt1crKjvqcetFNGdE4ywmD1+NO+q+MnDzctx8ewag@mail.gmail.com>
Organization: Please remain calm--I may be mad but I am a professional!
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5922.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 160.231.220.149
X-Source-L: No
X-Exim-ID: 1uPi60-00000002IBO-0Wq0
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (llin-psh13-dsa.dsone.3ds.com) [160.231.220.149]:34178
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTkyMi5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOBIwlzaqClZ2Ba8TY4Rwbhbiugj9pOz6tW9fU8f3OEQx71DrC8kAYbI8++yWdelEEYzQ8vL2GkFJiouW6klyk+Cs2y5or1YVKgSLlcyPniuybhqqu7Z
 snIQGX4zKq1zw0+gN+AG2WUtfYkU+RPrsf592LJhfMThL7av82NhVhTMKw2IaN1BAVSeDhxqKSbSsy2JV+B6MEApnR2lRPK8Hzc=

On Thu, 2025-06-12 at 01:50 -0400, Eric Sunshine wrote:
> Had it used the simpler:
>=20
> =C2=A0=C2=A0=C2=A0 echo "$foo"
>=20
> this sort of problem (forgetting the "\n") would never have occurred.

Just be aware that echo is not well-standardized: many versions of echo
accept extra options or treat certain chars specially.  So, printf
(which IS well-standardized) is always safer unless you are 100% sure
that the text on the echo command line is simple: cannot start with a
"-", doesn't contain special chars like backslash, etc.

For portability I (personally) always prefer printf unless I know
exactly what the text contains (like showing a static string).
