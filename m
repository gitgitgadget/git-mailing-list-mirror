From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: Message from 'git-rebase'; German translation
Date: Sun, 23 Sep 2012 19:34:23 +0200
Message-ID: <CAN0XMO+ySiOBpUFa5G-3_Ld1uY-qpY8s5QfqSwy2s+kEZv=ckw@mail.gmail.com>
References: <1527028.GPe6zkelBV@blacky>
	<CAN0XMO+Dd9S7j9Ujudcy+O3GwwBX1CvRPQTYWxymmEu=2bg7ww@mail.gmail.com>
	<224751243.JXpXFWu6vV@blacky>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?Q?Jan_Kr?= =?UTF-8?Q?=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	Jan Engelhardt <jengelh@inai.de>, knittl89@googlemail.com
To: Sascha Cunz <sascha-ml@babbelbox.org>
X-From: git-owner@vger.kernel.org Sun Sep 23 19:34:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFq4f-0001fq-Sr
	for gcvg-git-2@plane.gmane.org; Sun, 23 Sep 2012 19:34:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754232Ab2IWReZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Sep 2012 13:34:25 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:36567 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754119Ab2IWReY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Sep 2012 13:34:24 -0400
Received: by wgbdr13 with SMTP id dr13so3000038wgb.1
        for <git@vger.kernel.org>; Sun, 23 Sep 2012 10:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=dqmHU++5DUVf330Tngky6KGxG4VO0jMI2uyL2zndR6g=;
        b=e8Cb7LstOyBdo3P6HPaZDFutncF5qFfMuPiXhmWHWINZqf8C1dGSFkhFBjwCgNyik1
         uf/V9WDRmLESdE82Fm8Md7reCqGU+ZuV9bO+neHg2rdo6wegS5TE0EE51au8cKb3k7zb
         cMtpnU2hKC9q9UEL10Y7rQdJaIcQekAdGX9zuB6z7GTtmjABM/2RD+7qIKxxKHG2z0OB
         UyI8OKq2ZiBGi7mWO8fblPs88b9nX/nFizP6zR0NhOKdrJBCGAQek/1jykTX2dvjwaGJ
         uD6o1LI7Qm/l6LvZWKMGwTbwkdoHF6gaeGWFC76ZHcEeJO6JOeAFDCUktrxaPShSkiuA
         FAag==
Received: by 10.180.93.106 with SMTP id ct10mr9250547wib.8.1348421663322; Sun,
 23 Sep 2012 10:34:23 -0700 (PDT)
Received: by 10.194.23.201 with HTTP; Sun, 23 Sep 2012 10:34:23 -0700 (PDT)
In-Reply-To: <224751243.JXpXFWu6vV@blacky>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206247>

On Sun, Sep 23, 2012 at 5:41 PM, Sascha Cunz <sascha-ml@babbelbox.org> =
wrote:
> Exactly. The meaning is more important then the exact wording. Please=
 consider
> this:
>
>         Es wurden Neuaufbau- / Zusammenf=C3=BChrungs-Informationen ge=
funden.

We can't change the "... Verzeichnis *rebase-merge* ..." part of the me=
ssage,
because "rebase-merge" is a substitution and we have to use all of them=
=2E

>         Falls ein Neuaufbau bereits im Gange ist, versuche bitte:
>                 git rebase (--continue | --abort | --skip)
>         Sollte dies nicht der Fall sein, k=C3=B6nnen die Informatione=
n durch
>                 rm -fr "$(GIT_DIR)/rebase-merge"
>         entfernt werden. Es wird angehalten, falls etwas Sch=C3=BCtze=
nswertes
>         gefunden werden sollte.
>
> It sounds way cleaner (to me at least) and transports all of the mean=
ing. Esp.
> for  the last sentence, it's very hard to find something in German th=
at
> doesn't sound 'destructive'.

Not sure why you change "vorhanden ist" to "gefunden werden sollte".
Maybe we should use a combination? See below.

>
> Btw: In the past I've seen quite a few topics on translation on this =
list - is
> this at all the right place for that kind of discussion?
>

Different translation teams use different places for discussions.
The German uses this list.

Like this, maybe.

[PATCH] l10n: de.po: improve translation of a rebase message

The word "still" was translated as "bereits", change
it to "noch". "valuable" was translated as "n=C3=BCtzlich"
which is more like "useful" than "valuable", change it
to "sch=C3=BCtzenswert".

Noticed-by: Sascha Cunz <sascha-ml@babbelbox.org>
Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>

diff --git a/po/de.po b/po/de.po
index 2739bc0..7fc0185 100644
--- a/po/de.po
+++ b/po/de.po
@@ -5756,8 +5756,8 @@ msgstr ""
 "\t$cmd_live_rebase\n"
 "Wenn das nicht der Fall ist, probiere bitte\n"
 "\t$cmd_clear_stale_rebase\n"
-"und f=C3=BChre dieses Kommando nochmal aus. Es wird angehalten, falls=
 bereits\n"
-"etwas N=C3=BCtzliches vorhanden ist."
+"und f=C3=BChre dieses Kommando nochmal aus. Es wird angehalten, falls=
 noch\n"
+"etwas Sch=C3=BCtzenswertes vorhanden ist."

 #: git-rebase.sh:395
 #, sh-format
