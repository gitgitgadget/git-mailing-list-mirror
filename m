From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Teach 'git apply' to look at $GIT_DIR/config
Date: Sun, 18 Feb 2007 02:48:02 +0100
Organization: At home
Message-ID: <er8b4s$o7n$1@sea.gmane.org>
References: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net> <7v8xewsd2j.fsf@assigned-by-dhcp.cox.net> <20070217232603.GB30839@coredump.intra.peff.net> <7vmz3cqs3d.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0702180107250.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vbqjsqpgs.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0702180135240.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vsld4p99g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 18 02:46:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIb8P-0004Bo-9E
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 02:46:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993033AbXBRBqe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 17 Feb 2007 20:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993035AbXBRBqe
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 20:46:34 -0500
Received: from main.gmane.org ([80.91.229.2]:39456 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2993033AbXBRBqd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 20:46:33 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HIb8A-0002MA-TV
	for git@vger.kernel.org; Sun, 18 Feb 2007 02:46:23 +0100
Received: from host-81-190-26-89.torun.mm.pl ([81.190.26.89])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 18 Feb 2007 02:46:22 +0100
Received: from jnareb by host-81-190-26-89.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 18 Feb 2007 02:46:22 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-89.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40049>

Junio C Hamano wrote:

> I can do almost that with
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0git diff --color-words :GIT-VERSION-GEN :git-=
gui/GIT-VERSION-GEN
>=20
> but, it compares indexed ones, not from the working tree, so it
> is not exactly the same.

Not ::GIT-VERSION-GEN?=20

We could use :-1: for filesystem (working directory, :-: in short, vers=
ion.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
