From: Marc Weber <marco-oweber@gmx.de>
Subject: Re:Re: I suggest that git commit support -A option, just like hg does.thanks.
Date: Sat, 06 Aug 2011 21:35:35 +0200
Message-ID: <1312659297-sup-2956@nixos>
References: <20110806150246.GA20650@jpl.local> <35a2b515.12f42.1319f82c79d.Coremail.sinojelly@163.com> <4d88745.134ea.1319fe29f01.Coremail.sinojelly@163.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 06 21:35:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qpmet-0001CZ-LV
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 21:35:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756659Ab1HFTfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 15:35:39 -0400
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
Received: from mailout-de.gmx.net ([213.165.64.23]:60217 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756537Ab1HFTfi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 15:35:38 -0400
Received: (qmail invoked by alias); 06 Aug 2011 19:35:36 -0000
Received: from p4FEFD553.dip.t-dialin.net (EHLO mail.gmx.net) [79.239.213.83]
  by mail.gmx.net (mp017) with SMTP; 06 Aug 2011 21:35:36 +0200
X-Authenticated: #9006135
X-Provags-ID: V01U2FsdGVkX19AXVF5BytAMYFAoOrk1exUHuGvXfyl6wBiSXEeN7
	yyCyC6ZR8hY0mF
Received: by mail.gmx.net (sSMTP sendmail emulation); Sat, 06 Aug 2011 21:35:35 +0200
In-reply-to: <4d88745.134ea.1319fe29f01.Coremail.sinojelly@163.com>
User-Agent: Sup/git
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178889>

Excerpts from jelly's message of Sat Aug 06 18:17:34 +0200 2011:
> >It=C2=A0seems=C2=A0like=C2=A0you're=C2=A0looking=C2=A0for=C2=A0the=C2=
=A0-A=C2=A0option=C2=A0to=C2=A0"git=C2=A0add".
>=20
> I don't want to run "git add -A" before commit,=C2=A0
> I want to use "git commit -A -m 'msg' " instead.

if you need it that often add to your .bashrc:
gcA(){ git add -A && git commit -m "$@"; }

which is even faster.

Marc Weber
