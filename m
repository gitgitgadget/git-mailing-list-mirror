From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v0 3/3] Build in git-rebase.sh
Date: Thu, 21 May 2009 03:25:14 -0700 (PDT)
Message-ID: <m363fukb3j.fsf@localhost.localdomain>
References: <1242899229-27603-1-git-send-email-pclouds@gmail.com>
	<1242899229-27603-2-git-send-email-pclouds@gmail.com>
	<1242899229-27603-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?b?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?utf-8?b?YyBEdXk=?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 21 12:25:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M75Sm-0004kz-GV
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 12:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228AbZEUKZR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 May 2009 06:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752064AbZEUKZQ
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 06:25:16 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:48445 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635AbZEUKZO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 May 2009 06:25:14 -0400
Received: by rv-out-0506.google.com with SMTP id f9so330927rvb.1
        for <git@vger.kernel.org>; Thu, 21 May 2009 03:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=uJXalQxYPLVWd26uTsDdLs7vBiF9a88TAiBa4xBgNQ4=;
        b=VD9H12I3OXKHlPglI+7CreOBVuhMpnoxDFEubF1AOAY0AVG00p2s4cPMzjSgaBmU4S
         1uXF1JFyu562lWtKNtEK0gpbcGHNbXDnrphzMon/Tj7vcYxOls2JNfrqGq9NjKZa3f0A
         sEY5Stysz13fIw3GI0he0qXtK7Vutz6euQtgw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=RLEJK4Hu7ZsdL0eJoUbmLh843uvPuPURxY+Ua1c0zG6CDsTOHhD12AsA4zsdN8EHfI
         mBaM8Y+amWuL6P9TQAG0ornn2DBaOgnuyyYDgUQjpFQpiIlGXKOiXPm6gBFlJ33pl3BJ
         yd3Y7vkek718hg6qIyAQHpv9jI4qmOZLPSsuY=
Received: by 10.141.195.5 with SMTP id x5mr1064737rvp.128.1242901515718;
        Thu, 21 May 2009 03:25:15 -0700 (PDT)
Received: from localhost.localdomain (abwg97.neoplus.adsl.tpnet.pl [83.8.230.97])
        by mx.google.com with ESMTPS id g22sm6554427rvb.26.2009.05.21.03.25.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 May 2009 03:25:14 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n4LAOWW9013917;
	Thu, 21 May 2009 12:24:42 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n4LAOH1N013910;
	Thu, 21 May 2009 12:24:17 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1242899229-27603-3-git-send-email-pclouds@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119670>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy    <pclouds@gmail.com> writes=
:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Regression: "-M" is gone. Don't really want to mess up struct option=
 for "-M"
>=20
>  Makefile                       |    2 +-
>  builtin-rebase.c               |  992 ++++++++++++++++++++++++++++++=
++++++++++
>  builtin.h                      |    1 +
>  contrib/examples/git-rebase.sh |  530 +++++++++++++++++++++
>  git-rebase.sh                  |  530 ---------------------
>  git.c                          |    1 +
>  6 files changed, 1525 insertions(+), 531 deletions(-)
>  create mode 100644 builtin-rebase.c
>  create mode 100755 contrib/examples/git-rebase.sh
>  delete mode 100755 git-rebase.sh

You should have used -M option to git-format-patch to make it clear
that this patch moves git-rebase.sh to contrib/examples/git-rebase.sh
without changes.
=20

[...]
> +#define REBASE_ABORT		0x0001
> +#define REBASE_CONTINUE		0x0002
> +#define REBASE_FORCE		0x0004
> +#define REBASE_IGNORE_DATE	0x0008
> +#define REBASE_INTERACTIVE	0x0010
> +#define REBASE_MERGE		0x0020
> +#define REBASE_STAT		0x0040
> +#define REBASE_NO_VERIFY	0x0080
> +#define REBASE_PRESERVE_MERGES	0x0100
> +#define REBASE_ROOT		0x0200
> +#define REBASE_SKIP		0x0400
> +#define REBASE_VERBOSE		0x0800

I see misaligns here...

[...]

Couldn't you use parseopt also in subcommands?

--=20
Jakub Narebski
Poland
ShadeHawk on #git
