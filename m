From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC/PATCH] l10n: de.po: correct translation of a 'rebase' message
Date: Mon, 24 Sep 2012 22:26:20 +0200
Message-ID: <87k3vjtbf7.fsf@pctrast.inf.ethz.ch>
References: <1348508389-2883-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <trast@student.ethz.ch>, <jk@jk.gs>, <stimming@tuhh.de>,
	<git@vger.kernel.org>, <sascha-ml@babbelbox.org>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 22:26:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGFEe-0001fv-R0
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 22:26:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757996Ab2IXU0Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Sep 2012 16:26:24 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:41831 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757844Ab2IXU0X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Sep 2012 16:26:23 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 24 Sep
 2012 22:26:20 +0200
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.208.245) by
 CAS22.d.ethz.ch (172.31.51.112) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 24 Sep 2012 22:26:20 +0200
In-Reply-To: <1348508389-2883-1-git-send-email-ralf.thielow@gmail.com> (Ralf
	Thielow's message of "Mon, 24 Sep 2012 19:39:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.208.245]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206326>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> Noticed-by: Sascha Cunz <sascha-ml@babbelbox.org>
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
[...]
> The English original is:
>
> "It seems that there is already a $state_dir_base directory, and\n"
> "I wonder if you are in the middle of another rebase.  If that is the=
\n"
> "case, please try\n"
> "\t$cmd_live_rebase\n"
> "If that is not the case, please\n"
> "\t$cmd_clear_stale_rebase\n"
> "and run me again.  I am stopping in case you still have something\n"
> "valuable there."
[...]
> -"Es scheint so, als g=C3=A4be es das Verzeichnis $state_dir_base ber=
eits, und\n"
> -"es w=C3=A4re verwunderlich, wenn ein Neuaufbau bereits im Gange ist=
=2E Wenn das\n"
> -"der Fall ist, probiere bitte\n"
> +"Es sieht so aus, als gibt es das Verzeichnis $state_dir_base bereit=
s\n"

Not very elegant yet, shouldn't it say something like

  als ob es das Verzeichnis ... bereits {gibt,g=C3=A4be}

?

> +"und es k=C3=B6nnte ein anderer Neuaufbau im Gange sein. Wenn das de=
r Fall ist,\n"
> +"probiere bitte\n"
>  "\t$cmd_live_rebase\n"
>  "Wenn das nicht der Fall ist, probiere bitte\n"
>  "\t$cmd_clear_stale_rebase\n"
> -"und f=C3=BChre dieses Kommando nochmal aus. Es wird angehalten, fal=
ls bereits\n"
> -"etwas N=C3=BCtzliches vorhanden ist."
> +"und f=C3=BChre dieses Kommando nochmal aus. Es wird angehalten, fal=
ls noch\n"
> +"etwas Sch=C3=BCtzenswertes vorhanden ist."

Thanks Ralf and Sascha.

Please don't see this as a reason to fight the (i.e. Ralf's, for the
most part) translation.  It is definitely a mistake, but not any more s=
o
than any other bug.  In fact, it went through review here

  http://thread.gmane.org/gmane.comp.version-control.git/202784

where I too (sorry) missed this, even as I pointed out several other
things.  Then it went into the pull request

  http://thread.gmane.org/gmane.comp.version-control.git/203153

So for me the main take-away is that just like with code, review helps
catch some things early but bugs still get through.  More eyeballs woul=
d
certainly be appreciated.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
