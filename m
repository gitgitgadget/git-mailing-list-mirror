From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [PATCH] Documentation: "bisect run" can be given bangs before the run script.
Date: Thu, 3 May 2007 09:03:02 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070503070302.GA4491@informatik.uni-freiburg.de>
References: <20070503070607.fa2ffe92.chriscool@tuxfamily.org> <7vmz0m3261.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 03 09:03:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjVLO-0003Sf-6c
	for gcvg-git@gmane.org; Thu, 03 May 2007 09:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbXECHDK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 3 May 2007 03:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753520AbXECHDK
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 03:03:10 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:63608 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751571AbXECHDI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 May 2007 03:03:08 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1HjVLG-0001S8-Un; Thu, 03 May 2007 09:03:07 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l43733CK004679;
	Thu, 3 May 2007 09:03:03 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l43732O7004678;
	Thu, 3 May 2007 09:03:02 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Junio C Hamano <junkio@cox.net>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vmz0m3261.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46072>

Hello,

Junio C Hamano wrote:
> I am not convinced that '!' is a good extension for two and half
> reasons.
>=20
>  * The expected use is not quite clear.  If it is not used to
>    run a custom test script but something stock as "make", by
>    the nature of UNIX exit status convention, you are looking
>    for the commit that _fixed_ some breakage (i.e. "which commit
>    fixed the compilation error?").  While sometimes that is a
>    useful thing to do, it feels somewhat of limited value.
>=20
>    On the other hand, if you are running a custom test script, I
>    do not think it is unreasonable to always require that a test
>    script to signal "bad" with small non-zero, "good" with zero,
>    and error with high non-zero status, as we already do.
>=20
>  * How should this interact with the "high non-zero status means
>    an error and we cannot bisect" return convention?
>=20
>  * I was hoping that we can officially support "don't know,
>    cannot test this one, please give me another" for interactive
>    use, and at the same time allow the run-script used by
>    "git bisect run" to signal such with a special exit value
>    (perhaps "exit 42").  Taken together with the previous point,
>    it is not clear how '!' should interact with such an
>    enhancement.
Ack for all 2=BD reasons.

Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D1+newton+in+kg*m+%2F+s%5E2
