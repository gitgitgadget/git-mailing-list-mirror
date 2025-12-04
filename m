Received: from mail-07.mail-europe.com (mail-0701.mail-europe.com [51.83.17.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C822BEFE0
	for <git@vger.kernel.org>; Thu,  4 Dec 2025 08:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.17.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764837321; cv=none; b=oK/sUg10OwqKx3Wfkv2sJSuVbqheb2yo/7vi7bDFYd0pgRqtZON7FLsXz3qbxRvzqOWjfSLRcvgcvFoSofX86iEC3TdcPQVf+ysvUM2EkZF5oNyuIkDTKRkwgIfAyL9bEQgjLOArbepvOQF71iSaUFB2Flj7gUGTRnNGmCJ5jN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764837321; c=relaxed/simple;
	bh=/oyIoSTdisYJbrch8G2KxmYtE6WiRZ70fvVeRIuJWSc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qj67dIpIKZ/7o/uBPosXLRUhickHXRM3Z77H+Cz0N9Y3UbIA6C3vjQ26WZzfVze9rJKuh4xkcA1Vj1U0KwJ0usB59UH1oORIvB1yyu9D+LT7GD1CYUtR6w1KwjpgJaHHCh6zDjLxWhUG+LRuRVzXeRhz43jHdI1hseDSSTRTrdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=x14.nl; spf=fail smtp.mailfrom=x14.nl; dkim=pass (2048-bit key) header.d=x14.nl header.i=@x14.nl header.b=VMTZzvdZ; arc=none smtp.client-ip=51.83.17.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=x14.nl
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=x14.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=x14.nl header.i=@x14.nl header.b="VMTZzvdZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=x14.nl;
	s=protonmail; t=1764837300; x=1765096500;
	bh=/oyIoSTdisYJbrch8G2KxmYtE6WiRZ70fvVeRIuJWSc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=VMTZzvdZWD4Udt1CLfO4/Eb3Ibmcuv85qPpWsQPkxtMT9vweE8n5dajqfMv80fuuA
	 oXVQO+qyUdKwcopUf8jL6xVwZqxfDU0f9LlGvcZ2L7bBAOre7WgRldQtWSr0fSpfed
	 g4QO5BCVWJDTYA+REGAgI/8U8U7oKCbkKEPqU0+OspZmS6vhlUSvxGL9gpFWSfz3Oo
	 BN8TRkl36K7HiL7wtW3jBfAnYxuam4jAxvTCOehokYtPtyDvJhTPd9pNlOHwKECYgz
	 4FWYTi70sPlEP2jrkMd64QbWw0YVnWCuot+/cGu22l74bh81O3yCUfGQmqbHOqkaXs
	 YnecFCAPaH5nA==
Date: Thu, 04 Dec 2025 08:34:56 +0000
To: Mark Boonie <boonie@us.ibm.com>
From: Michiel Beijen <mb@x14.nl>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Command line query for teams
Message-ID: <k-decXSZ9QGZzgAzy5RoGwHGYOyGjmCnHpa951-iEy2DWj9cjViEaET6xO1HuAd-Dz23x6VYAtlfE8USIyH1zsHtsfAah6w8WllZPn8qP88=@x14.nl>
In-Reply-To: <PH7PR15MB617958EEAF07E4C5F8CDF0C5FBA6A@PH7PR15MB6179.namprd15.prod.outlook.com>
References: <PH7PR15MB617958EEAF07E4C5F8CDF0C5FBA6A@PH7PR15MB6179.namprd15.prod.outlook.com>
Feedback-ID: 168480574:user:proton
X-Pm-Message-ID: a73878030151f8a0f2dcd72b7f1dea7fbd311789
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Thursday, December 4th, 2025 at 06:10, Mark Boonie <boonie@us.ibm.com> w=
rote:

> I'm a git very-newbie, still trying to find my way around, so I apologize=
 if the answer to this question is somewhere obvious to everyone but me. I'=
m looking for a command that will return the teams that I'm on. Someone gav=
e me the URL https://github.ibm.com/orgs/ztpf/teams?query=3D+members%3Ame, =
which gives me the information in a GUI, but I would like to get the inform=
ation from the command line. Any suggestions?

What you're looking for is not a git feature but a feature from GitHub. Git=
Hub takes the git source control system and adds authentication, issues and=
 pull requests and many more things 'on top'. GitHub has their own command =
line utility called 'gh' that you can install, see https://cli.github.com/

However it does not expose the info you're looking for directly. You can us=
e it to request the teams in a given organization, and then you can request=
 for each teams the members and check if you are in it.

I hope this helps,

--
Michiel
