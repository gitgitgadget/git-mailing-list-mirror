From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH 5/6] user-manual: miscellaneous editing
Date: Mon, 7 May 2007 09:27:40 +0200
Message-ID: <8aa486160705070027g2cb6797fy5acbe338e30429ff@mail.gmail.com>
References: <-1060540797535999820@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@citi.umich.edu>
X-From: git-owner@vger.kernel.org Mon May 07 09:27:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkxdL-00028B-HQ
	for gcvg-git@gmane.org; Mon, 07 May 2007 09:27:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754069AbXEGH1o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 7 May 2007 03:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754090AbXEGH1o
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 03:27:44 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:54151 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754069AbXEGH1n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2007 03:27:43 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1319795wxd
        for <git@vger.kernel.org>; Mon, 07 May 2007 00:27:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uJGhTWHLC/py69wKtQH6XuQlsIrbIEEJYUZVVVi4sYFQ644GwCBNTYlsiI/9POgeoE14letohtlvPK8MmkA/8Kex7sFuqOJs9wC5gLa/4VrJqePgn0JSviOybzTv6nDsqjl7wzmkB7rCMB/d9fzsbWAlqxD6BYS01SCI/acr0X4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ja/umIZOE0qn4VDNZeEJk6CMfVJI7kLsnluJI0TWNWuawKN2K7UcMBOiE45v6yhaO89GFqDnxOWuQq8JO7bI9gwYKks+l8Is2JxqpADO1D5AqoUM8NvD+ELDu/VVzcvh4Md1+hml3OM6Cdy0Bq5ojwOf2Uu7vJMTDPbYxp8Lw90=
Received: by 10.78.134.12 with SMTP id h12mr887988hud.1178522860776;
        Mon, 07 May 2007 00:27:40 -0700 (PDT)
Received: by 10.78.137.19 with HTTP; Mon, 7 May 2007 00:27:40 -0700 (PDT)
In-Reply-To: <-1060540797535999820@unknownmsgid>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46421>

On 5/7/07, J. Bruce Fields <bfields@citi.umich.edu> wrote:
> From: J. Bruce Fields <bfields@citi.umich.edu>
>
> I cherry-picked some additional miscellaneous fixes from those sugges=
ted
> by Santi B=E9jar, including fixes to:
>
>         - correct discussion of repository/HEAD->repository shortcut
>         - add mention of git-mergetool
>         - add mention of --track
>         - mention "-f" as well as "+" for fetch
>

> Cc: Santi B=E9jar <sbejar@gmail.com>

You forgot to CC: the e-mail to me :-)

> diff --git a/Documentation/user-manual.txt b/Documentation/user-manua=
l.txt
> index c292b4d..67f5b9b 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt

[...]

> @@ -1830,14 +1836,14 @@ Now, assume your personal repository is in th=
e directory ~/proj.  We
>  first create a new clone of the repository:
>
>  -------------------------------------------------
> -$ git clone --bare proj-clone.git
> +$ git clone --bare proj.git
>  -------------------------------------------------

You missed the ~/proj as in:

$ git clone --bare ~/proj proj.git

What do you think about the rest of my changes, in particular:

@@ -2374,7 +2388,6 @@ then the following commands will all do the same =
thing:
 -------------------------------------------------
 $ git fetch git://example.com/proj.git master:ref/remotes/example/mast=
er
 $ git fetch example master:ref/remotes/example/master
-$ git fetch example example/master
 $ git fetch example
 -------------------------------------------------

Santi
