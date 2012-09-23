From: Sascha Cunz <sascha-ml@babbelbox.org>
Subject: Re: Message from 'git-rebase'; German translation
Date: Sun, 23 Sep 2012 19:57:51 +0200
Message-ID: <1896069.nSNvK2cQtd@blacky>
References: <1527028.GPe6zkelBV@blacky> <224751243.JXpXFWu6vV@blacky> <CAN0XMO+ySiOBpUFa5G-3_Ld1uY-qpY8s5QfqSwy2s+kEZv=ckw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Jan =?ISO-8859-1?Q?Kr=FCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	Jan Engelhardt <jengelh@inai.de>, knittl89@googlemail.com
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 23 19:58:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFqRO-0008Bw-5n
	for gcvg-git-2@plane.gmane.org; Sun, 23 Sep 2012 19:58:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754344Ab2IWR5v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Sep 2012 13:57:51 -0400
Received: from babbelbox.org ([83.133.105.186]:54797 "EHLO mail.babbelbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754287Ab2IWR5u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Sep 2012 13:57:50 -0400
Received: (qmail 25009 invoked from network); 23 Sep 2012 17:58:22 -0000
Received: from p54aecaae.dip.t-dialin.net (HELO blacky.localnet) (sascha@babbelbox.org@84.174.202.174)
  by babbelbox.org with ESMTPA; 23 Sep 2012 17:58:22 -0000
User-Agent: KMail/4.9.1 (Linux/3.5.3-gentoo; KDE/4.9.1; x86_64; ; )
In-Reply-To: <CAN0XMO+ySiOBpUFa5G-3_Ld1uY-qpY8s5QfqSwy2s+kEZv=ckw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206249>

Am Sonntag, 23. September 2012, 19:34:23 schrieb Ralf Thielow:
> On Sun, Sep 23, 2012 at 5:41 PM, Sascha Cunz <sascha-ml@babbelbox.org=
>=20
wrote:
> > Exactly. The meaning is more important then the exact wording. Plea=
se
> > consider>=20
> > this:
> >         Es wurden Neuaufbau- / Zusammenf=FChrungs-Informationen gef=
unden.
>=20
> We can't change the "... Verzeichnis *rebase-merge* ..." part of the
> message, because "rebase-merge" is a substitution and we have to use =
all of
> them.
> >         Falls ein Neuaufbau bereits im Gange ist, versuche bitte:
> >                 git rebase (--continue | --abort | --skip)
> >        =20
> >         Sollte dies nicht der Fall sein, k=F6nnen die Informationen=
 durch
> >        =20
> >                 rm -fr "$(GIT_DIR)/rebase-merge"
> >        =20
> >         entfernt werden. Es wird angehalten, falls etwas Sch=FCtzen=
swertes
> >         gefunden werden sollte.
> >=20
> > It sounds way cleaner (to me at least) and transports all of the me=
aning.
> > Esp. for  the last sentence, it's very hard to find something in Ge=
rman
> > that doesn't sound 'destructive'.
>=20
> Not sure why you change "vorhanden ist" to "gefunden werden sollte".
> Maybe we should use a combination? See below.

Probably a result of my initial misunderstanding of the original text. =
As I=20
pointed out in another mail on this thread, I think the real meaning is=
: "Es=20
wird [jetzt] angehalten, _weil_ dort [im Rebase-Merge Verzeichnis] noch=
 etwas=20
Sch=FCtzenswertes vorhanden sein k=F6nnte".

> > Btw: In the past I've seen quite a few topics on translation on thi=
s list
> > - is this at all the right place for that kind of discussion?
>=20
> Different translation teams use different places for discussions.
> The German uses this list.
>=20
> Like this, maybe.

Yes, that is already much better.

> [PATCH] l10n: de.po: improve translation of a rebase message
>=20
> The word "still" was translated as "bereits", change
> it to "noch". "valuable" was translated as "n=FCtzlich"
> which is more like "useful" than "valuable", change it
> to "sch=FCtzenswert".
>=20
> Noticed-by: Sascha Cunz <sascha-ml@babbelbox.org>
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
>=20
> diff --git a/po/de.po b/po/de.po
> index 2739bc0..7fc0185 100644
> --- a/po/de.po
> +++ b/po/de.po
> @@ -5756,8 +5756,8 @@ msgstr ""
>  "\t$cmd_live_rebase\n"
>  "Wenn das nicht der Fall ist, probiere bitte\n"
>  "\t$cmd_clear_stale_rebase\n"
> -"und f=FChre dieses Kommando nochmal aus. Es wird angehalten, falls
> bereits\n" -"etwas N=FCtzliches vorhanden ist."
> +"und f=FChre dieses Kommando nochmal aus. Es wird angehalten, falls =
noch\n"
> +"etwas Sch=FCtzenswertes vorhanden ist."
>=20
>  #: git-rebase.sh:395
>  #, sh-format
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
