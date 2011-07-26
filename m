From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: ls-tree with non-english characters
Date: Tue, 26 Jul 2011 12:39:27 +0200
Message-ID: <20110726103927.GA31625@goldbirke>
References: <4E2E8B33.6070900@intland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tajti =?iso-8859-1?Q?=C1kos?= <akos.tajti@intland.com>
X-From: git-owner@vger.kernel.org Tue Jul 26 12:39:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qlf31-0004WD-P4
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 12:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752284Ab1GZKjb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jul 2011 06:39:31 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:62978 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211Ab1GZKja (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 06:39:30 -0400
Received: from localhost6.localdomain6 (p5B1315A4.dip0.t-ipconnect.de [91.19.21.164])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0LmeI7-1RKRpj1QXb-00ZThl; Tue, 26 Jul 2011 12:39:28 +0200
Content-Disposition: inline
In-Reply-To: <4E2E8B33.6070900@intland.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:t6jUYbAjCid4HCANsOlL/Bi2u4L1dcudTph2urHiO6B
 Pp1jFxv5ZMpoXeMNO8z4YUxoF1XAzQgZthwhAbAd7NOvnjuqZd
 qy1LDsFfQuVnRI3/Mm/bj93UC/bZnvtUAIWUk1n89zxYuqA8xl
 7DP0yINCY+T0ArKTXCrbAnQ7tvWCRm7qqwzbZDWLrlx8fgDeGj
 BiA20PS5z1KKvMh/UJ2Ww==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177854>

Szervusz =C3=81kos,


On Tue, Jul 26, 2011 at 11:38:59AM +0200, Tajti =C3=81kos wrote:
> I tried to use git ls-tree but on blob names containing non-english
> characters I get a strange output. For example:
>=20
> =C3=A1kos=C5=B1 -> \303\241kos\305\261
>=20
> There's no mention of this format in the manual of ls-tree. Could you=
 please
> help me on resolving this cryptic string to the original form?

Try with the -z option, it seems to do more than the documentation
suggests:

  $ git ls-tree HEAD
100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391	"\303\241rv\303\25=
5zt\305\261r\305\221"
  $ git ls-tree -z HEAD
100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391	=C3=A1rv=C3=ADzt=C5=
=B1r=C5=91


G=C3=A1bor
