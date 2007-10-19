From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [RFC/PATCH] git-fetch: mega-terse fetch output
Date: Fri, 19 Oct 2007 16:38:44 +0200
Message-ID: <20071019143844.GB23765@diana.vm.bytemark.co.uk>
References: <20071019062219.GA28499@coredump.intra.peff.net> <ee77f5c20710182339g30d025f0tfe74479d672ae36e@mail.gmail.com> <20071019073938.GN14735@spearce.org> <8aa486160710190303l4ce996daqf5c8025c857ea8@mail.gmail.com> <20071019113822.GB16726@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Symonds <dsymonds@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Theodore Tso <tytso@thunk.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 16:39:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iit0Z-00012g-SR
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 16:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932702AbXJSOjP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Oct 2007 10:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760149AbXJSOjP
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 10:39:15 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1224 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760044AbXJSOjP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 10:39:15 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Iiszs-0006Yd-00; Fri, 19 Oct 2007 15:38:44 +0100
Content-Disposition: inline
In-Reply-To: <20071019113822.GB16726@thunk.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61718>

On 2007-10-19 07:38:22 -0400, Theodore Tso wrote:

> Finally, one last question --- am I the only one who had to take a
> second look at the whether the arrow should be <- or ->? The
> question is whether we are saying "gitk is moving to include all of
> spearce/gitk"; but I could also see it stated that we are assigning
> refs/heads/gitk with refs/remotes/spearce/gitk, in which case the
> arrow should be reversed. Or maybe:
>
> =3D=3D> git://repo.or.cz/git/spearce.git
>  * branch gitk :=3D spearce/gitk                (new)
>  * branch maint :=3D spearce/maint              1aa3d01..e7187e4
>  * branch master :=3D spearce/master            de61e42..7840ce6
>  * branch next :=3D spearce/next                895be02..2fe5433
>  + branch pu :=3D spearce/pu                    89fa332...1e4c517
>  * branch todo :=3D spearce/todo                (new)

I think the reasoning behind the "foo -> spearce/foo" syntax is that
"(refs/heads/)foo" in the remote repository has been fetched to
"(refs/remotes/)spearce/foo" in the local repository.

I might be deluded, though.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
