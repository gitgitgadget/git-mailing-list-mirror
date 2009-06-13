From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: EasyGit Integration
Date: Sat, 13 Jun 2009 03:24:31 +0200
Message-ID: <20090613012431.GA1578@atjola.homenet>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com> <200906122321.57479.jnareb@gmail.com> <94a0d4530906121448m57f272eej32e8d57e48002f1f@mail.gmail.com> <200906130005.20790.jnareb@gmail.com> <94a0d4530906121530m22dbfcb5ye63a0ecb400c4a59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Scott Chacon <schacon@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Theodore Tso <tytso@mit.edu>, Elijah Newren <newren@gmail.com>,
	git list <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 03:27:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFI1q-0003Tc-FK
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 03:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752986AbZFMBYf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Jun 2009 21:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752832AbZFMBYe
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 21:24:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:45739 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750851AbZFMBYd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 21:24:33 -0400
Received: (qmail invoked by alias); 13 Jun 2009 01:24:34 -0000
Received: from i59F56FD1.versanet.de (EHLO atjola.local) [89.245.111.209]
  by mail.gmx.net (mp071) with SMTP; 13 Jun 2009 03:24:34 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX197Pl4BWT97eqQLZ83aaudfCNRhfzxd91qR81DZtc
	YQwS+u57fFYdHz
Content-Disposition: inline
In-Reply-To: <94a0d4530906121530m22dbfcb5ye63a0ecb400c4a59@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121479>

On 2009.06.13 01:30:38 +0300, Felipe Contreras wrote:
> On Sat, Jun 13, 2009 at 1:05 AM, Jakub Narebski<jnareb@gmail.com> wro=
te:
> > On Fri, 12 Jun 2009, Felipe Contreras wrote:
> >> On Sat, Jun 13, 2009 at 12:21 AM, Jakub Narebski<jnareb@gmail.com>=
 wrote:
> >
> >>> Nope. 'git reset' always reset some part of state to a given comm=
it,
> >>> HEAD by default. =A0It can reset current branch with --soft, bran=
ch plus
> >>> index with --mixed (default), and branch plus index plus working
> >>> directory with --hard. =A0Source is always commit.
> >>
> >> You said it: 'git reset --hard' gets something out of the reposito=
ry
> >> and into the working directory.
> >>
> >> Try this:
> >> git checkout <random sha-1 with no ref>
> >>
> >> Then what is the difference between:
> >> git checkout HEAD^
> >> git reset --hard HEAD^
> >>
> >> In this case they do exactly the same thing, don't they?
> >
> > No, they don't. =A0"git checkout HEAD^" modifies HEAD detaching it.
> > "git reset --hard HEAD^" modifies branch that HEAD points to (well,
> > unless HEAD is detached).
>=20
> Read again:
> >> git checkout <random sha-1 with no ref>
>=20
> The HEAD is detached, so they do exactly the same in this case.

Not if there are uncommitted changes to tracked files.

Bj=F6rn
