Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7F5A4A
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 02:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 40B2s0cQ1732245
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 02:54:01 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Elijah Newren'" <newren@gmail.com>
Cc: "'Taylor Blau'" <me@ttaylorr.com>, "'Junio C Hamano'" <gitster@pobox.com>,
        "'Dragan Simic'" <dsimic@manjaro.org>, <git@vger.kernel.org>
References: <ZZ77NQkSuiRxRDwt@nand.local> <b2651b38a4f7edaf1c5ffee72af00e46@manjaro.org> <xmqqjzog96uh.fsf@gitster.g> <006b01da4412$96c6c500$c4544f00$@nexbridge.com> <ZZ8ZlX6bf+hjmhN+@nand.local> <007c01da4420$10a7b700$31f72500$@nexbridge.com> <CABPp-BEw_HFL-9u6WdSEe-qr_JfJyQtfU6PP7izEdPChKooc6g@mail.gmail.com> <008701da442f$b2dfe420$189fac60$@nexbridge.com> <CABPp-BHx=4HPSN4enkHTL7PPnNBsJ1vGWe4Em5imH7HcOcH2PA@mail.gmail.com>
In-Reply-To: <CABPp-BHx=4HPSN4enkHTL7PPnNBsJ1vGWe4Em5imH7HcOcH2PA@mail.gmail.com>
Subject: RE: [DISCUSS] Introducing Rust into the Git project
Date: Wed, 10 Jan 2024 21:57:44 -0500
Organization: Nexbridge Inc.
Message-ID: <009c01da4439$f70beef0$e523ccd0$@nexbridge.com>
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
Thread-Index: AQNL0k5wzhXZATyUnQ76Vxjn4eCV+QKEQ1wBALH7sDwDPprtZwK9Rr3fAtB2bewByXD01gDMKZblA0KzuhetYfeX4A==

On Wednesday, January 10, 2024 9:21 PM, Elijah Newren wrote:
>On Wed, Jan 10, 2024 at 5:44=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
>>
>> On Wednesday, January 10, 2024 7:59 PM, Elijah Newren wrote:
>[...]
>> >Would you be okay with the following alternative: requiring that all
>> >Rust code be optional for now?
>> >
>> >(In other words, allow you to build with USE_RUST=3D0, or something
>> >like that.  And then we have both a Rust and a C implementation of
>> >anything that is required for backward compatibility, while any new
>> >Rust-only stuff would not be included in your build.)
>>
>> To address the immediate above, I assume this means that platform
>> maintainers will be responsible for developing non-portable
>> implementations that duplicate Rust functionality
>
>This doesn't at all sound like what I thought I said.  The whole =
proposal was so that
>folks like NonStop could continue using Git with no more work than =
setting
>USE_RUST=3D0 at build time.
>
>Why do you feel you'd need to duplicate any functionality?

I think I misunderstood. What I took from this is that all new =
functionality would be in Rust, which would require a custom =
implementation in C for platforms that did not have Rust available - if =
that is even practical. Did I get that wrong?

