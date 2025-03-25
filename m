Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A6A27706
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 15:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742916007; cv=none; b=ua1lRzgYYoh5UowOBBhQlby98YxSZcZj2OR4Pq3wHvPDMiVw/byIm9wFjC7UFgk4eHQPD9WGyMbs/WB06C4X28zWYmZOO3rBX7Ry00fOorg0WQdtJ8u8ZBtH+3rB+2K8/S8O1Lkxhi0w0BYyWJIQvcSFU6ARuzwjLvcheD9NrWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742916007; c=relaxed/simple;
	bh=YWLbFfc3/YZcDRrtZEOwhL3MnpM0rJ+Hwn2HOdT+xbc=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=pjzTPjlKPSqjp9w9kA42fKbrZQF3Tm/viCm6iFLlgOYdd6VNi1BFAH8px/o07QhN4YWyvLxiRvR9igNmWo5l/VqjPqQ6jYKFkfgvhiXE+nMNs5N5IkFZTTHdMQRdRKfkDaIMSNBtaYIg2/u79ml5pDOvtn9qxVcNqipmykdbLyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 52PFJnhU690703
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 15:19:50 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Patrick Steinhardt'" <ps@pks.im>,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        <git@vger.kernel.org>, "'Taylor Blau'" <me@ttaylorr.com>
References: <Z9vuiCnKcMRRXHOR@pks.im> <Z9ySGbE4sq0JfgKs@tapette.crustytoothpaste.net> <Z-Knm2WGeMI9a7zt@pks.im>
In-Reply-To: <Z-Knm2WGeMI9a7zt@pks.im>
Subject: RE: Possible venues for Git Merge 2025
Date: Tue, 25 Mar 2025 11:19:44 -0400
Organization: Nexbridge Inc.
Message-ID: <022801db9d99$5a56b2b0$0f041810$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHLx1XFQGlW4lvMUsPU/M/mQ6bKUQHLITbwAnmlY2+zgXq+IA==
X-Antivirus: Norton (VPS 250325-16, 3/25/2025), Outbound message
X-Antivirus-Status: Clean

On March 25, 2025 8:55 AM, Patrick Steinhardt wrote:
>On Thu, Mar 20, 2025 at 10:09:29PM +0000, brian m. carlson wrote:
>> On 2025-03-20 at 10:31:36, Patrick Steinhardt wrote:
>> > given that this year is the 20th anniversary of the Git project it
>> > would be great to host another Git Merge so that the wider community
>> > can come together and celebrate. Taylor and I have been chatting
>> > about this opportunity a bit to figure out what we're going to do this
year.
>> >
>> > We have been discussing two different options:
>> >
>> >   - Hosting in the US in San Francisco at the GitHub HQ.
>> >
>> >   - Hosting in the EU in Amsterdam colocated with the Open Source
>> >     Summit Europe.
>> >
>> > Typically, the location is alternating on a yearly basis between the
>> > US and the EU. So given that last year it was hosted in Berlin it
>> > would be the US' turn. But given the recent political climate in the
>> > US I'm afraid that many people would not feel comfortable traveling
>> > there right now. So in the spirit of being inclusive I think we
>> > should at least consider whether we may want to break the typical
>> > alternating cycle and host in the EU again.
>>
>> Yes, I do think that given current circumstances the U.S. is not a
>> good place to host events.  Perhaps that will change in the future,
>> but I don't think that would be a prudent choice right now.  I've
>> talked to several people who are uncomfortable traveling there, so
>> we'd probably get better attendance hosting elsewhere.
>>
>> I would be fine with Amsterdam, and I might also suggest a major
>> Canadian city (such as Toronto, Montreal, or Vancouver) if we
>> preferred to do this in North America (since we've traditionally
>> alternated continents).  I can imagine other locations outside of the
>> U.S. that might be fine as well, so I'm willing to keep an open mind
>> if a good opportunity comes up.
>
>The only reasons why I proposed Amsterdam are the Open Source Summit and
that
>I have some ways to help out with organizing the event over there.
>I would be equally happy with alternatives like Canada, but didn't really
want to
>propose alternatives like this myself because I would have to push the
entire burden
>onto somebody else.
>
>So if it would be a possibility and if people could help out getting things
organized in
>other countries/continents I'd be happy.

There are multiple venues in the Toronto area that can support 1500+
attendees. 
Examples I have used:
Metro Toronto Convention Centre (downtown, likely preferable but they need
the longest advanced notice)
Westin Harbour Castle (downtown, loads of conference space)
Exhibition Place (downtown, no on-site hotels)
Rogers Centre (downtown, decent hotel and conference rooms)
Various airport hotels (including Marriot)

There are convenient dedicated express trains from the airport to downtown
that
accept luggage. Most airport hotels (Marriot) have shuttles to/from the
airport continuously
from 0400h to 0200h.

I have been to all of the above - and organized conferences at each about 2
decades ago, but
info should still be valid. I can assist if requested.

--Randall

