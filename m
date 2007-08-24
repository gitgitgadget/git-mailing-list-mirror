From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: name-rev does not show the shortest path
Date: Fri, 24 Aug 2007 14:52:30 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070824125230.GA12030@informatik.uni-freiburg.de>
References: <20070823103817.GF6573@informatik.uni-freiburg.de> <Pine.LNX.4.64.0708241253050.8987@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Fri Aug 24 14:53:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOYex-0004C8-SO
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 14:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765418AbXHXMwi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 24 Aug 2007 08:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764848AbXHXMwh
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 08:52:37 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:58030 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932898AbXHXMwd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Aug 2007 08:52:33 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1IOYeO-0006vI-Jr; Fri, 24 Aug 2007 14:52:32 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l7OCqVZu012247;
	Fri, 24 Aug 2007 14:52:31 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l7OCqUor012246;
	Fri, 24 Aug 2007 14:52:30 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708241253050.8987@reaper.quantumfyre.co.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56573>

Hello Julian,

Julian Phillips wrote:
> On Thu, 23 Aug 2007, Uwe Kleine-K=F6nig wrote:
> >I want to check to which kernel version I need to upgrade to get a
> >certain feature.  For my case it was introduced in 0567a0c022d5b.
> >
> >	zeisberg@cassiopeia:~/gsrc/linux-2.6$=20
> >	rev=3D0567a0c022d5b343370a343121f38fd89925de55
> >
> >	zeisberg@cassiopeia:~/gsrc/linux-2.6$ git name-rev --tags $rev
> >	0567a0c022d5b343370a343121f38fd89925de55 tags/v2.6.22~1686^2~1^3~5
> >
> >	zeisberg@cassiopeia:~/gsrc/linux-2.6$ git name-rev --refs=3D*-rc1 $=
rev
> >	0567a0c022d5b343370a343121f38fd89925de55=20
> >	tags/v2.6.22-rc1~1009^2~1^3~5
> >
> >I don't now the underlaying algorithm, maybe it's to get a short str=
ing?
> >
> >Anyhow I want to know the earliest tag that includes this patch?  Is
> >there something I missed?
> >
> >I remember there was a similar discussion regarding describe.
>=20
> git describe --contains 0567a0c022d5b
>=20
> probably a 1.5.3 feature? (certainly doesn't exist in 1.5.2.2)
That command says v2.6.22~1686^2~1^3~5, too.  That is, it doesn't use
the "older" v2.6.22-rc1 tag as a basis.

Best regards
Uwe


--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D1+degree+celsius+in+kelvin
