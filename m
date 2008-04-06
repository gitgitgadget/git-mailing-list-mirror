From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [bug] git-clone over ssh fails when repository has local commits
Date: Sun, 06 Apr 2008 22:50:25 +0200
Organization: At home
Message-ID: <ftbd2e$b9k$1@ger.gmane.org>
References: <1caff7430804060645s764f24f8y3d07ee8647ec8f25@mail.gmail.com> <20080406161120.GB24358@coredump.intra.peff.net> <1caff7430804060922seba4978qa13b123103b8282b@mail.gmail.com> <20080406165655.GA26060@coredump.intra.peff.net> <1caff7430804061011ye82e74v289dd3536b253bcb@mail.gmail.com> <20080406175136.GB32399@coredump.intra.peff.net> <1caff7430804061106m49a60bc0wbbd9001394e83589@mail.gmail.com> <1caff7430804061111u743e6257vf34d35303c864b49@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 06 22:51:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jibpo-0008QQ-99
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 22:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753271AbYDFUuo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Apr 2008 16:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753273AbYDFUuo
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 16:50:44 -0400
Received: from main.gmane.org ([80.91.229.2]:35865 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752996AbYDFUun (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 16:50:43 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Jiboz-00067E-CE
	for git@vger.kernel.org; Sun, 06 Apr 2008 20:50:37 +0000
Received: from abvn127.neoplus.adsl.tpnet.pl ([83.8.211.127])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 06 Apr 2008 20:50:37 +0000
Received: from jnareb by abvn127.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 06 Apr 2008 20:50:37 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvn127.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78927>

<opublikowany i wys=B3any>

seventh guardian wrote:

> On Sun, Apr 6, 2008 at 7:06 PM, seventh guardian
> <seventhguardian@gmail.com> wrote:
>>  Now that I look at the addresses, the "nouveau" part is common to t=
he
>>  problematic repo's. I'll make a local change on the last repo and s=
ee
>>  if it also exhibits the problem. I'll report back ASAP.
>=20
> The last repo also exhibits the problem after committing a local
> change. A hard reset to "origin" fixes the problem, but also throws
> away the local changes..

It looks for me as permission problems, as thought loose objects
get created unreadable by git daemon, or something...

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
