From: Yann Dirson <dirson@bertin.fr>
Subject: Re: Undocumented git-diff syntax
Date: Mon, 11 Oct 2010 16:17:21 +0200
Organization: Bertin Technologies
Message-ID: <20101011161721.35940919@chalon.bertin.fr>
References: <20101011150342.292ad725@chalon.bertin.fr>
 <AANLkTinqPiGf1nbo0oOvDD5edgLBdO8xZfjGeFC4q0MU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Santi =?UTF-8?B?QsOpamFy?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Mon Oct 11 16:26:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5JKj-0005ZJ-5N
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 16:26:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754924Ab0JKO0Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Oct 2010 10:26:24 -0400
Received: from blois.bertin.fr ([195.68.26.9]:34997 "EHLO blois.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754911Ab0JKO0X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Oct 2010 10:26:23 -0400
Received: from blois.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 7568D5430D
	for <git@vger.kernel.org>; Mon, 11 Oct 2010 16:26:22 +0200 (CEST)
Received: from YPORT1 (yport1.bertin.fr [192.168.1.13])
	by blois.bertin.fr (Postfix) with ESMTP id 52C7354335
	for <git@vger.kernel.org>; Mon, 11 Oct 2010 16:26:22 +0200 (CEST)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0LA400II1QRXFX10@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Mon, 11 Oct 2010 16:26:22 +0200 (CEST)
In-reply-to: <AANLkTinqPiGf1nbo0oOvDD5edgLBdO8xZfjGeFC4q0MU@mail.gmail.com>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8200-6.0.0.1038-17696.007
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158762>

On Mon, 11 Oct 2010 15:59:18 +0200
Santi B=C3=A9jar <santi@agolina.net> wrote:

> On Mon, Oct 11, 2010 at 3:03 PM, Yann Dirson <dirson@bertin.fr> wrote=
:
> [...]
> >
> > Another thought: if we can already compare arbitrary blobs, maybe
> > it would not be so hard to extend it to take arbitrary contents
> > that are not stored as blobs yet ? =C2=A0(a quick hack would be to
> > insert an object for them, but that does not look too clean...).
> > =C2=A0As a use-case, I'm often found generating diffs from within c=
ustom
> > scripts, from contents derived from a git repo, but can't use all
> > the bells and whistles (--color, --color-words, etc), just because
> > I have to use plain diff; that makes the output of those scripts
> > very inconsistent with native git commands.
>=20
> Are you talking about "git diff --no-index"?

Oh, right.  That's what it takes to read only the 1st paragraph for
each synopsis:

|If exactly two paths are given, and at least one is untracked,
|compare the two files / directories. This behavior can be
|forced by --no-index.

OTOH, that appears not to be 100% accurate (my tests would have
shown me): although --no-index does give me the expected results when
one or two of the files are untracked, I have to explicitely add it,
which seem to contradict this part of the doc.

That said, this two-path construct would surely deserve its own
synopsis.

To get back to my initial opuzzlement, maybe the behaviour I found is
also a special case that sets --no-index ?

--=20
Yann Dirson - Bertin Technologies
