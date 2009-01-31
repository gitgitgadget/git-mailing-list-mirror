From: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
Subject: Re: understanding index
Date: Sat, 31 Jan 2009 21:19:20 +0100
Message-ID: <20090131201920.GC29748@ultras>
References: <20090131111011.GA29748@ultras> <adf1fd3d0901310409y28dc493ak358749e0c29154cc@mail.gmail.com> <20090131124022.GB29748@ultras>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 31 21:26:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTMQ9-0000sx-1r
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 21:26:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203AbZAaUZE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jan 2009 15:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752137AbZAaUZE
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 15:25:04 -0500
Received: from out2.laposte.net ([193.251.214.119]:54109 "EHLO
	out1.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751797AbZAaUZD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 15:25:03 -0500
Received: from meplus.info (localhost [127.0.0.1])
	by mwinf8204.laposte.net (SMTP Server) with ESMTP id 9CE2A7000088
	for <git@vger.kernel.org>; Sat, 31 Jan 2009 21:24:55 +0100 (CET)
Received: from ? (91-164-156-12.rev.libertysurf.net [91.164.156.12])
	by mwinf8204.laposte.net (SMTP Server) with ESMTP id 628EA7000087
	for <git@vger.kernel.org>; Sat, 31 Jan 2009 21:24:55 +0100 (CET)
X-ME-UUID: 20090131202455403.628EA7000087@mwinf8204.laposte.net
Content-Disposition: inline
In-Reply-To: <adf1fd3d0901310409y28dc493ak358749e0c29154cc@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-me-spamlevel: not-spam
X-me-spamrating: 40.000000
X-me-spamcause: OK, (-100)(0000)gggruggvucftvghtrhhoucdtuddrvdektddrjeehucetggdotefuucfrrhhofhhilhgvmecuoehnohhnvgeqnecuuegrihhlohhuthemuceftddtnecuucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107936>


On Sat, Jan 31, 2009 at 01:09:49PM +0100, Santi B=E9jar wrote:

> You omitted the help message of git status, where it says how to unst=
age:
> # Changes to be committed:
> #   (use "git reset HEAD <file>..." to unstage)
>=20
> So to not commit foo at all:
>=20
> git reset HEAD foo

Thanks. I didn't omitted the help message of git status. The "unstage"
action is what I was looking for but I was wrongly presuming (and I've
read git docs !) that 'HEAD' is a kind of shortcut to the last commit o=
f
the current branch (not to the last state of the working tree).

Working on branch master for example, we have in .git/HEAD :
ref: refs/heads/master
And in .git/refs/heads/master, the hash of the last commit of branch
master.

I'm missing something here. But what ?

--=20
Nicolas Sebrecht
