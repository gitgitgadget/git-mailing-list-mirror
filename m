From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] Fix git to be (more) ANSI C99 compliant.
Date: Tue, 20 Jun 2006 10:16:20 +0200
Message-ID: <4497AED4.5060505@lsrfire.ath.cx>
References: <1150609831500-git-send-email-octo@verplant.org>	<Pine.LNX.4.64.0606180946090.5498@g5.osdl.org>	<20060619212116.GL1331@verplant.org> <7vac8860z9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Forster <octo@verplant.org>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Jun 20 10:16:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsbPV-0007wT-FY
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 10:16:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965069AbWFTIQa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 20 Jun 2006 04:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965148AbWFTIQa
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 04:16:30 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:63682
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S965069AbWFTIQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jun 2006 04:16:29 -0400
Received: from [10.0.1.3] (p508E482C.dip.t-dialin.net [80.142.72.44])
	by neapel230.server4you.de (Postfix) with ESMTP id C352327025;
	Tue, 20 Jun 2006 10:16:27 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vac8860z9.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22180>

Junio C Hamano schrieb:
> BTW, I think we would probably want to have this patch on top of
> Rene's patch.  In all instances, the variable "buf" is of type
> "const char *" and the existing casts do not make sense to me.
>=20
>=20
> diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
> index 5c8a5f0..39a61b6 100644

Your patch reverts builtin-tar-tree.c to the version which is
currently both in master and next, which I think is a good
change.  However, could it be avoided at merge time?

OT: I found the blobs 5c8a5f0 and 39a61b6 by guessing (they are
builtin-tar-tree.c in pu and master, respectively).  OK, that
was easy.  But is there a way to reversely look up an object
without guessing, i.e. find out which commit(s) introduced a
certain blob?

Thanks,
Ren=E9
