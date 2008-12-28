From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH 3/3] pretty: support multiline subjects with format:
Date: Sun, 28 Dec 2008 15:16:51 +0100
Message-ID: <200812281516.52080.markus.heidelberg@web.de>
References: <1230338961.8363.101.camel@ubuntu.ubuntu-domain> <200812280024.59096.markus.heidelberg@web.de> <4956C47B.4020602@lsrfire.ath.cx>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Dec 28 15:20:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGwVl-0003Fe-T5
	for gcvg-git-2@gmane.org; Sun, 28 Dec 2008 15:20:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754726AbYL1OQt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Dec 2008 09:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754671AbYL1OQt
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Dec 2008 09:16:49 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:54608 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754642AbYL1OQs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Dec 2008 09:16:48 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id 80337F84405A;
	Sun, 28 Dec 2008 15:16:47 +0100 (CET)
Received: from [91.19.28.232] (helo=pluto)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #273)
	id 1LGwRj-00051b-00; Sun, 28 Dec 2008 15:16:47 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <4956C47B.4020602@lsrfire.ath.cx>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19mrnPjByamrwYqvkCy1bzmFAp7BFDqgUDxVaAf
	qltS2KtohENlR7ditbTmEwRDL6a8gczbUK74QQtNKgthlbJPyJ
	sUjiqfS65SV57PzkDVjw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104049>

Ren=C3=A9 Scharfe, 28.12.2008:
> Markus Heidelberg schrieb:
> >> For consistency and increased code reuse, change format: to do the
> >> same as the other options.
> >=20
> > What's wrong with using the first line instead of the first paragra=
ph
> > for the other pretty options and for cases where only a small subje=
ct
> > line is desired? A sentence would be broken into a small uncomplete=
 part
> > for the subject for example. What else?
>=20
> I'm inching towards the goal of being able to replicate all of the ot=
her
> --pretty flavours with format: (or tformat:) strings.
>=20
> --pretty=3Doneline used to print only the first line, but was changed=
 to
> the way it's now in 4234a761 more than a year ago.  In my mind,
> "subject" is defined by "what oneline is printing", so I think changi=
ng
> the format: placeholder %s to show the whole first paragraph is a bug=
 fix.

Yes, now I think so, too. I had also noticed the unexpectedly different
behaviour once.

> If you actually like the old behaviour then perhaps a new placeholder
> (%S ?) should be introduced instead?

I don't need it. I rather asked regarding the old behaviour for oneline
and so, but reading that there are strong intentions for their
behaviour, it's fine.

Markus
