From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] Implement safe_strncpy() as strlcpy() and use it more.
Date: Sun, 11 Jun 2006 13:17:43 +0200
Message-ID: <448BFBD7.60900@lsrfire.ath.cx>
References: <20060611100628.GA10430@bohr.gbar.dtu.dk> <20060611.191540.68073375.yoshfuji@linux-ipv6.org> <20060611103358.GB10430@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 11 13:17:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpNx0-0003pf-7m
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 13:17:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWFKLRr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 11 Jun 2006 07:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbWFKLRr
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 07:17:47 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:63642
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1750774AbWFKLRq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jun 2006 07:17:46 -0400
Received: from [10.0.1.3] (p508E63B4.dip.t-dialin.net [80.142.99.180])
	by neapel230.server4you.de (Postfix) with ESMTP id 7F2131015;
	Sun, 11 Jun 2006 13:17:45 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
To: Peter Eriksen <s022018@student.dtu.dk>
In-Reply-To: <20060611103358.GB10430@bohr.gbar.dtu.dk>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21646>

Peter Eriksen schrieb:
> On Sun, Jun 11, 2006 at 07:15:40PM +0900, YOSHIFUJI Hideaki / ?$B5HF#=
1QL@ wrote:
>> In article <20060611100628.GA10430@bohr.gbar.dtu.dk> (at Sun, 11 Jun=
 2006 12:06:28 +0200), "Peter Eriksen" <s022018@student.dtu.dk> says:
>>
>>> I've taken strlcpy() from the OpenBSD CVS without attribution.  Is =
this
>>> allowed?  If it is, how should it be stated?
>> Please include full copyright information.
>=20
> Where should this information go?  Just above the function
> safe_strncpy(), or at the top of path.c?  I believe path.c is GPL, so
> can this be mixed freely with BSD licensed code?  Should I put
> safe_strncpy() into a seperate file as with strlcpy()?

Yes...  Or you could avoid all of this by using a GPL'd version, like
the one from the Linux kernel (in lib/string.c).

Ren=E9
