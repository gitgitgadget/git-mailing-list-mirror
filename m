From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 3/5] pretty describe: move library functions to the new
 file describe.c
Date: Sun, 04 Nov 2007 15:56:00 +0100
Message-ID: <472DDD80.2010203@lsrfire.ath.cx>
References: <472DB199.2040305@lsrfire.ath.cx> <Pine.LNX.4.64.0711041435540.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 04 15:56:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iogtz-0007ps-K6
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 15:56:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758968AbXKDO4V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Nov 2007 09:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759102AbXKDO4V
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 09:56:21 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:46675
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758968AbXKDO4U (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Nov 2007 09:56:20 -0500
Received: from [10.0.1.201] (p57B7F8A7.dip.t-dialin.net [87.183.248.167])
	by neapel230.server4you.de (Postfix) with ESMTP id F0A8A873BA;
	Sun,  4 Nov 2007 15:56:17 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0711041435540.4362@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63414>

Johannes Schindelin schrieb:
> Hi,
>=20
> On Sun, 4 Nov 2007, Ren? Scharfe wrote:
>=20
>>  Makefile           |    2 +-
>>  builtin-describe.c |  202 -----------------------------------------=
----------
>>  cache.h            |    5 ++
>>  describe.c         |  204 +++++++++++++++++++++++++++++++++++++++++=
+++++++++++
>>  4 files changed, 210 insertions(+), 203 deletions(-)
>>  create mode 100644 describe.c
>=20
> Would not "format-patch -C -C" have given a nicer output?

Yes, it would have been shorter, but it looks a bit strange, because it=
's
deleting stuff from the new file describe.c (i.e. all the things left i=
n
builtin-describe.c):

 Makefile                         |    2 +-
 builtin-describe.c               |  202 ------------------------------=
--------
 cache.h                          |    5 +
 builtin-describe.c =3D> describe.c |   85 ----------------
 4 files changed, 6 insertions(+), 288 deletions(-)
 copy builtin-describe.c =3D> describe.c (66%)

That's 367 lines of patch + stat vs. 470 lines for the one I sent.  Wil=
l
use next time.

Thanks,
Ren=E9
