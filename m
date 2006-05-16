From: Tommi Virtanen <tv@inoi.fi>
Subject: Re: git-svn vs. $Id$
Date: Tue, 16 May 2006 21:12:08 +0300
Organization: Inoi
Message-ID: <446A15F8.3040106@inoi.fi>
References: <446A0CCF.2060903@inoi.fi> <Pine.LNX.4.64.0605161037220.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 16 20:12:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fg41o-0000OK-G7
	for gcvg-git@gmane.org; Tue, 16 May 2006 20:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbWEPSMN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 16 May 2006 14:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbWEPSMN
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 14:12:13 -0400
Received: from i1.inoi.fi ([194.100.97.46]:21158 "EHLO mail.inoi.fi")
	by vger.kernel.org with ESMTP id S932469AbWEPSMN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 May 2006 14:12:13 -0400
Received: from mail.inoi.fi (localhost.localdomain [127.0.0.1])
	by mail.inoi.fi (Postfix) with ESMTP id 78F40AC04D;
	Tue, 16 May 2006 21:12:44 +0300 (EEST)
Received: from [10.116.0.186] (GMMDXXVII.dsl.saunalahti.fi [85.76.242.28])
	by mail.inoi.fi (Postfix) with ESMTP id 3D273AC02B;
	Tue, 16 May 2006 21:12:44 +0300 (EEST)
User-Agent: Mail/News 1.5 (X11/20060309)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605161037220.3866@g5.osdl.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20132>

Linus Torvalds wrote:
> Isn't there some flag to svn to avoid keyword expansion, like "-ko" t=
o=20
> CVS?
>=20
> Any import script definitely should avoid keyword expansion (and that=
's=20
> true whether you end up wanting to use keywords or not).

Well, yes, I agree. But, at least git-svn.txt says this:

BUGS
----
=2E..
svn:keywords can't be ignored in Subversion (at least I don't know of
a way to ignore them).

I guess one might be able to reach that information through the svn API=
=2E

Or just propget svn:keywords and sed s/\$Id\(:[^$]*\)\$/$Id$/ all files
with keywords, for all relevant keywords. Eww.

--=20
Inoi Oy, Tykist=F6katu 4 D (4. krs), FI-20520 Turku, Finland
http://www.inoi.fi/
Mobile +358 40 762 5656
