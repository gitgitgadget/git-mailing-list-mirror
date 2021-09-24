Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE79C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 16:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84610610FD
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 16:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbhIXQlJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 12:41:09 -0400
Received: from mout.web.de ([212.227.17.12]:38175 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229974AbhIXQlH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 12:41:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1632501556;
        bh=zaZjXqdni7RLoNk+NmL6my9Et6vIpIdLmNFXBkl/nGE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=cdddmEbhF6mjKokWRhmokyLRbOMfYd0FekKkOeywWZA4WYIkCx9xL3eLe9BnU16yC
         Te3zN8HGlx4eJgq8wLyO4zzbqTOklLu3muyJxvOcJav+Tdy3HGdBYLOpogQlfz1rpj
         1MjZdRENMJ1ej5XjVr+2bv2nAsjtXTftu61gyO/c=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MUCuv-1mLB832Ow7-00Qxo9; Fri, 24 Sep 2021 18:39:16 +0200
Subject: Re: [PATCH 8/8] hook-list.h: add a generated list of hooks, like
 config-list.h
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>
References: <cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com>
 <patch-8.8-80aae4d5c13-20210923T095326Z-avarab@gmail.com>
 <92471ff9-7573-c3e4-e9fd-63a5cbf5738f@gmail.com> <xmqqr1devuoc.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <d5f297d4-9c64-1ff9-8422-054979bf8cfa@web.de>
Date:   Fri, 24 Sep 2021 18:39:15 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqr1devuoc.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FVy7t/rDPHPsQMgdTBequc9OzEVGdikLSMOkMJVWjZacmLxvg30
 MeJ9SjjMDUHeDNjZ1ggMFEehzbC2yRW0dldDw3016bcGvw0lqVE7yC4c/t1erudWG80yEVu
 dv0urokvbZDlOgm4guEq2MiUJUoFKchZkVyvR0AEyhTG6Kva5sWziFVg7jtpbQJQxh0ZZF1
 hemfTVj/TuLEPQpqDQcEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M8/ki1mGjGM=:xAyTutu1qepBINhAq9l/S/
 jRJ8kT+g2q749XDdt3rLAWMgS0zhuVvTOu1IxZJcx4E22NvFBETOx25Bb263JAiF2rfxuL6yf
 OIGfSHbBMQb4HdVV23Uscgk3fJogcICP1hlgfwysBRiop71HyIIe9SrXFHoXIknn7jE5TwGY+
 mf4a6PdrHyS05oOQVznI3tzMLKfA0jIJRv6kuVKHdR+Bq3r3Km38UBX+lDRASusI3+FSjw2gF
 okfrw8GoxA87rWfw4JEtGx1eph/4vB6dAvLZPWyp7uf5rKTlPBMwz9Iwtl7SmdirhzD0hXkgC
 QF5tT7JZ9lf2S5Tx/laomEPZTFz7VfIM9HAFRRij99Em1olE3v9POvQ1giUL7o0VFfx4FXsyX
 5sPiRhCc1mVS8OZKQSmZU4jdOaY3AHYDd8mhgmVIFJdgzOee6W612ppqlm0A0flpINa2U3+p3
 2EJiM730/p5jLti1Vvy/pF5BvmOMmMQNC09yanpvvgkmVjp5Ct4lkenLV/YwBV+ABDskm1HUM
 3edQC5apjajIyRSj+w9GJU5RibPSC6Jt6I4qhk25bbzTTDGLhLp0QL1Zr1nCkF3FQkN+NDgpU
 w/px4br0k75fh30iRjbi1apdNoR76JkRXUG74QI7haKFUpJqNroKMl1ZJYI0o9D+kL6UJngyz
 2xdIr1jSO4P4W7WE42W8Wk4SAEfHlT4s00Q6LWGL46dIHxM1GE0arLYYmG4OsZFlphv91BTIE
 Ek1N9tyAk7EnCY25hvG7TdIKNMG7SEnG9qaVIJpHNSXnmTHQFvNBfnzxkr09jchlQCFEqwGDn
 dXumbIqyJR28GK66V7nxbODH1O6n18JfledZrneZRiGi7d5AACrGUu8Fl4XeOi87hdNnuKGuW
 pNGrRpzboe5RRj0th+StFTVEOAkGKLXDoCR6hc8/waNmpfyArj52cHc8FJGUNpkMbP8DfUS/3
 ibaFPAMQ3Rs6ZoCa8rzV4uAuDwyndxJS/2hbMCRQDUM6OSde+DM6eAQb7vkxXa/RpP4Tq1Ii7
 2HAaSmwpabAECE+/9RRHbSfWx+ty+PKQNFj1rrgEsXs8SJSsI6J2ys3tqYTSfWKjkiplcHwhY
 l/dhHgnk1/+i4A=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.09.21 um 17:51 schrieb Junio C Hamano:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
>>> +sed -n -e '/^~~~~*$/ {x; s/^.*$/	"&",/; p;}; x' \
>>
>> POSIX does not support using a semicolon after a closing brace [1],
>> ...
>> [1] "Editing commands other that {...}, a, b, c, i, r, t, w, : and #
>> can be followed by a <semicolon>" from
>> https://pubs.opengroup.org/onlinepubs/9699919799/utilities/sed.html
>
> Would sed implementation of BSD ancestry fail reliably to be a good
> coalmine canary?

I doubt it.  https://man.openbsd.org/sed says:

   "Multiple commands may be specified separated by newlines or
    semicolons"

   "The a, c, i, r, and w functions cannot be followed by another
    command separated with a semicolon."

   "Following the b, t, or : commands with a semicolon and another
    command is an extension to the specification."

   "The use of newlines to separate multiple commands on the command
    line is non-portable"

https://www.freebsd.org/cgi/man.cgi?query=3Dsed doesn't mention semicolons
at all.

On macOS 11.6 (FreeBSD-based userland) the semicolon is accepted:

   $ echo a | sed -n -e '{p;}; p'
   a
   a

Ren=C3=A9
