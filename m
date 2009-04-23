From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: A system administration use case for git
Date: Thu, 23 Apr 2009 13:39:24 +0200
Message-ID: <20090423113924.GA22915@pengutronix.de>
References: <2cfc40320904220133l5ab567f3q46608793b93f0e1f@mail.gmail.com> <20090423095533.GE13989@pengutronix.de> <49F04511.3070601@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jon Seymour <jon.seymour@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Apr 23 13:41:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwxIm-0000AC-F6
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 13:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756652AbZDWLjd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Apr 2009 07:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756609AbZDWLjd
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 07:39:33 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56077 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756394AbZDWLjc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 07:39:32 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1LwxH4-0004Zn-IS; Thu, 23 Apr 2009 13:39:26 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1LwxH2-0003AC-2p; Thu, 23 Apr 2009 13:39:24 +0200
Content-Disposition: inline
In-Reply-To: <49F04511.3070601@viscovery.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117331>

Hi Hannes,

On Thu, Apr 23, 2009 at 12:38:09PM +0200, Johannes Sixt wrote:
> Uwe Kleine-K=F6nig schrieb:
> > There is a practical problem though:  The filelist has to be sorted=
 in a
> > way that is not provided by ls, so:
> >=20
> > 	ukleinek@cepheus:~/gsrc/linux-2.6/usr$ for f in $(ls -A); do print=
f "100644 %s\x00" $f; git hash-object $f | perl -n -e 'chomp; for $c (s=
plit(/(.{2})/)) { printf("%c", hex($c)) if $c }'; done | git hash-objec=
t -t tree -w --stdin
> > 	a0a6efb3f1de956badc7607c7d372cc325a18846
>=20
> Does ... $(LANG=3DC ls -A) ... make a difference for you?
oh, up to now I thought that C and en_US.UTF-8 use the same sorting.  S=
o
yes, it does it right then.

Best regards and thanks
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
