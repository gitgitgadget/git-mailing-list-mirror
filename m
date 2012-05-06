From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH 2/5] l10n: de.po: translate "track" as "folgen"
Date: Sun, 06 May 2012 17:20:46 +0200
Organization: Alumni Technische =?UTF-8?B?VW5pdmVyc2l0w6R0?= Hamburg-Harburg
Message-ID: <1543115.9YNtu9coLS@cs-pc>
References: <1336160906-20708-1-git-send-email-ralf.thielow@googlemail.com> <1336160906-20708-3-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: trast@student.ethz.ch, jk@jk.gs, git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Sun May 06 17:21:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SR3Go-0000UM-CN
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 17:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753693Ab2EFPVE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 May 2012 11:21:04 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:58924 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753057Ab2EFPVD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2012 11:21:03 -0400
Received: from mail.tu-harburg.de (mail.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id q46FKqL3011044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sun, 6 May 2012 17:20:52 +0200
Received: from cs-pc.localnet (e176207151.adsl.alicedsl.de [85.176.207.151])
	(user=alucst mech=LOGIN bits=0)
	by mail.tu-harburg.de (8.13.8/8.13.8) with ESMTP id q46FKpdF025817
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 6 May 2012 17:20:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuhh.de; s=x2012-18;
	t=1336317652; bh=oSXSvXrF2jNBfWSP5WR+cNsibY6aJ5Xswg1zL6dU6lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Zgrn1LD66PgerTVlD5zGETqZ0RenxMWmGs5R+eAzG3z4lrHs3sW+vx0XrCZnuIzmd
	 x/qUQDIDQ9c6gXwe7TUeGfkDIceE8PDbAIDHN8/ALUMbWlqPcHGXrhjecvIHdjQ90K
	 f0Gd+9C3JMbpgxOIWWUiiOhjlvlHswiPFv6kTYyk=
User-Agent: KMail/4.7.3 (Linux/3.0.0-17-generic; KDE/4.7.4; x86_64; ; )
In-Reply-To: <1336160906-20708-3-git-send-email-ralf.thielow@googlemail.com>
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197196>

Am Freitag, 4. Mai 2012, 21:48:23 schrieb Ralf Thielow:
> The word "track" was translated as "verfolgt"
> which is not the correct word for it. We've
> changed it to "folgen".

I'm not so sure about this choice. We're talking about files which are =
tracked=20
by git (i.e. being versioned) vs. files or content that are not tracked=
, i.e.=20
those are just existing in the working copy's directory but are not tra=
cked by=20
git. I think from the point of view of git, the content of the files is=
 being=20
"verfolgt" vs. "nicht verfolgt", as git checks whether the content is c=
hanging=20
vs. git doesn't check this. Saying "folgen" here rather sounds like git=
 is=20
following something, just as your twitter account is following other=20
twitterers. Consider a choicebox "=C4nderungen dieser Datei verfolgen" =
vs.=20
"=C4nderungen dieser Datei folgen". In the former case, git is the subj=
ect and=20
it is tracking the file's content. In the latter case, the file is the =
subject=20
and git is triggered into some action when the file content changes. I =
think=20
the former fits the use case more.

Regards,

Christian

> --- a/po/de.po
> +++ b/po/de.po
> @@ -525,7 +525,7 @@ msgstr "ge=E4nderter Inhalt, "
>=20
>  #: wt-status.c:252
>  msgid "untracked content, "
> -msgstr "unverfolgter Inhalt, "
> +msgstr "ungefolgter Inhalt, "
