From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: Conflict editing
Date: Mon, 5 Mar 2007 16:07:28 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070305150728.GB17844@informatik.uni-freiburg.de>
References: <Pine.LNX.4.63.0703041339350.22628@wbgn013.biozentrum.uni-wuerzburg.de> <190CCFDA-7BCC-4CC9-81D5-F38B14D8D54D@silverinsanity.com> <Pine.LNX.4.63.0703051223420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brian Gernhardt <benji@silverinsanity.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 05 16:08:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOEnX-0002Lb-37
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 16:08:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933515AbXCEPHi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 5 Mar 2007 10:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933517AbXCEPHi
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 10:07:38 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:61519 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933515AbXCEPHh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Mar 2007 10:07:37 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1HOEmm-0003Kc-Bt; Mon, 05 Mar 2007 16:07:36 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l25F7TrB018227;
	Mon, 5 Mar 2007 16:07:29 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l25F7SbC018226;
	Mon, 5 Mar 2007 16:07:28 +0100 (MET)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Brian Gernhardt <benji@silverinsanity.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0703051223420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41449>

Hello,

Johannes Schindelin wrote:
> > > Of course, this script is dumb and has no way to edit files whose=
=20
> > > names contain spaces
> >=20
> > Wouldn't using xargs fix that?
>=20
> I tried that first, even in the proper form to catch newlines also, w=
ith=20
> "-z" for ls-files and "-0" for xargs.
>=20
> Alas, vi complained to me by saying "Not started from a terminal", an=
d=20
> wrecking my terminal settings. For example, echo was set to off, and=20
> Ctrl+C no longer worked.
Another problem is, that only GNU xargs has -0, the version on Solaris
(and probably on *BSD) doesn't know it.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3Dgigabyte+in+bit
