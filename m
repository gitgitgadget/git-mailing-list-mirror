From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] git gc --auto: defer on battery
Date: Mon, 31 Mar 2008 02:00:12 +0200
Message-ID: <20080331000012.GB23259@atjola.homenet>
References: <20080330231408.GR11666@genesis> <20080330232612.GA23063@atjola.homenet> <alpine.LFD.1.00.0803301645020.14670@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Mar 31 02:04:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jg7VL-0000y3-HY
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 02:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753559AbYCaAAS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Mar 2008 20:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753504AbYCaAAR
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 20:00:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:59153 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753394AbYCaAAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2008 20:00:16 -0400
Received: (qmail invoked by alias); 31 Mar 2008 00:00:14 -0000
Received: from i577ADF86.versanet.de (EHLO atjola.local) [87.122.223.134]
  by mail.gmx.net (mp009) with SMTP; 31 Mar 2008 02:00:14 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+r4Ph7RdGrLOzrQncwjJ4PYrTJIaPK0biyVM6JeJ
	os3mtLaqjRIVbq
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0803301645020.14670@woody.linux-foundation.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78534>

On 2008.03.30 16:46:51 -0700, Linus Torvalds wrote:
>=20
>=20
> On Mon, 31 Mar 2008, Bj?rn Steinbrink wrote:
> >=20
> > The /proc stuff is already deprecated IIRC, the new file to check o=
n
> > Linux is /sys/class/power_supply/AC/online.
>=20
> I would *seriously* suggest making this soem kind of generic callback=
 and=20
> not Linux-specific.=20

I didn't meant to make that Linux-specific, I just wanted to mention
that the /proc stuff might break rather "soon", and that the code shoul=
d
also check the the sysfs stuff.

> How about making it more akin to a pre-auto-gc "hook" - run a script=20
> instead of hardcoding something like this!

Sounds nice.

Bj=F6rn
