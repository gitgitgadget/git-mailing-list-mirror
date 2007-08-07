From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: git-sh-setup.sh:cd_to_toplevel problematic with symlinks
Date: Tue, 7 Aug 2007 14:45:26 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070807124526.GA11230@informatik.uni-freiburg.de>
References: <20070806161045.GA21815@moooo.ath.cx> <20070806211238.GA27363@informatik.uni-freiburg.de> <20070807101155.GA19233@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Tue Aug 07 14:46:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIORg-0003Jr-Ga
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 14:45:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759146AbXHGMpf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 7 Aug 2007 08:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759247AbXHGMpf
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 08:45:35 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:48797 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751032AbXHGMpe (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Aug 2007 08:45:34 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1IIORI-0003LM-DM; Tue, 07 Aug 2007 14:45:32 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l77CjQCE012273;
	Tue, 7 Aug 2007 14:45:26 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l77CjQep012272;
	Tue, 7 Aug 2007 14:45:26 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070807101155.GA19233@moooo.ath.cx>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello Matthias,

Matthias Lederhofer wrote:
> Your mail did not make it to the list, therefore I quote the full
> mail.
Ops, thanks.

> Uwe Kleine-K=F6nig <ukleinek@informatik.uni-freiburg.de> wrote:
> > > Is there any way to tell cd to ignore $PWD?
> > cd -P ... does the trick.  IIRC it's in SUSv3, but once more, Solar=
is
> > /bin/sh doesn't know about that option:
> >=20
[...]
>=20
> Do we care about that shell?  There was another thread about shell
> script cleanup where the default sun /bin/sh doesn't support some
> other features from the git shell scripts too.
Ah, I see, Makefile defines SHELL_PATH for SunOS to /bin/bash anyhow.

OK, then maybe just use it and if it breaks for someone we will notice
it ...

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D12+mol+in+dozen
