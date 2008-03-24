From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Spanish translation of gitk.
Date: Mon, 24 Mar 2008 10:00:32 +0100
Message-ID: <9D1D2D11-8C2E-4B8E-BB75-59D155AFF6BF@wincent.com>
References: <1206316703-15481-1-git-send-email-sgala@apache.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Santiago Gala <sgala@apache.org>
To: sgala@marlow.memojo.com
X-From: git-owner@vger.kernel.org Mon Mar 24 10:02:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdiZG-0007bI-Bd
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 10:02:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754266AbYCXJBV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Mar 2008 05:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752986AbYCXJBV
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 05:01:21 -0400
Received: from wincent.com ([72.3.236.74]:39574 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752542AbYCXJBT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2008 05:01:19 -0400
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m2O90ZVW003757;
	Mon, 24 Mar 2008 04:00:36 -0500
In-Reply-To: <1206316703-15481-1-git-send-email-sgala@apache.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78011>

Great job on the translation! Some feedback follows:

El 24/3/2008, a las 0:58, sgala@marlow.memojo.com escribi=F3:

> +#: gitk:275
> +msgid "Can't parse git log output:"
> +msgstr "No puedo analizar la salida de git log:"

Wouldn't it be normal to use an impersonal form there? ie. "No se =20
puede analizar" instead of "No puedo analizar"

> +#: gitk:683 gitk:1317
> +msgid "About gitk"
> +msgstr "Informaci=F3n sobre gitk"

I suspect that "Acerca de gitk" might be more typical here.

> +#: gitk:792
> +msgid "next"
> +msgstr "<<"
> +
> +#: gitk:793
> +msgid "prev"
> +msgstr ">>"
> +
> +#: gitk:794
> +msgid "commit"
> +msgstr "revisiones"

Why have you translated "commit" (singular) as "revisiones" (plural)?

> +#: gitk:800 gitk:1778 gitk:1783 gitk:2431
> +msgid "touching paths:"
> +msgstr "que modifican path:"

"path" should be "ruta", I think.

> +#: gitk:854
> +msgid "Old version"
> +msgstr "Versi=F3n ant=EDgua"
> +
> +#: gitk:856
> +msgid "New version"
> +msgstr "Versi=F3n Nueva"

Consistency: you've capitalized "Nueva" but not "antigua". I think =20
both should be uncapitalized.

Also, "antigua" is not supposed to have an accent on the "i".

> +msgid "Make patch"
> +msgstr "Crea patch"

I think you want the infinitive there, ie "Crear".

> +#: gitk:1058 gitk:6162
> +msgid "Create tag"
> +msgstr "Crea etiqueta"

Ditto.

> +#: gitk:1079
> +msgid "Check out this branch"
> +msgstr "Activar esta rama"

Here you've translated "Check out" as "activate", but I wonder if it =20
might be better to instead pick a term like "switch to" (ie. "Cambiar =20
a").

> +"Uso y redistribuci=F3n permitidos seg=FAn los t=E9rminos de la Lice=
ncia =20
> General P=FAblica"
> +"GNU"

The official translations of the GNU GPL refer to it as "Licencia =20
P=FAblica General de GNU (GNU GPL)". (See translation linked to from ht=
tp://www.gnu.org/licenses/old-licenses/gpl-2.0-translations.html)=20
=2E

> +#: gitk:1356
> +msgid "<PageUp>\tMove up one page in commit list"
> +msgstr "<PageUp>\tSubir una p=E1gina en la lista de revisiones"
> +
> +#: gitk:1357
> +msgid "<PageDown>\tMove down one page in commit list"
> +msgstr "<PageDown>\tSubir una p=E1gina en la lista de revisiones"

"Move down" would be "Bajar", not "Subir".

> +msgid "<%s-Up>\tScroll commit list up one line"
> +msgstr "<%s-Up>\tDesplazarse una l=EDnea arriba en la lista de =20
> revisiones"
> +
> +#: gitk:1361
> +#, tcl-format
> +msgid "<%s-Down>\tScroll commit list down one line"
> +msgstr "<%s-Down>\tDesplazarse una l=EDnea abajo en la lista de =20
> revisiones"
> +
> +#: gitk:1362
> +#, tcl-format
> +msgid "<%s-PageUp>\tScroll commit list up one page"
> +msgstr "<%s-PageUp>\tDesplaza hacia arriba una p=E1gina la lista de =
=20
> revisiones"
> +
> +#: gitk:1363
> +#, tcl-format
> +msgid "<%s-PageDown>\tScroll commit list down one page"
> +msgstr "<%s-PageDown>\tDesplaza hacia abajo una p=E1gina la lista de=
 =20
> revisiones"

Consistency: you've translated the per-line versions as "[unit] arriba/=
=20
abajo" but you've translated the per-page ones as "hace [direction] =20
[unit]". I think it would be better to use the latter format for all =20
four.

> +#: gitk:1364
> +msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
> +msgstr "<Shift-Up>\tBusca hacia atr=E1s (ariba, revisiones siguiente=
s)"

Spelling: "arriba"

> +#: gitk:1371
> +#, tcl-format
> +msgid "<%s-F>\t\tFind"
> +msgstr "<%s-F>\t\tBusca"

I think you want the infinitive there ("Buscar").

> +#: gitk:1372
> +#, tcl-format
> +msgid "<%s-G>\t\tMove to next find hit"
> +msgstr "<%s-G>\t\tBusca siguiente"

Ditto, infinitive "Buscar".

> +#: gitk:1373
> +msgid "<Return>\t\tMove to next find hit"
> +msgstr "<Return>\t\tBusca siguiente"

Ditto, infinitive "Buscar".

> +#: gitk:1374
> +msgid "/\t\tMove to next find hit, or redo find"
> +msgstr "/\t\tBusca siguiente, o vuelve a buscar"

Ditto, infinitive "Buscar", and infinitive "volver".

> +#: gitk:1375
> +msgid "?\t\tMove to previous find hit"
> +msgstr "?\t\tBusca anterior"

Ditto, infinitive "Buscar".

> +#: gitk:1379
> +#, tcl-format
> +msgid "<%s-KP+>\tIncrease font size"
> +msgstr "<%s-KP+>\tMayor tama=F1o de tipograf=EDa"
>
> +
> +#: gitk:1380
> +#, tcl-format
> +msgid "<%s-plus>\tIncrease font size"
> +msgstr "<%s-plus>\tMayor tama=F1o de tipograf=EDa"
> +
> +#: gitk:1381
> +#, tcl-format
> +msgid "<%s-KP->\tDecrease font size"
> +msgstr "<%s-KP->\tMenor tama=F1o de tipograf=EDa"
> +
> +#: gitk:1382
> +#, tcl-format
> +msgid "<%s-minus>\tDecrease font size"
> +msgstr "<%s-minus>\tMenor tama=F1o de tipograf=EDa"

Most apps I've seen use "Aumentar tama=F1o del texto", "Disminuir tama=F1=
o =20
del texto" for that purpose (see Firefox, for example).

> +#: gitk:1942
> +msgid "Enter files and directories to include, one per line:"
> +msgstr "Insertar archivos y directorios a incluir, uno por l=EDnea:"

I think you mean "Introducir", not "Insertar".

> +#: gitk:2531 gitk:4336
> +msgid "CDate"
> +msgstr "Fecha de Creaci=F3n"

=46or consistency with other terms in the translation, "Creaci=F3n" sho=
uld =20
probably not be capitalized.

> +#: gitk:2924
> +msgid "Local changes checked in to index but not committed"
> +msgstr "Cambios locales, a=F1adidos a =EDndice y pendientes de commi=
t"

I'm a little concerned about the translation of "commit" (when used as =
=20
a noun) as "revision", but when used as a verb as "commit". It would =20
be nice to settle settle on something standard that could be used in =20
both contexts. Not sure what might be the best option.

