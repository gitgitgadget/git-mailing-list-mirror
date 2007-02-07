From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Subject: Re: Deprecation/Removal schedule
Date: Wed, 07 Feb 2007 10:33:11 +0100
Message-ID: <20070207093311.258490@gmx.net>
References: <7v8xfdnlqm.fsf@assigned-by-dhcp.cox.net>
 <7vsldibfva.fsf@assigned-by-dhcp.cox.net>
 <200702070933.21804.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: ae@op5.se, torvalds@linux-foundation.org, mdw@distorted.org.uk,
	peff@peff.net, raa.lkml@gmail.com, spearce@spearce.org,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Feb 07 10:33:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEjB5-0003gY-Mm
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 10:33:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161095AbXBGJdP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 7 Feb 2007 04:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161092AbXBGJdO
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 04:33:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:32895 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161082AbXBGJdM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 04:33:12 -0500
Received: (qmail 15344 invoked by uid 0); 7 Feb 2007 09:33:11 -0000
Received: from 84.153.71.238 by www116.gmx.net with HTTP;
 Wed, 07 Feb 2007 10:33:11 +0100 (CET)
In-Reply-To: <200702070933.21804.jnareb@gmail.com>
X-Authenticated: #1490710
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38901>

Hi,

Jakub wrote:

> Junio C Hamano wrote:
>=20
> > In 1.5.0, you will still see git-resolve and git-diff-stages,
> > but they will be removed by 1.5.1.
>=20
> Well, it is not as if we cannot obtain equivalent of git-diff-stages
> without this command. Stages are <ours>, <theirs> and <ancestor>
> (git-merge-base <ours> <theirs>) so I think we can use git-diff-tree
> with appropriate arguments...

Not exactly. The stages are in the index. For example, when you have co=
nflicts, the stages might not reflect _any_ tree at all! This is becaus=
e _part_ of the changes could be merged, and _part_ of the changes conf=
lict.

But it does not matter anyway. Good bye diff-stages!

Ciao,
Dscho

--=20
Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!=20
Ideal f=FCr Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
