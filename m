From: Alejandro Riveira <ariveira@gmail.com>
Subject: Re: git gc - out of memory
Date: Sun, 15 Nov 2009 14:44:29 +0000 (UTC)
Message-ID: <hdp44d$4ml$1@ger.gmane.org>
References: <df1390cc0911141126w1a0c5691p83885053a73f829@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 15 15:45:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9gMG-0007M6-Vq
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 15:45:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753188AbZKOOou convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Nov 2009 09:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753183AbZKOOou
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 09:44:50 -0500
Received: from lo.gmane.org ([80.91.229.12]:59030 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753154AbZKOOou (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 09:44:50 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N9gLW-00074C-Hz
	for git@vger.kernel.org; Sun, 15 Nov 2009 15:44:54 +0100
Received: from 139.red-83-44-221.dynamicip.rima-tde.net ([83.44.221.139])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 15 Nov 2009 15:44:54 +0100
Received: from ariveira by 139.red-83-44-221.dynamicip.rima-tde.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 15 Nov 2009 15:44:54 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 139.red-83-44-221.dynamicip.rima-tde.net
User-Agent: Pan/0.132 (Waxed in Black)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132943>

El Sat, 14 Nov 2009 20:26:00 +0100, Simon Strandgaard escribi=C3=B3:

> My bare repository is on an OpenBSD machine. I was unaware of the
> importance of git gc until today after investigating a problem with "=
git
> pull". So there hasn't been run git gc on the repository ever.
>=20
> The biggest file in the repository is a 45 mb file. The repository si=
ze
> is near 2 gb.
>=20
> What can I do?

run =C2=AB git repack -adf --window=3Dmemory =C2=BB on the repo where m=
emory is
escaled apropiately for your machine ?

See =C2=AB git help repack =C2=BB

Regards;
