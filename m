From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: git-cvsexportcommit and commit date
Date: Sun, 10 Feb 2008 17:17:31 +0100
Message-ID: <200802101717.32747.robin.rosenberg.lists@dewire.com>
References: <OFFF18703C.5539A99A-ON852573E7.00699FE4-852573E7.006A0F3E@db.com> <200802101415.00726.robin.rosenberg.lists@dewire.com> <5f4b18bf0802100801t20952180u6afd1eeaf2fac17@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Derek Mahar" <derek.mahar@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 17:18:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOEsg-0001SQ-GI
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 17:18:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbYBJQRi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Feb 2008 11:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbYBJQRi
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 11:17:38 -0500
Received: from [83.140.172.130] ([83.140.172.130]:13351 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750917AbYBJQRh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 11:17:37 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 98AC38006AB;
	Sun, 10 Feb 2008 17:17:35 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3ewrS3kWeWlw; Sun, 10 Feb 2008 17:17:35 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id F267F800687;
	Sun, 10 Feb 2008 17:17:34 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <5f4b18bf0802100801t20952180u6afd1eeaf2fac17@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73363>

s=F6ndagen den 10 februari 2008 skrev Derek Mahar:
> On Feb 10, 2008 8:15 AM, Robin Rosenberg
> <robin.rosenberg.lists@dewire.com> wrote:
> > s=F6ndagen den 10 februari 2008 skrev Derek Mahar:
> > As I recall it (I'm using fromcvs, not git-cvsimport) cvs HEAD get =
imported
> > into origin which on initial import gets copied to master. So I thi=
nk you
> > should git rebase origin
>=20
> When it drops the extra commit, is there a way to ask git-rebase to
> keep the textual change of the original commit, but use the commit
> information from the imported CVS commit?  This way, the resulting Gi=
t
> repository would match that of another user who performs an initial
> git-cvsimport of the entire CVS repository.
No, for that to happen the full history must match. Maybe theoretically
possible, but then, in theory, you could use only Git and not worry abo=
ut
CVS.

If you involve CVS (or any other SCM) you must rebase on top of the
CVS imported version, whether your repo is a clone or not. The changed
commit to me also means I can see wheter it s a pure git checkin or
whether it is from the official CVS repo, which is a "good" thing.

> Can fromcvs read from a remote CVS repository via pserver or does it
> only parse the RCS files directly?  I have only pserver access to our
> CVS repo,
RCS only. Note that sometimes you have rsync access. If not politely as=
k
the admin of the repo that you get read access to the raw files. (the C=
VSROOT/*
files are not needed in case that is a concern).

-- robin
