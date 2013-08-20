From: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT] add FreeBSD support
Date: Tue, 20 Aug 2013 11:25:48 -0400
Message-ID: <20130820152547.GC8172@poseidon.cudanet.local>
References: <1376051548-3126-1-git-send-email-wenqing.lz@taobao.com>
 <20130809144641.GK22686@poseidon.cudanet.local>
 <68E9B1AC-A3A3-47DD-B0A7-07752428D16D@gmail.com>
 <20130809152046.GL22686@poseidon.cudanet.local>
 <20130820074415.GA27247@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Zheng Liu <gnehzuil.liu@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 20 17:26:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBnoh-0002Jh-9d
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 17:25:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251Ab3HTPZv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Aug 2013 11:25:51 -0400
Received: from josefsipek.net ([64.9.206.49]:1761 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751111Ab3HTPZu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 11:25:50 -0400
Received: from poseidon.cudanet.local (unknown [64.235.151.250])
	by josefsipek.net (Postfix) with ESMTPSA id 71FC5554D8;
	Tue, 20 Aug 2013 11:25:49 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20130820074415.GA27247@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232613>

On Tue, Aug 20, 2013 at 03:44:16PM +0800, Zheng Liu wrote:
> Hi Josef,
>=20
> On Fri, Aug 09, 2013 at 11:20:46AM -0400, Josef 'Jeff' Sipek wrote:
> > On Fri, Aug 09, 2013 at 11:04:45PM +0800, gnehzuil.liu wrote:
> > > ?? 2013-8-9??????10:46??Josef 'Jeff' Sipek <jeffpc@josefsipek.net=
> =D0=B4????
> > >=20
> > > > On Fri, Aug 09, 2013 at 08:32:28PM +0800, Zheng Liu wrote:
> > > >> From: Zheng Liu <gnehzuil.liu@gmail.com>
> > > >>=20
> > > >> Currently guilt doesn't support FreeBSD platform.  This commit=
 tries to
> > > >> add this support.  The file called 'os.FreeBSD' is copied from=
 os.Darwin
> > > >> due to these two platforms have almost the same command tools.
> > > >=20
> > > > Out of curiosity, is it identical?  I eyeballed it, and they do=
 look
> > > > identical.  There's probably a better way to do this whole os-s=
pecific
> > > > thing, but this will work well enough for now.
> > >=20
> > > Yes, it is identical.  Sorry, I am a newbie for guilt, but I am h=
appy to
> > > improve this os-specific thing.    Any idea?
> >=20
> > So, I'm a bit torn between some "build-time" checking that generate=
s
> > something like an "os" file based on what it detects and something =
that
> > happens at runtime.  I like that currently there's nothing to do - =
you just
> > clone the repo and you're set.  At the same time, the more code can=
 be
> > avoided executing the faster (in theory) guilt gets.
>=20
> Sorry for the late reply.  I did a simple experiment that tries to fo=
ld
> all os.* files into one file and uses a if statement to export functi=
ons
> according to different platforms.  But frankly I don't like this beca=
use
> it is not very clearly.  So IMHO we'd better add a 'os.FreeBSD' file =
to
> support FreeBSD platform.

Yeah, sounds like the simplest (at least for the moment).  I'll commit =
it.
Thanks.

=46WIW, the idea I was thinking about was to make "make all" figure out
various parts of the system and construct an os file.

Jeff.

--=20
UNIX is user-friendly ... it's just selective about who its friends are
