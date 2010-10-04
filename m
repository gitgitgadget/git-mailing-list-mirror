From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] Documentation/git-clone: describe --mirror more verbose
Date: Mon, 4 Oct 2010 09:50:15 +0200
Message-ID: <20101004075015.GN28679@pengutronix.de>
References: <1285963983-5629-1-git-send-email-u.kleine-koenig@pengutronix.de> <AANLkTimN53bcadyzshHNVULkt=kzdfTQrUmZxUd+FKpY@mail.gmail.com> <1285967766.6750.2.camel@gandalf.stny.rr.com> <4CA9815D.3040801@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Darren Hart <darren@dvhart.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Oct 04 09:50:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2foh-0000jt-Mt
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 09:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753375Ab0JDHuW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 03:50:22 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60449 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753136Ab0JDHuU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 03:50:20 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1P2foO-0007Zc-Tz; Mon, 04 Oct 2010 09:50:16 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1P2foN-0004nA-KB; Mon, 04 Oct 2010 09:50:15 +0200
Content-Disposition: inline
In-Reply-To: <4CA9815D.3040801@drmicha.warpmail.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158002>

Hello Michael,

On Mon, Oct 04, 2010 at 09:25:17AM +0200, Michael J Gruber wrote:
> Steven Rostedt venit, vidit, dixit 01.10.2010 23:16:
> > On Fri, 2010-10-01 at 13:18 -0700, Darren Hart wrote:
> >> 2010/10/1 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> >>> Some people in #linux-rt claimed that you cannot define "--mirror=
" with
> >>> "mirror".
> >>>
>=20
> I'd say "mirror" is a commonly known term for an exact copy. Moreover=
,
> the text below doesn't explain what a mirror is either, only how
> "update" behaves in it.
hmm.  The --mirror option doesn't have any effect (apart from the
changes in the config file) until you update.  So I think it's natural
to talk about git update.  No?
=20
> >>> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de=
>
> >>
> >> Acked-by: Darren 'Some People' Hart <darren@dvhart.com>
> >=20
> >   Acked-by: Steven Rostedt <rostedt@goodmis.org>
> >=20
> > -- Steve
> >=20
> >>
> >>> ---
> >>>  Documentation/git-clone.txt |   11 ++++++++++-
> >>>  1 files changed, 10 insertions(+), 1 deletions(-)
> >>>
> >>> diff --git a/Documentation/git-clone.txt b/Documentation/git-clon=
e.txt
> >>> index dc7d3d1..5eedfbd 100644
> >>> --- a/Documentation/git-clone.txt
> >>> +++ b/Documentation/git-clone.txt
> >>> @@ -128,7 +128,16 @@ objects from the source repository into a pa=
ck in the cloned repository.
> >>>        configuration variables are created.
> >>>
> >>>  --mirror::
> >>> -       Set up a mirror of the remote repository.  This implies `=
--bare`.
> >>> +       Set up a mirror of the remote repository.
> >>> +       Using
> >>> +
> >>> +               git remote update origin
> >>> +
> >>> +       (or `<name>` instead of `origin` if -o is given) in the r=
esulting
>=20
> "remote" has no "-o" option. You probably mean the "clone" option, bu=
t
> the way it's written it refers to the preceding command.
So what do you think about:

	... (or `<name>` instead of `origin` if -o is given to clone)

>=20
> >>> +       repository overwrites the local branches without asking.
> >>> +       This implies `--bare`.
>=20
> Again, "this" refers to the preceding sentence. But the update behavi=
or
> does not imply "--bare". Specifying "--mirror" for "clone" implies "-=
-bare".
OK.
=20
> >>> +       Without --mirror (but with --bare) git remote update does=
n't touch any
> >>> +       branches at all.
>=20
> That's not true. It just doesn't touch any local branches; it updates
> the remote branches, of course.
Hmm, for me there are no remote branches when using --bare:

	ukleinek@cassiopeia:~/tmp$ git clone --bare ~/gsrc/topgit
	Cloning into bare repository topgit.git...
	done.
	ukleinek@cassiopeia:~/tmp$ cd topgit.git/
	ukleinek@cassiopeia:~/tmp/topgit.git$ git remote update
	Fetching origin
	From /home/ukleinek/gsrc/topgit
	 * branch            HEAD       -> FETCH_HEAD

This is also documented for --bare:

	When this option is used, neither remote-tracking branches nor
	the related configuration variables are created.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
