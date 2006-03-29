From: =?ISO-8859-1?B?U+liYXN0aWVu?= Pierre <sebastien@xprima.com>
Subject: Re: Git terminology
Date: Wed, 29 Mar 2006 11:11:12 -0500
Organization: XPRima Corp.
Message-ID: <20060329111112.55bb8d44.sebastien@xprima.com>
References: <20060329052113.6a773480.sebastien@xprima.com>
	<7vodzp9r8r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Mar 29 18:12:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOdH2-0007fg-LN
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 18:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWC2QLv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 29 Mar 2006 11:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWC2QLv
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Mar 2006 11:11:51 -0500
Received: from ritalin.autolinq.com ([207.96.225.42]:24249 "HELO
	ritalin.autolinq.com") by vger.kernel.org with SMTP
	id S1751187AbWC2QLu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Mar 2006 11:11:50 -0500
Received: (qmail-ldap/ctrl 21977 invoked from network); 29 Mar 2006 16:11:50 -0000
Received: from unknown (HELO localhost.localdomain) ([207.96.159.2]) (envelope-sender <sebastien@xprima.com>)
          by ritalin.autolinq.com (qmail-ldap-1.03) with SMTP
          for <junkio@cox.net>; 29 Mar 2006 16:11:50 -0000
To: Junio C Hamano <junkio@cox.net>, Git ML <git@vger.kernel.org>
In-Reply-To: <7vodzp9r8r.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.1.1 (GTK+ 2.8.16; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18176>

On Wed, 29 Mar 2006 07:59:16 -0800
Junio C Hamano <junkio@cox.net> wrote:
=20
> Probably we can just say "ref" where we say "refname".
>=20
> A fast-forward is where you have a revision and you are
> "merging" other's change that happen to be a descendant what you
> have.  In such a case, you do not make a new merge commit but
> just update to his revision.  That is:
>=20
>           o---o---o---o his               o---o---o---o his
>          /                      ->       /             \
>     o---o---o---o yours             o---o---o---o-------* yours
>=20
> updating to his needs a merge like above, but in this case:
>=20
>           o---o---o---o his               o---o---o---o his =3D yours
>          /                      ->       /
>     o---o yours                     o---o
>=20
> you just update to his.

Ah, ok. The diagrams are really helpful to get what "fast forward" is.

Thanks !

 -- S=E9bastien
