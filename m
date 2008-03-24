From: Santiago Gala <sgala@apache.org>
Subject: Re: [PATCH] Spanish translation of gitk.
Date: Mon, 24 Mar 2008 10:07:08 +0000 (UTC)
Message-ID: <loom.20080324T091855-5@post.gmane.org>
References: <1206316703-15481-1-git-send-email-sgala@apache.org> <9D1D2D11-8C2E-4B8E-BB75-59D155AFF6BF@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 24 12:00:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdkQ3-0004ml-QG
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 12:00:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757430AbYCXLAG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Mar 2008 07:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756296AbYCXLAG
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 07:00:06 -0400
Received: from main.gmane.org ([80.91.229.2]:37111 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756084AbYCXLAF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 07:00:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JdkPL-0002lg-AV
	for git@vger.kernel.org; Mon, 24 Mar 2008 11:00:03 +0000
Received: from 233.Red-81-33-31.staticIP.rima-tde.net ([81.33.31.233])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 24 Mar 2008 11:00:03 +0000
Received: from sgala by 233.Red-81-33-31.staticIP.rima-tde.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 24 Mar 2008 11:00:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 81.33.31.233 (Mozilla/5.0 (X11; U; Linux x86_64; es-ES; rv:1.8.1.12) Gecko/20080209 Firefox/2.0.0.12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78019>

Wincent Colaiuta <win <at> wincent.com> writes:

>=20
> Great job on the translation! Some feedback follows:
>=20
> El 24/3/2008, a las 0:58, sgala <at> marlow.memojo.com escribi=C3=B3:
>=20
> > +#: gitk:275
> > +msgid "Can't parse git log output:"
> > +msgstr "No puedo analizar la salida de git log:"
>=20
> Wouldn't it be normal to use an impersonal form there? ie. "No se =20
> puede analizar" instead of "No puedo analizar"
>=20

Well, "no se puede" has 3 more characters than "no puedo", this was the
primary reason why I switched to the first person form. Spanish is way =
more
verbose than English. what about "Error analizando la salida de git log=
:"?
it is impersonal and shorter than the original one.

(...)

>=20
> "Move down" would be "Bajar", not "Subir".
>=20

done.

(...)
> > +#: gitk:6050
> > +msgid "From"
> > +msgstr "Da"
>=20

(...)

> Whoops! Some Italian crept in there!
>=20

This is not a good thing, as it means that I lost changes with my poor =
git
abilities :( I actually translated those lines, but the last changes go=
t lost
when I collapsed the commits into something decent to send.

> > #: gitk:8030
> > +msgid "Tab spacing"
> > +msgstr "Espaciado de  tabulador"
>=20
> Excess whitespace.
>=20

done.

> > +#: gitk:8039
> > +msgid "Limit diffs to listed paths"
> > +msgstr "Limita las diferencias a los path seleccionados"
>=20
> You want the infinitive there, "Limitar".
>=20
> > +#: gitk:8071
> > +msgid "Select bg"
> > +msgstr "Seleccione color de fondo"
>=20
> That's actually a misleading string in the English version of gitk. I=
t =20
> actually means "Selection background", not "Select a background". So =
=20
> the translation should be something like "Color de fondo de selecci=C3=
=B3n".
>=20
> > +#: gitk:8565
> > +msgid "Cannot find a git repository here."
> > +msgstr "No encuentro un repositorio git aqu=C3=AD."
>=20
> Personalized form "No encuentro" is not appropriate. "No se encuentra=
" =20
> would be better.
>=20
> > +#: gitk:8569
> > +#, tcl-format
> > +msgid "Cannot find the git directory \"%s\"."
> > +msgstr "No encuentro el directorio git \"%s\"."
>=20
> Again, "No se encuentra".
>=20
> > +#: gitk:8636
> > +msgid "Couldn't get list of unmerged files:"
> > +msgstr "Imposible obtener la lista de archivos pendientes de mezcl=
a:"
>=20
> Here you use "mezclar" (mix) as a translation for "merge", but =20
> previously you used "fusionar". I think you need to choose one or the=
 =20
> other and use it consistently. Personally, I think "fusionar" sounds =
=20
> better.
>=20
> > +#: gitk:8652
> > +msgid "No files selected: --merge specified but no files are =20
> > unmerged."
> > +msgstr ""
> > +"No hay archivos seleccionados: se seleccion=C3=B3 la opci=C3=B3n =
--merge =20
> > pero no hay "
> > +"archivos a falta de fusi=C3=B3nError al escribir revisi=C3=B3n:."
>=20
> This is munged, the "Error al escribir revisi=C3=B3n:" doesn't belong=
 there.
>=20
> Also, here you use "a falta de [fusi=C3=B3n]" for "unmerged", whereas=
 above =20
> you used "pendientes de [mezcla]". I think it would be best to always=
 =20
> use "pendientes de ...".
>=20
> Great job though, thanks a lot for the translation!
>=20

I think I have taken care of most/all of the suggestions. It would be e=
asier,
IMO, if I send an incremental commit and don't collapse them, so that w=
e can
keep the discussion on (hopefully) smaller patches each time :)

So I'm sending a patch assuming this one is committed, instead of rebas=
ing the
old and this one.

Regards
Santiago

> Cheers,
> Wincent
>=20
>=20

PD: the gmane UI does not allow me to post unless I remove the quotes, =
so I'm
cutting most of the detailed comments to be able to post or loose my ti=
me
answering. :(
