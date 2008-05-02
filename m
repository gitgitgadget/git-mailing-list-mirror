From: Wincent Colaiuta <win@wincent.com>
Subject: Re: To page or not to page
Date: Fri, 2 May 2008 12:34:10 +0200
Message-ID: <807E185B-BEE5-4AAF-8DF4-EE597681D61C@wincent.com>
References: <70F76C0E-E16D-4047-873D-7FD19FDBB55D@sb.org> <20080502054508.GA28506@sigill.intra.peff.net> <7vlk2txn8n.fsf@gitster.siamese.dyndns.org> <8C3474E2-3A4F-44E8-B301-C36939C7BA11@sb.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Fri May 02 12:35:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jrsbr-0005QX-7O
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 12:35:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758246AbYEBKeg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 May 2008 06:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757570AbYEBKef
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 06:34:35 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:34321 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756068AbYEBKef convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 May 2008 06:34:35 -0400
Received: from cuzco.lan (228.pool85-53-21.dynamic.orange.es [85.53.21.228])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m42AYBYE027889
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 2 May 2008 06:34:13 -0400
In-Reply-To: <8C3474E2-3A4F-44E8-B301-C36939C7BA11@sb.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80978>

El 2/5/2008, a las 8:04, Kevin Ballard escribi=F3:

> Is there any good reason to make git-status use the pager? The =20
> output is very rarely long enough to warrant it, and if I need a =20
> pager I can always just pipe it to less myself.

I for one welcome this change and often have status output that is =20
long enough to warrant using a pager. I am constantly seeing more than =
=20
a full screen of results and then either re-running the command as =20
"git -p status" or otherwise scrolling upwards to see the part of the =20
status output that is actually interesting to me. It has often annoyed =
=20
me that commands like "git log" have always given me a highly usable =20
default behaviour "out of the box" (one of the first things I noticed =20
about Git when I started using it that made me think, "ah, that's a =20
nice touch") while "git status" didn't.

But evidently given that there has been so much backlash against the =20
patch the only way to keep everyone happy will be to make this =20
configurable.

Cheers,
Wincent
