From: =?iso-8859-1?q?Bj=F6rn_Hendriks?= <bjoern01@nurfuerspam.de>
Subject: Re: Generate version file by hooks
Date: Tue, 17 Mar 2009 17:40:26 +0100
Message-ID: <200903171740.26575.bjoern01@nurfuerspam.de>
References: <450196A1AAAE4B42A00A8B27A59278E70A2AF280@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "John Dlugosz" <JDlugosz@tradestation.com>,
	Santi =?iso-8859-1?q?B=E9jar?= <santi@agolina.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 17 17:42:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjcMe-0005fS-0y
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 17:42:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755140AbZCQQkc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Mar 2009 12:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754530AbZCQQkc
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 12:40:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:44804 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753802AbZCQQkb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2009 12:40:31 -0400
Received: (qmail invoked by alias); 17 Mar 2009 16:40:27 -0000
Received: from malvasia.ibr.cs.tu-bs.de (EHLO malvasia.ibr.cs.tu-bs.de) [134.169.34.62]
  by mail.gmx.net (mp020) with SMTP; 17 Mar 2009 17:40:27 +0100
X-Authenticated: #1618055
X-Provags-ID: V01U2FsdGVkX19F9A9v1kxF8HoIs8ScndCCMmayLXA9Ebkv4fjJB4
	ci+dSQ4xir7mVl
User-Agent: KMail/1.9.10
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70A2AF280@EXCHANGE.trad.tradestation.com>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113501>


Hi John, hi Santi,

thanks for your help.

On Dienstag 17 M=E4rz 2009 16:42:01 John Dlugosz wrote:
> Isn't that what the existing file HEAD is for?  Possibly with a level=
 of
> indirection.  So use
> 	git rev-parse HEAD
> any time you need that SHA1 value.  The HEAD is always updated, since
> that _is_ what defines the "current" commit.

That might be a good alternative to my call of git-log which I was not=20
absolutely sure if it works under all circumstances.

In fact my problem is not to find out the SHA1 of the last commit in a =
script=20
but to have that script called automatically each time git changes the=20
commit. My idea was to use the git hooks for that, but as I explained I=
=20
couldn't find hooks for all cases in which a commit changes.

I need git to do that because my application is a Matlab-project which =
I=20
normally do not compile -- although there is a Matlab-compiler to get a=
=20
standalone application, but within the Matlab environment you don't nee=
d to=20
compile. It would be the same with my little bash-helper-scripts I mana=
ge=20
also with the great assistance of git.

But now -- as I think of it -- I might as well put a script call into t=
he=20
Matlab-code to get the last SHA1 and find a different solution for the =
rare=20
cases in which I really compile the Matlab-code.

Thanks
Bj=F6rn
