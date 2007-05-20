From: Michael <barra_cuda@katamail.com>
Subject: Re: [QGit PATCH] Remove most ASSERT warnings in Git::setStatus
Date: Sun, 20 May 2007 16:41:20 +0200
Message-ID: <200705201641.20305.barra_cuda@katamail.com>
References: <200705201401.35991.barra_cuda@katamail.com> <200705201558.53546.barra_cuda@katamail.com> <e5bfff550705200723i7b4e21ebi6a2c51d66659b388@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Marco Costalba" <mcostalba@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 20 16:38:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpmXy-000852-Nh
	for gcvg-git@gmane.org; Sun, 20 May 2007 16:38:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756321AbXETOiH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 20 May 2007 10:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756354AbXETOiH
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 10:38:07 -0400
Received: from slim-3a.inet.it ([213.92.5.124]:46200 "EHLO slim-3a.inet.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756321AbXETOiG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 May 2007 10:38:06 -0400
Received: from dial-up-mi-473.lombardiacom.it ([::ffff:212.34.226.219]) by slim-3a.inet.it via I-SMTP-5.4.4-547
	id ::ffff:212.34.226.219+nd9oNix676; Sun, 20 May 2007 16:38:01 +0200
User-Agent: KMail/1.9.4
In-Reply-To: <e5bfff550705200723i7b4e21ebi6a2c51d66659b388@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47841>

"Marco Costalba" <mcostalba@gmail.com>:
> So I rather would prefer something like
>=20
> =C2=A0 line.section('\t', 0, 0).section(' ', -1, -1).left(1)
>=20
> because we could have more then one file separated by a tab, so
>=20
> =C2=A0line.section('\t', -2, -2).right(1)
>=20
> it seems to me a little bit fragile. What do you think?

You're right.

> Also I don't understand why you consider the right most (right(1)),
> instead of the left most character as the status.

Only because it was simpler AND because I didn't know it was wrong.
