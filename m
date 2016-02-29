From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: What's cooking in git.git (Feb 2016, #07; Thu, 25)
Date: Mon, 29 Feb 2016 11:28:41 -0500
Message-ID: <CAPig+cQkP++rnE4L1QSr-sW8VkS8ce7CyY9KAscebLao2Hw73A@mail.gmail.com>
References: <xmqqfuwgmlgy.fsf@gitster.mtv.corp.google.com>
	<56D078F3.9070905@web.de>
	<xmqqsi0fjpez.fsf@gitster.mtv.corp.google.com>
	<56D0D2DF.1040807@web.de>
	<xmqqtwkvhwpd.fsf@gitster.mtv.corp.google.com>
	<20160227032907.GB10313@sigill.intra.peff.net>
	<56D14C56.6070306@web.de>
	<20160229101808.GD2950@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 29 17:29:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaQh4-0008Oa-51
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 17:29:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753718AbcB2Q2r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Feb 2016 11:28:47 -0500
Received: from mail-vk0-f41.google.com ([209.85.213.41]:35865 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbcB2Q2m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Feb 2016 11:28:42 -0500
Received: by mail-vk0-f41.google.com with SMTP id c3so139086094vkb.3
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 08:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=yZ9OiA8yJDiT8OENG4IxX49j5//eC25Q/QAhptaTdnk=;
        b=B9k7VX8jA42vxMJ3fUkhVDYF38BYZER6P5+kBt2UJZlwKGw4zhkcZ4wSF5CSreoFUc
         IGakvfnRpL3P6L4MevQSmRHl5qqqgn+VJqikhKjms5qVy3LHcJxe7HED6JCqbpUoVgHu
         fonRQYQEANJgsAGhdO4HSeXravacUcDNNedsCT9vBv9HWAQqpwNTilocRAFuin07tH5x
         2V4ihyZQFWWNeYIqGvMNIUh0mP7IRRZapnCETK/sPFN9ZBoJoB47H32kXzSg15YGk9/D
         dCUhRNqkS421y+B0IB6L65IaiisiCbOdSSE5AoCYvft+1x2+KWxgMujry9uCVSwXff2k
         BlWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=yZ9OiA8yJDiT8OENG4IxX49j5//eC25Q/QAhptaTdnk=;
        b=EuwnDZyM1j1hrPekSJ8Z08d/ZBl78zlf2GS4refdNKKG9x/yf8Nd+3h1YKw7dNrmwl
         cT4lqn8Gab8sZzsnrV7NMO7YCt/qZYGXw+Xlbzp6jmzsSXn9WYSYGUwi8W48TpUSAt+Q
         KMBddgqAT4SDtFhE3+6YAMKIhTztqScU6eRbbOovWVQlhxB3rQ12pkEymmcZ9/Zgt01J
         rMDzD0SUztJmZHKq1qx2VNsJ3FjaT/rZYnTL40xO4I3uJrLdZNaaewJH80/NqziCwXct
         CTOAJhAi/mkXPLPNeOPIUYwzwMAmUDYrbjAsPRMEevIoftGygcEtSd6BbWwLg30I9CA4
         zvwQ==
X-Gm-Message-State: AD7BkJJPQt8Jp2RBUO4aUeV3vacLqTOvB3BDIRRYRwpXkdUlU4Lc1Jn38KblUqzoCLZA0W69IQ5lQh475YjIpg==
X-Received: by 10.31.168.76 with SMTP id r73mr12181885vke.117.1456763321226;
 Mon, 29 Feb 2016 08:28:41 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 29 Feb 2016 08:28:41 -0800 (PST)
In-Reply-To: <20160229101808.GD2950@sigill.intra.peff.net>
X-Google-Sender-Auth: w8ojz7fm9Dh14CeHZ6Js28eAAsc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287847>

On Mon, Feb 29, 2016 at 5:18 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Feb 27, 2016 at 08:12:22AM +0100, Torsten B=C3=B6gershausen w=
rote:
>> > Torsten, what is the compiler version (I don't have Apple compiler=
s, but
>> > it seems plausible that older clang might have the same problem).
>>
>> That's machine is running Mac OS X 10.6, which is no longer supporte=
d
>> with updates.
>>
>>  gcc --version
>> i686-apple-darwin10-gcc-4.2.1 (GCC) 4.2.1 (Apple Inc. build 5666) (d=
ot 3)
>> Copyright (C) 2007 Free Software Foundation, Inc.
>> This is free software; see the source for copying conditions.  There=
 is NO
>> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR P=
URPOSE.
>
> Thanks. Out of curiosity, I tried to reproduce by with a build of gcc
> 4.2.1, to see if I could bisect. But it seems the toolchain is quite
> complex. After much munging, I managed to build a broken compiler (wh=
ich
> I think is due to a much too-new version of bison, but I stopped
> digging).
>
> Your suggestion elsewhere in the thread to just use clang instead sou=
nds
> good to me. :)

If possible, for the moment, I'd prefer to hold off on that
sledge-hammer approach of unconditionally making the build use clang.
It would be nice to have a more detailed understanding of what exactly
is triggering the Apple compiler bug, and I've been trying to find
time to check it out on my old Mac.
