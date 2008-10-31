From: Francis Galiegue <fg@one2team.net>
Subject: Re: [PATCH] Avoid using non-portable `echo -n` in tests.
Date: Fri, 31 Oct 2008 20:50:31 +0100
Organization: One2team
Message-ID: <200810312050.31167.fg@one2team.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 31 20:52:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw02t-00053u-U5
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 20:52:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135AbYJaTvI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Oct 2008 15:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752127AbYJaTvH
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 15:51:07 -0400
Received: from ns35774.ovh.net ([213.251.185.197]:47560 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751984AbYJaTvG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Oct 2008 15:51:06 -0400
Received: from erwin.kitchen.eel (AOrleans-157-1-104-197.w90-20.abo.wanadoo.fr [90.20.179.197])
	(Authenticated sender: fg@one2team.net)
	by ns35774.ovh.net (Postfix) with ESMTP id 3859892C018
	for <git@vger.kernel.org>; Fri, 31 Oct 2008 20:50:54 +0100 (CET)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99628>

Le Friday 31 October 2008 19:39:33 Jeff King, vous avez =C3=A9crit=C2=A0=
:
[...]
>
> Agreed, and actually I found such a bashism (test =3D=3D) last week (=
though
> of course it also broke on FreeBSD).
>

As for bash-isms, a hunt for $(...) also looks necessary...

$ grep -rl '\$([^)]\+)' $(find -type f)|wc -l
272

Unless I'm mistaken (and I probably am), the $(...) construct is=20
bash-specific, isn't it?

--=20
fge
