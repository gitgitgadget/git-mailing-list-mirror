From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Documentation: update git-pull.txt for clone's new default behavior
Date: Tue, 02 Jan 2007 01:38:39 +0100
Organization: At home
Message-ID: <enc9cn$a4o$1@sea.gmane.org>
References: <20070101214023.GB23857@fieldses.org> <182318.86313.qm@web31812.mail.mud.yahoo.com> <7vd55y46ta.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Jan 02 01:36:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1XdL-0005OO-B3
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 01:36:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754700AbXABAfw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 1 Jan 2007 19:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754747AbXABAfw
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 19:35:52 -0500
Received: from main.gmane.org ([80.91.229.2]:54134 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754700AbXABAfv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jan 2007 19:35:51 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H1Xd0-0004q1-Fx
	for git@vger.kernel.org; Tue, 02 Jan 2007 01:35:42 +0100
Received: from host-81-190-24-56.torun.mm.pl ([81.190.24.56])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Jan 2007 01:35:42 +0100
Received: from jnareb by host-81-190-24-56.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Jan 2007 01:35:42 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-56.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35757>

Junio C Hamano wrote:

> So after a clone, you would get:
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0[remote "origin"]
> =A0 =A0 =A0 =A0 =A0=A0=A0=A0=A0=A0=A0=A0url =3D ....
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fetch =3D refs/heads/*:refs/remotes/o=
rigin/*

By the way, I have thought that you would also get (to avoid nasty=20
"we don't know which branch is first in glob")

                  fetch =3D refs/heads/master:refs/remotes/origin/maste=
r

or

                  fetch =3D refs/heads/master:refs/remotes/origin/HEAD

(if master was current branch)

> =A0 =A0 =A0 =A0 [branch "master"]
> =A0 =A0 =A0 =A0 =A0=A0=A0=A0=A0=A0=A0=A0remote =3D origin
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 merge =3D refs/heads/master

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