In any case I think it should be "al =EDndice", not "a =EDndice".

> +msgid "Local uncommitted changes, not checked in to index"
> +msgstr "Cambios locales sin a=F1adir a =EDndice"

Again, "al =EDndice".

> +#: gitk:4305
> +msgid "Searching"
> +msgstr "B=FAscando"

That accent shouldn't be in there. Should be "Buscando".

> +#: gitk:5961
> +msgid "Children"
> +msgstr "Hijos"

I notice that you translated "Child" (singular) as "Hija" (feminine), =20
but "Children" (plural) as "Hijos" (masculine). Should probably pick =20
one gender and stick to it.

> +#: gitk:6050
> +msgid "From"
> +msgstr "Da"

I think you mean "De".

> +#: gitk:6055
> +msgid "To"
> +msgstr "A"

I'm not sure of the context of this, but I suspect that "Para" would =20
be better.

> +#: gitk:6080
> +msgid "From:"
> +msgstr "Da:"

Again, "De:".

> +#: gitk:6089
> +msgid "To:"
> +msgstr "A:"

Again, depending on the context this might be "Para:". I'm no sure =20
where this is used in the UI.

> +#: gitk:6098
> +msgid "Reverse"
> +msgstr "Invertido"

"Al rev=E9s"?

> +#: gitk:6404
> +msgid "Confirm reset"
> +msgstr "Conferma git reset"

