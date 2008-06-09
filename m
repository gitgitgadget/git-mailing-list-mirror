From: Olivier Marin <dkr@freesurf.fr>
Subject: Re: [PATCH v2] remote show: fix the -n option
Date: Mon, 09 Jun 2008 18:58:16 +0200
Message-ID: <484D6128.1010800@freesurf.fr>
References: <484B2DD3.8050307@free.fr> <1212927772-10006-1-git-send-email-dkr+ml.git@free.fr> <7v63sjk6yo.fsf@gitster.siamese.dyndns.org> <484C7CBE.4070700@free.fr> <484C7DCC.6080303@free.fr> <484D5322.6050309@free.fr> <alpine.DEB.1.00.0806091733230.1783@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 09 18:59:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5ki7-00033Q-KO
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 18:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752420AbYFIQ6S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Jun 2008 12:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752266AbYFIQ6S
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 12:58:18 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:32984 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752244AbYFIQ6R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 12:58:17 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id AFE3612B6CD;
	Mon,  9 Jun 2008 18:58:16 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 5606D12B766;
	Mon,  9 Jun 2008 18:58:16 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <alpine.DEB.1.00.0806091733230.1783@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84403>

Johannes Schindelin a =E9crit :
>=20
> And I do not like this change either.  It proliferates the "we just d=
ie()=20
> and do not care about reusing the code where die()ing is not desired"=
=20
> paradigm.

I agree and I'm OK to try to do something about that. But not in that p=
atch.

This patch is just to fix a regression.

Olivier.
