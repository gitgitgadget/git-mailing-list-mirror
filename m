From: Eric Wong <e@80x24.org>
Subject: Re: feature request: git svn dommit --preserve-timestamps
Date: Sat, 11 Jun 2016 01:39:48 +0000
Message-ID: <20160611013948.GA5793@dcvr.yhbt.net>
References: <87a8iy6s4e.fsf@free.fr>
 <20160607000902.GA4445@dcvr.yhbt.net>
 <87ziqx5z9h.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Peter =?utf-8?Q?M=C3=BCnster?= <pmlists@free.fr>
X-From: git-owner@vger.kernel.org Sat Jun 11 03:40:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBXu5-00072F-V2
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jun 2016 03:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbcFKBju convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2016 21:39:50 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:60000 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750753AbcFKBju (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 21:39:50 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09CBF1FF70;
	Sat, 11 Jun 2016 01:39:49 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <87ziqx5z9h.fsf@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297087>

Peter M=C3=BCnster <pmlists@free.fr> wrote:
> On Tue, Jun 07 2016, Eric Wong wrote:
> > Peter M=C3=BCnster <pmlists@free.fr> wrote:
> >> It would be nice, if timestamps could be preserved when rewriting =
the
> >> git-log.
> >
> > Unfortunately, last I checked (a long time ago!), explicitly
> > setting revprops might require SVN administrators to enable the
> > feature for the repo.
>=20
> Not the svn-log, only the git-log.

The git log after dcommit is tied to the SVN log,
so git-svn can only reflect changes which appear in SVN.

	Sidenote: The convention is reply-to-all on lists like
	this one which do not require subscription to post.
	It prevents the list from being a single-point-of-failure
	or censorship.

> > It's been a while and I'm not up-to-date with the latest SVN.
> > Maybe there's a newer/easier way you could give us details about :)
>=20
> No, sorry. I don't care about the svn-log.

Unfortunately, you would have to care about svn log as long as
SVN exists in your workflow and you need to interact with SVN
users.

git svn tries hard to work transparently and as close to the
behavior of the upstream SVN repo as possible.
