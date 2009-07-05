From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git diff infinite loop at attempt to diff two specific commits
Date: Sun, 5 Jul 2009 20:12:08 +0200
Message-ID: <20090705181208.GA8629@atjola.homenet>
References: <b33ba6660907051037ve9e4176s2a1edbda8af4068f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alexander Toresson <alexander.toresson@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 05 20:12:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNWCP-0001kf-DM
	for gcvg-git-2@gmane.org; Sun, 05 Jul 2009 20:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753190AbZGESMJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Jul 2009 14:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752495AbZGESMI
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jul 2009 14:12:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:41731 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752716AbZGESMH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jul 2009 14:12:07 -0400
Received: (qmail invoked by alias); 05 Jul 2009 18:12:09 -0000
Received: from i59F5BC2C.versanet.de (EHLO atjola.local) [89.245.188.44]
  by mail.gmx.net (mp015) with SMTP; 05 Jul 2009 20:12:09 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/XteRj7I/X1UcrNpzOWFrWyY08VsRf6kRItQ5qsw
	FK0/QXmW2ReLpr
Content-Disposition: inline
In-Reply-To: <b33ba6660907051037ve9e4176s2a1edbda8af4068f@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122743>

On 2009.07.05 19:37:44 +0200, Alexander Toresson wrote:
> Hello,
>=20
> I've got problems with git diff, it hangs in an infinite loop when
> attempting to generate a diff between two specific commits. Commands
> to reproduce:
>=20
> git clone git://eulex.zapto.org/nightfall.git
> cd nightfall
> git diff --stat 597711..61a139
>=20
> (Note that the clone needs to fetch 16mb)
>=20
> I'm running git 1.6.3.3.

=46WIW, it "hangs" on the save.xml file. The old version is 1.2M, the n=
ew
one is 9M. Using the patience diff algorithm to compare them takes abou=
t
5 seconds here, while the default algorithm took 6m15s.

HTH
Bj=F6rn
