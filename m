From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Implement selectable group ownership in git-init
Date: Mon, 5 Nov 2007 14:49:17 +0100
Message-ID: <8EF5148D-C1F0-4329-A221-82D0B7E9932C@wincent.com>
References: <472CC676.3000603@gmail.com> <7vabpvx8uu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Francesco Pretto <ceztkoml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 14:50:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip2LW-0005Hw-NQ
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 14:50:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755524AbXKENuP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Nov 2007 08:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755428AbXKENuP
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 08:50:15 -0500
Received: from wincent.com ([72.3.236.74]:44989 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755402AbXKENuO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Nov 2007 08:50:14 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lA5DnICR006600;
	Mon, 5 Nov 2007 07:49:19 -0600
In-Reply-To: <7vabpvx8uu.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63518>

El 3/11/2007, a las 23:27, Junio C Hamano escribi=F3:

> I think what the patch attempts to achieve may be good, but only
> to reduce a few keystrokes of doing the "chgrp".  Is it really
> worth it, I have to wonder...

I think this proposal adds unnecessary clutter to the codebase for =20
something that can easily be achieved (and *should*) using chown, =20
chgrp, or "sudo -u" etc.

The permissions of your Git installation and your repositories are =20
completely outside of the domain of Git itself, and should be =20
controlled using the administration tools designed for managing =20
access, just like every other SCM (and every server, and every piece =20
of software which can be accessed by many on a multi-user system).

Cheers,
Wincent
