From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: git cvsimport fails noisily if cvs has no server support
Date: Sun, 3 Feb 2008 19:08:27 +0100
Message-ID: <200802031908.28115.robin.rosenberg.lists@dewire.com>
References: <47A5DD98.6000606@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jean-Luc Herren <jlh@gmx.ch>
X-From: git-owner@vger.kernel.org Sun Feb 03 19:08:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLjGz-0003U4-Gd
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 19:08:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757044AbYBCSIY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Feb 2008 13:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755309AbYBCSIY
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 13:08:24 -0500
Received: from [83.140.172.130] ([83.140.172.130]:29018 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1756739AbYBCSIX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 13:08:23 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id CB15B800688;
	Sun,  3 Feb 2008 19:08:21 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bzdOXQ9QC0ri; Sun,  3 Feb 2008 19:08:21 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 49DC0800687;
	Sun,  3 Feb 2008 19:08:21 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <47A5DD98.6000606@gmx.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72387>

s=F6ndagen den 3 februari 2008 skrev Jean-Luc Herren:
> Hello list!
>=20
> cvs (1.12.12) can be compiled with --disable-server to omit
> support for cvs servers.  Although this is not ./configure's
> default, it was the default on my distro (gentoo).  git-cvsimport
> fails loudly as pasted below (note that this command is part of
> the test t9600-cvsimport.sh).  Nicer behavior would of course be
> to detect the situation and inform the user that server support is
> missing (and to skip the test).
>=20
> jlh
>=20
> $ git-cvsimport -a -z 0 -C module-git module

I'm guessing now, but try -Z '--cvs-direct'.

-- robin
