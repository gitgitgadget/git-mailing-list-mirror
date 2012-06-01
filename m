From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Nits abut the italian translation (was: Re: Please pull git-l10n
 updates on master branch)
Date: Fri, 01 Jun 2012 13:33:33 +0200
Message-ID: <4FC8A88D.3080700@gmail.com>
References: <CANYiYbF3sbtKVTZJOTbQ-aOjBKGKFZfq-xQDwyOvR56C7akrLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Marco Paolone <marcopaolone@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdQ==?= =?UTF-8?B?w6Ju?= 
	<vnwildman@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 13:33:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaQ6z-00087q-29
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 13:33:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758024Ab2FALdk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Jun 2012 07:33:40 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:51749 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664Ab2FALdj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 07:33:39 -0400
Received: by bkcji2 with SMTP id ji2so1747764bkc.19
        for <git@vger.kernel.org>; Fri, 01 Jun 2012 04:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=mBmmiB/nI/pyeovSvCGnXqksumH0cyEStl2Fv8CkELQ=;
        b=zl2LsD9yOf2YIMfN8jhzJ2hSeQJN4z4RUZuJwrUMlIN8GCyKMim5rbJH3mDjLlJa6L
         0kj6VyCcHpilqLk+EdH7xgXn/AAgJQazQRLBzV/eDfUuQu3ZuH4DNCPnUZet0grw8CCG
         ZhRJcewZsdpaJmwYxXuzlV8oKsGpFrRpWIdTGJespnoc+UIje+LlMhNwGvDlkNJ8zpbN
         LHMm7I0Riw3b2UFNmLGRqgE59w5R1/tKbCpfbRnm+arDE/UJHkeCx4LNJbOePRXir1iC
         nR7EPHmkqFs/NBBfXK+kxRrlPfbTNoegWugOJb/hCNm7OYpF25OmguKLwv+5Nx74P3/8
         G+aA==
Received: by 10.205.126.14 with SMTP id gu14mr1418020bkc.137.1338550417894;
        Fri, 01 Jun 2012 04:33:37 -0700 (PDT)
Received: from [87.8.100.238] (host238-100-dynamic.8-87-r.retail.telecomitalia.it. [87.8.100.238])
        by mx.google.com with ESMTPS id n19sm1717239bkv.14.2012.06.01.04.33.35
        (version=SSLv3 cipher=OTHER);
        Fri, 01 Jun 2012 04:33:36 -0700 (PDT)
In-Reply-To: <CANYiYbF3sbtKVTZJOTbQ-aOjBKGKFZfq-xQDwyOvR56C7akrLw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198979>

On 06/01/2012 12:20 PM, Jiang Xin wrote:
> Hi Junio,
>=20
> As usual, this pull is for master branch. In this pull, both 'it.po'
> and 'zh_CN.po'
> have fuzzy translations. One translation in 'zh_CN.po' intends to be =
fuzzy,
> because it is hard to translate right, and I sent a patch for this ye=
sterday.
>
> Marco Paolone (1):
>       l10n: New it.po file with 504 translations
>
I see few minor issues with the new translations; I hope it's OK if I r=
eport
them here.  Do not consider the following as an exhaustive list, since =
I've
just skimmed the it.po file.  And sorry for the messy and out-of-order =
report,
but I'm short of time in these days.

Regards,
  Stefano

~~~

  #: diff.c:1421
  #, c-format
  msgid ", %d insertion(+)"
  msgid_plural ", %d insertions(+)"
  msgstr[0] ", %d aggiunta(+)"
  msgstr[1] ", %d aggiunte(+)<"

Spurious "<" here?

~~~

  #: help.c:214
  msgid "git commands available from elsewhere on your $PATH"
  msgstr "i comandi git sono disponibili in un altro percorso nel tuo $=
PATH"

Given the context this message is use in (output of "git help -a"), I t=
hink a
more correct translation would be:

  comandi git disponibili altrove nel tuo $PATH

~~~

  #: sequencer.c:403
  #, c-format, fuzzy
  msgid "Cannot get commit message for %s"
  msgstr "Non =C3=A8 possibile prelevare il messaggio di commit per %s"

