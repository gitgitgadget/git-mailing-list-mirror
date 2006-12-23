From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: confusion over the new branch and merge config
Date: Sat, 23 Dec 2006 11:40:53 +0100
Organization: At home
Message-ID: <emj0uh$21s$1@sea.gmane.org>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home> <7vd56cam66.fsf@assigned-by-dhcp.cox.net> <20061223051210.GA29814@segfault.peff.net> <7vbqlvuoi4.fsf@assigned-by-dhcp.cox.net> <7vbqlvrldk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Dec 23 11:38:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy4HD-0003bA-MQ
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 11:38:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753151AbWLWKij convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 23 Dec 2006 05:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753149AbWLWKij
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 05:38:39 -0500
Received: from main.gmane.org ([80.91.229.2]:33589 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753151AbWLWKii (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 05:38:38 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Gy4Gu-0007W7-0M
	for git@vger.kernel.org; Sat, 23 Dec 2006 11:38:32 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Dec 2006 11:38:32 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Dec 2006 11:38:32 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35311>

Junio C Hamano wrote:

>> Only *if* you store it in that tracking branch. =A0The name the
>> other party gives _do_ matter to you anyway, because you have to
>> _know_ it to fetch. =A0What it does NOT matter is if you use a
>> tracking branch, or if you do, which local tracking branch you
>> use to track it.
>=20
> Having said that, I think we _could_ do this.
>=20
> If you (or other people) use branch.*.merge, with its value set
> to remote name _and_ local name, and actually verify that either
> form works without confusion, please report back and I'll apply.

Hmmm... that DWIM is even better than proposed some time ago localmerge
(or mergelocal, I don't remember) config variable.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
