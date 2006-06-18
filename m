From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFD] gitweb configuration
Date: Sun, 18 Jun 2006 06:00:47 +0200
Organization: At home
Message-ID: <e72j53$1m1$1@sea.gmane.org>
References: <e720r0$qdv$1@sea.gmane.org> <20060617232358.GK2609@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sun Jun 18 06:01:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FroTI-00032E-Lf
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 06:01:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbWFREBD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 18 Jun 2006 00:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWFREBD
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 00:01:03 -0400
Received: from main.gmane.org ([80.91.229.2]:22725 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751073AbWFREBB (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jun 2006 00:01:01 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FroSz-00030A-Eo
	for git@vger.kernel.org; Sun, 18 Jun 2006 06:00:53 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 18 Jun 2006 06:00:53 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 18 Jun 2006 06:00:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22049>

Petr Baudis wrote:

>> - gitweb installation options (gitweb version need not to correspond=
 to=20
>>   git version, and we could theoretically have more than one gitweb
>>   installation while one git-core installation). It was proposed to =
put
>>   such options on gitweb.conf file in the same directory as gitweb.c=
gi.
>>   Unfortunately if one would want to use git-repo-config for managin=
g
>>   gitweb.conf one is out of luck: git-repo-config uses $GIT_DIR/conf=
ig.
>=20
> In the longer term, perhaps this kind of configuration might land in =
the
> global git configuration file.

We could use user's "global" configuration file, ~/.gitconfig, in patch
from Johannes=A0Schindelin (and now in 'pu').

So GIT_CONFIG would be ~/.gitconfig, and GIT_CONFIG_LOCAL would be=20
$GIT_DIR/config or what?

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
