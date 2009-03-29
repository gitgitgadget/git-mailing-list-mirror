From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] git-gui: French translation improvements
Date: Sun, 29 Mar 2009 10:16:55 +0200
Message-ID: <200903291016.56106.chriscool@tuxfamily.org>
References: <ae74fa8c7846e3f4e6d6d75cc4177b6e6afe6824.1238180731.git.nicolas.s-dev@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Sam Hocevar <sam@zoy.org>
To: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
X-From: git-owner@vger.kernel.org Sun Mar 29 10:19:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnqF7-00032a-0T
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 10:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417AbZC2ISI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Mar 2009 04:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752231AbZC2ISI
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 04:18:08 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:42471 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752121AbZC2ISG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Mar 2009 04:18:06 -0400
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 593334C816C;
	Sun, 29 Mar 2009 10:17:50 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 470A04C80D0;
	Sun, 29 Mar 2009 10:17:48 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <ae74fa8c7846e3f4e6d6d75cc4177b6e6afe6824.1238180731.git.nicolas.s-dev@laposte.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115001>

Le vendredi 27 mars 2009, Nicolas Sebrecht a =E9crit :

[...]

>  #: git-gui.sh:2286 lib/choose_rev.tcl:548
>  msgid "Commit@@noun"
> -msgstr "Commit"
> +msgstr "Commit@@noun"

I am not sure that this change is needed.
The "@@noun" part does not appear and it's only useful for the original=
=20
language, right?

>  #: lib/branch_create.tcl:58
>  msgid "Match Tracking Branch Name"
> -msgstr "Trouver nom de branche de suivi"
> +msgstr "Correspond au nom de la branche de suivi"

I am not sure about this one too.
Are you sure that it's ok in the context where it appears?

>  #: lib/branch_create.tcl:66
>  msgid "Starting Revision"
> @@ -780,6 +780,16 @@ msgstr "Toujours (Ne pas faire de test de fusion=
=2E)"
>  msgid "The following branches are not completely merged into %s:"
>  msgstr "Les branches suivantes ne sont pas compl=C3=A8tement fusionn=
=C3=A9es
> dans %s :"
>
> +#: lib/branch_delete.tcl:115
> +msgid ""
> +"Recovering deleted branches is difficult. \n"
> +"\n"
> +" Delete the selected branches?"
> +msgstr ""
> +"Il est difficile de r=C3=A9cup=C3=A9rer des branches supprim=C3=A9e=
s.\n"
> +"\n"
> +"Supprimer les branches s=C3=A9lectionn=C3=A9es ?"

Why do you need to add this? Wasn't it delete by Sam for a good reason?
Or am I missing something?

>  #: lib/branch_delete.tcl:141
>  #, tcl-format
>  msgid ""
> @@ -1099,7 +1109,7 @@ msgstr "Standard (rapide, semi-redondant, liens
> durs)"
>
>  #: lib/choose_repository.tcl:508
>  msgid "Full Copy (Slower, Redundant Backup)"
> -msgstr "Copy compl=C3=A8te (plus lent, sauvegarde redondante)"
> +msgstr "Copie compl=C3=A8te (plus lent, sauvegarde redondante)"
>
>  #: lib/choose_repository.tcl:514
>  msgid "Shared (Fastest, Not Recommended, No Backup)"
> @@ -1524,12 +1534,10 @@ msgid ""
>  "\n"
>  "Compress the database now?"
>  msgstr ""
> -"Ce d=C3=A9p=C3=B4t comprend actuellement environ %i objets ayant le=
ur fichier "
> -"particulier.\n"
> +"Ce d=C3=A9p=C3=B4t comprend actuellement environ %i objets inutilis=
=C3=A9s.\n"

I don't think the files are unused, it looks like "loose" in english he=
re=20
means that the objects are alone in their own file.

>  "\n"
>  "Pour conserver une performance optimale, il est fortement recommand=
=C3=A9
> de " -"comprimer la base quand plus de %i objets ayant leur fichier
> particulier " -"existent.\n"
> +"comprimer la base quand plus de %i objets inutilis=C3=A9s existent.=
\n"
>  "\n"
>  "Comprimer la base maintenant ?"

[...]

>  #: lib/index.tcl:427
>  msgid "Reverting selected files"
> -msgstr "Annuler modifications dans fichiers selectionn=C3=A9s"
> +msgstr "R=C3=A9vocation en cours des fichiers s=C3=A9lectionn=C3=A9s=
"

After what Alexandre Bourget said about "revert" in git-gui, I think we=
=20
should keep "Annuler".

Thanks,
Christian.
