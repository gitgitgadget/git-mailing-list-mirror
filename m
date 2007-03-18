From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [wishlist] graphical diff
Date: Mon, 19 Mar 2007 00:51:45 +0100
Organization: Dewire
Message-ID: <200703190051.46954.robin.rosenberg.lists@dewire.com>
References: <1174223784.5987.6.camel@localhost> <200703181606.20678.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.63.0703182342110.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Raimund Bauer <ray007@gmx.net>, git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 19 00:49:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT58D-00081U-5V
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 00:49:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933564AbXCRXti convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 18 Mar 2007 19:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933541AbXCRXti
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 19:49:38 -0400
Received: from [83.140.172.130] ([83.140.172.130]:7999 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S933564AbXCRXth convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Mar 2007 19:49:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id D73E1802855;
	Mon, 19 Mar 2007 00:44:15 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 19548-04; Mon, 19 Mar 2007 00:44:15 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 8E59A800199;
	Mon, 19 Mar 2007 00:44:13 +0100 (CET)
User-Agent: KMail/1.9.4
In-Reply-To: <Pine.LNX.4.63.0703182342110.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42545>

m=C3=A5ndag 19 mars 2007 00:09 skrev Johannes Schindelin:
> On Sun, 18 Mar 2007, Robin Rosenberg wrote:
> > git diff HEAD^..HEAD | kompare -
>=20
> BTW here, "kompare -" does not work as expected. It shows an empty di=
ff.=20
I think that's what the older kompare did. That why mentioned that you =
need the
verson from 3.5.5, or even 3.5.6 for this to work.

> At any rate, have you tried something like "GIT_PAGER=3D'kompare -' g=
it diff=20
> HEAD^..HEAD"?
Doesn't work here. Shows empty diff...

but AH, that's because of the colored-diff settings. I you have color.d=
iff or color.status
set to true neither version will work. With auto the first one will, bu=
t not the second.=20

-- robin
