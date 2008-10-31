From: Francis Galiegue <fg@one2team.com>
Subject: Re: [PATCH] Avoid using non-portable `echo -n` in tests.
Date: Fri, 31 Oct 2008 20:35:19 +0100
Organization: One2team
Message-ID: <200810312035.20016.fg@one2team.com>
References: <8A4A84EC-51F7-4038-957C-CCA5C00E5977@silverinsanity.com> <20081031183601.GB8464@artemis.corp> <20081031183933.GA3577@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 31 21:04:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw0EZ-0000Rs-Sf
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 21:04:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186AbYJaUD0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Oct 2008 16:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752069AbYJaUD0
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 16:03:26 -0400
Received: from ns35774.ovh.net ([213.251.185.197]:51817 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752052AbYJaUD0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Oct 2008 16:03:26 -0400
X-Greylist: delayed 1651 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Oct 2008 16:03:26 EDT
Received: from smtp.olympe.o2t (138.193.65-86.rev.gaoland.net [86.65.193.138])
	by ns35774.ovh.net (Postfix) with ESMTP id 5569F92C011
	for <git@vger.kernel.org>; Fri, 31 Oct 2008 20:35:43 +0100 (CET)
Received: from erwin.kitchen.eel (unknown [10.8.0.6])
	by smtp.olympe.o2t (Postfix) with ESMTP id ED7977001F
	for <git@vger.kernel.org>; Fri, 31 Oct 2008 20:35:52 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <20081031183933.GA3577@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99631>

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
=46rancis Galiegue
ONE2TEAM
Ing=C3=A9nieur syst=C3=A8me
Mob : +33 (0) 6 83 87 78 75
Tel : +33 (0) 1 78 94 55 52
fge@one2team.com
40 avenue Raymond Poincar=C3=A9
75116 Paris
