From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: understanding index
Date: Sat, 31 Jan 2009 22:18:00 +0100
Message-ID: <20090131211800.GA30645@atjola.homenet>
References: <20090131111011.GA29748@ultras> <adf1fd3d0901310409y28dc493ak358749e0c29154cc@mail.gmail.com> <20090131124022.GB29748@ultras> <20090131201920.GC29748@ultras>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
X-From: git-owner@vger.kernel.org Sat Jan 31 22:19:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTNFT-0008Ou-IV
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 22:19:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752503AbZAaVSI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jan 2009 16:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752467AbZAaVSG
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 16:18:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:41526 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752429AbZAaVSF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 16:18:05 -0500
Received: (qmail invoked by alias); 31 Jan 2009 21:18:02 -0000
Received: from i577B9892.versanet.de (EHLO atjola.local) [87.123.152.146]
  by mail.gmx.net (mp008) with SMTP; 31 Jan 2009 22:18:02 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/Jo1Qc8UbJ48AjsbbdejhO8LWUnHlvWEknhwa4/P
	z7pVl+EMB9stza
Content-Disposition: inline
In-Reply-To: <20090131201920.GC29748@ultras>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107940>

On 2009.01.31 21:19:20 +0100, Nicolas Sebrecht wrote:
>=20
> On Sat, Jan 31, 2009 at 01:09:49PM +0100, Santi B=E9jar wrote:
>=20
> > You omitted the help message of git status, where it says how to un=
stage:
> > # Changes to be committed:
> > #   (use "git reset HEAD <file>..." to unstage)
> >=20
> > So to not commit foo at all:
> >=20
> > git reset HEAD foo
>=20
> Thanks. I didn't omitted the help message of git status. The "unstage=
"
> action is what I was looking for but I was wrongly presuming (and I'v=
e
> read git docs !) that 'HEAD' is a kind of shortcut to the last commit=
 of
> the current branch (not to the last state of the working tree).
>=20
> Working on branch master for example, we have in .git/HEAD :
> ref: refs/heads/master
> And in .git/refs/heads/master, the hash of the last commit of branch
> master.
>=20
> I'm missing something here. But what ?

You're missing the fact that you want to reset the index entry to the
state from HEAD. The working tree state is the modified one, and you ge=
t
that into the index using "git add". But you want the index entry to be
back at the state from HEAD. So HEAD is what you need to pass to reset
(well, actually, you can skip "HEAD" there, it's the default).

Bj=F6rn
