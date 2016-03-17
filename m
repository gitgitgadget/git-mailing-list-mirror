From: =?UTF-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
Subject: Re: [PATCH/RFC/GSoC 3/3] t0301: test credential-cache support of XDG_RUNTIME_DIR
Date: Thu, 17 Mar 2016 18:10:33 +0800
Message-ID: <CAKqreuy2-QVxuKuC707MdgxMafx31R00NiY_tBP3-mGqHtbohw@mail.gmail.com>
References: <CAKqreux4aYhXTE9kUHKoKCJ2-4KDWyi58ioCm-CWqXhUYCtEEw@mail.gmail.com>
	<1458122865-29447-1-git-send-email-huiyiqun@gmail.com>
	<1458122865-29447-3-git-send-email-huiyiqun@gmail.com>
	<xmqqr3fa5rdi.fsf@gitster.mtv.corp.google.com>
	<CAKqreuwRpS3uP6=afm-0pBkPW0-bqoJconnKO5q3qTgZwdU_xQ@mail.gmail.com>
	<xmqqbn6e5o9v.fsf@gitster.mtv.corp.google.com>
	<729c6af810e3000e789f4afd537b77a8@riseup.net>
	<xmqqmvpx1q25.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?6LCt5L+K5rWp?= <pickfire@riseup.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 11:10:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agUt4-0007TH-LK
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 11:10:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965644AbcCQKKg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Mar 2016 06:10:36 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:35118 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935535AbcCQKKe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Mar 2016 06:10:34 -0400
Received: by mail-oi0-f46.google.com with SMTP id w20so4070482oia.2
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 03:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=aT0ssYNYGz4sRYNkaiD919riw8OwrteuDj4+FDDqDgk=;
        b=ZwXYszRya34FCtybsu7C3agC472F4cKFwkkduyYOCvFZs1LPC6L613u5wf7Qxl4mf2
         HpCh4N4GYDsXbfK5zuVrnUGsfmZx4R1WpF+7kFz3Mf4oQHomXJ9BoOxzz3gaz++4Q+kY
         y0aHH49rG7LjJmwkueOb8HHG2PFPRcgcYCH8491OVXoKrgqmYlqd5SI2+8Avc5BpNZQB
         swhK3HcshnrbnREN6OSdBkKYqDPyDrVlnXhNJJOwmpVeVNowPNkaXrpYeqREic0OYaTg
         gxalf6CaXZwoH5TU/6PPbP2wKuGWpMCcLOoubXq8MipzYnRBVBgJDoletv6agCT9MmSW
         qcPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=aT0ssYNYGz4sRYNkaiD919riw8OwrteuDj4+FDDqDgk=;
        b=Y2L7rHJPLd6a68d9Pp8LX9dB+3Gt05af+H0+cP9dOz0nd1DqkOsHZ+hhMBqlZS42nt
         rmxq6Vb25IBVuNhbUjI6XGiWZWYHy6d1oVQKT+rIsk7Uzm1namqQYgwSw5yrF5EWtZ7C
         c9apTeayH0r9JjhxgYMF2J3WEGmSNXHMbYVDEtWu8BB4pQ9+fenKaBKxYVeX9p4Esqz6
         pZwiBLawJmeF4VQyIa5QOE7cKTpMvSDQzcIjjxViJLo4qryA5iXab+FmSAWFMZcZpcOq
         YH5Vq1M0LIhRfXgTZbN7AxqsMdZGmDuj4wbY9gEovpVFPVGPz+XUbLN0lUM+Ob7xbpQm
         s44Q==
X-Gm-Message-State: AD7BkJKVyph5HxOYAQ5oMVdfB/1kEmu9eoXcrHxAOCfm1b911M/8F1kyn7iMGSqacReAcWFXeJxyUmaKoQHxqQ==
X-Received: by 10.202.66.5 with SMTP id p5mr5284372oia.65.1458209433169; Thu,
 17 Mar 2016 03:10:33 -0700 (PDT)
Received: by 10.157.43.68 with HTTP; Thu, 17 Mar 2016 03:10:33 -0700 (PDT)
In-Reply-To: <xmqqmvpx1q25.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289093>

2016-03-17 16:12 GMT+08:00 Junio C Hamano <gitster@pobox.com>:
> =E8=B0=AD=E4=BF=8A=E6=B5=A9 <pickfire@riseup.net> writes:
>
>> On 17/03/2016 01:24, Junio C Hamano wrote:
>>
>>> Using ~/.git-credential-cache/credential-cache.sock would not help
>>> at all for existing users, but ~/.git-credential-cache/socket would
>>> interoperate well with users with existing versions of Git, no?
>>>
>>>>> Just being curious, and wanting to see the reasoning behind the
>>>>> design decision the patch series makes in the log message of one =
of
>>>>> these patches.
>>
>> I guess it is better to use /tmp or such instead of $HOME/.* so that
>> the users home directory won't be flooded by sockets.
>
> The "fallback" being discussed is to see if $XDG can be used (and
> use it if so), otherwise see if ~/.git-credential-cache/socket can
> be used (and use it if so), otherwise die with a message (see
> credential-cache.c).  The order of the falling back may want to be
> the other way around, but in either case, the definition of "can be
> used" includes "is there already a directory in which we can create
> a socket?".
>
> The existing versions have used ~/.git-credential-cache/socket as
> the default socket path, so it is reasonable to expect that users
> that are already using the feature already have the directory there.
>
> So I do not think there is any "flooded" involved; if the directory
> is already there, we can use it to create and use a single socket.
> It's not like we'd be creating many random new directories in ~/.

As mentioned above, The purpose I try "$XDG_RUNTIME_DIR" and then
"/tmp/git-$uid" is that I'd like to build an identical mechanism for se=
arching
for path to store runtime files such as socket and so on.

I guess you would not second an additional configuration to let git
store runtime
files under XDG-compatible path.

Then is there any better solution to keep compatibility than checking t=
he
existence of ~/.git-credential-cache? I'm not sure.

I think we could left following message in documentation:

    From version xxx, we put the socket under a XDG-compatible path ins=
tead of
    a directory under $HOME. If that incompatibility disturbs you,
please consider
    adding `--socket $HOME/.git-credential-cache/socket` to your config=
uration.
