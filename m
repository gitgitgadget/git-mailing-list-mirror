Received: from mail.comstyle.com (speedy.comstyle.com [206.51.28.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1659F18BC3D
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 04:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.51.28.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749702371; cv=none; b=L2iDnpvSib+lYS0wZcP9MU+m6c1xot4ygpYU+LIyfHp1cAtaeGxvSD7IbcSjAUwjKpEgJe/ADpdC+wUvgx8Nh8wsOFjg0ZqOjAwcv2iYOqFL/kwiCZ+HdeRiihC8htFr4yl8FU49Cs6lgBzuEa/tvvtjnwXVwFJdv6fDc+UWj78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749702371; c=relaxed/simple;
	bh=if3eoVeOMuodo5hoI+0AaYiI18paNPCMLaQJy0qF2XM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q+vC3qatSUrQjpw2gIZ6cyTk5k0fLeo08Msp9t/tu0+BJlKH8YNwInzpR6vH9PXI2QDT/ZWe9FlLT00KWWgKLmgn1/MA5X/4sXraEVn/6tB4vsLSOugN7wWQK9lHxTL3zTn0raWA+4IXVLS/xbDhdF5Epf8jHfyxXvJhgWrzrW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comstyle.com; spf=pass smtp.mailfrom=comstyle.com; dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b=X1w8jY/f; arc=none smtp.client-ip=206.51.28.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comstyle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=comstyle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b="X1w8jY/f"
Received: from mail.comstyle.com (localhost [127.0.0.1])
	by mail.comstyle.com (Postfix) with ESMTP id 4bHqGS6RRFz8PbQ;
	Thu, 12 Jun 2025 00:26:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=default;
	 bh=if3eoVeOMuodo5hoI+0AaYiI18paNPCMLaQJy0qF2XM=; b=X1w8jY/fmjQq
	SWNelXE8h2ZY9LcS8TGJ0FSFDXJSjhPOIUHGcO27xMA5QFS+Dieb0Ro43YVn0js1
	psD+LAUg8/ApQ4qtSg5ueOnuMNI37+yimIlhBtSbXY2+ZRXdB2VlMeoaGW4n+zRT
	3wnQJoD7EmRd1A97TqjExK447hhZZZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=message-id
	:date:mime-version:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=default; b=EvG
	ojiCNgP8m6LwPLmY/Gob4lJiQCIQpQTBZNWznZoQxQ8sxw2aZLvF7imMRt/nQVPN
	/Gk75/H/wSL7rbd2A6kFUaIUNwCuUc2E4chfjQAJk4tI2Mvo3R0B+MToXOhuvzi4
	IK5Q25Jq0Vjvn/FC2eQ+XrBCOVpXAiErq5YKr/uU=
Received: from [IPV6:2001:470:b050:6:142d:4b81:8fea:90b2] (unknown [IPv6:2001:470:b050:6:142d:4b81:8fea:90b2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: brad)
	by mail.comstyle.com (Postfix) with ESMTPSA id 4bHqGS3ccrz8PbN;
	Thu, 12 Jun 2025 00:26:08 -0400 (EDT)
Message-ID: <e63d1ef3-6bd9-4720-95ea-16c800f549c1@comstyle.com>
Date: Thu, 12 Jun 2025 00:26:07 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Solaris sed
To: Eli Schwartz <eschwartz@gentoo.org>, Collin Funk <collin.funk1@gmail.com>
Cc: git@vger.kernel.org
References: <09f954b8-d9c3-418f-ad4b-9cb9b063f4ae@comstyle.com>
 <87bjqteicd.fsf@gmail.com>
 <f2082cde-7eb9-4927-a01c-e6fb3b355d13@comstyle.com>
 <ed3d9c32-5de8-4653-be75-d2b5c89340e0@gentoo.org>
Content-Language: en-US
From: Brad Smith <brad@comstyle.com>
In-Reply-To: <ed3d9c32-5de8-4653-be75-d2b5c89340e0@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 2025-06-12 12:16 a.m., Eli Schwartz wrote:
> On 6/11/25 11:49 PM, Brad Smith wrote:
>> On 2025-06-11 11:42 p.m., Collin Funk wrote:
>>> Hi Brad,
>>>
>>> Brad Smith <brad@comstyle.com> writes:
>>>
>>>> Building on Solaris I noticed the following two issues with Solaris =
sed.
>>>>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 GEN version-def.h
>>>> sed: Missing newline at end of file standard input.
>>>>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 GEN config-list.h
>>>> sed: illegal option -- E
>>>> Usage:=C2=A0 sed [-n] script [file...]
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sed [-n] [-e scrip=
t]...[-f script_file]...[file...]
>>>>
>>>>
>>>> https://github.com/git/git/commit/
>>>> e1b81f54da80267edee2cb8fd0d0f75f03023019
>>>>
>>>> The second issue being introduced fairly recently. Not sure what
>>>> would be
>>>> appropriate fixes. Just pointing them out if someone has an
>>>> suggestions for
>>>> fixes.
>>> I noticed these as well, but just ignored them since it seems to buil=
d
>>> fine.
>>>
>>> The first one seems like just a warning? Probably something to do wit=
h
>>> POSIX defining a "Text File" as "A file that contains characters
>>> organized into zero or more lines" where a line is "A sequence of zer=
o
>>> or more non- <newline> characters plus a terminating <newline>
>>> character."
>> It looks as if it is just a warning to me. I wasn't worrying about tha=
t
>> one as much
>> as I was the second issue.
>>> The second is more tricky. The '-E' option to use EREs was not added =
to
>>> the specification for 'sed' until POSIX.1-2024 [1]. Maybe the script
>>> could check for the 'gsed' command? All of the (few) Solaris machines=
 I
>>> use will have many GNU programs installed like that.
>> I can't comment on that especially as the build bits support pretty ol=
d
>> releases and
>> I have no idea how long Sun / Oracle have been shipping GNU bits like
>> this. I do not
>> believe this has always been a thing.
>
> The Solaris box I have a shell on, has gsed installed as a purely
> optional third-party addon from a third-party package feed. As far as I
> know, Solaris never did nor plans to ship "GNU bits like this".
>
> Of course, the Git project *could* declare users must first build GNU
> sed, then build Git. Or only build on boxes where the admin is a GNU
> enthusiast. But that option seems unlikely and unattractive...

To clarify what I meant. Solaris 11 from the looks of it includes GNU=20
sed with
the base OS. That was not the case with 10 and older.

The documentation for 11.4 for example mentions both versions of sed.

https://docs.oracle.com/cd/E88353_01/html/E37839/sed-1.html
https://docs.oracle.com/cd/E88353_01/html/E37839/sed-1g.html
