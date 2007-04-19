From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] user-manual.txt: Some doc updates
Date: Thu, 19 Apr 2007 12:02:35 -0400
Message-ID: <20070419160235.GE9101@fieldses.org>
References: <87hcrcjre3.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 19 18:03:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeZ5z-0003ck-4C
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 18:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766829AbXDSQCj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 19 Apr 2007 12:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766833AbXDSQCj
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 12:02:39 -0400
Received: from mail.fieldses.org ([66.93.2.214]:41031 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1766829AbXDSQCh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 12:02:37 -0400
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HeZ5f-00036N-9r; Thu, 19 Apr 2007 12:02:35 -0400
Content-Disposition: inline
In-Reply-To: <87hcrcjre3.fsf@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45026>

Thanks!  Just a couple things I noticed on a quick skim:

On Thu, Apr 19, 2007 at 05:49:40PM +0200, Santi B=E9jar wrote:
>=20
> * use "git config" instead of directly editing config files

It was a conscious decision to use a mixture of the two techniques; see=
,
e.g.,

	http://marc.info/?l=3Dgit&m=3D116994435503452&w=3D2

and followups.

> * git branch {,-a,-r} list local, all or remote branches
>=20
> * git branch -d checkd for reachability from the current branch
>=20
> * refs/remotes/${remote}/HEAD does not depend on the number of branch=
es
>=20
> * log family can use the --reverse flag

Given the number of options available, we have to make some hard
decisions about which are worth mentioning in the manual and which can
be left to the man pages.  The --reverse option doesn't seem important
enough to be worth a mention at this point, but I'd listen to reason.

The best way to work in --reverse, I think, would be in an examples
section as part of a pipeline that needed to get commits in --reverse
order.  I can't think of one off hand.

--b.
