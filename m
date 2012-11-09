From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git merge commits are non-deterministic? what changed?
Date: Fri, 09 Nov 2012 16:04:31 +0100
Message-ID: <m2y5iarf5s.fsf@igel.home>
References: <20121109133132.GK69724@acme.spoerlein.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ulrich =?utf-8?Q?Sp=C3=B6rlein?= <uqs@spoerlein.net>
X-From: git-owner@vger.kernel.org Fri Nov 09 16:04:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWq8d-0006Lw-HF
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 16:04:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753994Ab2KIPEm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Nov 2012 10:04:42 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:57981 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753527Ab2KIPEl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 10:04:41 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3Xyl5G43xNz3hhZT;
	Fri,  9 Nov 2012 16:04:33 +0100 (CET)
X-Auth-Info: 3aNM6MCnjvul3WRBbGYEawmp+6SDZw0U47e4NbTIurI=
Received: from igel.home (ppp-88-217-114-57.dynamic.mnet-online.de [88.217.114.57])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3Xyl5F49xrzbbhV;
	Fri,  9 Nov 2012 16:04:33 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 07EF4CA2A4; Fri,  9 Nov 2012 16:04:32 +0100 (CET)
X-Yow: You mean you don't want to watch WRESTLING from ATLANTA?
In-Reply-To: <20121109133132.GK69724@acme.spoerlein.net> ("Ulrich
 =?utf-8?Q?Sp=C3=B6rlein=22's?=
	message of "Fri, 9 Nov 2012 14:31:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209222>

Ulrich Sp=C3=B6rlein <uqs@spoerlein.net> writes:

> Two questions:
> 1. Can we impose a stable ordering of the commits being recorded in a
> merge commit? Listing parents in chronological order or something lik=
e
> that.

The order is determined by the order the refs are given to git merge (o=
r
git commit-tree when using the plumbing).

> 2. Why the hell is the commit hash dependent on the ordering of the
> parent commits? IMHO it should sort the set of parents before
> calculating the hash ...

What would be the sort key?

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
