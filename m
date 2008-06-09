From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH] remote show: fix the -n option
Date: Mon, 09 Jun 2008 16:22:08 +0200
Message-ID: <484D3C90.2050009@free.fr>
References: <484B2DD3.8050307@free.fr> <1212927772-10006-1-git-send-email-dkr+ml.git@free.fr> <7v63sjk6yo.fsf@gitster.siamese.dyndns.org> <484C7CBE.4070700@free.fr> <484C7DCC.6080303@free.fr> <alpine.DEB.1.00.0806090212270.1783@racer> <484C901B.6000401@free.fr> <alpine.DEB.1.00.0806090330490.1783@racer> <484CAE95.3020008@free.fr> <alpine.DEB.1.00.0806090551070.1783@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 09 16:23:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5iHf-0004aE-1Z
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 16:23:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079AbYFIOWM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Jun 2008 10:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762157AbYFIOWL
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 10:22:11 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:34625 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762153AbYFIOWK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 10:22:10 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 0CA9912B749;
	Mon,  9 Jun 2008 16:22:09 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id AFB7612B72C;
	Mon,  9 Jun 2008 16:22:08 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <alpine.DEB.1.00.0806090551070.1783@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84386>

Johannes Schindelin a =E9crit :
>=20
> For me, a dry run is something that avoids the high-cost operations.

See:
 http://en.wikipedia.org/wiki/Dry_Run_(testing)
 http://www.askoxford.com/concise_oed/dryrun?view=3Duk
 http://encarta.msn.com/dictionary_1861689507/dry_run.html

It's more "do something as it was for real but it's not". It has nothin=
g
to do with high-cost operations or something like that.

Yes?

> I would not like to remove the got_states.  I think this is the wrong=
=20
> direction.  Rather change the die() into a return error().

OK, I will try that.

--=20
Olivier.
