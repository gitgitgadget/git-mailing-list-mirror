From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git-svn, and which branch am I on?
Date: Sat, 28 Feb 2009 15:54:16 +0100
Message-ID: <20090228145416.GA6289@atjola.homenet>
References: <87ljrr7xof.fsf@rimspace.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Daniel Pittman <daniel@rimspace.net>
X-From: git-owner@vger.kernel.org Sat Feb 28 15:55:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdQba-0006FR-3o
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 15:55:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652AbZB1OyZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Feb 2009 09:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751571AbZB1OyZ
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 09:54:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:41714 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750966AbZB1OyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 09:54:25 -0500
Received: (qmail invoked by alias); 28 Feb 2009 14:54:18 -0000
Received: from i577B8EA8.versanet.de (EHLO atjola.local) [87.123.142.168]
  by mail.gmx.net (mp004) with SMTP; 28 Feb 2009 15:54:18 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18+x7MZQeI+Lyg81GA187TYAUA4RZ4PAoIB9lWX6K
	tP8pVM+IDP6VjJ
Content-Disposition: inline
In-Reply-To: <87ljrr7xof.fsf@rimspace.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111768>

On 2009.02.28 19:50:08 +1100, Daniel Pittman wrote:
> G'day.
>=20
> I recently got asked a question about git-svn that I had no idea how =
to
> answer, and which I am actually curious to know how to find out.
>=20
> The general question was: in git, how do I identify where this branch
> came from?

"git svn info" tells you, besides other things, the URL your checked ou=
t
branch is based upon WRT svn. Use it with "--url" to show only the URL.

> ...and, finally, is the reason that I am finding it hard to explain t=
his
> because I have an expectation of how things work that doesn't match u=
p
> with git?  In other words, is the question actually meaningless?

If you use git-svn, it's actually meaningful, because it controls what
svn rebase and svn dcommit do. For a pure git repo, it's usually not
that interesting.

Bj=F6rn
