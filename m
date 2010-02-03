From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: aborting rebase -i right at the start, was Re: [BUG] - "git
	commit --amend" commits, when exiting the editor with no changes
	written
Date: Wed, 3 Feb 2010 10:41:44 +0100
Message-ID: <20100203094144.GM15202@neumann>
References: <76c5b8581002021431o2b5073a0s42b273b6d61893db@mail.gmail.com>
	<alpine.DEB.1.00.1002022356460.4985@pacific.mpi-cbg.de>
	<76c5b8581002021534i1f0dbd18y1b216233d282cd84@mail.gmail.com>
	<40aa078e1002021540i13e35776xd733a4e40f34b477@mail.gmail.com>
	<76c5b8581002021548n129b3997r48ee6f6df5a1a4eb@mail.gmail.com>
	<40aa078e1002021616s3098bf53la6af93ab0949e7e@mail.gmail.com>
	<76c5b8581002021655k5f63b81h1c55ae87625fbfc5@mail.gmail.com>
	<20100203015947.GA4280@neumann> <vpqaavqkc1s.fsf@bauges.imag.fr>
	<alpine.DEB.1.00.1002031006570.3099@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eugene Sajine <euguess@gmail.com>, kusmabite@gmail.com,
	Wincent Colaiuta <win@wincent.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 03 10:41:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcbkB-0000mf-F1
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 10:41:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756781Ab0BCJlt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2010 04:41:49 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:59254 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756751Ab0BCJls (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 04:41:48 -0500
Received: from [127.0.1.1] (p5B130E6A.dip0.t-ipconnect.de [91.19.14.106])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0MUAOE-1NCj8d16Di-00QbRI; Wed, 03 Feb 2010 10:41:45 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1002031006570.3099@intel-tinevez-2-302>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Provags-ID: V01U2FsdGVkX18QvK/sQcX8JAKFuzmLPvlj+3N/aBKpiu792mP
 w7tKfUrf9q1L2VjlJ3tcYAanGMmC7UXy6nUXpQuYaeC/qKtSt1
 JC4J4Mwb08orrv/B/LsRQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138819>

On Wed, Feb 03, 2010 at 10:08:50AM +0100, Johannes Schindelin wrote:
> Hi,
>=20
> On Wed, 3 Feb 2010, Matthieu Moy wrote:
>=20
> > Strictly speaking, an empty [rebase -i] todolist should mean to dro=
p all=20
> > the patches (like a todolist with just one line would mean to drop =
all=20
> > the others). But a user never wants to do that (otherwise, "git res=
et"=20
> > would be the right command), so "git rebase -i" considers it as a=20
> > special case.
>=20
> Actually, it is a design bug, but it was the only sane way I could th=
ink=20
> of aborting the rebase.
>=20
> Note that there _are_ users who want to do that ("let me see what com=
mits=20
> I have, ah, oh, okay, I want none of them"). I am one of those.

I regularly mess up the todo file so badly that I don't want to bother
with undo but rather start over from the beginning.


Best,
G=E1bor
