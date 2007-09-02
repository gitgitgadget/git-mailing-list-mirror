From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Add a new lstat implementation based on Win32 API, and make stat use that implementation too.
Date: Mon, 3 Sep 2007 00:04:33 +0200
Message-ID: <200709030004.33963.robin.rosenberg.lists@dewire.com>
References: <46DACD93.9000509@trolltech.com> <200709022228.00733.robin.rosenberg.lists@dewire.com> <20070902213856.GB2756@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 00:03:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRxXV-0008Bf-Be
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 00:03:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753945AbXIBWDE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 2 Sep 2007 18:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753931AbXIBWDE
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 18:03:04 -0400
Received: from [83.140.172.130] ([83.140.172.130]:19325 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753323AbXIBWDD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 18:03:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id B1CC2802866;
	Sun,  2 Sep 2007 23:55:07 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 01860-06; Sun,  2 Sep 2007 23:55:07 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 52BE7802849;
	Sun,  2 Sep 2007 23:55:07 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <20070902213856.GB2756@steel.home>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57394>

s=F6ndag 02 september 2007 skrev Alex Riesen:
> Robin Rosenberg, Sun, Sep 02, 2007 22:27:59 +0200:
> > s=F6ndag 02 september 2007 skrev Marius Storm-Olsen:
> > > (Also, since Windows doesn't really handle symlinks, it's fine th=
at stat just uses lstat)
> >=20
> > It does now: See http://msdn2.microsoft.com/en-us/library/aa363866.=
aspx
> >=20
>=20
> Except they fscked it up, as usual for microsoft: it 's got a
> mandatory argument specifying what the target should be, file or
> directory. And they don't tell what happens when the argument is wron=
g
> or the target does not exists. Typical, too.

Why would this API be an exception?

-- robin
