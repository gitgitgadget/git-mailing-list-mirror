Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4441CA87
	for <git@vger.kernel.org>; Thu,  4 Jul 2024 16:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720110817; cv=none; b=iyVxOyEFrKntiLbIXqGucHtvu6/gBH2KK0s3le9Jh/tyNG9uKAYz7bDQdzIl3QNASJFV1fATCCBVUglelEk+qwNI19osVIhnVQvPBZFBLGo78WtLFGpnYf5twwOdfhiQ019j8ypDa90T2xGRp6mEflzn92XAux8MQrxN2SBHbgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720110817; c=relaxed/simple;
	bh=lrpVNUXOoSdaOxQm7MQ0GmgtcDxJn8WhxWBpxriaVxo=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=p1aSUrgADanKYZDCZSDgMvIzTyHjjPBKlVJCcmCkewsvQnpHXtEGqbFQHA7s/8c5tMG4aNp0LlGnMNmCcqkWuwj7RDeP+3P3d0Hr0Ml6MfN4/UpLlAnu3/Sq9Lvpxw1U6DXXYvp3sDG4fMsKIOmqJQBte2exld4W2nC9Lu56ZWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 464GXWwu2443090
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Jul 2024 16:33:32 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Abraham Zsombor Nagy'" <abrahamzsombornagy@gmail.com>
Cc: <git@vger.kernel.org>
References: <CANoqcKYwgA5sT0fAgSp4atpuPOaUSDALRVcf9XoajOe0g6xibQ@mail.gmail.com> <08e701dace1f$388be050$a9a3a0f0$@nexbridge.com> <CANoqcKZtOwghKGaUBfS_JnL4mBKsD9+=S1EX8J=rtVW4OUqjOQ@mail.gmail.com> <08ee01dace25$b87cf640$2976e2c0$@nexbridge.com> <CANoqcKZ8ABFQrfakK0MRbrgf-ipm4mPGHkvpFQ_Kg_mmn+F_JQ@mail.gmail.com> <08f101dace2e$adadffd0$0909ff70$@nexbridge.com> <CANoqcKasK6UOqa8YNKkqR+ZmizbMwP+Q9j0Yiid-mrUuXHQeew@mail.gmail.com>
In-Reply-To: <CANoqcKasK6UOqa8YNKkqR+ZmizbMwP+Q9j0Yiid-mrUuXHQeew@mail.gmail.com>
Subject: RE: Unable to push to git server
Date: Thu, 4 Jul 2024 12:33:26 -0400
Organization: Nexbridge Inc.
Message-ID: <090401dace2f$e88a1840$b99e48c0$@nexbridge.com>
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
Thread-Index: AQFrWY4iENBmw4H5pHVPakRrFzvPSgHloaVvAmKAru8Br0RWEgGVgQsuAcSE7bkBuvAhdrJtSWwQ
Content-Language: en-ca

Glad to help.
(Adding the original recipients back in for archive purposes).

From: Abraham Zsombor Nagy <abrahamzsombornagy@gmail.com>=20
Sent: Thursday, July 4, 2024 12:28 PM
To: rsbecker@nexbridge.com
Subject: Re: Unable to push to git server

Thank you Randall, I will contact GitHub to check the issue.
Sincerely,
Abraham

On Thu, Jul 4, 2024, 6:24=E2=80=AFPM <mailto:rsbecker@nexbridge.com> =
wrote:
On Thursday, July 4, 2024 12:05 PM, Abraham Zsombor Nagy wrote:
>Indeed, I got the error with the classic PAT as well as with OAuth =
authentication
>within Intellij IDEA.
>
>On Thu, 4 Jul 2024 at 17:20, <mailto:rsbecker@nexbridge.com> wrote:
>>
>> On Thursday, July 4, 2024 11:14 AM, Abraham Zsombor Nagy wrote:
>> >Thank you so much, with SSH, I was able to push my code.
>> >On Thu, 4 Jul 2024 at 16:34, <mailto:rsbecker@nexbridge.com> wrote:
>> >>
>> >> On Thursday, July 4, 2024 9:56 AM, Abraham Zsombor Nagy wrote:
>> >> >I'm trying to push my code to GitHub, however I'm unable to do =
so:
>> >> >
>> >> >abris@dell:~/Projects/maradandohalo/server$ git push
>> >> >--set-upstream origin main Username for 'https://github.com':
>> >> >nazsombor Password for
>> >> >'https://nazsombor@github.com':
>> >> >fatal: protocol error: bad line length 175
>> >> >send-pack: unexpected disconnect while reading sideband packet
>> >> >error: failed to push some refs to
>> >> >'https://github.com/nazsombor/maradandohalo.git'
>> >> >Enumerating objects: 31, done.
>> >> >Counting objects: 100% (31/31), done.
>> >> >Delta compression using up to 16 threads Compressing objects: =
100%
>> >> >(22/22), done.
>> >> >
>> >> >I use Debian 12. I tried this with the git installed via apt as
>> >> >well with the git compiled from source code. Git version: =
2.45.GIT
>> >> >
>> >> >I also asked this question first on StackOverflow:
>> >> =
>https://stackoverflow.com/questions/78670914/git-fatal-protocol-er
>> >> >ror
>> >> >-bad-line-
>> >> >length-173
>> >>
>> >> As far as I know, GitHub changed to use personal access tokens to
>> >> authentication
>> >for HTTPS push rather than password. Have you tried SSH?
>>
>> That's good but we need to understand what is going on with HTTPS. =
Try to create
>a PAT and try that.

I would suggest contacting GitHub and Intellij. This may also be a =
possible firewall/proxy issue in your environment. I may be wrong here =
(someone else chime in please) but this is not looking like it is caused =
directly by git. Part of this may be the communication protocol you =
selected in Intellij or a TLS compatibility issue between your machine =
and GitHub. There are some articles at StackOverflow discussing this =
error that may be helpful.

