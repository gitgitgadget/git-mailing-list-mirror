From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-daemon on NSLU2
Date: Sat, 25 Aug 2007 00:39:16 +0200
Organization: At home
Message-ID: <fanmmk$f5q$1@sea.gmane.org>
References: <9e4733910708232254w4e74ca72o917c7cadae4ee0f4@mail.gmail.com> <20070824062106.GV27913@spearce.org> <9e4733910708241238n1899f332j4fafbd6d7ccc48b9@mail.gmail.com> <alpine.LFD.0.999.0708241618070.16727@xanadu.home> <9e4733910708241417l44c55306xaa322afda69c6beb@mail.gmail.com> <9e4733910708241506h6eecc11ge41b1dc313022b4b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 25 00:39:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOhoU-0002y4-P8
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 00:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761655AbXHXWjb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 24 Aug 2007 18:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760858AbXHXWjb
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 18:39:31 -0400
Received: from main.gmane.org ([80.91.229.2]:40450 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760928AbXHXWja (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 18:39:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IOhoN-0004g4-BZ
	for git@vger.kernel.org; Sat, 25 Aug 2007 00:39:27 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 25 Aug 2007 00:39:27 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 25 Aug 2007 00:39:27 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56608>

Jon Smirl wrote:
> On 8/24/07, Nicolas Pitre <nico@cam.org> wrote:

>> Try running "git repack -a" directly on the NSLU2. =A0You should hav=
e the
>> same performance problems as with a clone.
>=20
> This is true, it would take over 24hrs to finish.
>=20
> Is their a reason why initial clone hasn't been special cased? Why
> can't initial clone just blast over the pack file already sitting on
> the disk?

There was idea to special case clone (just concatenate the packs, the
receiving side as someone told there can detect pack boundaries; do not
forget to pack loose objects, first), instead of using generic fetch --=
all
for clone, bnut no code. Code speaks louder than words (although if som=
eone
would provide details of pack boundary detection...)

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
