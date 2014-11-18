From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate 2 new messages
Date: Tue, 18 Nov 2014 14:37:04 +0100
Message-ID: <CAN0XMOLPN6ojrpR5VWw7jCwe-L6N8EELXyiSmkzsyBMPjmjxCA@mail.gmail.com>
References: <1416153257-2407-1-git-send-email-phillip.szelat@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	=?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
	=?UTF-8?Q?Magnus_G=C3=B6rlitz?= <magnus.goerlitz@googlemail.com>,
	mackyle@gmail.com
To: Phillip Sz <phillip.szelat@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 14:37:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqiy2-00041L-F6
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 14:37:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754214AbaKRNhI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Nov 2014 08:37:08 -0500
Received: from mail-wi0-f175.google.com ([209.85.212.175]:65000 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753439AbaKRNhG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Nov 2014 08:37:06 -0500
Received: by mail-wi0-f175.google.com with SMTP id l15so1842178wiw.8
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 05:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=mz8tBHiUzgeMUCzVRXxKe1wlrUIICTVIpJCWk6HrBj0=;
        b=GiOzYIVHUSd4BDuXsOZbKFx4+x1jqyk/nWlbHyGc64dhiqUVO0mFBohhrl62RcV/Dt
         zGhM+dW+3bQDp36fnRA5CnVnhpjdrsyCK0+g5OjqPaKEGfwGnpGHUdwx69VSvNCJEEyP
         NZOW6toW7gq64XwdPVFr4E5SIjORemYEEjw6n6bVtdRb6ek1Da4WwWrY0ugyfA96C7ZT
         hsmlUMtLzwbxdSSQOFLSJmOtJnzCr637ELt7qWmT5PMdOyxaelJTFBWxp3zUkWoPfinJ
         4uU2WHtqeVVvnr8VXLlmpb9JESECmBy3uL3aUjaPcnj023qae5YItn26UmMsE7bXlvOx
         7ehw==
X-Received: by 10.180.11.140 with SMTP id q12mr12389167wib.45.1416317824752;
 Tue, 18 Nov 2014 05:37:04 -0800 (PST)
Received: by 10.194.35.137 with HTTP; Tue, 18 Nov 2014 05:37:04 -0800 (PST)
In-Reply-To: <1416153257-2407-1-git-send-email-phillip.szelat@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

2014-11-16 16:54 GMT+01:00 Phillip Sz <phillip.szelat@gmail.com>:
> Phillip

There's no need for writing your name in the commit message
body.

>
> Signed-off-by: Phillip Sz <phillip.szelat@gmail.com>
> ---
>  po/de.po | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/po/de.po b/po/de.po
> index c807967..5af3f8f 100644
> --- a/po/de.po
> +++ b/po/de.po
> @@ -5473,7 +5473,7 @@ msgstr "pr=C3=BCft die Reflogs (Standard)"
>
>  #: builtin/fsck.c:613
>  msgid "also consider packs and alternate objects"
> -msgstr ""
> +msgstr "ziehen Sie au=C3=9Ferdem Pakete und alternative Objekte in B=
etracht"
>

Your message has a different style than other messages of this
type. I wouldn't address the user directly and would write it as:

msgstr "ebenso Pakete und alternative Objekte betrachten"

What do you think?

>  #: builtin/fsck.c:614
>  msgid "enable more strict checking"
> @@ -8253,7 +8253,7 @@ msgstr "Referenz muss sich auf dem angegebenen =
Wert befinden"
>
>  #: builtin/push.c:495
>  msgid "check"
> -msgstr ""
> +msgstr "=C3=9Cberpr=C3=BCfung"
>

Hm. If I understand it correctly, "check" is one option of the
--recurse-submodules
parameter for git-push, the other one is "on-demand". Since the possibl=
e values
are either "check" or "on-demand", we shouldn't translate this string a=
t all and
should just write "check|on-demand" as shown in "git help push".

Perhaps this message need to be adjusted and excluded from translation.=
 I dunno.

>  #: builtin/push.c:496
>  msgid "control recursive pushing of submodules"
> --
> 2.1.3
>
