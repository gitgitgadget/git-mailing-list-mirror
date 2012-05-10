From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] Clean weird documentation for 'git var' and 'git
Date: Thu, 10 May 2012 19:06:42 +0200
Message-ID: <4FABF5A2.1050200@lsrfire.ath.cx>
References: <CAGK7Mr7QWrddaRLkr=1h=GYUNtNVOatQF1sj+p11mejzs65u8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Philippe Vaucher <philippe.vaucher@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 10 19:07:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSWpY-0004nG-B3
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 19:07:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753225Ab2EJRHB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 May 2012 13:07:01 -0400
Received: from india601.server4you.de ([85.25.151.105]:59483 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865Ab2EJRHA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 13:07:00 -0400
Received: from [192.168.2.105] (p579BE1ED.dip.t-dialin.net [87.155.225.237])
	by india601.server4you.de (Postfix) with ESMTPSA id BA14C2F803C;
	Thu, 10 May 2012 19:06:58 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <CAGK7Mr7QWrddaRLkr=1h=GYUNtNVOatQF1sj+p11mejzs65u8A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197603>

Am 10.05.2012 18:45, schrieb Philippe Vaucher:
> Here's a patch removing the weird bits. I spoke about in my previous =
message.

Ideally, a commit message should be self-contained and explain the=20
reasons for the introduced changes, or at least contain a link to a=20
mailing list archive, so that readers who only have the git repository=20
have a chance to follow the arguments.

>
> Philippe
>
>
> Signed-off-by: Philippe Vaucher<philippe.vaucher@gmail.com>

The author field of a commit plus the sign-off line are enough to=20
identify you, no extra line with your name required.

> ---
>   Documentation/git-commit-tree.txt |    9 ---------
>   Documentation/git-var.txt         |    9 ---------
>   2 files changed, 18 deletions(-)
>
> diff --git a/Documentation/git-commit-tree.txt
> b/Documentation/git-commit-tree.txt
> index cfb9906..eb8ee99 100644
> --- a/Documentation/git-commit-tree.txt
> +++ b/Documentation/git-commit-tree.txt
> @@ -88,15 +88,6 @@ for one to be entered and terminated with ^D.
>
>   include::date-formats.txt[]
>
> -Diagnostics
> ------------
> -You don't exist. Go away!::
> -    The passwd(5) gecos field couldn't be read
> -Your parents must have hated you!::
> -    The passwd(5) gecos field is longer than a giant static buffer.
> -Your sysadmin must hate you!::
> -    The passwd(5) name field is longer than a giant static buffer.
> -

These are actual error messages and their meanings, e.g. git prints "Yo=
u=20
don't exist. Go away!" in case the gecos field of your account in=20
/etc/passwd (or NIS, or LDAP) couldn't be read.

Ren=E9
