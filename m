From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: problems when pushing to a master repository
Date: Thu, 22 Dec 2005 08:56:03 -0200
Message-ID: <1135248963.17758.18.camel@localhost>
References: <1135246723.17758.14.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu Dec 22 11:56:19 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpO7K-0003gv-H2
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 11:56:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbVLVK4K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 22 Dec 2005 05:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbVLVK4K
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 05:56:10 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:50081 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932125AbVLVK4J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 05:56:09 -0500
Received: from [200.103.119.234] (helo=[192.168.1.112])
	by pentafluge.infradead.org with esmtpsa (Exim 4.54 #1 (Red Hat Linux))
	id 1EpO7D-0007oe-48
	for git@vger.kernel.org; Thu, 22 Dec 2005 10:56:08 +0000
To: git@vger.kernel.org
In-Reply-To: <1135246723.17758.14.camel@localhost>
X-Mailer: Evolution 2.4.2.1-1mdk 
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[200.103.119.234 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[200.103.119.234 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13941>

Em Qui, 2005-12-22 =E0s 08:18 -0200, Mauro Carvalho Chehab escreveu:
> 	I've started working recently with git, and I'm suffering problems t=
o
> update a master repository. Sometimes, git refuses to update a master
> repository:
>=20
> git push
> ssh://master.kernel.org/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git
> master
> error: src refspec master matches more than one.
> fatal: unexpected EOF
>=20
> 	Even removing the branch, git-prune and reimporting doesn't work. I
> have to reimport the tree from master repository.
>=20
> 	Any sugestions?
	I found the problem. git created a refs/bases dir, with old references
with the same names. Removing it fixed the problem.

Cheers,
Mauro.
