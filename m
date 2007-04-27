From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: Re: [PATCH 0/5] RFC: for_each_revision() helper
Date: Fri, 27 Apr 2007 10:21:13 -0300
Organization: Mandriva
Message-ID: <20070427102113.46869367@localhost>
References: <11776168001253-git-send-email-lcapitulino@mandriva.com.br>
	<7vr6q6svkc.fsf@assigned-by-dhcp.cox.net>
	<20070426181420.4db235cc@localhost>
	<7vk5vysufp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, robbat2@gentoo.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 27 15:21:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhQO6-0005V2-OT
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 15:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755784AbXD0NVX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 09:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755822AbXD0NVX
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 09:21:23 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:36081 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755784AbXD0NVV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 09:21:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 08A131811B;
	Fri, 27 Apr 2007 10:21:20 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id xhfGZkiJ5Wlo; Fri, 27 Apr 2007 10:21:14 -0300 (BRT)
Received: from localhost (doriath.conectiva [10.0.2.48])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 9978318119;
	Fri, 27 Apr 2007 10:21:14 -0300 (BRT)
In-Reply-To: <7vk5vysufp.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.3; i586-mandriva-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45714>

Em Thu, 26 Apr 2007 14:21:46 -0700
Junio C Hamano <junkio@cox.net> escreveu:

| "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
| writes:
| 
| > Em Thu, 26 Apr 2007 13:57:23 -0700
| > Hermes Trismegisto <junkio@cox.net> escreveu:
| >
| > | Luiz Fernando N Capitulino <lcapitulino@mandriva.com.br> writes:
| > | 
| > | >  [This' also a git-send-email test, so, if this fail by showing just
| > | >   the first e-mail in the series, do not blame me :)]
| > | 
| > | But if you changed your name to omit '.', that is not much of a
| > | test I suspect...
| >
| >  Yes, I did. But git-send-email is taking my name from the patches,
| > so the same problem happened.
| >
| >  I had to change my name in the patches to make it to work.
| 
| I know.  But my point of "changing your name is not much of a
| test" is that that was exactly what Robin Johnson's patches to
| quote CC: addresses that were taken from the sign-off lines in
| the proposed commit log message were meant to fix.
| 
| Specifically:
| 
| http://repo.or.cz/w/alt-git.git?a=commitdiff;h=732263d411fe2e3e29ee9fa1c2ad1a20bdea062c

 Okay.

 With the --dry-run option it became very easy to run tests,
so, I've changed everything back and tried to reproduce it
again:

-> First e-mail:

"""
Dry-OK. Log says:
Date: Fri, 27 Apr 2007 10:04:48 -0300
Sendmail: /usr/sbin/sendmail -i junkio@cox.net git@vger.kernel.org
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: [PATCH 0/5] RFC: for_each_revision() helper
Cc: git@vger.kernel.org
To: junkio@cox.net
"""

-> Last one (others are the same)

"""
Dry-OK. Log says:
Date: Fri, 27 Apr 2007 10:04:53 -0300
Sendmail: /usr/sbin/sendmail -i junkio@cox.net git@vger.kernel.org lcapitulino@mandriva.com.br
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: [PATCH 5/5] builtin-log.c: Use for_each_revision() helper
Cc: git@vger.kernel.org, "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: junkio@cox.net
"""

 Looks like it's fixed, I'll submit this patch series again
shortly.

 BTW, Robin, can we have an option to read the introductory e-mail
from a file? It could read a Subject line from it too.

-- 
Luiz Fernando N. Capitulino
