Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA601591E8
	for <git@vger.kernel.org>; Mon,  6 May 2024 20:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715027958; cv=none; b=e4cEqZSXgO3vEqXBYTg9+EJkkj2CNc2J1tVx60JjAHGoWPXUpMNcZzE8lCO9McU7S4/SKOg7/bDhCE4ZWCLNUZWwQlIwf8crCk5EnS5NAba+1YOCgEzK09iZyK5PFuJpkVFumFowzff28sh50r2MXeWsSENK56xuTVHMzlALye0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715027958; c=relaxed/simple;
	bh=OWZV2fhYNVtj0xakftU0/ur2tg7TIy+ADIihZY3Y8UU=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=SEWUFkkazDHRfpJuqVnGwT/szjdM+Y3ZGm1mCjDFIlU4KPGstgdD3Y9nMOEQ7r4D9GEx24Z2Q9q2EKRAz1OyW2GR3VJ0CBOB1+TmsVVdY+/ovjcSmqbDpONEKQzSolOIacYVauGpcGjhyc5O/ru5SmjGZAYc5fvtQYBNQwTtDvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 446Kd3C12639699
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 6 May 2024 20:39:04 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Taylor Blau'" <me@ttaylorr.com>, "'Patrick Steinhardt'" <ps@pks.im>
Cc: <git@vger.kernel.org>, "'Kristoffer Haugsbakk'" <code@khaugsbakk.name>,
        "=?utf-8?Q?'Jean-No=C3=ABl_AVILA'?=" <jn.avila@free.fr>,
        "'Eric Sunshine'" <sunshine@sunshineco.com>,
        "'Junio C Hamano'" <gitster@pobox.com>,
        "'Dragan Simic'" <dsimic@manjaro.org>
References: <cover.1709724089.git.ps@pks.im> <cover.1714982328.git.ps@pks.im> <Zjk73l5l6AqQOz6N@nand.local>
In-Reply-To: <Zjk73l5l6AqQOz6N@nand.local>
Subject: RE: [PATCH v5 00/14] builtin/config: introduce subcommands
Date: Mon, 6 May 2024 16:38:59 -0400
Organization: Nexbridge Inc.
Message-ID: <04ef01da9ff5$700fab90$502f02b0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKBQTBe5e4gLvpUZ43kt8vf+F35UwI064m5Ae+SBLSwHEQ6gA==
Content-Language: en-ca

On Monday, May 6, 2024 4:22 PM, Taylor Blau wrote:
>On Mon, May 06, 2024 at 10:55:51AM +0200, Patrick Steinhardt wrote:
>> Hi,
>>
>> this is the fifth and hopefully last version of my patch sthat
>> introduces subcommands into git-config(1).
>>
>> The only changes compared to v4 are some fixes to commit messages.
>> Otherwise I'm not aware of any other feedback that would need to be
>> addressed.
>
>Thanks for the new round. I took a close look through the series, and =
couldn't see
>any remaining issues. I appreciate the translation guide you included =
in the
>documentation to indicate "git config --add" is replaced by things like =
"git config set
>--append".

Please make sure that there is a compatibility mode available for some =
large period. There are huge numbers of scripts in the customer base I =
deal with that use config extensively. Changing the CLI for this will be =
dire consequences.

