From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [GIT GUI PATCH 0/2] teach git gui to open the configured editor
Date: Fri, 23 Mar 2012 19:43:32 +0100
Message-ID: <CAKPyHN1SWLMKtWOPJ7NwcwuE2Kpwb84yz443P7R=vE4jSPFEOw@mail.gmail.com>
References: <cover.1332523097.git.hvoigt@hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri Mar 23 19:43:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SB9Sd-00080d-US
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 19:43:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759423Ab2CWSne convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Mar 2012 14:43:34 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:56807 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753486Ab2CWSnd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Mar 2012 14:43:33 -0400
Received: by vbbff1 with SMTP id ff1so1652194vbb.19
        for <git@vger.kernel.org>; Fri, 23 Mar 2012 11:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=cGwLyYgKv8xUqbrHwv1B5ZP5FdjQ4TVVbZNl60Pa+28=;
        b=eLMkcf7lOztS+4M28x64mA+au1BHZINLuKsxhxiN6Tt5gR4BnR8zcqQg/5y5fqSSX2
         XfqcjQlGjiQFDME4TIPpXzM9nImXATUj1yW2xjODgOvhaEmMmz0LGamrzUj9Drtz4G+2
         m2fDtx9a49Gy8FHaE2Z1KWJqgtpw046eCOKsEu9jXz1t2EpRle9RnLAIPipntUI2y1bM
         oPV/KbKJY4m+L6gZZGWELNEUyq1ne0jeaawZaDvF2JcYt1yjUHY4dt2Tb+y9ZpC9BZDk
         accPW7A4j0yIuDIa05xPi1SJHUBH+nfHFDySUdoRY2Ft/gpD5c8PTS/lrGAoJoyofzvK
         D4kQ==
Received: by 10.220.228.200 with SMTP id jf8mr5962608vcb.0.1332528212353; Fri,
 23 Mar 2012 11:43:32 -0700 (PDT)
Received: by 10.52.186.8 with HTTP; Fri, 23 Mar 2012 11:43:32 -0700 (PDT)
In-Reply-To: <cover.1332523097.git.hvoigt@hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193790>

Hi,

On Fri, Mar 23, 2012 at 18:30, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> This patch series adds a new right click menuitem which allows the us=
er
> to open the configured editor with the currently viewed file. For som=
e
> popular editors it is also able to move the cursor close to the watch=
ed
> line.

I once mentioned this in a patch I send ages ago:

<1289770869-11665-1-git-send-email-bert.wesarg@googlemail.com>

Look for the '[1]' reference.

I have done, what was discussed in this thread, but never send
something to the list (maybe a private mail to Pat?), but you can have
a look at my git-gui repo at [1]. The patch which implements this is
bw/master~5 (a648f3a06 'git-gui: open file with GIT_EDITOR').

Regards,
Bert

[1] http://repo.or.cz/w/git-gui/bertw.git

>
> Please have a look at the parsing of the configured editor commandlin=
e.
> I tested it for most situations. Maybe someone has an idea for a more
> elegant way to split up between arguments and command.
>
> Currently I substitute all ' with " and then abuse the lindex command=
 for
> trimming and splitting.
>
> Cheers Heiko
>
> Heiko Voigt (2):
> =C2=A0git-gui: teach _which procedure to work with absolute paths
> =C2=A0git-gui: add "open in editor" diff context menu entry
>
> =C2=A0git-gui/git-gui.sh | =C2=A0 55 ++++++++++++++++++++++++++++++++=
++++++++++++++++++++
> =C2=A01 file changed, 55 insertions(+)
>
> --
> 1.7.10.rc1.29.gf035d
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
