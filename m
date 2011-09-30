From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v3 1/4] compat/win32/sys/poll.c: upgrade from upstream
Date: Fri, 30 Sep 2011 21:00:02 +0200
Message-ID: <4E8611B2.8030907@lsrfire.ath.cx>
References: <1317329963-6656-1-git-send-email-kusmabite@gmail.com> <1317329963-6656-2-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, peff@peff.net, j6t@kdbg.org, gitster@pobox.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 30 21:00:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9iJq-0008Tr-HQ
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 21:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758702Ab1I3TAR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Sep 2011 15:00:17 -0400
Received: from india601.server4you.de ([85.25.151.105]:55562 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757531Ab1I3TAP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 15:00:15 -0400
Received: from [192.168.2.104] (p4FFDAD66.dip.t-dialin.net [79.253.173.102])
	by india601.server4you.de (Postfix) with ESMTPSA id 164192F8105;
	Fri, 30 Sep 2011 21:00:14 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0) Gecko/20110922 Thunderbird/7.0
In-Reply-To: <1317329963-6656-2-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182503>

Am 29.09.2011 22:59, schrieb Erik Faye-Lund:
> poll.c is updated from revision adc3a5b in
> git://git.savannah.gnu.org/gnulib.git
>=20
> The changes are applied with --whitespace=3Dfix to reduce noise.
>=20
> poll.h is not upgraded, because the most recent version now
> contains template-stuff that breaks compilation for us.

> @@ -27,7 +27,10 @@
>  #include <malloc.h>
> =20
>  #include <sys/types.h>
> -#include "poll.h"
> +
> +/* Specification.  */
> +#include <poll.h>
> +

In order to make bisecting easier, I think it's a good idea to squash i=
n
the next patch that undoes this part, i.e. simply skip this hunk and ad=
d
a third non-verbatim note to the commit message.

Ren=E9
