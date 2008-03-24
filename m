From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: What I miss from Cogito...
Date: Sun, 23 Mar 2008 22:14:11 -0400
Message-ID: <20080324021411.GE24943@mit.edu>
References: <47E69044.3000207@zytor.com> <20080323173841.GA24943@mit.edu> <20080323182102.GA22551@bit.office.eurotux.com> <87r6e1b6c8.fsf@mid.deneb.enyo.de> <20080324001617.GB24943@mit.edu> <20080324014030.GA24695@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Weimer <fw@deneb.enyo.de>, git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 24 03:15:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdcDL-000806-7t
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 03:15:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754599AbYCXCO0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Mar 2008 22:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754571AbYCXCO0
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 22:14:26 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:62906 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754567AbYCXCO0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Mar 2008 22:14:26 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m2O2EL26019124;
	Sun, 23 Mar 2008 22:14:21 -0400 (EDT)
Received: from closure.thunk.org (c-98-216-98-217.hsd1.ma.comcast.net [98.216.98.217])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m2O2EDSX009515
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 23 Mar 2008 22:14:21 -0400 (EDT)
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@mit.edu>)
	id 1JdcCR-0007BQ-P4; Sun, 23 Mar 2008 22:14:11 -0400
Content-Disposition: inline
In-Reply-To: <20080324014030.GA24695@atjola.homenet>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77994>

On Mon, Mar 24, 2008 at 02:40:30AM +0100, Bj=F6rn Steinbrink wrote:
> > If we were going to separate the two commands out, I'd use the name
> > "git revert-file", because that's what people who are coming from b=
k
> > or hg are used to (where "revert" means to undo the local edits don=
e
> > to a particular file, as opposed to the git meaning of undoing a
> > particular commit).
>=20
> Nah, that would create confusion within git, because it does somethin=
g
> totally different from git revert. And checkout can also checkout a
> whole tree, not just a file. So you would either need revert-tree as
> well... Or add more confusion, because revert-file "reverting" a tree=
 is
> not quite intuitive.

That's why I said "git revert-file" as being different from "git
revert".  If you want to revert the entire tree in the sense of
"undoing local edits", most people today use "git reset --hard".

> Maybe it's just a misunderstanding on my side, but to me "checkout"
> means as much as "get me something out of the repo".=20

If that's true, why is the one-line summary in the git-checkout man
page and in the git top-level man page read as follows?

       git-checkout - Checkout and switch to a branch

At the very least, will you admit that the summary in the man page is
perhaps just a wee bit misleading?

						- Ted
