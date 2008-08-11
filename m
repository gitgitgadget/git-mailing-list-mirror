From: Alexandre Bourget <alexandre.bourget@savoirfairelinux.com>
Subject: Re: [PATCH] Update french translation
Date: Mon, 11 Aug 2008 17:17:41 -0400
Organization: Savoir-faire Linux
Message-ID: <1218489461.11353.135.camel@alexandre-desktop>
References: <1218465592-2446-1-git-send-email-alexandre.bourget@savoirfairelinux.com>
	 <1218465592-2446-2-git-send-email-alexandre.bourget@savoirfairelinux.com>
	 <vpqr68vuzoo.fsf@bauges.imag.fr>
Reply-To: alexandre.bourget@savoirfairelinux.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Aug 11 23:18:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSemS-0004hX-T5
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 23:18:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905AbYHKVRS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Aug 2008 17:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753723AbYHKVRS
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 17:17:18 -0400
Received: from mail.savoirfairelinux.net ([69.28.212.163]:48586 "EHLO
	open-xchange.savoirfairelinux.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753480AbYHKVRR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Aug 2008 17:17:17 -0400
Received: from localhost (unknown [127.0.0.1])
	by open-xchange.savoirfairelinux.net (Postfix) with ESMTP id 0035B4618E4;
	Mon, 11 Aug 2008 21:17:15 +0000 (UTC)
Received: from open-xchange.savoirfairelinux.net ([127.0.0.1])
	by localhost (open-xchange.savoirfairelinux.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bm-eH7ptTNzD; Mon, 11 Aug 2008 17:17:12 -0400 (EDT)
Received: from [192.168.1.221] (mtl.savoirfairelinux.net [199.243.85.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by open-xchange.savoirfairelinux.net (Postfix) with ESMTP id 0AF4B4618E2;
	Mon, 11 Aug 2008 17:17:11 -0400 (EDT)
In-Reply-To: <vpqr68vuzoo.fsf@bauges.imag.fr>
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92002>

Hi Matthieu and list,

I've retouched the French translation update for git-gui.. I'll send it
right after this mail.

I've fixed some more "out-of-context" translations, and considered some
of the comments from Matthieu Moy.

A second patch will follow which will updated all lacking translations
as of today. This makes the French translation 100% covered and
reviewed.



Le lundi 11 ao=C3=BBt 2008 =C3=A0 21:19 +0200, Matthieu Moy a =C3=A9cri=
t :
> General remark: you should split your patch into
>=20
> * Some word substitution on the one side (s/r=C3=A9f=C3=A9rentiel/d=C3=
=A9pos/g,
>   s/fonte/police/g, ...)
>=20
> * Some manual rephrasing.

This is funny requirement, especially when I see what you've let in as =
a
"french" translation :) I doubt=20


> >  msgid "Hardlinks are unavailable.  Falling back to copying."
> > -msgstr "Les liens durs ne sont pas disponibles. On se r=C3=A9soud =
=C3=A0 copier."
> > +msgstr "Les liens durs ne sont pas support=C3=A9s. Une copie sera =
effectu=C3=A9e =C3=A0 la place."
>
> This is an anglicism (also very commonly used in practice).
> "Supporter" is a false friend. "Supporter quelque chose" means "to
> endure something" in correct french.

In fact, there are many meanings to that word. "Centre de support"
doesn't mean a place to endure stuff :)

http://www.granddictionnaire.com reveals us that "supporter" is a
computer-related term that means just what we need here, and it's been
reviewed by the "Office de la langue fran=C3=A7aise" in 2002.

> >  #: lib/choose_rev.tcl:531
> >  msgid "Updated"
> > -msgstr "Misa =C3=A0 jour"
> > +msgstr "=C3=80 jour (updated)"
>=20
> If you go for "index=C3=A9" elsewhere, you should s/updated/index=C3=A9=
/ here
> also.

Have you looked at the context ?

To tell you the truth, I hadn't either, but I just did and fixed it in
the second patch I send. It was used in a tooltip to show the last date
a branch was updated, so it's now "Mise-=C3=A0-jour:".


There you go, I've fixed most of the things you've outlines.

Hope this helps


Alexandre Bourget

--=20
Alexandre Bourget
Consultant en Logiciel Libre
Savoir-faire Linux Inc.
alexandre.bourget@savoirfairelinux.com
514-276-5468 poste 124
