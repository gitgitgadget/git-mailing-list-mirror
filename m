From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: Re: [PATCH (topgit) 1/2] Implement setup_pager just like in git
Date: Wed, 7 Jan 2009 11:35:34 +0100
Message-ID: <20090107103534.GA30089@chistera.yi.org>
References: <cover.1231254832.git.kirr@landau.phys.spbu.ru> <acaae74f79d385014e726b97f8258b2a0caa3dd0.1231254832.git.kirr@landau.phys.spbu.ru> <20090106203203.GA11274@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kirill Smelkov <kirr@landau.phys.spbu.ru>, git@vger.kernel.org,
	pasky@suse.cz
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Wed Jan 07 11:37:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKVmW-0000ui-U3
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 11:37:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbZAGKfi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Jan 2009 05:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbZAGKfi
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 05:35:38 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:4434
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbZAGKfi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 05:35:38 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id 6B548801BF68;
	Wed,  7 Jan 2009 11:35:35 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LKVl8-0007rq-Lj; Wed, 07 Jan 2009 11:35:34 +0100
Content-Disposition: inline
In-Reply-To: <20090106203203.GA11274@lapse.rw.madduck.net>
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104783>

* martin f krafft [Tue, 06 Jan 2009 21:32:03 +0100]:

> > +	_pager_fifo=3D"$(mktemp -t tg-pager-fifo.XXXXXX)"
> > +	rm "$_pager_fifo" && mkfifo -m 600 "$_pager_fifo"

> There's a race condition here. I can't see a real problem with it,
> though, nor do I know of a better way.

mktemp -d, and create the fifo inside the directory created by mktemp.

--=20
Adeodato Sim=C3=B3                                     dato at net.com.=
org.es
Debian Developer                                  adeodato at debian.or=
g
=20
A hacker does for love what other would not do for money.
