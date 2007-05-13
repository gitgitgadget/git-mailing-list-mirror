From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: ~ and ^
Date: Sun, 13 May 2007 22:31:02 +0200
Organization: Dewire
Message-ID: <200705132231.03180.robin.rosenberg.lists@dewire.com>
References: <20070513144442.b3cba792.seanlkml@sympatico.ca> <7v8xbssfti.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sean <seanlkml@sympatico.ca>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 13 22:31:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnKiz-0001Z9-3E
	for gcvg-git@gmane.org; Sun, 13 May 2007 22:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754154AbXEMUa6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 13 May 2007 16:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755066AbXEMUa6
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 16:30:58 -0400
Received: from [83.140.172.130] ([83.140.172.130]:22101 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754154AbXEMUa5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 May 2007 16:30:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 967F78028BD;
	Sun, 13 May 2007 22:24:46 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 03806-07; Sun, 13 May 2007 22:24:46 +0200 (CEST)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 416DB80264D;
	Sun, 13 May 2007 22:24:46 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <7v8xbssfti.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47179>

s=F6ndag 13 maj 2007 skrev Junio C Hamano:
> Sean <seanlkml@sympatico.ca> writes:
>=20
> > Would it be possible/reasonable to treat a bare ~3 (or ^) on the gi=
t command
> > line as equivalent to "<current branch>~3" ?    At least @{3} alrea=
dy works
> > this way and it would be nice to do the same for the even more comm=
on tilde
> > and hat operations.  If so, it would be a small convenience to just=
 type:
> > "git show ~3"
>=20
> Interesting.
>=20
> At least, "ls ~0" does not seem to get confused by bash to be
> the home directory of the root user, so I do not offhand think
> of a reason not to have ~$n as a synonym to HEAD~$n.  Would that
> be useful?  I dunno.

~0 is my current directory in bash.

$ echo ~0
/home/me/tmp

-- robin
