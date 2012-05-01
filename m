From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] Consistently use perl from /usr/bin/ for scripts
Date: Tue, 01 May 2012 13:54:54 -0700
Message-ID: <86vckfmxk1.fsf@red.stonehenge.com>
References: <20120501175500.GA24258@sigill.intra.peff.net>
	<1335903498-583-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, peff@peff.net, gitster@pobox.com,
	jnareb@gmail.com, tboegi@web.de
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Tue May 01 22:55:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPK6A-00014x-0r
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 22:55:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752346Ab2EAUy5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 May 2012 16:54:57 -0400
Received: from lax-gw15.mailroute.net ([199.89.0.115]:42505 "EHLO
	gw15.lax01.mailroute.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165Ab2EAUy4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 May 2012 16:54:56 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gw15.lax01.mailroute.net (Postfix) with ESMTP id 8419EE36318;
	Tue,  1 May 2012 20:54:56 +0000 (GMT)
X-Virus-Scanned: by MailRoute
Received: from gw15.lax01.mailroute.net ([199.89.0.115])
	by localhost (gw15.lax01.mailroute.net.mailroute.net [127.0.0.1]) (mroute_mailscanner, port 10026)
	with LMTP id 5b-U8YzHRdyg; Tue,  1 May 2012 20:54:55 +0000 (GMT)
Received: from red.stonehenge.com (red.stonehenge.com [208.79.95.2])
	by gw15.lax01.mailroute.net (Postfix) with ESMTP id 6F870E3631D;
	Tue,  1 May 2012 20:54:55 +0000 (GMT)
Received: by red.stonehenge.com (Postfix, from userid 1001)
	id 7B1461303; Tue,  1 May 2012 13:54:54 -0700 (PDT)
x-mayan-date: Long count = 12.19.19.6.6; tzolkin = 4 Cimi; haab = 9 Uo
In-Reply-To: <1335903498-583-1-git-send-email-zbyszek@in.waw.pl> ("Zbigniew
	=?utf-8?Q?J=C4=99drzejewski-Szmek=22's?= message of "Tue, 1 May 2012
 22:18:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196745>

>>>>> "Zbigniew" =3D=3D Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.wa=
w.pl> writes:

Zbigniew> Suggested-by: Junio C Hamano <gitster@pobox.com>
Zbigniew> Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.w=
aw.pl>

And I strongly support this change.  Too many things use that env trick=
,
and it really isn't the proper solution to this.

--=20
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 =
0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.posterous.com/ for Smalltalk discussion
