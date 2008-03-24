From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: What I miss from Cogito...
Date: Mon, 24 Mar 2008 03:57:01 +0100
Message-ID: <20080324025701.GA25064@atjola.homenet>
References: <47E69044.3000207@zytor.com> <20080323173841.GA24943@mit.edu> <20080323182102.GA22551@bit.office.eurotux.com> <87r6e1b6c8.fsf@mid.deneb.enyo.de> <20080324001617.GB24943@mit.edu> <20080324014030.GA24695@atjola.homenet> <20080324021411.GE24943@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Weimer <fw@deneb.enyo.de>, git@vger.kernel.org
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Mon Mar 24 03:57:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdcsd-0007dA-Da
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 03:57:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbYCXC5G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Mar 2008 22:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbYCXC5G
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 22:57:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:55359 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750729AbYCXC5F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 22:57:05 -0400
Received: (qmail invoked by alias); 24 Mar 2008 02:57:02 -0000
Received: from i577AC57D.versanet.de (EHLO atjola.local) [87.122.197.125]
  by mail.gmx.net (mp015) with SMTP; 24 Mar 2008 03:57:02 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/rcAhl9QDrKGOH1u+m7gZ8Nu0EsqiTrSEELDa5AR
	VKRP5ceCmN3UKc
Content-Disposition: inline
In-Reply-To: <20080324021411.GE24943@mit.edu>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77997>

On 2008.03.23 22:14:11 -0400, Theodore Tso wrote:
> On Mon, Mar 24, 2008 at 02:40:30AM +0100, Bj=F6rn Steinbrink wrote:
> > > If we were going to separate the two commands out, I'd use the na=
me
> > > "git revert-file", because that's what people who are coming from=
 bk
> > > or hg are used to (where "revert" means to undo the local edits d=
one
> > > to a particular file, as opposed to the git meaning of undoing a
> > > particular commit).
> >=20
> > Nah, that would create confusion within git, because it does someth=
ing
> > totally different from git revert. And checkout can also checkout a
> > whole tree, not just a file. So you would either need revert-tree a=
s
> > well... Or add more confusion, because revert-file "reverting" a tr=
ee is
> > not quite intuitive.
>=20
> That's why I said "git revert-file" as being different from "git
> revert".  If you want to revert the entire tree in the sense of
> "undoing local edits", most people today use "git reset --hard".

But that still leaves out e.g. "git checkout HEAD -- some_directory/".
Passing a directory to git revert-file seems plain broken, but you can
do that with checkout, so you would also need a git revert-tree (or com=
e
up with a better name ;-)). And IMHO the difference between git revert
and the suggested revert-file has too much potential for confusion
already.

> > Maybe it's just a misunderstanding on my side, but to me "checkout"
> > means as much as "get me something out of the repo".=20
>=20
> If that's true, why is the one-line summary in the git-checkout man
> page and in the git top-level man page read as follows?
>=20
>        git-checkout - Checkout and switch to a branch
>=20
> At the very least, will you admit that the summary in the man page is
> perhaps just a wee bit misleading?

I won't disagree on that one ;-) But I probably won't come up with
something better either. My brain stops somewhere at "Checkout stuff",
and that's even less useful than the current one.

Bj=F6rn