What about "Impossibile ottenere il messaggio di commit per %s" instead=
?
"Prelevare" sounds weird in this context, at least to me ...

~~~

"branch" is sometimes translated, sometimes not:

  #: wt-status.c:744
  msgid "Not currently on any branch."
  msgstr "Al momento non si =C3=A8 su alcun ramo."

  #: sha1_name.c:869
  #, c-format
  msgid "No upstream configured for branch '%s'"
  msgstr "Nessun upstream configurato per il branch '%s'"

BTW, are we sure it's a good idea to translate technical terms like
'branch'?  And if yes, why translate some terms (branch -> albero),
but not others (tag -> etichetta)?

~~~

  #. TRANSLATORS: Make sure to include [Y] and [n] in your
  #. translation. The program will only accept English input
  #. at this point.
  #: git-bisect.sh:279
  msgid "Are you sure [Y/n]? "
  msgstr "Si =C3=A8 sicuri? [S/n] "

The translation "[S/n]" seems to contradict the comment above.

  #. TRANSLATORS: Make sure to include [y], [n], [e], [v] and [a]
  #. in your translation. The program will only accept English
  #. input at this point.
  #: git-am.sh:766
  #, fuzzy
  msgid "Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all "
  msgstr "Applicare? [s]=C3=AC/[n]o/[m]odifica/[v]isualizza/mostra [p]a=
tch/[a]ccetta tutto "

Likewise, but worse.

~~~

  #: common-cmds.h:28
  #, fuzzy
  msgid "Create, list, delete or verify a tag object signed with GPG"
  msgstr "Crea, elenca. elimina o verifica un oggetto tag firmato con G=
PG"

Minor typo: should be "elenca," not "elenca.".

~~~

  #: builtin/tag.c:376
  #, c-format, fuzzy
  msgid "The tag message has been left in %s\n"
  msgstr "Il messaggio tag =C3=A8 stato lasciato in %s\n"

"Il messaggio del tag" or "Il messaggio associato al tag" seems clearer=
 and more
correct.

~~~


  #: builtin/reset.c:325
  #, c-format, fuzzy
  msgid "%s reset is not allowed in a bare repository"
  msgstr "%s reset non =C3=A8 consentito in un archivio scoperto #FIXME=
: bare"

What about translating "bare" with "spoglio"?

~~~

  #: builtin/mv.c:171
  msgid "not under version control"
  msgstr "non si trova nel sistema di controllo versione"

What about "non e' sotto controllo di versione"?  It seems a slightly m=
ore
faithful translation to me.

~~~

  #: builtin/merge.c:1146 builtin/merge.c:1303
  #, c-format, fuzzy
  msgid "%s - not something we can merge"
  msgstr "%s - non =C3=A8 qualcosa per cui effettuare il merge"

I'd say: "non =C3=A8 qualcosa per cui possiamo effettuare il merge"

~~~

  #: builtin/help.c:108
  #, c-format
  msgid "emacsclient version '%d' too old (< 22)."
  msgstr "la versione '%d' di emacsclient =C3=A8 vecchia (<22)."

s/vecchia/troppo vecchia/?

~~~

  #: builtin/commit.c:1588
  msgid ""
  "Repository has been updated, but unable to write\n"
  "new_index file. Check that disk is not full or quota is\n"
  "not exceeded, and then \"git reset HEAD\" to recover."
  msgstr ""
  "L'archivio =C3=A8 stato aggiornato, ma non =C3=A8 stato possibile sc=
rivere il file\n"
  "new_index. Verificare che l'unit=C3=A0 disco non sia piena o che la =
quota non sia\n"
  "stata superata, ed eseguire \"git reset HEAD\"ccc per il ripristino.=
"

What is that "ccc" after "HEAD" for?

~~~

  #: builtin/add.c:297
  msgid "Empty patch. Aborted."
  msgstr "Patch vuota. Operazione terminata."

I beliave "bloccata" (or even "abortita") would be clearer than "termin=
ata" in
this context?
