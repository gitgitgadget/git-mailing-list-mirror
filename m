From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-fetch: Allow branch."branchname".remote=.
Date: Fri, 13 Oct 2006 15:06:07 +0200
Organization: At home
Message-ID: <ego2vm$568$1@sea.gmane.org>
References: <87y7rk3b9n.fsf@gmail.com> <7vpscwd4ya.fsf@assigned-by-dhcp.cox.net> <8aa486160610130208s67ea0746o8a54910860b3fb78@mail.gmail.com> <Pine.LNX.4.63.0610131324090.14200@wbgn013.biozentrum.uni-wuerzburg.de> <ego1ea$tsn$1@sea.gmane.org> <Pine.LNX.4.63.0610131448390.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Oct 13 15:07:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYMl3-0005VA-Qp
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 15:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686AbWJMNHX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 13 Oct 2006 09:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751683AbWJMNHX
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Oct 2006 09:07:23 -0400
Received: from main.gmane.org ([80.91.229.2]:33931 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751679AbWJMNHW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Oct 2006 09:07:22 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GYMkV-0005LS-5b
	for git@vger.kernel.org; Fri, 13 Oct 2006 15:06:51 +0200
Received: from host-81-190-17-207.torun.mm.pl ([81.190.17.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Oct 2006 15:06:51 +0200
Received: from jnareb by host-81-190-17-207.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 13 Oct 2006 15:06:51 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-207.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28841>

<opublikowany i wys=B3any>

Johannes Schindelin wrote:


> On Fri, 13 Oct 2006, Jakub Narebski wrote:
>=20
>> Johannes Schindelin wrote:
>>=20
>> > There is a subtle problem here. Up until now, "remote" meant a sho=
rt cut.=20
>> > You either had a file with that name in .git/remotes/ or .git/bran=
ches, or=20
>> > an entry in the config (remote.<name>.url).
>>=20
>> Not exactly. "git-pull . <branch>" and "git-peek-remote ." meant use
>> _current_ repository. "." as remote name means "current", i.e. local=
=20
>> repository.
>=20
> From Documentation/git-pull.txt:
>=20
>       SYNOPSIS
>       --------
>       'git-pull' <options> <repository> <refspec>...
>=20
> It says "repository", not "remote". As for the name "git-peek-remote"=
:=20
> yes, it is a short cut for "remote repository".
>=20
> The thing is, if you say you pull "from a remote", then it is not=20
> sufficient to specify just a URL of a repository. You also have to sp=
ecify=20
> a branch.

O.K. "remote" =3D "repository + set of branches". But we can say that "=
=2E"
is a default remote, which points to local repository (".") and has
no branches information.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
