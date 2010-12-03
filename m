From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: Re: Problem in Patches with commit-messages containing non-ascii
Date: Fri, 3 Dec 2010 13:59:44 +0100
Message-ID: <20101203135944.31d7cfbf@jk.gs>
References: <4CF8D243.50108@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Martin =?UTF-8?B?S3LDvGdlcg==?= <martin.krueger@gmx.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 13:59:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POVEx-00012u-CM
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 13:59:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489Ab0LCM7s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Dec 2010 07:59:48 -0500
Received: from zoidberg.org ([88.198.6.61]:57449 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750852Ab0LCM7s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 07:59:48 -0500
Received: from jk.gs (xdsl-89-0-24-162.netcologne.de [::ffff:89.0.24.162])
  (AUTH: LOGIN jast, SSL: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Fri, 03 Dec 2010 13:59:46 +0100
  id 004005F3.4CF8E9C2.00000B57
In-Reply-To: <4CF8D243.50108@gmx.com>
X-Mailer: Claws Mail 3.7.7 (GTK+ 2.22.0; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162794>

--- Martin Kr=C3=BCger <martin.krueger@gmx.com> wrote:

> Consider this log-Message:
> commit ea2cd63dfe9b3ac3581b6cff8b13a52e69066242
> Author: martin <martin@chad.upnx.de>
> Date:   Fri Nov 19 18:58:58 2010 +0100
>=20
>     Methoden =C3=BCberall angepasst.
>     Ausser Aussnahmen
>=20

=46WIW, support for multi-line summaries is very limited. Several
tools assume that the log message has this format:

<Summary in one line>
<Blank line>
<Details>

So one could argue that your patch fixes something that isn't really
supported anyway.

> [...]
>=20
> Applyin leads to a correct commit-Messsage:
>=20
> commit 62d06e3415ec0726dbd58c11ed93771502b77805
> Author: martin <martin@chad.upnx.de>
> Date:   Fri Nov 19 18:58:58 2010 +0100
>=20
>     Methoden =C3=BCberall angepasst.Ausser Aussnahmen

How is that correct? It's different from the original commit message.

-Jan
