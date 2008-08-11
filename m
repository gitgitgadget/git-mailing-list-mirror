From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Update french translation
Date: Mon, 11 Aug 2008 21:19:51 +0200
Message-ID: <vpqr68vuzoo.fsf@bauges.imag.fr>
References: <1218465592-2446-1-git-send-email-alexandre.bourget@savoirfairelinux.com>
	<1218465592-2446-2-git-send-email-alexandre.bourget@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alexandre Bourget <alexandre.bourget@savoirfairelinux.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 21:22:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KScyc-0001i8-EG
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 21:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbYHKTVn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Aug 2008 15:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751687AbYHKTVn
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 15:21:43 -0400
Received: from imag.imag.fr ([129.88.30.1]:61763 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751505AbYHKTVm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 15:21:42 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m7BJJtTA008713
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 11 Aug 2008 21:19:56 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KScvn-0006ZK-NU; Mon, 11 Aug 2008 21:19:51 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KScvn-0005Ix-LA; Mon, 11 Aug 2008 21:19:51 +0200
In-Reply-To: <1218465592-2446-2-git-send-email-alexandre.bourget@savoirfairelinux.com> (Alexandre Bourget's message of "Mon\, 11 Aug 2008 10\:39\:52 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 11 Aug 2008 21:19:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91983>

General remark: you should split your patch into

* Some word substitution on the one side (s/r=E9f=E9rentiel/d=E9pos/g,
  s/fonte/police/g, ...)

* Some manual rephrasing.

(so that the first patch doesn't need much review, while the second
should be read more carefully)

Alexandre Bourget <alexandre.bourget@savoirfairelinux.com> writes:

> -msgstr "Invalide fonte sp=E9cifi=E9e dans %s :"
> +msgstr "Police invalide sp=E9cifi=E9e dans %s :"

This is indeed technically incorrect. fonte is not just an anglicism,
it is also an actual french word:

  http://police.planete-typographie.com/definitions.html

(for non-french speaking, it says that "Times" is a "police" and
"times normal, times italic, times bold, ..." are the different
"fonte" declinaisons of it)

That said, "police" is the most commonly used french word, so it can
be worth

>  msgid "Browse Branch Files"
> -msgstr "Visionner fichiers de branches"
> +msgstr "Naviguer fichiers de branches"

           Naviguer dans les fichiers de la branche

?

> -"Impossible d'avancer rapidement =E0 %s.\n"
> +"Impossible de mettre =E0 jour de mani=E8re rectiligne (fast forward=
) =E0 %s.\n"
>  "Une fusion est n=E9cessaire."
I think you can re-use the tape-recorder analogy here:

    Impossible de faire une avance-rapide vers %s.\n

> +"Un autre programme Git a modifi=E9 ce d=E9p=F4tdepuis la derni=E8re=
 synchronisation. Une resynchronisation doit =EAtre effectu=E9e avant d=
e pouvoir modifier la branche courante.\n"

missing space between d=E9p=F4t and depuis.

> -msgstr "Emprunt de '%s' abandonn=E9. (Il est n=E9cessaire de fusionn=
er des fichiers.)"
> +msgstr "Chargement de '%s' abandonn=E9. (Il est n=E9cessaire de fusi=
onner des fichiers.)"

Misplaced periods:

  +msgstr "Chargement de '%s' abandonn=E9 (Il est n=E9cessaire de fusio=
nner des fichiers)."

>  msgid "Hardlinks are unavailable.  Falling back to copying."
> -msgstr "Les liens durs ne sont pas disponibles. On se r=E9soud =E0 c=
opier."
> +msgstr "Les liens durs ne sont pas support=E9s. Une copie sera effec=
tu=E9e =E0 la place."

This is an anglicism (also very commonly used in practice).
"Supporter" is a false friend. "Supporter quelque chose" means "to
endure something" in correct french.

> -"Impossible de r=E9cup=E9rer les marques. Voir la sortie console pou=
r plus de "
> +"Impossible de r=E9cup=E9rer les marques (tags). Voir la sortie cons=
ole pour plus de "
>  "d=E9tails."

Right, I wouldn't have guessed that "marque" would refer to tags ;-)
but I can't give a really better translation.

> -msgstr "L'emprunt initial de fichier a =E9chou=E9."
> +msgstr "Checkement initial du fichier =E9chou=E9."

Chargement ?

>  #: lib/choose_rev.tcl:531
>  msgid "Updated"
> -msgstr "Misa =E0 jour"
> +msgstr "=C0 jour (updated)"

If you go for "index=E9" elsewhere, you should s/updated/index=E9/ here
also.

>  #: lib/commit.tcl:221
>  msgid "Calling pre-commit hook..."
> -msgstr "Appel du programme externe d'avant commit..."
> +msgstr "Appel du programme externe d'avant commit (pre-commit)..."

Quite un-natural to mee (but although I'm french, I'm more used to
technical english than technical french ;-) ) : "program externe" just
means "external program", but "hook" says something more. Perhaps
"action avant commit" would be more explicit.

> =20
>  #: lib/diff.tcl:303
>  msgid "Failed to unstage selected hunk."
> -msgstr "La suppression dans le pr=E9-commit de la section s=E9lectio=
nn=E9e a =E9chou=E9e."
> +msgstr "=C9chec lors de la d=E9sindexation de la section."
                                          de la section s=E9lectionn=E9=
e."

?

--=20
Matthieu
