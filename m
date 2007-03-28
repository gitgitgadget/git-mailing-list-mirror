From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [PATCH] bisect: use update-ref to update refs
Date: Wed, 28 Mar 2007 16:10:23 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070328141023.GB23378@informatik.uni-freiburg.de>
References: <20070328123519.GA4472@cepheus> <460A71A1.D1388D3@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 16:10:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWYrA-0004rI-Kq
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 16:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917AbXC1OK2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 28 Mar 2007 10:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932AbXC1OK2
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 10:10:28 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:58039 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751917AbXC1OK1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Mar 2007 10:10:27 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1HWYr4-0001hI-O9; Wed, 28 Mar 2007 16:10:26 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l2SEAOcn023896;
	Wed, 28 Mar 2007 16:10:24 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l2SEAN4n023895;
	Wed, 28 Mar 2007 16:10:23 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <460A71A1.D1388D3@eudaptics.com>
User-Agent: Mutt/1.5.14+cvs20070315 (2007-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43373>

Johannes Sixt wrote:
> Uwe Kleine-K=F6nig wrote:
> >         GIT_DIR=3D"$GIT_DIR" git-$command ...
> >=20
> > where the assignment to GIT_DIR should be superfluous?
>=20
> git-sh-setup sets GIT_DIR, but does not export it. Therefore, this
> assignment is *not* superfluous (its effect is to export GIT_DIR for
> this command only).
=2E.., but why do only two invocations of git get GIT_DIR=3D"$GIT_DIR" =
and
the other 20+ don't?

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3Dsine+of+%2830+degree%29
