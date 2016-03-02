From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] l10n: de.po: fix interactive rebase message
Date: Wed, 2 Mar 2016 09:46:31 -0800
Message-ID: <CAGZ79kZA0rC87yJGHB8NaS0aR6fvWJQsBaw998dRySYhBgrD7Q@mail.gmail.com>
References: <1456940183-6712-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, tr@thomasrast.ch,
	jk@jk.gs, Christian Stimming <stimming@tuhh.de>,
	Phillip Sz <phillip.szelat@gmail.com>,
	=?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
	Magnus G <magnus.goerlitz@googlemail.com>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 18:46:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abAr8-0002Xe-2m
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 18:46:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755029AbcCBRqe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Mar 2016 12:46:34 -0500
Received: from mail-ig0-f179.google.com ([209.85.213.179]:34645 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbcCBRqd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Mar 2016 12:46:33 -0500
Received: by mail-ig0-f179.google.com with SMTP id g6so51263863igt.1
        for <git@vger.kernel.org>; Wed, 02 Mar 2016 09:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=5DymSWAOOCdSV8p5M9gefMMmPdkreVX8Unmvz0LGPxQ=;
        b=lXOzUd5+0JjovO+CmFAlZrdS9uJA4ODV/70lfra5vC+IAgMKFN1fLnv2oRCmPZmxSa
         2OqQC5Yvw5kmQboar3J2mpa5JuO2ZTzWe6BeRXnPkdEivLWeZcvqNhikPxHXoRKrKCET
         /Y6Tg9gGUnHISjj2QQWxiyhvVzUrD1O14F2kKR6GbY2yMIXPZ8u5mtxAX5RJ4fr5+OvK
         VwDvOx/aorPm2xv8A05N6QU294ha+Z+ly+jKqmwnbPprNymZ49RGBTP4JoZmBn4S24kf
         MJXZ80tUVnz/D0bLCvAaR8uKe0cYpJrlUiEuIaMZTAjLKznTfl1PefO7byAMg5rHIDZM
         iV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=5DymSWAOOCdSV8p5M9gefMMmPdkreVX8Unmvz0LGPxQ=;
        b=TtSRd7L2106vQmvBZIP+LbvnbyeSfG6rygebToe5w2BWsDFG9FBQF9Viq33rB3RC5q
         4CBzL1wYG7Lv1znej0SVJX7MXwdGQfCqfiNv63yPi+0D8h216kS0f4c0xs8qXNlUsgS4
         dsS/oMy1A4khEJGvLwSUpt1Bua5chd9tMPhbYk5jqyEOtvurH9iqNGjsKMeEmKOiZ39y
         BcjZkVF3MhxwPMZ3mDJx1SvfcIo2cjfFtXlwCSnsUjivUW4LtI4oHCCARINvhYzpPHK9
         o07fTIMvkqLdpJH+fO1TCr8TX8vV6zKGCYmDc6ehYSXnCXYfxlOy+1he7yuakamP7OV3
         xMDQ==
X-Gm-Message-State: AD7BkJLiktEeTqXGQHI2xhRceM/2ODYDyIiS21gtL+L+7aSdVphdCu/0kVWgOTtj1IUzJT6jBTj7z2Je4rKMvcz+
X-Received: by 10.50.112.10 with SMTP id im10mr1175752igb.93.1456940791331;
 Wed, 02 Mar 2016 09:46:31 -0800 (PST)
Received: by 10.107.58.6 with HTTP; Wed, 2 Mar 2016 09:46:31 -0800 (PST)
In-Reply-To: <1456940183-6712-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288137>

On Wed, Mar 2, 2016 at 9:36 AM, Ralf Thielow <ralf.thielow@gmail.com> w=
rote:
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
>  po/de.po | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/po/de.po b/po/de.po
> index 8c5f05d..07b4456 100644
> --- a/po/de.po
> +++ b/po/de.po
> @@ -1950,8 +1950,8 @@ msgstr "Keine Kommandos ausgef=C3=BChrt."
>  #, c-format
>  msgid "Last command done (%d command done):"
>  msgid_plural "Last commands done (%d commands done):"
> -msgstr[0] "Letztes Kommando ausgef=C3=BChrt (%d Kommando ausgef=C3=BC=
hrt):"
> -msgstr[1] "Letzte Kommandos ausgef=C3=BChrt (%d Kommandos ausgef=C3=BC=
hrt):"
> +msgstr[0] "Zuletzt ausgef=C3=BChrtes Kommando (%d Kommando ausgef=C3=
=BChrt):"
> +msgstr[1] "Zuletzt ausgef=C3=BChrte Kommandos (%d Kommandos ausgef=C3=
=BChrt):"

Ist "Kommando" generell akzeptiert in der deutschen Uebersetzung?
Intuitive haette ich jetzt

    Zuletzt ausgef=C3=BChrter Befehl (%d Befehl ausgef=C3=BChrt):

erwartet.

thanks,
Stefan


>
>  #: wt-status.c:1119
>  #, c-format
> --
> 2.8.0.rc0.140.gf92f5fe
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
