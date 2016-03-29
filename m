From: =?UTF-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
Subject: Re: [GSoC] A late proposal: a modern send-email
Date: Tue, 29 Mar 2016 12:17:55 +0800
Message-ID: <CAKqreuy0RwgxqrRf7t1AU8dM2VtkvD9gd3VnzVRe-GEieVXDNA@mail.gmail.com>
References: <CAKqreuyC8p9m_dgVpXCiT_hf=8qBA_5kZ5NABQGx0QDOiCBbww@mail.gmail.com>
	<xmqqzitm2zkj.fsf@gitster.mtv.corp.google.com>
	<CAKqreux1S2ioEEjPPCkyz1NJnXJ1RyiWdM5thZD607PkL0HKuQ@mail.gmail.com>
	<CACBZZX6q87dw6UW9z+2bAvvWu0WZcYCMD8gxW8MchHwd8Rv3kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 06:18:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akl6P-0007re-6B
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 06:18:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbcC2ER5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2016 00:17:57 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:35516 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbcC2ER4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2016 00:17:56 -0400
Received: by mail-oi0-f43.google.com with SMTP id h6so5922693oia.2
        for <git@vger.kernel.org>; Mon, 28 Mar 2016 21:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=sICgFn5rzaN7VhoGDnE+RmHzLj4q5boVKhS9IRvkCYA=;
        b=j6ZIYJdt7lKmbcuwQ/b7U2YwWvwNQv6RxvdCYEky4U0aFK3lV/UUmM3kXKc7aPCMYW
         u9k1/i8j5ZiYjO8/fx0P6sFUZ2lc5X/kA5Ew4r98z61mIH2wYSYWOnkV98y9xVD/E/xo
         qP7GwUPRGgbEMHgZcvKpLZCUTzcOaKi72iQNg+qDkvGeYHQ1iT2jq7G26un/pyhpUiqM
         1J04t19tirFFQHnpiZ2kZQmP2P0jctFQCAwDylU4hXHfkW7UmttE6bF90NiTeVTbdbjS
         IGcTVJiAD25UUnmhTMVtU2OxyuK7+ROEP7PNVkjtKT76katJHsvsKtfk6X0zPvCSZzFI
         97/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=sICgFn5rzaN7VhoGDnE+RmHzLj4q5boVKhS9IRvkCYA=;
        b=kGRCFRZO1FIJCOLMUanKiCX6C8C6RafnpugtikiV+43K5IfzqX0HeQzJuVjt4Ifv0N
         BYOdkwTt0GbngHiAlDmGAQH73N04IHBynptfk8+jbFxjPp17zgejVadznQxFmrKfD/3v
         CorNydotW1l53pQUxizhrPrYk4qda6YFuIJleYN7up15SrCGXOBob6p+Lq4xzXWYlLAT
         KxPynotsNVRDWDnLUCkvM463w5JaUFWYIFHYx4UYKpxkTD+erLkYNJFee1H6tpBJGi+n
         kN4QUcl8RGq8fuMDF0bsAN7R5hntxJIrv5CV0FhchmTZybslDsf4iJIMhyZmZ6JxDPMF
         8bgg==
X-Gm-Message-State: AD7BkJKgD1CnAxRfbVzBNdVJTsaVAB+Unq7SexUgySsLlAa3VHlwEeqEdo6OrR0/HkmScSWq0ChftA5w4/MExQ==
X-Received: by 10.157.49.116 with SMTP id v49mr35855otd.97.1459225075173; Mon,
 28 Mar 2016 21:17:55 -0700 (PDT)
Received: by 10.157.12.170 with HTTP; Mon, 28 Mar 2016 21:17:55 -0700 (PDT)
In-Reply-To: <CACBZZX6q87dw6UW9z+2bAvvWu0WZcYCMD8gxW8MchHwd8Rv3kw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290100>

2016-03-29 0:49 GMT+08:00 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avara=
b@gmail.com>:
> On Sat, Mar 26, 2016 at 3:13 AM, =E6=83=A0=E8=BD=B6=E7=BE=A4 <huiyiqu=
n@gmail.com> wrote:
>> 2016-03-26 2:16 GMT+08:00 Junio C Hamano <gitster@pobox.com>:
>>> =E6=83=A0=E8=BD=B6=E7=BE=A4 <huiyiqun@gmail.com> writes:
>>>
>>>> # Purpose
>>>> The current implementation of send-email is based on perl and has =
only
>>>> a tui, it has two problems:
>>>> - user must install a ton of dependencies before submit a single p=
atch.
>>>> - tui and parameter are both not quite friendly to new users.
>>>
>>> Is "a ton of dependencies" true?  "apt-cache show git-email"
>>> suggests otherwise.  Is "a ton of dependencies" truly a problem?
>>> "apt-get install" would resolve the dependencies for you.
>>
>> There are three perl packages needed to send patch through gmail:
>> - perl-mime-tools
>> - perl-net-smtp-ssl
>> - perl-authen-sasl
>>
>> Yes, not too many, but is it better none of them?
>>
>> What's more, when I try to send mails, I was first disrupted by
>> "no perl-mime-tools" then by "no perl-net-smtp-ssl or perl-authen-sa=
sl".
>> Then I think, why not just a mailto link?
>
> I think your proposal should clarify a bit who these users are that
> find it too difficult to install these perl module dependencies. User=
s
> on OSX & Windows I would assume, because in the case of Linux distros
> getting these is the equivalent of an apt-get command away.

In fact, I'm not familiar with the build for OSX or Windows.

> If installing these dependencies is hard for users perhaps a better
> thing to focus on is altering the binary builds on Git for platforms
> that don't have package systems to include these dependencies.

Why `mailto` not a good choice? I'm confusing.

> In this case it would mean shipping a statically linked OpenSSL since
> that's what these perl SSL packages eventually depend on.
