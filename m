From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] revert/cherry-pick: allow starting from dirty work tree.
Date: Wed, 14 Nov 2007 01:21:47 +0100
Organization: At home
Message-ID: <fhdf2o$v60$1@ger.gmane.org>
References: <7vd4udsv6b.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711132154370.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 14 01:22:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is61H-0007jm-To
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 01:22:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763104AbXKNAV4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Nov 2007 19:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763490AbXKNAVz
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 19:21:55 -0500
Received: from main.gmane.org ([80.91.229.2]:40754 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762265AbXKNAVy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 19:21:54 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Is60r-0002Bb-PG
	for git@vger.kernel.org; Wed, 14 Nov 2007 00:21:49 +0000
Received: from abwy6.neoplus.adsl.tpnet.pl ([83.8.248.6])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Nov 2007 00:21:49 +0000
Received: from jnareb by abwy6.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Nov 2007 00:21:49 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwy6.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64928>

Johannes Schindelin wrote:

> While we're at cherry-pick: Two days ago I had to rebase in a dirty=20
> working directory. =A0Why? =A0Because one of the submodules was not y=
et ready=20
> to be committed to the superproject.
>=20
> And you cannot easily stash away a submodule.

git stash --recursive (to be written)? ;-)

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
