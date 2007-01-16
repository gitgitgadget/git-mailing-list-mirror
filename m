From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>
Subject: Re: [PATCH RFC] new config option remote.<name>.pushexec
Date: Tue, 16 Jan 2007 17:26:45 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070116162645.GA18894@informatik.uni-freiburg.de>
References: <20070116150259.GA2439@cepheus> <Pine.LNX.4.63.0701161614070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 17:26:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6r9B-000193-Q4
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 17:26:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbXAPQ0u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 16 Jan 2007 11:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbXAPQ0u
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 11:26:50 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:44742 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751284AbXAPQ0t (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Jan 2007 11:26:49 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1H6r96-0007OT-9a; Tue, 16 Jan 2007 17:26:48 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11) with ESMTP id l0GGQkab018986;
	Tue, 16 Jan 2007 17:26:46 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11/Submit) id l0GGQjbw018985;
	Tue, 16 Jan 2007 17:26:45 +0100 (MET)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <zeisberg@informatik.uni-freiburg.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0701161614070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36947>

Hi Johannes,

Johannes Schindelin wrote:
> On Tue, 16 Jan 2007, Uwe Kleine-K=F6nig wrote:
>=20
> > git push --exec=3D... is fine, but having it to specify every time =
is
> > annoying.
>=20
> What would you specify? The only sensible thing would be "--exec=3Dbl=
abla"=20
> where "blabla" is a workalike to git-receive-pack.
Exactly.  Quoting git-send-pack(1):

	Path to the git-receive-pack program on the remote end.
	Sometimes useful when pushing to a remote repository over ssh,
	and you do not have the program in a directory on the default
	$PATH.

=46or me it would be:

	pushexec =3D /home/zeisberg/usr/bin/git-receive-pack

While having /home/zeisberg/usr/bin only in my PATH for interactive
shells.  (Yes I know I could expand my PATH which .<someshrc>, but I'd
prefer it that way.)

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D1+newton+in+kg*m+%2F+s%5E2
