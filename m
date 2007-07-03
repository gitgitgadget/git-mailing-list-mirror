From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [PATCH] stash: end commit log with a newline
Date: Tue, 3 Jul 2007 16:01:19 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070703140119.GA15711@informatik.uni-freiburg.de>
References: <20070703085906.GA4963@lala> <Pine.LNX.4.64.0707031228460.4071@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 03 16:01:45 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5iwm-00086R-Nz
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 16:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754366AbXGCOBY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 3 Jul 2007 10:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754392AbXGCOBX
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 10:01:23 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:63955 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754366AbXGCOBW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jul 2007 10:01:22 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1I5iwT-0006kV-41; Tue, 03 Jul 2007 16:01:21 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l63E1JYc015798;
	Tue, 3 Jul 2007 16:01:19 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l63E1Ju1015797;
	Tue, 3 Jul 2007 16:01:19 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707031228460.4071@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51494>

Hallo Johannes,

Johannes Schindelin wrote:
> On Tue, 3 Jul 2007, Uwe Kleine-K?nig wrote:
>=20
> > -	w_commit=3D$(printf 'WIP on %s' "$msg" |
> > +	w_commit=3D$(printf 'WIP on %s\n' "$msg" |
>=20
> Why not
>=20
> 	w_commit=3D$(echo "WIP on $msg" |
I just continued to use printf to make a minimal change.  I don't have
anything against echo.
=20
Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D5%2B7
