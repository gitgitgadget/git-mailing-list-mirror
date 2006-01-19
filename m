From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Lower priority of Cogito's default exclude patterns
Date: Thu, 19 Jan 2006 15:07:28 +0100
Message-ID: <20060119140728.GA14998@diana.vm.bytemark.co.uk>
References: <20060107221931.10616.25897.stgit@backpacker.hemma.treskal.com> <20060119100712.GA12154@diana.vm.bytemark.co.uk> <20060119124244.GJ27976@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 19 15:09:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzaS2-0006cI-9W
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 15:07:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161210AbWASOHn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 19 Jan 2006 09:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161221AbWASOHn
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 09:07:43 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:41999 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S1161210AbWASOHn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2006 09:07:43 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1EzaRk-0003wG-00; Thu, 19 Jan 2006 14:07:28 +0000
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20060119124244.GJ27976@pasky.or.cz>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14908>

On 2006-01-19 13:42:44 +0100, Petr Baudis wrote:

> Dear diary, on Thu, Jan 19, 2006 at 11:07:12AM CET, I got a letter
> where Karl Hasselstr=F6m <kha@treskal.com> said that...
>
> > On 2006-01-07 23:19:31 +0100, Karl Hasselstr=F6m wrote:
> >
> > > Put the default exclude patterns in a file referenced with
> > > --exclude-from, instead of on the command line with --exclude.
> > > (The existing behavior was bad since --exclude has higher
> > > priority than --exclude-from and --exclude-per-directory, which
> > > made it impossible for the user to override the default
> > > patterns.)
> > >
> > > Signed-off-by: Karl Hasselstr=F6m <kha@treskal.com>
> > >
> > > ---
> > >
> > >  Makefile           |   15 +++++++++++++--
> > >  cg-Xlib            |    6 +++++-
> > >  cg-default-exclude |    6 ++++++
> > >  3 files changed, 24 insertions(+), 3 deletions(-)
> >
> > Did you miss this patch, or just not like it?
>
> Just postponed for next sweep through my patch queue, due today or
> tomorrow. ;) I will rename cg-default-exclude to default-exclude,
> though.

Good point.

> Oh, now I remember - one my major concern is that now Cogito will
> not work if not make install'd, which is how I actually primarily
> use it on my machine.

The not-installed case could easily be worked around by users if
cogito looked at /etc/cogito/exclude and ~/.cogito/exclude as well.
(Or maybe that should be /etc/git/exclude and ~/.gitexclude, so that
e.g. stgit can use the same files.) Would you accept a patch that did
this?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
