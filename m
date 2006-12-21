From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: t5000-tar-tree.sh failing
Date: Thu, 21 Dec 2006 15:00:25 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612211458360.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061221133746.GA13751@cepheus>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-2107858282-1166709625=:19693"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 21 15:00:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxOTH-0002If-Uw
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 15:00:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422881AbWLUOA2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 09:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422949AbWLUOA2
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 09:00:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:54607 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422881AbWLUOA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 09:00:28 -0500
Received: (qmail invoked by alias); 21 Dec 2006 14:00:25 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp047) with SMTP; 21 Dec 2006 15:00:25 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>
In-Reply-To: <20061221133746.GA13751@cepheus>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35068>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-2107858282-1166709625=:19693
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 21 Dec 2006, Uwe Kleine-König wrote:

> [...]
> 	* FAIL 14: extract ZIP archive
> 		(mkdir d && cd d && $UNZIP ../d.zip)
> [...]
>
> I think the problem is:
> 
> 	zeisberg@cepheus:~/gsrc/git$ unzip
> 	bash: unzip: command not found

Yep. That's the problem.

> Probably the subversion tests suffer the same (for svn instead of 
> unzip).
> 
> Do we want the tests to depend on all that or would it be sensible to
> output a warning that a program is missing?

Why not enclose the tests in a

	if unzip -h >/dev/null 2>/dev/null; then

		# all these tests

	fi

Hmm?

Ciao,
Dscho

---1148973799-2107858282-1166709625=:19693--
