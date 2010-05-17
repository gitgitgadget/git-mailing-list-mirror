From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Has anyone looked at Gettext support for Git itself?
Date: Mon, 17 May 2010 16:32:47 +0200
Message-ID: <201005171632.48253.trast@student.ethz.ch>
References: <AANLkTinlDF-aKDjwvgZEqtUgzW7MCIuElQ_RfJn_RkZp@mail.gmail.com> <20100516160800.GB22447@efreet.light.src> <AANLkTinGSBRMRyaD0w2p9PQELLA6ThvKFdi6hcNWBTxr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jan Hudec <bulb@ucw.cz>, Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 17 16:32:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OE1NI-0002v9-CF
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 16:32:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777Ab0EQOcu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 May 2010 10:32:50 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:27255 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752374Ab0EQOcu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 May 2010 10:32:50 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 17 May
 2010 16:32:48 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 17 May
 2010 16:32:48 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.3; x86_64; ; )
In-Reply-To: <AANLkTinGSBRMRyaD0w2p9PQELLA6ThvKFdi6hcNWBTxr@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147241>

=C6var Arnfj=F6r=F0 Bjarmason wrote:
> On Sun, May 16, 2010 at 16:08, Jan Hudec <bulb@ucw.cz> wrote:
> > It would definitely not be fine to break *git*. You need to make su=
re no
> > part of git itself or anything distributed with it (gitk, git gui, =
gitweb,
> > things in contrib) is looking for any string that might be broken b=
y
> > translating.
>=20
> Of course internal breakage, i.e. git-foo parsing the output from
> git-bar breaking under non-English is unacceptable. I meant that
> external tools now running under some non-English locale may start
> breaking if they're parsing the output and assuming English. The
> remedy for that is easy though, just prefix the calls to git with
> LC_ALL=3DC.

And how exactly do you expect us to go back in history and prefix all
invocations of git in all scripts with LC_ALL=3DC?

Porcelain such as git-status could be changed, but then there's not
that much of it anyway.  IMHO a set of standard documentation in each
language would be more useful.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
