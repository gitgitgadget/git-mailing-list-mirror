From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Mon, 12 Feb 2007 01:14:21 +0100
Organization: Dewire
Message-ID: <200702120114.21477.robin.rosenberg.lists@dewire.com>
References: <45CFA30C.6030202@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@verizon.net>
X-From: git-owner@vger.kernel.org Mon Feb 12 01:13:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGOp3-0004Ga-9W
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 01:13:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbXBLANY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 11 Feb 2007 19:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbXBLANY
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 19:13:24 -0500
Received: from [83.140.172.130] ([83.140.172.130]:20795 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750950AbXBLANT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Feb 2007 19:13:19 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id CB2F7803395;
	Mon, 12 Feb 2007 01:08:27 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 15019-06; Mon, 12 Feb 2007 01:08:27 +0100 (CET)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 71B1F80338F;
	Mon, 12 Feb 2007 01:08:27 +0100 (CET)
User-Agent: KMail/1.9.4
In-Reply-To: <45CFA30C.6030202@verizon.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39341>

m=E5ndag 12 februari 2007 00:13 skrev Mark Levedahl:
> The recent threads on a mingw git port are explicit in the intent to=20
> provide a Windows native git. I believe there is a fundamental confli=
ct=20
> here with the position, clearly stated by Linus, that git does not al=
ter=20
> content in any way. Windows suffers the curse of DOS line endings (\r=
\n=20
> vs \n), and a true port to Windows *must* allow for \r\n and \n to be=
=20
> semantically the same thing as most large projects end up with a mixt=
ure=20
> of such files and/or are targeting cross-platform capabilities. The=20
> major competing solutions git seeks to supplant (cvs, cvsnt, svn, hg)=
=20
> have capability to recognize "text" files and transparently replace \=
r\n=20
> with \n on input, the reverse on output, and ignore all such differen=
ces=20
> on diff operations. To be relevant on native Windows, git must do the=
=20
> same. Otherwise, git will be deemed "too wierd" and dismissed in favo=
r=20
> of a tool "that works."
>=20
As of today git is a posix tool simply because it's not fully ported to
other enviromnents. I brought this up quite a time ago, and didn't face=
 heavy artillery
then, and wouldn't today either. The code is still missing though. I di=
dn't=20
write it then, because it's my #1 priority and nobody else did. Linus e=
ven did a=20
rough scetch, but that's it.=20

I guess git will get this feature when someone does the code for it.

-- robin
