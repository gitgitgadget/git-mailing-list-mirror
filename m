From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] Keep committer and committer dates
Date: Wed, 4 Jun 2008 14:29:56 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0806041424140.1798@tm8103-a.perex-int.cz>
References: <Pine.LNX.4.61.0806031647320.1798@tm8103-a.perex-int.cz>
 <alpine.DEB.1.00.0806032115340.13507@racer.site.net>
 <Pine.LNX.4.61.0806041113520.1798@tm8103-a.perex-int.cz>
 <20080604102906.GA2126@diana.vm.bytemark.co.uk> <m3ej7dzc7y.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463789724-1187592818-1212582596=:1798"
Cc: =?iso-8859-15?q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 14:30:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3s8n-0000EH-T3
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 14:30:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752223AbYFDMaE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 08:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbYFDMaE
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 08:30:04 -0400
Received: from mail1.perex.cz ([212.20.107.53]:40715 "EHLO mail1.perex.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750764AbYFDMaD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 08:30:03 -0400
Received: from server.perex.cz (server.perex.cz [172.16.0.20])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 22B3D149D90;
	Wed,  4 Jun 2008 14:29:58 +0200 (CEST)
Received: from tm8103.perex-int.cz (localhost [127.0.0.1])
	by server.perex.cz (Perex's E-mail Delivery System) with ESMTP id 116B384356;
	Wed,  4 Jun 2008 14:29:58 +0200 (CEST)
Received: by tm8103.perex-int.cz (Postfix, from userid 1000)
	id D944A57FD7; Wed,  4 Jun 2008 14:29:56 +0200 (CEST)
X-X-Sender: perex@tm8103-a.perex-int.cz
In-Reply-To: <m3ej7dzc7y.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83778>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463789724-1187592818-1212582596=:1798
Content-Type: TEXT/PLAIN; charset=iso8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 4 Jun 2008, Jakub Narebski wrote:

> Karl Hasselstr=F6m <kha@treskal.com> writes:
>=20
> > On 2008-06-04 11:16:46 +0200, Jaroslav Kysela wrote:
> >=20
> > > On Tue, 3 Jun 2008, Johannes Schindelin wrote:
> > >
> > > > That feels really funny, given that the guy running git-am _is_
> > > > the committer, not whoever provided some extra headers to the
> > > > mailbox.
> > >
> > > Yes, the implementatation does not make sense for public patch
> > > handling, but if you do various things locally with git-rebase or
> > > git-am (pack picking from another repo), you may consider it useful.
> >=20
> > But still, you're creating new commits, so they should have your name
> > on them.
>=20
> Yes, if you are _creating_ *commits*, then you are *committer*, isn't it?

I agree with that, but if you just manage patches and you want to keep=20
commit history and change only hash numbers, it's an option. Nothing else.=
=20
It's just tool extension and users have to cleverly decide if it's worth=20
to use it or not.

I just used in for my work.

=09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

---1463789724-1187592818-1212582596=:1798--
