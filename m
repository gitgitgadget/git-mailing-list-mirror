From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] tutorial.txt renamed
Date: Wed, 7 Jan 2009 06:28:37 +0100
Message-ID: <200901070628.38019.chriscool@tuxfamily.org>
References: <20090107042337.GA24735@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Wed Jan 07 06:29:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKQyl-0007A8-99
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 06:29:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003AbZAGF1z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Jan 2009 00:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbZAGF1z
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 00:27:55 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:33845 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751123AbZAGF1y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jan 2009 00:27:54 -0500
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 69A6E4B0099;
	Wed,  7 Jan 2009 06:27:46 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 50B714B0067;
	Wed,  7 Jan 2009 06:27:43 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <20090107042337.GA24735@gnu.kitenet.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104758>

Le mercredi 7 janvier 2009, Joey Hess a =E9crit :
> The tutorial.txt file was renamed to gittutorial.txt some time ago,
> update README.
>
> Signed-off-by: Joey Hess <joey@gnu.kitenet.net>
> ---
>  README |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/README b/README
> index 548142c..5fa41b7 100644
> --- a/README
> +++ b/README
> @@ -24,7 +24,7 @@ It was originally written by Linus Torvalds with he=
lp
> of a group of hackers around the net. It is currently maintained by J=
unio
> C Hamano.
>
>  Please read the file INSTALL for installation instructions.
> -See Documentation/tutorial.txt to get started, then see
> +See Documentation/gittutorial.txt to get started,=20

"man gittutorial" and "git help tutorial" should work to display the=20
tutorial, so perhaps we should advise to use them instead of the source=
,=20
since we are advising to use "man git-commandname" below to get help on=
=20
each command.

> then see=20
>  Documentation/everyday.txt for a useful minimum set of commands,

(But the everyday.txt file has not been converted to a man page, so we=20
cannot advise to use "man giteveryday".)

>  and "man git-commandname" for documentation of each command.

Yeah "man git-commandname" and "git help commandname" should work.

>  CVS users may also want to read Documentation/cvs-migration.txt.

The "cvs-migration.txt" was also renamed "gitcvs-migration.txt". It sho=
uld=20
be available with "man gitcvs-migration" and "git help cvs-migration".

Thanks,
Christian.

> --
> 1.5.6.5
