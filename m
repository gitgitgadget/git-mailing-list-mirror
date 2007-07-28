From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: git-svn rebase screwing up commit messages
Date: Sat, 28 Jul 2007 21:48:12 +0200
Message-ID: <200707282148.13751.robin.rosenberg.lists@dewire.com>
References: <724DFB31-0471-4A5E-95DF-F5F74876AC77@lrde.epita.fr> <20070728092914.48f6305c.seanlkml@sympatico.ca> <7vk5skps1g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sean <seanlkml@sympatico.ca>, Benoit SIGOURE <tsuna@lrde.epita.fr>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 21:47:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEsG2-0004Qx-5K
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 21:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753242AbXG1TrG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 28 Jul 2007 15:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753328AbXG1TrF
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 15:47:05 -0400
Received: from [83.140.172.130] ([83.140.172.130]:28369 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752953AbXG1TrE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 15:47:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 2A57F8026E8;
	Sat, 28 Jul 2007 21:39:42 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 16201-08; Sat, 28 Jul 2007 21:39:41 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id CA6CB8026DD;
	Sat, 28 Jul 2007 21:39:41 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <7vk5skps1g.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54055>

l=F6rdag 28 juli 2007 skrev Junio C Hamano:
> Sean <seanlkml@sympatico.ca> writes:
>=20
> >> Having said all that, so that the readers understand the
> >> background, here is a not-so-heavily-tested patch, which might
> >> help.  It passes all the test suite as before, but that tells
> >> how existing git-svn tests do not test many things.
> >>=20
> >> I am not considering this for inclusion right now, by the way.
> >
> > FWIW your patch fixed my test case here.
>=20
> Actually the patched behaviour actively encourages a bad (not in
> the sense that those oneline tools will not work well, but in
> the sense that these messages are reader unfriendly) practice; I
> do not think what the patch did deserves to be called "fixed".

git-svn should not enforce git conventions when managing commits
intended for svn. Those commits should obviously follow the conventions
for the target (svn) repo.=20

-- robin
