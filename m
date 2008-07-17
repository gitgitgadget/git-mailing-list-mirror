From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Documentation/RelNotes-1.6.0.txt: Expand on the incompatible packfiles
Date: Thu, 17 Jul 2008 19:10:32 +0200
Organization: At home
Message-ID: <g5nue6$3ek$1@ger.gmane.org>
References: <20080717170118.14083.87086.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 19:11:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJX1D-0004Xz-Ax
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 19:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756674AbYGQRKv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jul 2008 13:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756246AbYGQRKv
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 13:10:51 -0400
Received: from main.gmane.org ([80.91.229.2]:59032 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756027AbYGQRKu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 13:10:50 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KJX03-0001cw-LZ
	for git@vger.kernel.org; Thu, 17 Jul 2008 17:10:39 +0000
Received: from abxe74.neoplus.adsl.tpnet.pl ([83.8.254.74])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 17:10:39 +0000
Received: from jnareb by abxe74.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 17:10:39 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abxe74.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88888>

Petr Baudis wrote:

> +introduced in v1.5.2 and v1.4.4.5. =A0If you want to keep your repos=
itories
> +backwards compatible past these versions, set repack.useDeltaBaseOff=
set
> +to false or pack.indexVersion to 1, respectively.

'or'? Not 'and'?

You shouldn't have, I think, this "respectively" here.  You need it onl=
y
if you are writing "a, b, c, then a', b', c', respectively".

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
