From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH] documentation: update the "Pushing changes to a public 
	repository" section
Date: Sat, 20 Feb 2010 00:09:11 +0100
Message-ID: <adf1fd3d1002191509y60f4e411kfe2c0e8e580d4df9@mail.gmail.com>
References: <4df72b1a1002190845o2cbde92btb8804e2467ffda51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 00:09:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NibyL-00055r-QS
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 00:09:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755946Ab0BSXJO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Feb 2010 18:09:14 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:36735 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753259Ab0BSXJN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Feb 2010 18:09:13 -0500
Received: by fxm19 with SMTP id 19so652765fxm.21
        for <git@vger.kernel.org>; Fri, 19 Feb 2010 15:09:12 -0800 (PST)
Received: by 10.103.84.32 with SMTP id m32mr1025290mul.69.1266620951979; Fri, 
	19 Feb 2010 15:09:11 -0800 (PST)
In-Reply-To: <4df72b1a1002190845o2cbde92btb8804e2467ffda51@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140493>

On Fri, Feb 19, 2010 at 5:45 PM, Elia Pinto <gitter.spiros@gmail.com> w=
rote:
> Extracted from git v1.7.0 Release Notes:
>
> * "git push" into a branch that is currently checked out (i.e. pointe=
d at by
> =A0 HEAD in a repository that is not bare) is refused by default.
>
> Update the user manual where necessary

It is a good change. I have some comments below, but I prefer when the
docs explain first the current behavior and afterwards, as a note or
alike, the prior behavior. Like this?

-repository that has a checked-out working tree, but the working tree
-will not be updated by the push.  This may lead to unexpected results =
if
-the branch you push to is the currently checked-out branch!
+repository that has a checked-out working tree, but not into a branch =
that is
+currently checked out (i.e. pointed at by HEAD in a repository that is=
 not
+bare), as it is refused by default. This is not allowed by default bec=
ause
+this may lead to unexpected results. Note that prior to the version 1.=
7 it was
+allowed.

> ---
> =A0Documentation/user-manual.txt | =A0 12 ++++++++----
> =A01 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manua=
l.txt
> index fe6fb72..0897839 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -1963,10 +1963,14 @@ As with `git fetch`, `git push` will complain
> if this does not result in a
> =A0handling this case.
>
> =A0Note that the target of a "push" is normally a
> -<<def_bare_repository,bare>> repository. =A0You can also push to a
> -repository that has a checked-out working tree, but the working tree
> -will not be updated by the push. =A0This may lead to unexpected resu=
lts if
> -the branch you push to is the currently checked-out branch!
> +<<def_bare_repository,bare>> repository. =A0Until the version 1.7 yo=
u could

This implies that in 1.7 you can.

> +also push to a repository that has a checked-out working tree,
> +but the working tree will not be updated by the push. =A0This might =
lead to
> +unexpected results if the branch you pushed to was the currently che=
cked-out
> +branch! From 1.7.0 git push" into a branch that is currently checked=
 out

Missing ".

> +(i.e. pointed at by =A0 HEAD in a repository that is not bare)
> +is refused by default.
> +

Thanks,
Santi
