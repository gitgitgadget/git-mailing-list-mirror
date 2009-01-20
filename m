From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] diff: Support diff.color-words config option
Date: Tue, 20 Jan 2009 15:38:48 +0100
Organization: At home
Message-ID: <gl4nkp$4kq$1@ger.gmane.org>
References: <alpine.DEB.1.00.0901162208180.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901200031350.3586@pacific.mpi-cbg.de> <200901192017.54163.bss@iguanasuicide.net> <200901192145.21115.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 20 15:40:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPHli-0004Do-KM
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 15:39:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755438AbZATOia convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2009 09:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753484AbZATOia
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 09:38:30 -0500
Received: from main.gmane.org ([80.91.229.2]:59220 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752085AbZATOi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 09:38:29 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LPHkI-0008E2-Bl
	for git@vger.kernel.org; Tue, 20 Jan 2009 14:38:26 +0000
Received: from abvq106.neoplus.adsl.tpnet.pl ([83.8.214.106])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Jan 2009 14:38:26 +0000
Received: from jnareb by abvq106.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Jan 2009 14:38:26 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvq106.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106477>

Boyd Stephen Smith Jr. wrote:

> Nawi=B1zania: 1 2 3
> When diff is invoked with --color-words (w/o =3Dregex), use the regul=
ar
> expression the user has configured as diff.color-words.
>=20
> diff drivers configured via attributes take precedence over the
> diff.color-words setting. =A0If the user wants to change them, they h=
ave
> their own configuration variables.

Just a nit: all other configuration variables use camelCase or runwords=
;
this would be first configuration variable with '-' as words separator,
I think.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
