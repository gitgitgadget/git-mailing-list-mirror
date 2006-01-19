From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Lower priority of Cogito's default exclude patterns
Date: Thu, 19 Jan 2006 13:42:44 +0100
Message-ID: <20060119124244.GJ27976@pasky.or.cz>
References: <20060107221931.10616.25897.stgit@backpacker.hemma.treskal.com> <20060119100712.GA12154@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 19 13:41:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzZ6X-0001B7-2O
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 13:41:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161062AbWASMl0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 19 Jan 2006 07:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbWASMl0
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 07:41:26 -0500
Received: from w241.dkm.cz ([62.24.88.241]:23444 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751408AbWASMl0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2006 07:41:26 -0500
Received: (qmail 20430 invoked by uid 2001); 19 Jan 2006 13:42:44 +0100
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Content-Disposition: inline
In-Reply-To: <20060119100712.GA12154@diana.vm.bytemark.co.uk>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14901>

Dear diary, on Thu, Jan 19, 2006 at 11:07:12AM CET, I got a letter
where Karl Hasselstr=F6m <kha@treskal.com> said that...
> On 2006-01-07 23:19:31 +0100, Karl Hasselstr=F6m wrote:
>=20
> > Put the default exclude patterns in a file referenced with
> > --exclude-from, instead of on the command line with --exclude. (The
> > existing behavior was bad since --exclude has higher priority than
> > --exclude-from and --exclude-per-directory, which made it impossibl=
e
> > for the user to override the default patterns.)
> >
> > Signed-off-by: Karl Hasselstr=F6m <kha@treskal.com>
> >
> > ---
> >
> >  Makefile           |   15 +++++++++++++--
> >  cg-Xlib            |    6 +++++-
> >  cg-default-exclude |    6 ++++++
> >  3 files changed, 24 insertions(+), 3 deletions(-)
>=20
> Did you miss this patch, or just not like it?

Just postponed for next sweep through my patch queue, due today or
tomorrow. ;) I will rename cg-default-exclude to default-exclude,
though.

Oh, now I remember - one my major concern is that now Cogito will not
work if not make install'd, which is how I actually primarily use it on
my machine.

Sorry for the delay,

--=20
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
