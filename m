From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] builtin-add: fix command line building to call interactive
Date: Sun, 25 Nov 2007 19:27:24 +0100
Message-ID: <F09249EB-475A-4352-A3A1-A8B15D2A94FF@wincent.com>
References: <1195996542-86074-1-git-send-email-win@wincent.com> <7vd4tynqpw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 19:27:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwMCu-0001Mc-6A
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 19:27:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754816AbXKYS1e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Nov 2007 13:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754773AbXKYS1d
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 13:27:33 -0500
Received: from wincent.com ([72.3.236.74]:36725 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753427AbXKYS1d convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Nov 2007 13:27:33 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAPIRPxa017692;
	Sun, 25 Nov 2007 12:27:26 -0600
In-Reply-To: <7vd4tynqpw.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65980>

El 25/11/2007, a las 19:07, Junio C Hamano escribi=F3:

> The earlier 7c0ab4458994aa895855abc4a504cf693ecc0cf1 (Teach builtin-=20
> add
> to pass multiple paths to git-add--interactive) did not allocate =20
> enough,

Yes, it was off by one; sorry about that. You may have noticed that I =20
fixed that up in the patches I sent out yesterday and today. May need =20
to redo them now to apply on top of this.

Cheers,
Wincent
