Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB5D6A33F
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 14:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481593; cv=none; b=fzyR8xpnY1GM3Jp4xLO1CtRxHb+FcATYn8xWwZwVQhJV13t6hEoSMnLYSWYiq+Ya5K6/7ERKjjkhVBbnOzYwocSL6bVkMHRbj/H344Omkq91lrY+QnOpLNYI0Z1Se5P51QonGBdoaizs5J2ILxzfVbsM9d0f70JhvAAHn3mak3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481593; c=relaxed/simple;
	bh=ET6aMeS0mfIF0BThwNjvDn5XsQhR6Mahdqb+fmzkt0c=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=LnpcApD3dpnhNXEcO/oiOK2lsiMULyNgFH9lLztAGLhUY82pUxTS6ttGMjljn3bJ5zI9EtMVnaLQCtH5NLZHrveft8sbvJVirTqkT+U5pmrerGDUT0CuyV/JYQk7qNfNE9NbkTcOgK7dHqwE2GuieWvqCfdR9Qcf7uFTfBBaCl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 52KEdeQB3800542
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 14:39:40 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Taylor Blau'" <me@ttaylorr.com>, "'Patrick Steinhardt'" <ps@pks.im>
Cc: <git@vger.kernel.org>
References: <Z9vuiCnKcMRRXHOR@pks.im> <Z9wcY/55BoMsaEnt@nand.local>
In-Reply-To: <Z9wcY/55BoMsaEnt@nand.local>
Subject: RE: Possible venues for Git Merge 2025
Date: Thu, 20 Mar 2025 10:39:35 -0400
Organization: Nexbridge Inc.
Message-ID: <043401db99a5$ea048560$be0d9020$@nexbridge.com>
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
Content-Language: en-ca
Thread-Index: AQHLx1XFQGlW4lvMUsPU/M/mQ6bKUQGSy9Dcs48l56A=
X-Antivirus: Norton (VPS 250320-8, 3/20/2025), Outbound message
X-Antivirus-Status: Clean

On March 20, 2025 9:47 AM, Taylor Blau wrote:
>On Thu, Mar 20, 2025 at 11:31:36AM +0100, Patrick Steinhardt wrote:
>> Hi,
>>
>> given that this year is the 20th anniversary of the Git project it
>> would be great to host another Git Merge so that the wider community
>> can come together and celebrate. Taylor and I have been chatting =
about
>> this opportunity a bit to figure out what we're going to do this =
year.
>>
>> We have been discussing two different options:
>>
>>   - Hosting in the US in San Francisco at the GitHub HQ.
>>
>>   - Hosting in the EU in Amsterdam colocated with the Open Source
>>     Summit Europe.
>
>Sorry for the miscommunication on our part! Let me clarify some of the =
details
>around where things are with Git Merge planning:n
>
>I have been looking into various option for Git Merge this year to =
celebrate the
>project's 20th anniversary. After exploring a number of options, GitHub =
has secured
>the budget and space availability to host Git Merge at GitHub HQ in San =
Francisco
>over a couple of weekdays in September!
>
>We haven't finalized exactly what those two days are yet, hence why I =
haven't sent
>an announcement yet to the list. As soon as we finalize what those =
dates are, I'll
>send an announcement with the details (including the dates ;-)).
>
>Please expect that from me soon, and I am very much looking forward to =
seeing as
>many people in San Francisco to celebrate as can make it!

While I would love to be at Git Merge, travel to the US is currently =
restricted and I will
not be able to attend meetings at a US venue. Amsterdam would be a more =
acceptable
location for the foreseeable future. I hope that will change by =
September, but it is not
up to me.

--Randall

