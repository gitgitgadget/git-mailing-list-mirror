From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: Bulgarian translation of git
Date: Mon, 13 Feb 2012 10:46:14 +0800
Message-ID: <CANYiYbGr3zN-kJwq_MCnttNZP6Cc0aj-fsZjd4V=4z+BA5TvUw@mail.gmail.com>
References: <75009f1d7c4aba4d62bb226ab122932c@192.168.122.10>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: =?KOI8-R?B?QWxleGFuZGVyIFNob3BvdiAo4czFy9PBzsTf0iD7z9DP1yk=?= 
	<lists@kambanaria.org>
X-From: git-owner@vger.kernel.org Mon Feb 13 03:46:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwlwE-0006hm-Oc
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 03:46:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754770Ab2BMCqQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Feb 2012 21:46:16 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:38332 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754274Ab2BMCqP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Feb 2012 21:46:15 -0500
Received: by yhoo21 with SMTP id o21so2141011yho.19
        for <git@vger.kernel.org>; Sun, 12 Feb 2012 18:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=fArXx+G2I/a22UkCttOwKgaVFQhacQvJ3FHY/2R2pgU=;
        b=CQk8Sj8jiqDGOVrKONfdS/RixmBrp0UdTsbKH5s9eKRmOZjv4dOeHKS5scITguWzoq
         vPhW0ofqtgyjjT48wPfCBVJC7Dd/6dIcxeganbXb5L3g0Bb6wvHZ4C/5RMfdcWqljNon
         8fecJBYm65jzdkLZANKj1efByl4rN9F4nqjBA=
Received: by 10.236.157.10 with SMTP id n10mr17582987yhk.41.1329101175060;
 Sun, 12 Feb 2012 18:46:15 -0800 (PST)
Received: by 10.236.153.195 with HTTP; Sun, 12 Feb 2012 18:46:14 -0800 (PST)
In-Reply-To: <75009f1d7c4aba4d62bb226ab122932c@192.168.122.10>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190597>

Junio has a suggestion on how to contrib l10n for git, and you can see =
the
discussion here: http://article.gmane.org/gmane.comp.version-control.gi=
t/189584.

Seems that the suggested git-po repo has not been setup yet, so let me
have a try.

1. Repositiry git-po is hosted on GitHub: https://github.com/gotgit/git=
-po/

2. I made a commit on the maint branch with a initial version of 'po/gi=
t.pot'
    https://github.com/gotgit/git-po/commit/4247a7a9d39e2a74ce1d58e5eb1=
f5e5d87977989

3. As l10n coordinator for Chinese, I translate against the pot file, a=
nd
    the translated po file 'po/zh_CN.po' is commited in my own branch:
maint-zh-cn.
    You can find the commit in:
https://github.com/gotgit/git-po/commits/maint-zh-cn

4. I will merge the commit in branch maint-zh-cn back or other l10n
coordinators' contributes
    to maint branch.

I have a question, which version of po should be maintained? master
branch or maint branch.

2012/2/10 "Alexander Shopov (=A7=A1=A7=DD=A7=D6=A7=DC=A7=E3=A7=D1=A7=DF=
=A7=D5=A7=EC=A7=E2 =A7=BA=A7=E0=A7=E1=A7=E0=A7=D3)" <lists@kambanaria.o=
rg>:
> Hello,
>
> I am Alexander Shopov and would like to volunteer for the Bulgarian
> translation of git po file if no one else is doing this.
> How should I contribute it back?
> Via this email list, via fork-push from github, or a patch?
>
> Kind regards:
> al_shopov
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
=BD=AF=F6=CE

=B1=B1=BE=A9=C8=BA=D3=A2=BB=E3=D0=C5=CF=A2=BC=BC=CA=F5=D3=D0=CF=DE=B9=AB=
=CB=BE
=D3=CA=BC=FE: worldhello.net@gmail.com
=CD=F8=D6=B7: http://www.ossxp.com/
=B2=A9=BF=CD: http://www.worldhello.net/
=CE=A2=B2=A9: http://weibo.com/gotgit/
=B5=E7=BB=B0: 010-51262007, 18601196889
