From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH] tests: use $TEST_DIRECTORY to refer to the t/ directory
Date: Sun, 10 Aug 2008 00:53:15 +0200
Message-ID: <489E1FDB.5070700@free.fr>
References: <alpine.DEB.1.00.0808080752210.9611@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.DEB.1.00.0808080754230.9611@pacific.mpi-cbg.de.mpi-cbg.de> <489BF95F.1070000@lsrfire.ath.cx> <7vprojgbbu.fsf@gitster.siamese.dyndns.org> <7vod43etuw.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 10 00:54:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRxKH-00035i-7F
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 00:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752763AbYHIWxS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Aug 2008 18:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752735AbYHIWxS
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 18:53:18 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:59589 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752671AbYHIWxR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 18:53:17 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 71FFF1AB2D1;
	Sun, 10 Aug 2008 00:53:16 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 3602A1AB2D5;
	Sun, 10 Aug 2008 00:53:16 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <7vod43etuw.fsf_-_@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91791>

Junio C Hamano a =E9crit :
>=20
> all the tests still pass, but we would want extra sets of eyeballs on=
 this
> type of change to really make sure.

OK, I read the diff and found some trivial quoting issues that will bre=
ak the
following tests if $TEST_DIRECTORY contain a space:

>  t/t4101-apply-nonl.sh                    |    2 +-
>  t/t5100-mailinfo.sh                      |   18 +++++++++---------
>  t/t7500-commit.sh                        |   16 ++++++++--------

Olivier.
