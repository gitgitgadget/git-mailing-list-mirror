From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] l10n: de.po: translate 22 new messages
Date: Mon, 03 Dec 2012 16:09:23 +0100
Message-ID: <50BCC0A3.4050203@drmicha.warpmail.net>
References: <1354510146-2919-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: trast@inf.ethz.ch, jk@jk.gs, stimming@tuhh.de, git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 16:09:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfXeO-0001YZ-O5
	for gcvg-git-2@plane.gmane.org; Mon, 03 Dec 2012 16:09:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754000Ab2LCPJZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Dec 2012 10:09:25 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:51994 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753786Ab2LCPJY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Dec 2012 10:09:24 -0500
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id C5204211DA;
	Mon,  3 Dec 2012 10:09:23 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute6.internal (MEProxy); Mon, 03 Dec 2012 10:09:23 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=ovynSTeMfPXrvhCddSg9K8
	5Rh+Y=; b=KKpcn8cPxdl51HRgOGLYiIyvMGoBtziUaHJ5C/Mv2U4W5i7Pf6ITjU
	xAMh9ImFdWmk7/QPZQvqHm9uLC2nCReKFCfFnlJDi2z6hnz92l51ppDXc5NXfVSb
	8DWpKuqjjO/DJ4h5+xJ644IgSSezUFw03Rw9Htxnj/WtBtD8wkqag=
X-Sasl-enc: QPpYOuwsKmCewrYb7l2pNuaD0SfZ7RYRj5EmtQQK1QsC 1354547363
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id B2E5A8E05D0;
	Mon,  3 Dec 2012 10:09:22 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <1354510146-2919-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211041>

Ralf Thielow venit, vidit, dixit 03.12.2012 05:49:
> Translate 22 new messages came from git.pot
> updates in 9306b5b (l10n: Update git.pot (3 new,
> 6 removed messages)), fe52cd6 (l10n: Update git.pot
> (14 new, 3 removed messages)) and f9472e3
> (l10n: Update git.pot (5 new, 1 removed messages)).
>=20
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
>  po/de.po | 68 ++++++++++++++++++++++++++++++++++--------------------=
----------
>  1 file changed, 36 insertions(+), 32 deletions(-)
>=20
> diff --git a/po/de.po b/po/de.po
> index a0bf3da..7350818 100644
> --- a/po/de.po
> +++ b/po/de.po
=2E..
>  #: remote.c:1659
> -#, fuzzy
>  msgid "  (use \"git pull\" to merge the remote branch into yours)\n"
>  msgstr ""
> -"  (benutze \"git am --abort\" um den urspr=C3=BCnglichen Zweig wied=
erherzustellen)"
> +"  (benutze \"git pull\" um den externen Zweig mit Deinem zusammenzu=
f=C3=BChren)\n"

That sounds as if git-pull did something to the remote branch, whereas
it would do something with your local branch. Reverting the roles may h=
elp:

+"  (benutze \"git pull\" um Deinen Zweig mit dem externen
zusammenzuf=C3=BChren)\n"

BTW: Is there a standard about capitalising or not "Deine/Du" in de.pot=
?
I think I've seen both here. (New spelling after the reform(s)
recommends du/deine but Sie/Ihr, me thinks.)


>  #: builtin/grep.c:740
>  msgid "pager"
> @@ -8029,6 +8024,9 @@ msgid ""
>  "submodule '%s' (or one of its nested submodules) uses a .git direct=
ory\n"
>  "(use 'rm -rf' if you really want to remove it including all of its =
history)"
>  msgstr ""
> +"Unterprojekt '%s' (oder ein geschachteltes Unterprojekt dessen) ver=
wendet \n"

s/dessen/hiervon/ ?

> +"ein .git-Verzeichnis (benutze 'rm -rf' wenn du dieses wirklich mit =
seiner\n"
> +"Historie l=C3=B6schen m=C3=B6chtest)"

s/mit/mitsamt/ ?

(to emphasize "including" like in the original and avoid "mit=3Dby"
misinterpretation)

Michael
