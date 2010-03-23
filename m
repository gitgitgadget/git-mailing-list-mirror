From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to ignore changes on remote
Date: Tue, 23 Mar 2010 18:47:52 +0100
Organization: At home
Message-ID: <hoaus7$3br$1@dough.gmane.org>
References: <26ae428a1003230654m50c35caci4a02e2df321f289c@mail.gmail.com> <d411cc4a1003230905y12839743x400333a0aa2e7018@mail.gmail.com> <4BA8EA6A.4030607@viscovery.net> <201003231820.51618.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 23 18:48:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu8D7-00070m-0b
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 18:48:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753764Ab0CWRsI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Mar 2010 13:48:08 -0400
Received: from lo.gmane.org ([80.91.229.12]:47340 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753751Ab0CWRsG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 13:48:06 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nu8Cy-0006uw-2i
	for git@vger.kernel.org; Tue, 23 Mar 2010 18:48:04 +0100
Received: from absh220.neoplus.adsl.tpnet.pl ([83.8.127.220])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 18:48:04 +0100
Received: from jnareb by absh220.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 18:48:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: absh220.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143037>

Johan Herland wrote:

> I'm rolling out Git at my $DAYJOB to a few hundred developers, and I=20
> instruct them to
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0git config --global push.default tracking
>=20
> immediately after installing Git. Which sucks, but is the only sane=20
> thing I can do to prevent this problem from haunting us.

Why not have administrator use

         git config --system push.default tracking

once (and/or setup skeleton for /etc/gitconfig)?
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
