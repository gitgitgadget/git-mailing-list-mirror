From: Phillip Sz <phillip.szelat@gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate 68 new messages
Date: Fri, 25 Dec 2015 20:13:59 +0100
Message-ID: <567D9577.9050809@gmail.com>
References: <1450805964-7734-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	matthias.ruester@gmail.com, magnus.goerlitz@googlemail.com
To: Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 25 20:14:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aCXow-0007E7-8q
	for gcvg-git-2@plane.gmane.org; Fri, 25 Dec 2015 20:14:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753655AbbLYTOG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Dec 2015 14:14:06 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:33465 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753485AbbLYTOD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Dec 2015 14:14:03 -0500
Received: by mail-wm0-f44.google.com with SMTP id p187so205404345wmp.0
        for <git@vger.kernel.org>; Fri, 25 Dec 2015 11:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=+gPL0UM1rWPfnvox8BcKiX7L5PRMSy9dHYL7et6j8hA=;
        b=WtQkZd0zmA2tUBhhlH3ulW09cjAV+dopky1HIN0JN+wLcZ/8blDtJ6Q0TzG8j1i9f+
         SWuZ2d3izzYKWQf0BjKy13PKnsjGtvf8+TslOxiXbHOqDtmXXBAVyWPsHNLRsi9YFPlP
         VWzQxOLOgS/Pp5gDC4Akn8iC+/ZD6xOKt3tgw7pprEAYaA6n2vq+SUFVxCegwycIsLwc
         GGAc+ingK8Xvnpf6RomVSX4wyuYylv/dl/rvhadstIxoeEpwW6C3Uq1MSLzy9I4h/sKF
         2GcBT8NqV9cKFMXBhKjd1e3FYZDlqYClqsOcKBM7HG6uYVPAPWI4XU6rTwXfpREfIwSO
         aVrA==
X-Received: by 10.194.9.169 with SMTP id a9mr45311449wjb.60.1451070841287;
        Fri, 25 Dec 2015 11:14:01 -0800 (PST)
Received: from [192.168.178.84] (i59F45441.versanet.de. [89.244.84.65])
        by smtp.googlemail.com with ESMTPSA id t9sm21952070wjt.36.2015.12.25.11.13.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 Dec 2015 11:14:00 -0800 (PST)
X-Enigmail-Draft-Status: N1010
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <1450805964-7734-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282991>

Hi,

Just some comments, the rest looks fine.

>  #: ref-filter.c:893
>  #, c-format
>  msgid "improper format entered align:%s"
> -msgstr ""
> +msgstr "Ung=C3=BCltiges Format eingegeben align:%s"
> =20

Maybe: "Sie haben ein ung=C3=BCltiges Format eingegeben align:%s"

However, I don't know if that's too long, but to me this sounds a bit n=
icer.

>  #: ref-filter.c:1561
>  #, c-format
>  msgid "format: %%(end) atom missing"
> -msgstr ""
> +msgstr "format: %%(end) Atom fehlt"
> =20

"Format: %%(end) Atom fehlt" ?


>  #: builtin/fsck.c:486
>  msgid "Checking object directories"
> @@ -6369,14 +6351,20 @@ msgstr "zu langes Objekt-Verzeichnis %.*s"
>  msgid ""
>  "The last gc run reported the following. Please correct the root cau=
se\n"
>  "and remove %s.\n"
>  "Automatic cleanup will not be performed until the file is removed.\=
n"
>  "\n"
>  "%s"
>  msgstr ""
> +"Die letzte Ausf=C3=BChrung von \"gc run\" enthielt die folgenden Me=
ldungen.\n"
> +"Bitte beheben Sie das Hauptproblem und l=C3=B6schen Sie %s.\n"
> +"Ein automatisches Cleanup wird nicht ausgef=C3=BChrt, bis diese Dat=
ei entfernt\n"
> +"wurde.\n"
> +"\n"
> +"%s"
> =20

"Ein automatischer Cleanup wird nicht ausgef=C3=BChrt, bis diese Datei
entfernt\n"
"wurde.\n" ?

Merry Christmas.

Phillip
