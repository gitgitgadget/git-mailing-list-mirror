From: Ingo Molnar <mingo@elte.hu>
Subject: Re: git-grep: small suggestion, -w flag
Date: Sun, 22 Feb 2009 17:14:10 +0100
Message-ID: <20090222161410.GA24886@elte.hu>
References: <20090222103448.GA32119@elte.hu> <49A133C9.2030601@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Feb 22 17:17:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbH0y-0003fx-U5
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 17:17:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379AbZBVQOY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Feb 2009 11:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752214AbZBVQOX
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 11:14:23 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:54216 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751191AbZBVQOX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 11:14:23 -0500
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1LbGy5-0000L0-2z
	from <mingo@elte.hu>; Sun, 22 Feb 2009 17:14:21 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 0B2A13E2132; Sun, 22 Feb 2009 17:14:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <49A133C9.2030601@lsrfire.ath.cx>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx2: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111011>


* Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> wrote:

> Ingo Molnar schrieb:
> > Here's a stupid little git-grep suggestion.
> >=20
> > I recently transitioned from the use of egrep to git-grep, and i=20
> > like it very much (it nicely excludes build related files,=20
> > etc.), but there's one small detail: the lack of the -w flag.
>=20
> git grep knows this flag since version 1.4.1.  Does it do=20
> something different from egrep's?

ah:

 earth4:~/tip> git grep -lw schedule
 usage: git grep <option>* [-e] <pattern> <rev>* [[--] <path>...]


should have been 'git grep -l -w schedule'.

	Ingo
