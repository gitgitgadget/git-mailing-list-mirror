From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [RFC/PATCH 3/4] test-lib: provide lazy TIME_COMMAND prereq
Date: Tue, 16 Oct 2012 17:11:25 +0200
Message-ID: <007401cdabb0$831d1f10$89575d30$@schmitz-digital.de>
References: <k5gq60$q8c$1@ger.gmane.org> <0140f3f2f2f4bded6868f4082bef0c36e9a8560e.1350387132.git.git@drmicha.warpmail.net> <007001cdaba8$5afc6c00$10f54400$@schmitz-digital.de> <507D7809.6040904@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, "'Junio C Hamano'" <gitster@pobox.com>
To: "'Michael J Gruber'" <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Oct 16 17:13:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TO8pl-0007nR-L1
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 17:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754897Ab2JPPNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 11:13:09 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:61396 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754878Ab2JPPNI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 11:13:08 -0400
Received: from DualCore (dsdf-4db552a4.pool.mediaWays.net [77.181.82.164])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0MYLIX-1SswlC1suH-00V8r9; Tue, 16 Oct 2012 17:11:51 +0200
In-Reply-To: <507D7809.6040904@drmicha.warpmail.net>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQJeqU/4XWJERJTycJKdEfjaJWW8tQL0cImCAhznpmcCn+72OZZcg/vg
Content-Language: de
X-Provags-ID: V02:K0:+cINxT9Z7BqRQqV5KxD7YtilOzHRbN4E5p7P/1Vnhga
 o3LqLG1jVPWi+/HNQlHgmauX/w/XWLODHKfBZzAKVlP5UZJUBf
 T4Jgk27M+uzgLePKSjYc9tDH8bBDm1T69699JsXAZWiFJnY3re
 SDa5rEgGXNXNziw1mPqG/X1ci/pfENIUYNASM0ckfT2/cCFNoI
 N6qj200Zr6+7GygLqWpNNNNRW3VRp1j2VPKpUSi33sPpZhgi+Q
 nAcu6VW5q65gSAhQUQgH9SmpGgpPOU7N56VTy4lEPVZg8WQJZs
 VG1vLmY8djCuDcCo5m8HUzBqb23u7IYsHo+JUtTifFe2h65A4J
 vkXZyfkVcgCTPO9YY46pTQ7eDJcVdf0Xd8ucHpNuA4WKSwxEup
 Ufdn1nzihtq6w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207836>

> From: Michael J Gruber [mailto:git@drmicha.warpmail.net]
> Sent: Tuesday, October 16, 2012 5:07 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org; 'Junio C Hamano'
> Subject: Re: [RFC/PATCH 3/4] test-lib: provide lazy TIME_COMMAND prereq
> 
> Joachim Schmitz venit, vidit, dixit 16.10.2012 16:13:
> >> From: Michael J Gruber [mailto:git@drmicha.warpmail.net]
> >> Sent: Tuesday, October 16, 2012 1:40 PM
> >> To: git@vger.kernel.org
> >> Cc: Joachim Schmitz; Junio C Hamano
> >> Subject: [RFC/PATCH 3/4] test-lib: provide lazy TIME_COMMAND prereq
> >>
> >> Some test want to use the time command (not the shell builtin) and test
> >> for its availability at /usr/bin/time.
> >>
> >> Provide a lazy prereq TIME_COMMAND which tests for /usr/bin/time and
> >> /bin/time. If any is found, set TEST_COMMAND_PATH to the first match.
> >>
> >> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> >> ---
> >> Rather than iterating over 2 or more hardcoded paths, one could use
> >> "test -P time" or allow a make variable TIME_COMMAND_PATH whose
> >
> > test -P time won't work for me:
> > test -P: unary operator expected
> >
> > I do have another one in /usr/local/bin, maybe that could get added too?
> 
> Yikes.
> 
> If we introduce a make variable TIME_COMMAND_PATH we can even get rid of
> 2/4 (but have to change Makefile or t/Makefile).

I don't mind too much. /usr/bin/time and /bin/time should be enough.
