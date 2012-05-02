From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: Re: [PATCH de.po 5/5] de.po: collection of suggestions
Date: Wed, 2 May 2012 20:36:40 +0200
Message-ID: <CAN0XMOJFSginzA-0ED36YMqxbdv3vAQ01UDW-5fR9gfso5E_cQ@mail.gmail.com>
References: <cover.1335966202.git.trast@student.ethz.ch>
	<abfde735e408a8fc34e143ec25d1a345b6fcbd27.1335966202.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed May 02 20:36:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPePu-0008DP-LQ
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 20:36:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755671Ab2EBSgl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 14:36:41 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55661 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755457Ab2EBSgk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 May 2012 14:36:40 -0400
Received: by yenm10 with SMTP id m10so490632yen.19
        for <git@vger.kernel.org>; Wed, 02 May 2012 11:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=lXkGNgMY9P9+zJ3Uk3BaieV8wPcXfgrZntz459ueGX0=;
        b=EHQK9J+D0Ey5TVtewXhGOwyQgskdfdPBfF8aUh6fAR7bLAJrdENkhNGZ+uLWxFmz1r
         8eu+ztDXlNjC4A1lAZGwuxvpceuiZUQ0UJ0mq7LqoKoCVe4Azsa49xnVfGWva92iyLWi
         Gfn+1T1xWDPDPKOdsteE2/pyPLG9qpcW9kYncuAwzcvQS1K0aKG/WhFqax0rqX0hLcIv
         glqhdlaWomDv+8FRHYIvK/htFDjCxK6Gq+kbJg503t3WsVBYpgnVXvFnrNBPcNBIwZG8
         WXrEuRe+seLESSOGygw49pDSIXaDRxUt5YpD+YDkEr+AL/iUVW+k9Ttk7U6RQkwqHhW7
         rB2A==
Received: by 10.236.181.129 with SMTP id l1mr32108061yhm.59.1335983800276;
 Wed, 02 May 2012 11:36:40 -0700 (PDT)
Received: by 10.146.203.1 with HTTP; Wed, 2 May 2012 11:36:40 -0700 (PDT)
In-Reply-To: <abfde735e408a8fc34e143ec25d1a345b6fcbd27.1335966202.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196849>

Looks good so far.
I amended (and applied) your patch but have changed the following parts=
=2E
If you don't agree with them, please let me know. Commonly I don't chan=
ge
a patch but I want to get these changes in and I think you'll agree wit=
h my
changes.

> +"um die Aufl=C3=B6sung entsprechend zu markieren und einzutragen,\n"
> =C2=A0"oder benutze 'git commit -a'."

There are a couple of other parts in the file with the same pattern.
I've changed them in the same way.

> =C2=A0#: wt-status.c:207
> =C2=A0msgid "bug"
> -msgstr "Fehler"
> +msgstr "Bug"

I don't think that "Bug" is a better translation than "Fehler". It's no=
t
really a German word. Most of the German people should
know what that means, but at least it's the same question
like the translation of terms like "commit". I removed it for now.

> +"und benutze dann 'git add/rm <Datei>' \n"

I removed the whitespace before the line break.

I also changed "..packen..." to "...Packen...".

Thanks
