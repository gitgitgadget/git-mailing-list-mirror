From: JT Olds <jtolds@xnet5.com>
Subject: Re: Git Rebase blows away GIT_AUTHOR_NAME
Date: Mon, 17 Jan 2011 20:55:42 -0700
Message-ID: <AANLkTinY1Wcirxi2bRUv+GuTG9eWczd-T1o0Mmx8VFdA@mail.gmail.com>
References: <AANLkTikqfX3jhSdP5xhFj=VktqW2S6AeGL_MF18g8ZA_@mail.gmail.com>
	<AANLkTimf2rwKqyWwQbdj7cjS8YcQwCXYGRCvQbZ5HZ19@mail.gmail.com>
	<AANLkTik15iV9SOv6rRL5+DQkAZ4JwBGTS+gqS3nXy2hN@mail.gmail.com>
	<AANLkTikk7Xdiey76Dmy848_B4qNX2-Vbis7p=E8vtNL9@mail.gmail.com>
	<AANLkTimONqL4=E4Unrsj9PU5u57KGXrmO6xWUOCLorgs@mail.gmail.com>
	<AANLkTi=PTgmOSC7pRLjujO5fi9Wdp69Jmj4zCkhGSYSz@mail.gmail.com>
	<AANLkTiksAZSi-Yo8yJv5ca9XWWvB3iVQhZOJtTs-F8gk@mail.gmail.com>
	<AANLkTi=Z6Dx6m68zi7Q1eRVxX3DXOyKj+Ff177UCQrAj@mail.gmail.com>
	<AANLkTimZF+r2aNzrXsUuHVZR65N5wpOYLutFgGAGoci_@mail.gmail.com>
	<20110114162144.GA867@sigill.intra.peff.net>
	<20110117222128.GA30869@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Tor Arntsen <tor@spacetec.no>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 18 04:55:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pf2fd-0000xN-Th
	for gcvg-git-2@lo.gmane.org; Tue, 18 Jan 2011 04:55:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753531Ab1ARDzp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Jan 2011 22:55:45 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33185 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884Ab1ARDzo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Jan 2011 22:55:44 -0500
Received: by wyb28 with SMTP id 28so5704419wyb.19
        for <git@vger.kernel.org>; Mon, 17 Jan 2011 19:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=a/CeNeSy92zOKtlLcjGHg+EPEpYWzVjL1UoLBj6Jk+Q=;
        b=pBzeOKPz1K5c+6OJ0C+W2pMTk6JCJFReo0+KooE7CVay9LpYrLshJAlkYhbZkaV7Ej
         EDmtuftqbJnNvdeZavjSg1bC0b7Df0nGFfhu5knWvZczv7Yj3ElUHoA0++IpD7aZw87V
         bMFh0ewrcm8j/7CiQTZJhdVmp/F/L4Lgw6Ds4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=Mr3cDLVqFk/nn24Jm7rBvcL2v1qO2eO6CXqJUBiFmFLzYa16Yy2CW7gu81qXM1uLZI
         VZedKI1eqoAiI5+iHxzMQmBM8eWG7YrTerUlKJPJQOHzd1Rt76I+jD9mgsZub8fymkC3
         4Ppyg8CWgG78lgYUnLDzq+0x3Tj23YZPVLdxA=
Received: by 10.216.48.211 with SMTP id v61mr4129636web.35.1295322942940; Mon,
 17 Jan 2011 19:55:42 -0800 (PST)
Received: by 10.216.2.194 with HTTP; Mon, 17 Jan 2011 19:55:42 -0800 (PST)
In-Reply-To: <20110117222128.GA30869@sigill.intra.peff.net>
X-Google-Sender-Auth: MYXc4-Hpd5qGcKe_ECCTftnqJfM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165190>

On Mon, Jan 17, 2011 at 3:21 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Jan 14, 2011 at 11:21:45AM -0500, Jeff King wrote:
>
>> So we should probably do one or both of:
>>
>> =A0 1. Make an --allow-any-name option to mailinfo, and use it when =
we
>> =A0 =A0 =A0invoke mailinfo internally for rebasing. That still doesn=
't solve
>> =A0 =A0 =A0the emailed patch problem, but at least keeps purely inte=
rnal
>> =A0 =A0 =A0operations sane.
>
> So I wrote up a nice tidy patch series with mailinfo changes and test=
s,
> and then am/rebase changes and tests on top of that. And guess what I
> noticed? My rebase tests didn't actually fail with stock git.
>
> I bisected to 43c2325 (am: use get_author_ident_from_commit instead o=
f
> mailinfo when rebasing, 2010-06-16), which was written to handle exac=
tly
> this sort of thing.
>
> That commit made it into v1.7.2. JT, which version of git are you
> running? Do you still see any problems with v1.7.2 and above? I can't
> replicate your issue with more recent versions.
>
> So unless we want to do any sort of commit-time warning, I don't thin=
k
> there is anything left to be done on this topic.
>
> -Peff
>

Oh ho! No, I am running 1.7.1. I was so pleased to find out what the
root of the problem was, though, that I did go and add my last name
and haven't had any trouble since.

Thanks for all your help everyone.

-JT
