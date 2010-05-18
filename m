From: Yann Droneaud <yann@droneaud.fr>
Subject: Re: [PATCH] t9129: fix UTF-8 locale detection
Date: Tue, 18 May 2010 22:37:54 +0200
Message-ID: <1274215074.16337.4.camel@localhost>
References: <1274193685-5468-1-git-send-email-yann@droneaud.fr>
	 <4BF2BABC.2010405@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue May 18 22:38:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OETYJ-0006nD-9F
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 22:38:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753560Ab0ERUiF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 May 2010 16:38:05 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:56297 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751434Ab0ERUiC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 May 2010 16:38:02 -0400
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 298D6E08096;
	Tue, 18 May 2010 22:37:56 +0200 (CEST)
Received: from mais.quest-ce.net (mais.quest-ce.net [88.161.129.79])
	by smtp6-g21.free.fr (Postfix) with ESMTP;
	Tue, 18 May 2010 22:37:55 +0200 (CEST)
Received: by mais.quest-ce.net (Postfix, from userid 500)
	id E76BD7C0B4; Tue, 18 May 2010 22:37:54 +0200 (CEST)
In-Reply-To: <4BF2BABC.2010405@drmicha.warpmail.net>
X-Mailer: Evolution 2.26.3-1.1mdv2009.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147308>

Le mardi 18 mai 2010 =C3=A0 18:05 +0200, Michael J Gruber a =C3=A9crit =
:
> Yann Droneaud venit, vidit, dixit 18.05.2010 16:41:

> This is on Fedora 13, which is not exactly exotic. What is your syste=
m?

I've tested on:
 - FreeBSD 8.0
 - NetBSD 5.0.1
 - OpenSolaris 2009.06

and none of these systems report en_US.utf8 in locale -a, they're all
reporting en_US.UTF-8

Regards

--=20
Yann
