From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: "bash: git-upload-pack: command not found" ??
Date: Thu, 6 Mar 2008 13:47:10 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20080306124710.GA10266@informatik.uni-freiburg.de>
References: <20080306110600.GA925@cs-wsok.swansea.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
X-From: git-owner@vger.kernel.org Thu Mar 06 13:48:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXFW8-0008Ri-3o
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 13:48:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757068AbYCFMre convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Mar 2008 07:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756796AbYCFMre
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 07:47:34 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:53849 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753936AbYCFMrd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Mar 2008 07:47:33 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1JXFVU-0005l3-82; Thu, 06 Mar 2008 13:47:32 +0100
Received: from zeisberg by login.informatik.uni-freiburg.de with local (Exim 4.63)
	(envelope-from <zeisberg@login.informatik.uni-freiburg.de>)
	id 1JXFV8-0003F7-N6; Thu, 06 Mar 2008 13:47:10 +0100
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Oliver Kullmann <O.Kullmann@swansea.ac.uk>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20080306110600.GA925@cs-wsok.swansea.ac.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76389>

Hello,

Oliver Kullmann wrote:
> Hello,
>=20
> when using
>=20
> Transitional> git pull ssh://user@host.xz/~/path/to/Transitional mast=
er
>=20
> on a remote machine I get
>=20
> Password:
> bash: git-upload-pack: command not found
> fatal: The remote end hung up unexpectedly
Where is git-upload-pack on the server machine?  Where do you set your
PATH to include $(basedir git-upload-pack).  Does=20

	git pull --upload-pack /path/to/git-upload-pack ...

help?

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

