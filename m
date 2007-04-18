From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Things that surprise naive users
Date: Wed, 18 Apr 2007 18:28:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0704181746410.27922@iabervon.org>
References: <Pine.LNX.4.64.0704181503080.27922@iabervon.org>
 <1176930970.7733.9.camel@mejai>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-11394343-1176933878=:27922"
Cc: git@vger.kernel.org
To: Steve =?ISO-8859-1?Q?Fr=E9cinaux?= <nudrema@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 19 00:28:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeIdW-0008Kj-4X
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 00:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992865AbXDRW2X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 18:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992891AbXDRW2X
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 18:28:23 -0400
Received: from iabervon.org ([66.92.72.58]:4960 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992865AbXDRW2W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 18:28:22 -0400
Received: (qmail 31425 invoked by uid 1000); 18 Apr 2007 22:28:21 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Apr 2007 22:28:21 -0000
In-Reply-To: <1176930970.7733.9.camel@mejai>
Content-ID: <Pine.LNX.4.64.0704181824220.27922@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44957>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-11394343-1176933878=:27922
Content-Type: TEXT/PLAIN; CHARSET=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <Pine.LNX.4.64.0704181824221.27922@iabervon.org>

On Wed, 18 Apr 2007, Steve Fr=E9cinaux wrote:

> On Wed, 2007-04-18 at 16:55 -0400, Daniel Barkalow wrote:
>=20
> > 1. If your organization has a bunch of different projects, and there's=
=20
> >    some central location holding the upstream that people regularly pul=
l=20
> >    from, there's no way to abbreviate this parent directory. (Equivalen=
t=20
> >    of CVSROOT environment variable)
> >=20
> >    I.e., we've got file-server:/var/git/<project>.git at my work, with=
=20
> >    dozens of projects, and you have to give the whole thing to git clon=
e=20
> >    each time.=20
>=20
> export GITROOT=3Dfile-server:/var/git
> git-clone $GITROOT/project.git
>=20
> git doesn't enforce that but you can still do it with some shell karma.
>=20
> BTW as far as I know no other scm than CVS provides this kind of thing,
> and it's more often seen as a defect than an advantage. For instance, a
> novice which had to checkout a CVS project from sourceforge and another
> from cvs.gnome.org and another from... wasn't helped at all. SVN has it
> much simpler (understandable) by just providing a URL for checkouts.

It's counterproductive to require both a "root" and a "module" if there=20
isn't any sort of commonality, but it's useful to be able to have a=20
default. Besides CVS, arch also has something of the sort. I haven't used=
=20
anything else in a corporate setting (where most of the things you check=20
out are from the same place).

> > 2. There's no easy way to tell that you've made commits that you haven'=
t=20
> >    pushed upstream. In fact, it's impossible to tell when disconnected=
=20
> >    whether you've pushed everything. This needs some command to report =
it,
> >    and also for push to update the fetch sides of remote heads it updat=
es.
>=20
> I surprised myself doing so:
>   git-push $remote
>   git-fetch $remote
> given that the remote in question pushes master, and pulls into $remote.
> Maybe such a thing (in the idea) should be done implicitely.

I mentioned it a while back, but never got around to implementing it,=20
mostly because it's all in shell scripts (or was).

=09-Daniel
*This .sig left intentionally blank*
--1547844168-11394343-1176933878=:27922--
