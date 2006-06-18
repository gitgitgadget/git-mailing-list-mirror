From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] Fix git to be (more) ANSI C99 compliant.
Date: Sun, 18 Jun 2006 10:26:26 +0200
Message-ID: <44950E32.10904@lsrfire.ath.cx>
References: <1150609831500-git-send-email-octo@verplant.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 18 10:26:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Frsc7-0007AW-FJ
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 10:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWFRI0X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 18 Jun 2006 04:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWFRI0X
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 04:26:23 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:22230
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S932161AbWFRI0X (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jun 2006 04:26:23 -0400
Received: from [10.0.1.3] (p508E50CB.dip.t-dialin.net [80.142.80.203])
	by neapel230.server4you.de (Postfix) with ESMTP id D495B1A038;
	Sun, 18 Jun 2006 10:26:21 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
To: Florian Forster <octo@verplant.org>
In-Reply-To: <1150609831500-git-send-email-octo@verplant.org>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22058>

=46lorian Forster schrieb:
> Using this patch I was able to build git with
> $ make CFLAGS=3D"-Wall -Werror -ansi -pedantic -std=3Dc99 -D_XOPEN_SO=
URCE=3D500 -D_BSD_SOURCE"
>=20
> While most of this patch fixes void-pointer arithmetic and is therefo=
re
> trivial, I had to change the use of a struct with FAMs in `diff-lib.c=
'. Since
> this is the first time I encountered FAMs it'd probably be a good ide=
a if
> someone who knows would take a look at that.

Nice work!  However, could you split it up a bit?  I.e. please send one
patch per error class/topic.  A comment on why the changes are needed
would be nice too, e.g. "void pointer arithmetic is a GNU extension, ge=
t
rid of it".

Thanks,
Ren=E9
