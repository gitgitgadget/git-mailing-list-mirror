From: Darren Hart <darren@dvhart.com>
Subject: Re: [PATCH] Documentation/git-clone: describe --mirror more verbose
Date: Fri, 1 Oct 2010 13:18:00 -0700
Message-ID: <AANLkTimN53bcadyzshHNVULkt=kzdfTQrUmZxUd+FKpY@mail.gmail.com>
References: <1285963983-5629-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Fri Oct 01 22:18:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1m3X-0007TB-8H
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 22:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581Ab0JAUSF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Oct 2010 16:18:05 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:42268 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414Ab0JAUSE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Oct 2010 16:18:04 -0400
Received: by qyk36 with SMTP id 36so3784549qyk.19
        for <git@vger.kernel.org>; Fri, 01 Oct 2010 13:18:03 -0700 (PDT)
Received: by 10.224.74.1 with SMTP id s1mr4224713qaj.26.1285964280147; Fri, 01
 Oct 2010 13:18:00 -0700 (PDT)
Received: by 10.229.26.82 with HTTP; Fri, 1 Oct 2010 13:18:00 -0700 (PDT)
In-Reply-To: <1285963983-5629-1-git-send-email-u.kleine-koenig@pengutronix.de>
X-Google-Sender-Auth: PIat9rCGA00qo79vTRMLJC34np0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157778>

2010/10/1 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> Some people in #linux-rt claimed that you cannot define "--mirror" wi=
th
> "mirror".
>
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Darren 'Some People' Hart <darren@dvhart.com>

> ---
> =A0Documentation/git-clone.txt | =A0 11 ++++++++++-
> =A01 files changed, 10 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.tx=
t
> index dc7d3d1..5eedfbd 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -128,7 +128,16 @@ objects from the source repository into a pack i=
n the cloned repository.
> =A0 =A0 =A0 =A0configuration variables are created.
>
> =A0--mirror::
> - =A0 =A0 =A0 Set up a mirror of the remote repository. =A0This impli=
es `--bare`.
> + =A0 =A0 =A0 Set up a mirror of the remote repository.
> + =A0 =A0 =A0 Using
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 git remote update origin
> +
> + =A0 =A0 =A0 (or `<name>` instead of `origin` if -o is given) in the=
 resulting
> + =A0 =A0 =A0 repository overwrites the local branches without asking=
=2E
> + =A0 =A0 =A0 This implies `--bare`.
> + =A0 =A0 =A0 Without --mirror (but with --bare) git remote update do=
esn't touch any
> + =A0 =A0 =A0 branches at all.
>
> =A0--origin <name>::
> =A0-o <name>::
> --
> 1.7.2.3
>
>



--=20
Darren Hart
