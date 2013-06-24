From: Yann Droneaud <ydroneaud@opteya.com>
Subject: Re: Another core.safecrlf behavor with git diff/git status
Date: Mon, 24 Jun 2013 18:43:48 +0200
Organization: OPTEYA
Message-ID: <a52e61e60f626e8ad75435af94a85042@meuh.org>
References: <866f886ef5e48ba22eec0f67203666bb@meuh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git-owner@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 24 18:44:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur9s6-0003Oy-Nd
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 18:44:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753155Ab3FXQnu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Jun 2013 12:43:50 -0400
Received: from mx-out.ocsa-data.net ([194.36.166.37]:62655 "EHLO
	mx-out.ocsa-data.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046Ab3FXQnt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 12:43:49 -0400
Received: from [192.168.111.12] (helo=rc.ouvaton.coop)
	by mx-out.ocsa-data.net with esmtpa (Exim - FreeBSD Rulez)
	id 1Ur9ro-000Joy-8G; Mon, 24 Jun 2013 18:43:48 +0200
In-Reply-To: <866f886ef5e48ba22eec0f67203666bb@meuh.org>
X-Sender: ydroneaud@opteya.com
User-Agent: Roundcube Webmail/0.9.2
X-abuse-contact: abuse@ocsa-data.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228858>

Le 24.06.2013 18:37, Yann Droneaud a =C3=A9crit=C2=A0:

> I'm still trying to use .gitattributes "text" flag with CRLF line=20
> ending files
> under Linux.
>=20
> I'm surprised about the interaction between the index and the working=
=20
> directory,
> more specificaly about the interaction between git diff and git statu=
s:

[...]

> - Why git diff does not always report the CRLF/LF mismatch ?
>=20
> - Why git status does not report about the CRLF/LF mismatch before
> updating the index:
>   it silently hide the CRLF/LF warning.
>   git add, git commit report the warning. git status should probably
> do the same.

Can this problem be related to the rebase failure I've described in=20
thread
"git rebase fail with CRLF conversion" [1][2][3] ?

1. <fb20a7d711fdd218f58f1f2090b1c515@meuh.org>
2. <http://thread.gmane.org/gmane.comp.version-control.git/228613>
3. <http://marc.info/?l=3Dgit&m=3D137182211414404&w=3D2>

Regards.

--=20
Yann Droneaud
OPTEYA
