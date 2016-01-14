From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] t0060: loosen overly strict expectations
Date: Thu, 14 Jan 2016 13:52:11 -0500
Message-ID: <CAPig+cRa9mk0U4iPim5GRWzFN-vHEA=rx8bb40oQyCJVZL7t3A@mail.gmail.com>
References: <eccf149d9557fd9afb591d9411ecb0b3460c9eb0.1452754049.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Michael Blume <blume.mike@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 14 19:52:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJn0K-0004rs-Ma
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 19:52:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755433AbcANSwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 13:52:13 -0500
Received: from mail-vk0-f41.google.com ([209.85.213.41]:33262 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754824AbcANSwM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 13:52:12 -0500
Received: by mail-vk0-f41.google.com with SMTP id i129so147619412vkb.0
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 10:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=4+tGOsBFtmKBUJ9RxFK11afCdpg8h7lsUc2JP9LCdUA=;
        b=x4acHJP8ngkSxGnZ4ux0489PLl3B4yk70FKsfiz68S308j7Wd5UIrODHL+BhwibjUF
         70QR5GttuBJq09A0HJADsGv5upiCar5kCitqFAHnoTVkdJd5dBQLcGOjtY4g7hXv2TA8
         0cHr6o4An+E9L1MWZvRXZSf13bIFQ1gBshwPAHfur/gZ6uHFWFQ+W+0xxvNd0v9G42wQ
         jh/UYoHrDn7OnUDUPMOjI3HopRcb2gJGj0ow9YXrYgg7iE4j6CfuQileD9XUG5SmtVPM
         dOP5BuYyN9CPFLovoSFh6dkI+CAhys+ZkB1pC2w/i4D48avHVn4UCifYP49SEAM84Q0L
         C0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=4+tGOsBFtmKBUJ9RxFK11afCdpg8h7lsUc2JP9LCdUA=;
        b=bBY+v/D+Pd1xbUZVCSl5ThpfODKzKJOKymK83aZKgzf09JfiVnQhWF0FU2y4rw9fCG
         yPbZr1n/9TxKi5yLcnoOglGQecUfMSuEFm9lZR05ur1z1UZSamokUPPGbWNfqxUbZPc9
         Yx3KjVZp+bP9PRrr21CtmGNJ+3qmf+vV27oDYJi8w1DD/6l6HmF0ULNGZYWTwxoVaGHy
         7BskrBdN0KlFwCe6QLH3kEcZSiZyHfclznx3W14yowvPgTHCei04igCHHi3hS7Btot3a
         S4hCuLf/7PMf+g3LnDcC30s7d7kSmA4aE4FLLOEF9M701fgoBXvZcGH1x8Ed75j3GpDT
         ff3g==
X-Gm-Message-State: ALoCoQmQBujmnMmcjuPEFv+qYjwuYG/K44RY+TpsyzzBAlcCfxh9RBLGIwTZcn62UcuVBL7+VUbRal+B2wyIlqLJGOGlFcGb2Q==
X-Received: by 10.31.58.74 with SMTP id h71mr4450360vka.151.1452797531099;
 Thu, 14 Jan 2016 10:52:11 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Thu, 14 Jan 2016 10:52:11 -0800 (PST)
In-Reply-To: <eccf149d9557fd9afb591d9411ecb0b3460c9eb0.1452754049.git.johannes.schindelin@gmx.de>
X-Google-Sender-Auth: XLHUhMpTTML2BhCwmyFKA49zlR4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284080>

On Thu, Jan 14, 2016 at 1:48 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> The dirname() tests file were developed and tested on only the five
> platforms available to the developer at the time, namely: Linux (both 32
> and 64bit), Windows XP 32-bit (MSVC), MinGW 32-bit and Cygwin 32-bit.
>
> http://pubs.opengroup.org/onlinepubs/9699919799/functions/basename.html
> (i.e. the POSIX spec) says, in part:
>
>         If the string pointed to by path consists entirely of the '/'
>         character, basename() shall return a pointer to the string "/".
>         If the string pointed to by path is exactly "//", it is
>         implementation-defined whether "/" or "//" is returned.
>
> The thinking behind testing precise, OS-dependent output values was to
> document that different setups produce different values. However, as the
> test failures on MacOSX illustrated eloquently: hardcoding pretty much each
> and every setup's expectations is pretty fragile.
>
> This is not limited to the "//" vs "/" case, of course, other inputs are
> also allowed to produce multiple outpus by the POSIX specs.

s/outpus/outputs/

> So let's just test for all allowed values and be done with it. This still
> documents that Git cannot rely on one particular output value in those
> cases, so the intention of the original tests is still met.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
