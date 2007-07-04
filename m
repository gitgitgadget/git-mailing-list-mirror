From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [PATCH] gitk: fix for "gitk <ambiguous-name> --"
Date: Wed, 4 Jul 2007 10:38:49 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070704083849.GA6970@informatik.uni-freiburg.de>
References: <20070703202301.GA24071@informatik.uni-freiburg.de> <Pine.LNX.4.64.0707032248570.4071@racer.site> <alpine.LFD.0.98.0707031514160.9434@woody.linux-foundation.org> <Pine.LNX.4.64.0707032353330.4071@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Mackerras <paulus@samba.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 04 10:39:03 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I60O4-0007or-UU
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 10:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756565AbXGDIi6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 4 Jul 2007 04:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756359AbXGDIi6
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 04:38:58 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:36237 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755901AbXGDIi5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jul 2007 04:38:57 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1I60O0-0001Il-F6; Wed, 04 Jul 2007 10:38:56 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l648cseS007385;
	Wed, 4 Jul 2007 10:38:54 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l648cnNv007384;
	Wed, 4 Jul 2007 10:38:49 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Paul Mackerras <paulus@samba.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707032353330.4071@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51583>

Hello Johannes,

> If you have an ambiguous ref, i.e. a file in the working directory be=
ars
> the same name, you have to use "--" at the end to disambiguate ref fr=
om
> file. This works with "git rev-list". Make it work with gitk, too.

This fixes only one half of the problem.  Now=20

	gitk fixes ^linus/master --

works fine, but=20

	gitk fixes ^linus/master

still hangs. =20

I didn't try Gerrits patch yet.

BTW, I don't use a range, because originally I used something like:

	git branch | cut -b3- | grep -v ^attic/ | xargs gitk ^linus/master

Now I have to think how I can add the ending "--" ...

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

5 out of 4 people have trouble with fractions.
