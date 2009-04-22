From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] show-branch: color the commit status signs
Date: Wed, 22 Apr 2009 22:45:23 +0200
Message-ID: <200904222245.24034.markus.heidelberg@web.de>
References: <1240350779-9686-1-git-send-email-markus.heidelberg@web.de> <780e0a6b0904221226s43a40a12k8bf83de12fa7815d@mail.gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 22:48:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwjLo-0004i9-1T
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 22:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753711AbZDVUpu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Apr 2009 16:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753658AbZDVUpt
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 16:45:49 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:37201 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753602AbZDVUpt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2009 16:45:49 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id C6005FAE5CCB;
	Wed, 22 Apr 2009 22:44:44 +0200 (CEST)
Received: from [89.59.119.90] (helo=.)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LwjJE-0004RA-00; Wed, 22 Apr 2009 22:44:44 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <780e0a6b0904221226s43a40a12k8bf83de12fa7815d@mail.gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+HdBfG+nWrQJtW4djjJVQHdMgSJ/eV5c/ZuI6R
	xS2zG6y9tod67f780mBwt4UvSo8wgTL3HakR0cSFlitKENB3s2
	5dgbboy9+sjtYy1i5llg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117256>

Stephen Boyd, 22.04.2009:
> On Tue, Apr 21, 2009, Markus Heidelberg <markus.heidelberg@web.de> wr=
ote:
> > +--color::
> > + =C2=A0 =C2=A0 =C2=A0 Color the status sign of the commits. Each b=
ranch uses a single color.
>=20
> I don't know what the status sign of a commit is without reading your=
 commit
> message. Maybe reword this to be:
>=20
> Color the status sign ('*' '!' '+' '-') of each commit corresponding
> to the branch
> it's in.

I had some problems with finding the right words for the description an=
d
still wasn't satisfied with it. I think your suggestion makes it easier
and will include it.

> > +static char column_colors[][COLOR_MAXLEN] =3D {
> > + =C2=A0 =C2=A0 =C2=A0 GIT_COLOR_RED,
> > + =C2=A0 =C2=A0 =C2=A0 GIT_COLOR_GREEN,
> > + =C2=A0 =C2=A0 =C2=A0 GIT_COLOR_YELLOW,
> > + =C2=A0 =C2=A0 =C2=A0 GIT_COLOR_BLUE,
> > + =C2=A0 =C2=A0 =C2=A0 GIT_COLOR_MAGENTA,
> > + =C2=A0 =C2=A0 =C2=A0 GIT_COLOR_CYAN,
> > +};
> > +
> > +#define COLUMN_COLORS_MAX (ARRAY_SIZE(column_colors))
>=20
> This looks like a copy/paste (with a small edit) from graph.c so mayb=
e you
> want to refactor the original code from graph.c to color.h?

How exactly do you think it can be refactored and then combined?

Markus
