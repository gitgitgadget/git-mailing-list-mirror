From: =?UTF-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
Subject: Re: [GSOC] Microproject "Move ~/.git-credential-cache to ~/.config/git"
Date: Tue, 15 Mar 2016 03:53:52 +0800
Message-ID: <CAKqreuwgxzVTAUdZPf9+ivXCdW8F2Ksafw7V0pbLAaRPwGX9Uw@mail.gmail.com>
References: <CAKqreux4aYhXTE9kUHKoKCJ2-4KDWyi58ioCm-CWqXhUYCtEEw@mail.gmail.com>
	<xmqqshztawwd.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 20:54:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afYZ2-0006Sr-HT
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 20:54:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755966AbcCNTxy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Mar 2016 15:53:54 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:35604 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755505AbcCNTxx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Mar 2016 15:53:53 -0400
Received: by mail-ob0-f181.google.com with SMTP id fp4so187935196obb.2
        for <git@vger.kernel.org>; Mon, 14 Mar 2016 12:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=BCsqPjwvTSLqIJw/LX0D6Tb+aHTjb1ZzIMSqLX2jDA0=;
        b=DZlSYePuocsfb7d7xFY4zIMbkMy2vviyrwdOV1CZAXYf/pAXAb5y1q7MhWX9U8PW32
         IQ/H9A2vc2vEcGXjfSbIh0f5ITSkMixO7F1kbP5F0ubbLWALcOE4RRm5wOCxpSEDeByW
         0BdAQeCBCgSc4VsNbs8eK+bxJ5GPQs4v2lXoYRRgez2nL/MwQfyQs5/XA9Xy35fxyHXB
         Q8/+bNwKVfZW1uQiUMCHcxORpZk5iaHDBE+73ukcvU92PyAny/uWwOY/GxPNpBbhGCGk
         8rjzsiU1O7nSwNwUrUT0Ogg0y2dhWOIm0fzBQ5p7YQ6Q+/hlvfSoYh/ba6yQA8r3kZ1s
         GmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=BCsqPjwvTSLqIJw/LX0D6Tb+aHTjb1ZzIMSqLX2jDA0=;
        b=jk6ex6mT/d96tgvsudOnhd8x8sUOeFOvk6m8V6iuEi09K66QBMmQFn14Suf9W4w54v
         FDfHrM7ekZPikp4Zip24IyvEWBrS+oE4JoT61t+uC1vxOuUOq7Q8hufhHnJTKydNk8YG
         gWSww5qDubr+nkwmWinIpDmqeYQYcZbq97hfkJOu8ro/YfGDtYAIJcpcNklajwpSNdl/
         ad/gf2N0mNEnfMQzFmiLyxqSjfmjxMQ1V7wp0Tv+p31oaOd7lTooZx+grZhJ9eSRSbT8
         beaWIV97rx7puDcqTqONtTUZmYrP+Ejbn8A1BUFFBAz7kVbYInKA2hkleIHzESxinkzA
         K8KA==
X-Gm-Message-State: AD7BkJKZiqJ5xcsj8CA+X4lRWU9cEW5VSDbmoIhTq4E40x5zN5vThm4an1+4bez+WCRiVmBSp+tMBFPxH57D/g==
X-Received: by 10.182.158.42 with SMTP id wr10mr14696881obb.37.1457985232479;
 Mon, 14 Mar 2016 12:53:52 -0700 (PDT)
Received: by 10.157.43.68 with HTTP; Mon, 14 Mar 2016 12:53:52 -0700 (PDT)
In-Reply-To: <xmqqshztawwd.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288803>

2016-03-14 23:42 GMT+08:00 Junio C Hamano <gitster@pobox.com>:
> =E6=83=A0=E8=BD=B6=E7=BE=A4 <huiyiqun@gmail.com> writes:
>
>> I'm still confused about following:
>>
>> 1. should `~/.git-credential-cache` been moved to
>> `~/.cache/git/credential`(as the descreption of the micropject says)
>> or `~/.config/git/credential`(as the title of the microproject says)=
?
>
> The latter, I'd think, as you noticed in 2. the former does not make
> much sense.

I'm not sure. There is only a unix socket under ~/.git-credential-cache=
=2E
It's not a config.

After reading the
[spec](https://specifications.freedesktop.org/basedir-spec/basedir-spec=
-0.7.html)
more carefully, I think that $XDG_RUNTIME_DIR may be a better choice th=
an
the above two. For ~/.git-credential-cache/socket is a unix socket and =
should
be used only runtime.

On my computer, this variable is well defined and pointed to /run/user/=
$UID.

The problem is that there is no suitable default to it if $XDG_RUNTIME_=
DIR is
not set. I guess /tmp/git-$USER is a good choice.

>> 3. Does "without breaking compatibility with the old behavior." mean
>> that I should still try to connect to the unix socket placed at the
>> old place? If yes, which order is prefered?
>
> Let me be vague and oblique on purpose ;-)
>
> We used to have only ~/.gitconfig as the per-user location, and at
> some point in the history we added XDG_CONFIG_HOME support.  Study
> how that was done (hint: "git log" and "git blame" may be useful
> tools for this purpose), and imitate it.
>

I have read almost every commit which contains "XDG", as well as their =
diffs.

I think this issue I'm currently dealing with is a little different
from formers,
=46or this file is just an unix socket and never persistent. I could no=
t just
keep in step with old behavior unless that user manually create the fil=
e
at new-style path.

Of course I could check the existence of `~/.git-credential-cache` and
`$XDG_CONFIG_HOME/git/credential-cache` to decide where to put
the socket, but it's not elegant enough. Because, as mentioned above,
the socket file itself is not persistent.
