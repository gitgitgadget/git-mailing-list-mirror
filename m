From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [RFC/PATCH] Bisect: add special treatment for bangs passed to "bisect run".
Date: Tue, 1 May 2007 11:44:03 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070501094403.GA7613@informatik.uni-freiburg.de>
References: <20070501113112.c4b32b55.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio Hamano <junkio@cox.net>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue May 01 11:44:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hiou6-0007SK-Fh
	for gcvg-git@gmane.org; Tue, 01 May 2007 11:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031633AbXEAJoK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 1 May 2007 05:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031634AbXEAJoK
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 05:44:10 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:43147 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1031633AbXEAJoJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 May 2007 05:44:09 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1Hiotz-0007ga-Sq; Tue, 01 May 2007 11:44:08 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l419i4tm007821;
	Tue, 1 May 2007 11:44:04 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l419i3o5007820;
	Tue, 1 May 2007 11:44:03 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Junio Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070501113112.c4b32b55.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45935>

Hallo Christian,

> Something like:
>=20
>  $ git bisect run ! grep string my_file
>=20
> does not work right now, probably because '!' is a shell keyword.

I didn't check you patch in deep, but you should consider that the
special meaning of "!" isn't implemented in the original Bourne
Shell[1].

IIRC this or something similar was brought up some time ago and the
result was, that your script has to do the negation if needed.

Best regards
Uwe

[1] login@~ > uname -a
    SunOS login 5.10 Generic_118833-36 sun4u sparc

    login@~ > /bin/sh -c "! true"
    /bin/sh: !: not found

--=20
Uwe Kleine-K=F6nig

cal 9 1752 | grep 10
