From: Mike Stump <mikestump@comcast.net>
Subject: Re: cherry picking and merge
Date: Fri, 1 Aug 2014 10:48:33 -0700
Message-ID: <5AF18A76-DD3B-4B9A-BF70-EFE4BB852C3D@comcast.net>
References: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net> <20140801024329.GA28914@vauxhall.crustytoothpaste.net> <53DBBFE8.8060607@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
To: =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 19:49:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDGwt-0001og-GX
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 19:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754842AbaHARss convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Aug 2014 13:48:48 -0400
Received: from qmta15.emeryville.ca.mail.comcast.net ([76.96.27.228]:56259
	"EHLO qmta15.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751204AbaHARsr convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Aug 2014 13:48:47 -0400
Received: from omta18.emeryville.ca.mail.comcast.net ([76.96.30.74])
	by qmta15.emeryville.ca.mail.comcast.net with comcast
	id ZV6X1o00A1bwxycAFVongJ; Fri, 01 Aug 2014 17:48:47 +0000
Received: from [IPv6:2001:558:6045:a4:40c6:7199:cd03:b02d] ([IPv6:2001:558:6045:a4:40c6:7199:cd03:b02d])
	by omta18.emeryville.ca.mail.comcast.net with comcast
	id ZVom1o0042ztT3H8eVomRX; Fri, 01 Aug 2014 17:48:46 +0000
In-Reply-To: <53DBBFE8.8060607@gmail.com>
X-Mailer: Apple Mail (2.1878.6)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1406915327;
	bh=y7erG1tMZ60nEXEfSfRGHd8DTFkgzGRzObeiaMq6rPg=;
	h=Received:Received:Content-Type:Mime-Version:Subject:From:Date:
	 Message-Id:To;
	b=tWSU/kW/lur2/oib30mChd+oigw/yLXqCXKdgKu5WqyrjSiey4q83TdFMUjbYpJNg
	 ZmwrqTJ+9WtqA61GA9WGF0/vRK/CHY4oOai2YfCJX9dlTKadnDwmaAWsntJf4ifud4
	 teeLW8lSfMMwhybcoaJ5jtTzZ6qAmUh8js2pkaESk4dLJY4A/4B2p9yjEYKtAJXLRD
	 BezRC7DsFXlPDDxp0HlGZajHYLR3B5Uoq9Lg0nOdsGotJ2RI6CAtjzdKTCsxz+z5yW
	 B5fDVyYdtWov7MQFPVIjQo+GwikKEBMsX63ha9caEJaYift1ycLtwXEL4BcbaP7rNC
	 ovsvs23pqBjSw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254643>

On Aug 1, 2014, at 9:27 AM, Jakub Nar=C4=99bski <jnareb@gmail.com> wrot=
e:
>=20
> Note that you should try to avoid cherry-picking, as they do not
> leave trace in the graph of revisions.

=46ine, then I want a new command to merge in a change into my branch f=
rom another branch and I want merge to account for the motion and not d=
uplicate it when I merge that branch back into master.  Funny thing is,=
 cherry and merge seem to be documented mostly to do exactly what I wan=
t.

> For example if you are creating a bugfix, instead of putting it
> directly on maint, and then cherry-picking to master, it is better
> to create a separate feature branch for this fix

You=E2=80=99re assuming that I=E2=80=99m the author of master, I=E2=80=99=
m not, I=E2=80=99m merely a contributor.  This tail doesn=E2=80=99t wag=
 that dog.  What that means is that I cannot change the world to work a=
round a simple bug in git.

> There is also git-imerge, third party tool that is intended to help
> merging changes (and make it possible to do it in incremental way).

Then remove git merge and replace it with git-imerge.  :-)  Anyway, I r=
ead that, and I can see some beauty of that that might be nice in compl=
ex merges.  The problem is, I want git merge to work.


I was curious if svn handles this better the same or worse, and it did =
it just fine.  I know that a while ago, svn could not handle this, it w=
ould do what git does currently.  Apparently they figured out it was a =
bug and fixed it.  Have you guys figured out it is a bug yet?  The firs=
t step in solving a problem, is admitting you have a problem.