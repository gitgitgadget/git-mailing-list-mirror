From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Suggestions for documentation
Date: Thu, 21 Jun 2007 17:16:09 +0200
Organization: At home
Message-ID: <f5e4no$b6f$1@sea.gmane.org>
References: <467786B1.5000009@gmail.com> <20070620180615.529dff2a@localhost> <467A5FE1.1010401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 21 17:43:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1Oog-00042T-7P
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 17:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753093AbXFUPnZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 21 Jun 2007 11:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751990AbXFUPnZ
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 11:43:25 -0400
Received: from main.gmane.org ([80.91.229.2]:52520 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752098AbXFUPnY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 11:43:24 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I1ObL-0000yB-O2
	for git@vger.kernel.org; Thu, 21 Jun 2007 17:29:40 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Jun 2007 17:29:39 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Jun 2007 17:29:39 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50634>

Claudio Scordino wrote:

> =A0 =A0 actually I didn't understand the difference between "git clon=
e --bare" and
> "git --bare fetch" either... (maybe is not clear in the documentation=
 ?)
>=20
> For instance, what should be used when setting up a public not-workin=
g repository ?
>=20
> I mean, we can use both
>=20
> git --bare init
> git --bare fetch ... master:master

"git --bare <command>" is equivalent to "git --git-dir=3D. <command>", =
and
it only tells where to find repository...
=20
> and
>=20
> git clone --bare =A0...

=2E..while "git clone --bare" setups _bare_ repository, which means
1:1 mapping of references, and no working area.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
