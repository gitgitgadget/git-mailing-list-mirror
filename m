From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git rescue mission
Date: Fri, 09 Feb 2007 03:01:41 +0100
Organization: At home
Message-ID: <eqgkj2$2nl$1@sea.gmane.org>
References: <17866.27739.701406.722074@lisa.zopyra.com> <Pine.LNX.4.64.0702080858430.8424@woody.linux-foundation.org> <87fy9gz9vu.fsf@host94.eke.fi> <Pine.LNX.4.64.0702081321040.8424@woody.linux-foundation.org> <87bqk4z4qw.fsf@host94.eke.fi> <20070208221023.GB1091@spearce.org> <20070209014852.GA13207@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 09 03:00:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFL3o-0000qb-Ej
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 03:00:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945974AbXBICAW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 8 Feb 2007 21:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946014AbXBICAV
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 21:00:21 -0500
Received: from main.gmane.org ([80.91.229.2]:58870 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945974AbXBICAV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 21:00:21 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HFL3e-0004E1-8S
	for git@vger.kernel.org; Fri, 09 Feb 2007 03:00:14 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Feb 2007 03:00:14 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Feb 2007 03:00:14 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39149>

<opublikowany i wys=B3any>

Theodore Tso wrote:

> On Thu, Feb 08, 2007 at 05:10:23PM -0500, Shawn O. Pearce wrote:
>>      git config alias.new "gitk --all --not ORIG_HEAD"
>>=20
>> Would give you a new git subcommand:
>>=20
>>      git new
>>=20
>> which shows all of the new stuff, on all branches, but doesn't show
>> your prior commit history.
>=20
> Aliases don't seem to be working for me; I'm using git 1.5.0-rc4.  Am
> I doing something wrong?
>=20
> <tytso@candygram> {/usr/projects/linux/linux-2.6}  [master]
> 37% git version
> git version 1.5.0.rc4
> <tytso@candygram> {/usr/projects/linux/linux-2.6}  [master]
> 38% git config alias.new "gitk --all --not ORIG_HEAD"
> <tytso@candygram> {/usr/projects/linux/linux-2.6}  [master]
> 39% git new
> git: 'new' is not a git-command

> <tytso@candygram> {/usr/projects/linux/linux-2.6}  [master]
> 40% tail .git/config=20
>=20
> [user]
>         name =3D Theodore Ts'o
>         email =3D tytso@mit.edu
>=20
> [remote "iwlwifi"]
>         url =3D http://bughost.org/repos/iwlwifi.git/
>         fetch =3D +refs/heads/*:refs/remotes/iwlwifi/*
> [alias]
>         new =3D gitk --all --not ORIG_HEAD
>                                      =20

Actually I think you can only alias git commands. For example
"alias.last  =3D  cat-file  commit HEAD" makes "git last" call
"git cat-file  commit HEAD".

So "alias.new  =3D gitk --all --not ORIG_HEAD" would mean that
"git new" invokes "git gitk ..." not "gitk ...". Do you see
the problem.

But error message is a bit strange...
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
