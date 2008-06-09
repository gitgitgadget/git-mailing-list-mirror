From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH v2] remote show: fix the -n option
Date: Mon, 09 Jun 2008 20:37:20 +0200
Message-ID: <484D7860.6050301@free.fr>
References: <484B2DD3.8050307@free.fr> <1212927772-10006-1-git-send-email-dkr+ml.git@free.fr> <7v63sjk6yo.fsf@gitster.siamese.dyndns.org> <484C7CBE.4070700@free.fr> <484C7DCC.6080303@free.fr> <484D5322.6050309@free.fr> <alpine.DEB.1.00.0806091733230.1783@racer> <484D6128.1010800@freesurf.fr> <alpine.DEB.1.00.0806091856180.1783@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 09 20:38:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5mG1-0006b5-Vf
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 20:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753485AbYFIShX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Jun 2008 14:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753469AbYFIShX
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 14:37:23 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:47085 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753440AbYFIShX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 14:37:23 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 2B6AD12B745;
	Mon,  9 Jun 2008 20:37:22 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id E318512B77D;
	Mon,  9 Jun 2008 20:37:19 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <alpine.DEB.1.00.0806091856180.1783@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84409>

Johannes Schindelin a =E9crit :
>=20
> But did you not now make it harder to fix "that"?  By relying on the =
die()=20
> behaviour in your regression fix?

If I change return path for some functions, I will have to check all th=
e
callers anyway. So, no I don't think it make things harder to fix. Also
I don't like to add dead code.

Please, let me do this fix so that I can post my next patches. After th=
at
I will be happy to work on what you asked.

Olivier.
