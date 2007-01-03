From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH] Documentation/tutorial: misc updates
Date: Wed, 03 Jan 2007 10:50:56 -0300
Message-ID: <200701031350.l03Doulu015800@laptop13.inf.utfsm.cl>
References: <sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 03 14:51:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H26WJ-0000H3-Uu
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 14:51:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbXACNvD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 08:51:03 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbXACNvD
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 08:51:03 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:58186 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750776AbXACNvA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 08:51:00 -0500
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [200.1.19.201])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id l03Douae013356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 3 Jan 2007 10:50:56 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id l03Doulu015800;
	Wed, 3 Jan 2007 10:50:56 -0300
To: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
In-Reply-To: Message from =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com> 
   of "Wed, 03 Jan 2007 13:53:27 BST." <87fyastgoo.fsf@gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.19.1]); Wed, 03 Jan 2007 10:50:56 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35867>

Santi B=C3=A9jar <sbejar@gmail.com> wrote:
> Three changes:
> 1) Teach how to delete a branch with "git branch -d name".
> 2) The first commit does not have a parent.
> 3) Teach "git show" instead of "git cat-file -p".
> ---
>  Documentation/tutorial.txt |   17 +++++++++++++----
>  1 files changed, 13 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
> index d043e84..f0a5526 100644
> --- a/Documentation/tutorial.txt
> +++ b/Documentation/tutorial.txt
> @@ -222,6 +222,15 @@ $ gitk
> =20
>  will show a nice graphical representation of the resulting history.
> =20
> +At this point you could delete the experimental branch with
> +
> +------------------------------------------------
> +$ git branch -d experimental
> +------------------------------------------------
> +
> +This command ensures that the changes in the experimental branch are
> +already in the current branch.
> +

Huh? This deletes the branch, it doesn't ensure changes have been saved=
=2E

>  If you develop on a branch crazy-idea, then regret it, you can alway=
s
>  delete the branch with
> =20
> @@ -391,8 +400,8 @@ $ git show HEAD		# the tip of the current branch
>  $ git show experimental	# the tip of the "experimental" branch
>  -------------------------------------
> =20
> -Every commit has at least one "parent" commit, which points to the
> -previous state of the project:
> +Every commit has at least one "parent" commit (except the first),
> +which points to the previous state of the project:

And how can it have more than one parent? If you mention it, better com=
e
clean about merges (can be explained in detail later).

>  -------------------------------------
>  $ git show HEAD^  # to see the parent of HEAD

And if there are several parents?

> @@ -510,10 +519,10 @@ of the file:
>  $ git diff v2.5:Makefile HEAD:Makefile.in
>  -------------------------------------

HEAD:Makefile.in doesn't need HEAD.
--=20
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
