From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/2] git-commit.txt: Correct option alternatives
Date: Sat, 7 Jun 2008 05:34:45 +0200
Message-ID: <200806070534.45761.chriscool@tuxfamily.org>
References: <1212798261-26785-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sat Jun 07 05:31:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4p9i-0007RK-25
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 05:31:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753313AbYFGDaZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Jun 2008 23:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753369AbYFGDaZ
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 23:30:25 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:55647 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753092AbYFGDaY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jun 2008 23:30:24 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 60BC21AB2B7;
	Sat,  7 Jun 2008 05:30:23 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 2CD2F1AB2B3;
	Sat,  7 Jun 2008 05:30:23 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1212798261-26785-1-git-send-email-s-beyer@gmx.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84169>

Le samedi 7 juin 2008, Stephan Beyer a =E9crit :
>
> Furthermore, for long-option consistency --author <author>
> is changed to --author=3D<author>.

[...]

> The second hunk is: --author <author> is advertised for historical
> reasons (I guess), but all the other long options with an argument
> are --long-opt=3D<arg>, e.g. --message=3D<msg> or --cleanup=3D<mode>.
> (Notice the equals sign.)
> Because parse_long_opt() accepts both, I changed this for consistency
> reasons.

[...]

> @@ -8,8 +8,8 @@ git-commit - Record changes to the repository
>  SYNOPSIS
>  --------
>  [verse]
> -'git-commit' [-a | --interactive] [-s] [-v] [-u]
> -	   [(-c | -C) <commit> | -F <file> | -m <msg> | --amend]
> +'git-commit' [-a | --interactive] [-s] [-v] [-u] [--amend]
> +	   [(-c | -C) <commit>] [-F <file> | -m <msg>]
>  	   [--allow-empty] [--no-verify] [-e] [--author <author>]

In the above line there is still "[--author <author>]" without "=3D",

>  	   [--cleanup=3D<mode>] [--] [[-i | -o ]<file>...]

while in this line there is "[--cleanup=3D<mode>]" with "=3D".

So I think that to be consistent, "[--author=3D<author>]" (with "=3D") =
should be=20
used in the SYNOPSIS too.

> @@ -68,7 +68,7 @@ OPTIONS
>  	Take the commit message from the given file.  Use '-' to
>  	read the message from the standard input.
>
> ---author <author>::
> +--author=3D<author>::
>  	Override the author name used in the commit.  Use
>  	`A U Thor <author@example.com>` format.

Thanks,
Christian.
