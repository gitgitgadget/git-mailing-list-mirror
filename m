From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: builtin-fetch code with messy history
Date: Tue, 19 Jun 2007 18:46:29 +0200
Organization: At home
Message-ID: <f59194$odb$1@sea.gmane.org>
References: <Pine.LNX.4.64.0706190255430.4740@iabervon.org> <Pine.LNX.4.64.0706191037590.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 19 18:55:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0gzb-00074P-Oj
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 18:55:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755489AbXFSQzq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 19 Jun 2007 12:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753994AbXFSQzq
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 12:55:46 -0400
Received: from main.gmane.org ([80.91.229.2]:51728 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752749AbXFSQzp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 12:55:45 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I0gu3-0001X5-OU
	for git@vger.kernel.org; Tue, 19 Jun 2007 18:50:04 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 19 Jun 2007 18:50:03 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 19 Jun 2007 18:50:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50496>

Johannes Schindelin wrote:

>> =A0* when a branch config file section refers to a branches/* remote=
, the=20
>> =A0 =A0merge setting is used (if one is given), even though this isn=
't useful=20
>> =A0 =A0either way.
>=20
> Maybe this is the right time to cut off branches/* and remotes/*?

We should read branches/* and remotes/* for a long time; even if people
are using new version of git, their repositories are not necessarily
converted (and IIRC there is only script for remotes -> config, in cont=
rib,
not in core git).

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
