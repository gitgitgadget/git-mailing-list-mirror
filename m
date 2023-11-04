Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B90A946
	for <git@vger.kernel.org>; Sat,  4 Nov 2023 14:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4EAD47
	for <git@vger.kernel.org>; Sat,  4 Nov 2023 07:55:57 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 3A4Eqg6T230053
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 4 Nov 2023 14:52:43 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Jeff King'" <peff@peff.net>, "'Eric Sunshine'" <sunshine@sunshineco.com>
Cc: "'Git List'" <git@vger.kernel.org>
References: <00a101da0e88$778cd3b0$66a67b10$@nexbridge.com> <CAPig+cTzWCpmksJm-0M1MfUSeYpWbgMaFNHRSOtAhCsNQigV-g@mail.gmail.com> <00c301da0e9d$0d2cb8e0$27862aa0$@nexbridge.com> <CAPig+cRG3VWgnwOPWvbW9boUooa6sD9d667wbSUe4_RkcR60vg@mail.gmail.com> <00c401da0ea1$b61899c0$2249cd40$@nexbridge.com> <CAPig+cQpxRQnhffR8EWWRhqJPmOeOuCE3qsuMcnDyuMLLbTH8Q@mail.gmail.com> <20231104134915.GA1492953@coredump.intra.peff.net>
In-Reply-To: <20231104134915.GA1492953@coredump.intra.peff.net>
Subject: RE: Request for Help - Too many perl arguments as of 2.43.0-rc0
Date: Sat, 4 Nov 2023 10:55:47 -0400
Organization: Nexbridge Inc.
Message-ID: <00e301da0f2f$024f9360$06eeba20$@nexbridge.com>
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
Thread-Index: AQH8AFPdmoJbSBrW69WyjYc4DVAhPQHKzdRFAXVVb+ICzGdHswG6Pfs1ALN0UB0CcynsmK/O8Z5g
Content-Language: en-ca

On November 4, 2023 9:49 AM, Jeff King wrote:
>On Sat, Nov 04, 2023 at 02:36:48AM -0400, Eric Sunshine wrote:
>
>> I don't see an urgent need for it. Unlike the actual tests themselves
>> run by `make test` which may catch platform-specific problems in Git
>> itself, the purpose of the "linting" checks is not to catch
>> platform-specific problems, but rather to help test authors by
>> identifying mistakes in the tests which might make them fragile. So,
>> disabling linting on a particular platform isn't going to cause `make
>> test` to miss some important Git problem specific to that platform.
>
>Hmm. With compilation, we split the audience of "developers" vs "people =
who just
>want to build the program", and we crank up the number and severity of =
warning
>checks for the former. We could do the same here for tests. I.e., turn =
off test linting
>by default and re-enable it for DEVELOPER=3D1.
>
>OTOH, this is the first time I think I've seen the linting cause a =
problem (whereas
>unexpected compile warnings are much more likely, as we are depending =
on the
>system compiler's behavior).
>
>So consider it an idle thought for discussion, and not necessarily a =
proposal. ;)

In my case, I am building git for users of the platform (a.k.a. mostly a =
packager), although I'm hoping to be more involved in contributions =
soon. This involves build + full test under multiple situations on the =
NonStop platform.
--Randall

