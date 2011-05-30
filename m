From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 3/3] gitk: Allow displaying time zones from author and commit timestamps
Date: Tue, 31 May 2011 00:17:13 +0200
Message-ID: <m21uzfal5i.fsf@igel.home>
References: <alpine.DEB.2.02.1101191445130.23868@dr-wily.mit.edu>
	<m3mxi4yco5.fsf@localhost.localdomain>
	<20110530061757.GC3723@Imperial-SD-Longsword>
	<201105300829.52619.jnareb@gmail.com>
	<alpine.DEB.2.02.1105301717520.23145@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Tim Guirgies <lt.infiltrator@gmail.com>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Anders Kaseorg <andersk@MIT.EDU>
X-From: git-owner@vger.kernel.org Tue May 31 00:17:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRAm3-0008VS-N4
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 00:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658Ab1E3WRS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 May 2011 18:17:18 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:45827 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698Ab1E3WRS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 18:17:18 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id DDDB21C08E17;
	Tue, 31 May 2011 00:17:14 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id D9FCE1C00087;
	Tue, 31 May 2011 00:17:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id 6cuoxejMi52G; Tue, 31 May 2011 00:17:14 +0200 (CEST)
Received: from igel.home (ppp-88-217-112-53.dynamic.mnet-online.de [88.217.112.53])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Tue, 31 May 2011 00:17:14 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 13917CA29C; Tue, 31 May 2011 00:17:14 +0200 (CEST)
X-Yow: I have a TINY BOWL in my HEAD
In-Reply-To: <alpine.DEB.2.02.1105301717520.23145@dr-wily.mit.edu> (Anders
	Kaseorg's message of "Mon, 30 May 2011 17:35:55 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174785>

Anders Kaseorg <andersk@MIT.EDU> writes:

> In Tcl =E2=89=A5 8.5, none of this matters because =E2=80=98clock for=
mat -timezone=E2=80=99 just=20
> uses the numerical UTC offset as the zone name.  For the fallback cod=
e, I=20
> can=E2=80=99t do that by manipulating TZ, because the zone name needs=
 to be made=20
> of letters.

POSIX defines the form TZ=3D"<-0430>+04:30" where <...> can contain any
character from [a-zA-Z0-9+-].

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