"Confirmar"

> +#: gitk:6523
> +msgid "Cannot delete the currently checked-out branch"
> +msgstr "No se puede borrar la rama sobre la que se trabaja"

"la rama actual" might be a bit simpler than "la rama sobre la que se =20
trabaja".

> +#: gitk:6560
> +#, tcl-format
> +msgid "Tags and heads: %s"
> +msgstr "Etiquetas y ramas: %s"

I know you've translated "branch" as "rama" elsewhere, but now you've =20
conflated "head" as "rama" as well.

Don't we want a separate term for "head"? Something like "cabecera"?

> +#: gitk:6868
> +msgid ""
> +"Error reading commit topology information; branch and preceding/=20
> following "
> +"tag information will be incomplete."
> +msgstr ""
> +"Error al leer la topolog=EDa de revisiones: la informaci=F3n sobre =
"
> +"las ramas y etiquetas precedentes y siguientes sar=E1 incompleta."

Spelling: "ser=E1", not "sar=E1".

> +#: gitk:8005
> +msgid "Gitk preferences"
> +msgstr "Preferencias gitk"

You probably want "Preferencias de gitk".

> +#: gitk:8009
> +msgid "Maximum graph width (lines)"
> +msgstr "Larghezza massima del grafico (in linee)"
> +
> +#: gitk:8013
> +#, tcl-format
> +msgid "Maximum graph width (% of pane)"
> +msgstr "Larghezza massima del grafico (% del pannello)"
> +
> +#: gitk:8018
> +msgid "Show local changes"
> +msgstr "Mostra modifiche locali"
> +
> +#: gitk:8023
> +msgid "Auto-select SHA1"
> +msgstr "Seleziona automaticamente SHA1 hash"

Whoops! Some Italian crept in there!

> #: gitk:8030
> +msgid "Tab spacing"
> +msgstr "Espaciado de  tabulador"

Excess whitespace.

> +#: gitk:8039
> +msgid "Limit diffs to listed paths"
> +msgstr "Limita las diferencias a los path seleccionados"

You want the infinitive there, "Limitar".

> +#: gitk:8071
> +msgid "Select bg"
> +msgstr "Seleccione color de fondo"

That's actually a misleading string in the English version of gitk. It =
=20
actually means "Selection background", not "Select a background". So =20
the translation should be something like "Color de fondo de selecci=F3n=
".

> +#: gitk:8565
> +msgid "Cannot find a git repository here."
> +msgstr "No encuentro un repositorio git aqu=ED."

Personalized form "No encuentro" is not appropriate. "No se encuentra" =
=20
would be better.

> +#: gitk:8569
> +#, tcl-format
> +msgid "Cannot find the git directory \"%s\"."
> +msgstr "No encuentro el directorio git \"%s\"."

Again, "No se encuentra".

> +#: gitk:8636
> +msgid "Couldn't get list of unmerged files:"
> +msgstr "Imposible obtener la lista de archivos pendientes de mezcla:=
"

Here you use "mezclar" (mix) as a translation for "merge", but =20
previously you used "fusionar". I think you need to choose one or the =20
other and use it consistently. Personally, I think "fusionar" sounds =20
better.

> +#: gitk:8652
> +msgid "No files selected: --merge specified but no files are =20
> unmerged."
> +msgstr ""
> +"No hay archivos seleccionados: se seleccion=F3 la opci=F3n --merge =
=20
> pero no hay "
> +"archivos a falta de fusi=F3nError al escribir revisi=F3n:."

This is munged, the "Error al escribir revisi=F3n:" doesn't belong ther=
e.

Also, here you use "a falta de [fusi=F3n]" for "unmerged", whereas abov=
e =20
you used "pendientes de [mezcla]". I think it would be best to always =20
use "pendientes de ...".

Great job though, thanks a lot for the translation!

Cheers,
Wincent
