From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git blame not respecting --find-copies-harder ?
Date: Wed, 30 Jul 2008 17:01:23 +0200
Message-ID: <20080730150123.GB9758@atjola.homenet>
References: <20080730093903.GA14330@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailinglist <git@vger.kernel.org>
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Jul 30 17:03:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KODC7-0001RO-UK
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 17:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548AbYG3PB1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Jul 2008 11:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751934AbYG3PB1
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 11:01:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:49142 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751260AbYG3PB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 11:01:26 -0400
Received: (qmail invoked by alias); 30 Jul 2008 15:01:25 -0000
Received: from i577B93CF.versanet.de (EHLO atjola.local) [87.123.147.207]
  by mail.gmx.net (mp066) with SMTP; 30 Jul 2008 17:01:25 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+LpGw5qO6LMANR1rtPw2bh/kJzokmQBiW/0UObji
	QJMIfiiANP6Vfx
Content-Disposition: inline
In-Reply-To: <20080730093903.GA14330@cuci.nl>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90800>

On 2008.07.30 11:39:03 +0200, Stephen R. van den Berg wrote:
> git clone git://git.cuci.nl/pike
>=20
> Both of this "git blame" commands return the same (erroneous) results
> at the end of the files (the last lines are older, and are from the o=
ld
> README file next to it).
>=20
> git blame README-CVS
> git blame --find-copies-harder README-CVS

git blame doesn't know --find-copies-harder, it's -C -C for blame.

Bj=F6rn
