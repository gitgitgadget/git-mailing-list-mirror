From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [PATCH] [TRIVIAL] Change default man page path to /usr/share/man
Date: Tue, 8 May 2007 17:02:20 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070508150220.GA18860@informatik.uni-freiburg.de>
References: <200705081349.34964.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ismail =?iso-8859-1?Q?D=F6nmez?= <ismail@pardus.org.tr>
X-From: git-owner@vger.kernel.org Tue May 08 17:02:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlRCx-00069E-1G
	for gcvg-git@gmane.org; Tue, 08 May 2007 17:02:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934294AbXEHPCZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 8 May 2007 11:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934347AbXEHPCZ
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 11:02:25 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:43364 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934294AbXEHPCY convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 8 May 2007 11:02:24 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1HlRCp-00003y-9x; Tue, 08 May 2007 17:02:23 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l48F2LPf019234;
	Tue, 8 May 2007 17:02:21 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l48F2KPG019233;
	Tue, 8 May 2007 17:02:20 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Ismail =?iso-8859-1?Q?D=F6nmez?= <ismail@pardus.org.tr>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200705081349.34964.ismail@pardus.org.tr>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46585>

Hallo,

Ismail D=F6nmez wrote:
> According to FHS standard default man page path is $prefix/share/man =
[0] ,=20
> attached patch fixes this for GIT.
According to some GNU standard it's $prefix/man.

E.g. autoconf managed projects use $prefix/man if you don't give
--mandir=3D... to configure.

Personally I prefer FHS, so I have=20

	mandir=3D$(prefix)/share/man

in my config.mak.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D72+PS+point+in+inch
