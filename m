From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Saving patches from this list
Date: Fri, 12 Dec 2008 07:14:19 -0800
Message-ID: <20081212151419.GL32487@spearce.org>
References: <loom.20081212T072326-350@post.gmane.org> <49421AEE.8090902@viscovery.net> <loom.20081212T082629-274@post.gmane.org> <e2b179460812120107t74a4a8e3y1654233fe2870ac7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
To: Mike Ralphson <mike.ralphson@gmail.com>,
	Stefan =?iso-8859-1?Q?N=E4we?= <stefan.naewe+git@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 16:15:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LB9ju-0004bG-6t
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 16:15:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756698AbYLLPOV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Dec 2008 10:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756767AbYLLPOU
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 10:14:20 -0500
Received: from george.spearce.org ([209.20.77.23]:41777 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754930AbYLLPOU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 10:14:20 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 50A2E38200; Fri, 12 Dec 2008 15:14:19 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <e2b179460812120107t74a4a8e3y1654233fe2870ac7@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102901>

Mike Ralphson <mike.ralphson@gmail.com> wrote:
> 2008/12/12 Stefan N=E4we <stefan.naewe+git@gmail.com>
> > > Stefan N=E4we schrieb:
> > > > What's the best way to get patches sent to this list in a form =
suitable
> > > > for 'git am' without subscribing to this list ?

If you find the article on the web with gmane, add '/raw' onto the
end of direct link URL.  E.g. to get:

  http://article.gmane.org/gmane.comp.version-control.git/102874

use:

  curl http://article.gmane.org/gmane.comp.version-control.git/102874/r=
aw | git am=20
=20
> Junio's blog[1] shows he's looking at patchwork. Personally I think i=
t
> would be fantastic to have a public patchwork server available. It
> might avoid the chicken and egg problem in that it's currently easier
> (for some people) to get hold of a patch to play with / review only
> after it's accepted.

One of the things I want to do with Gerrit 2 is teach it to read a
mailing list and convert patches it receives into temporary branches
that can be fetched over git://, and also create records in its web
database so reviews can be done on the web interface, then let it
CC the list back with a proper In-Reply-To when comments are posted
on the web to a change it received by email.

IOW, I want to make Gerrit 2 useful to the git community to monitor
patch state without changing our current email based workflow.
But I'm still a good two or three months from being able to do that.
Android's workflow is higher priority to me right now.

--=20
Shawn.
