From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>
Subject: Re: specify charset for commits (Was: [PATCH] Fix documentation copy&paste typo)
Date: Thu, 21 Dec 2006 14:43:38 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20061221134338.GA2246@cepheus>
References: <11655782712452-git-send-email-zeisberg@informatik.uni-freiburg.de> <20061221085907.GA2244@cepheus> <Pine.LNX.4.63.0612211050450.19693@wbgn013.biozentrum.uni-wuerzburg.de> <200612211623.14236.litvinov2004@gmail.com> <emdorr$kt$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 21 14:43:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxOD3-0007Zb-8c
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 14:43:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422943AbWLUNnm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 21 Dec 2006 08:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422944AbWLUNnm
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 08:43:42 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:57238 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422943AbWLUNnl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Dec 2006 08:43:41 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1GxOCy-0003zl-BM; Thu, 21 Dec 2006 14:43:40 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11) with ESMTP id kBLDhbdg016000;
	Thu, 21 Dec 2006 14:43:37 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11/Submit) id kBLDhb1o015999;
	Thu, 21 Dec 2006 14:43:37 +0100 (MET)
To: Jakub Narebski <jnareb@gmail.com>
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <zeisberg@informatik.uni-freiburg.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <emdorr$kt$1@sea.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35066>

Hello,

Jakub Narebski wrote:
> Alexander Litvinov wrote:
>=20
> >>> What do you think about a patch that makes git-commit-tree call i=
conv on
> >>> its input to get it to UTF-8 (or any other charset).
> >>
> >> We had this discussion over and over again. Last time (I think) wa=
s here:
> >> http://article.gmane.org/gmane.comp.version-control.git/11710
> >> Summary: we do not want to force the use of utf8.
> >=20
> > May we can add new header into commit with commit text encoding ?
>=20
> I think it should be repository-wide decision. And we have
> i18n.commitEncoding configuration variable
The disadvantage from a repository-wide decision is that you cannot
change it after a while.

I didn't know that variable, but I think as it exists,
git-commit-tree should iconv the commit message from local to
i18n.commitEncoding before writing it.

Moreover I like the idea of a new header for commits specifing the
encoding.  Git could default to the handling as it is now (i.e. just
bytes) if the header is missing.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D1+newton+in+kg*m+%2F+s%5E2
