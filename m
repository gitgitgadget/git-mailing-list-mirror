From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] l10n: de.po: translate 5 new messages
Date: Tue, 19 Feb 2013 21:01:41 +0100
Message-ID: <87ehgcoyxm.fsf@pctrast.inf.ethz.ch>
References: <1361293966-3975-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <jk@jk.gs>, <stimming@tuhh.de>, <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 21:02:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7tOF-0000ZE-2m
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 21:02:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934052Ab3BSUBr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Feb 2013 15:01:47 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:36198 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933124Ab3BSUBq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Feb 2013 15:01:46 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 19 Feb
 2013 21:01:39 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (46.126.8.85) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 19 Feb
 2013 21:01:42 +0100
In-Reply-To: <1361293966-3975-1-git-send-email-ralf.thielow@gmail.com> (Ralf
	Thielow's message of "Tue, 19 Feb 2013 18:12:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216656>

Ralf Thielow <ralf.thielow@gmail.com> writes:

>  msgid "You are currently bisecting branch '%s'."
> -msgstr "Sie sind gerade beim Halbieren."
> +msgstr "Sie sind gerade beim Halbieren in Zweig '%s'."

I know this one is already in other messages (and also in the Glossary)=
,
but I still find it iffy and I might finally have a better idea:

  Sie sind gerade an einer bin=C3=A4ren Suche in Zweig '%s'.

[note to English speakers: I'm just using "binary search" instead of
"bisect"]

That makes it quite a bit harder to use it in a verbed[1] form, but I
think it gets the concept across much better.  (And in all the usage I
know in CS, the two things refer to the same.)

ACK on the rest.


=46ootnotes:=20
[1]  Verbing weirds language. -- Calvin

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
