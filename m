From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH/RFC] l10n: de.po: translate 2 new messages
Date: Fri, 7 Sep 2012 18:31:46 +0800
Message-ID: <CANYiYbFBoK7D+9oZ2YGsrHYafOETLRUWUmHzfnAyA7RRhqgEkA@mail.gmail.com>
References: <1346865100-10908-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de,
	git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Fri Sep 07 12:31:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9vqu-0000ZJ-KL
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 12:31:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760251Ab2IGKbt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Sep 2012 06:31:49 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:38983 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757399Ab2IGKbr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Sep 2012 06:31:47 -0400
Received: by ieje11 with SMTP id e11so4743381iej.19
        for <git@vger.kernel.org>; Fri, 07 Sep 2012 03:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=T0xVqhfFkYefTV5z5TZdtMeKJdhdmGQu6gPC5qs8G9A=;
        b=cYL411KHRrkI/0Lb0FwPKfTrT1jQr6wgZs1Rqifl6pSSzGOQ66BWRR+7kk6i3oQXMR
         43wKkDU7UPCggM73X7rppJoeGcdUHYKA26PwOknwCUujtN49H8LOAFLmYdHUXjvYvdfV
         nwa6dGf7wGNa7hIAK9yd/7tPtNY7IoHgDMq5QCTx9oUo5XeWN4tE9b4eUS+DGz1eZvJA
         wlOhNuIQAo2WpWcJW8CExewkyJCujwf4+AYOoStAJg2UGZ9uewWhcGmrgC9Hckj1/hC8
         JSKkbXd7ceswCqoQP18xlzKDxFsYG2EuvlqdWvuTuEcGY86Wt6sYxQQVz5CCR07+4GSn
         +SIg==
Received: by 10.50.187.202 with SMTP id fu10mr5580477igc.59.1347013907111;
 Fri, 07 Sep 2012 03:31:47 -0700 (PDT)
Received: by 10.50.42.230 with HTTP; Fri, 7 Sep 2012 03:31:46 -0700 (PDT)
In-Reply-To: <1346865100-10908-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204958>

I just notice that the 1st line of the orignal message below has
only 56  characters, much shorter than other lines. It is because
this is a warning message, and would add a prefix: "warning: ".

#: builtin/push.c:151
msgid ""
"push.default is unset; its implicit value is changing in\n"
"Git 2.0 from 'matching' to 'simple'. To squelch this message\n"
"and maintain the current behavior after the default changes, use:\n"
"\n"
"  git config --global push.default matching\n"

=46or this reason, translations as follows are not well-formed.
So I rewind git-po, and your commits may need a bit amend.

Swedish update from Peter:

+"push.default har inte st=C3=A4llts in; dess underf=C3=B6rst=C3=A5dda =
v=C3=A4rde =C3=A4ndras i\n"
+"Git 2.0 fr=C3=A5n \"matching\" till \"simple\". F=C3=B6r att undertry=
cka det h=C3=A4r\n"
+"meddelandet och beh=C3=A5lla nuvarande beteende efter att f=C3=B6rval=
et =C3=A4ndras,\n"
+"skriver du:\n"
+"\n"
+"  git config --global push.default matching\n"

Vietnamese update form Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n:

+msgstr ""
+"push.default ch=C6=B0a =C4=91=C6=B0=E1=BB=A3c =C4=91=E1=BA=B7t, gi=C3=
=A1 tr=E1=BB=8B ng=E1=BA=A7m =C4=91=E1=BB=8Bnh c=E1=BB=A7a n=C3=B3 =C4=91=
=C3=A3 =C4=91=C6=B0=E1=BB=A3c thay =C4=91=E1=BB=95i trong\n"
+"Git 2.0 t=E1=BB=AB 'matching' th=C3=A0nh 'simple'. =C4=90=E1=BB=83 ch=
=E1=BA=A5m d=E1=BB=A9t l=E1=BB=9Di nh=E1=BA=AFc nh=E1=BB=9F n=C3=A0y\n"
+"v=C3=A0 duy tr=C3=AC c=C3=A1ch x=E1=BB=AD l=C3=BD sau nh=E1=BB=AFng t=
hay =C4=91=E1=BB=95i m=E1=BA=B7c =C4=91=E1=BB=8Bnh n=C3=A0y, h=C3=A3y c=
h=E1=BA=A1y l=E1=BB=87nh:\n"
+"\n"
+"  git config --global push.default matching\n"



2012/9/6 Ralf Thielow <ralf.thielow@gmail.com>:
> Translate 2 new messages came from git.pot update in
> ccfca8d (l10n: Update git.pot (2 new, 4 removed messages)).
>
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
>
> Hi German l10n team,
>
> please review this small update on German translation.
> This patch here is based on a preparation commit which
> just contains the "msgmerge" change.
> For an easier review, I'll copy the first message in english
> in this email.
> The second change shows that there are some newlines, came
> from 'msgmerge', on places where we don't want to have them.
> I'll fix that soon.
>
> A hint on this translation:
> I've translated "See 'git help config' and search for" as
> "F=C3=BChre 'git help config' aus und suche nach...", not as
> "Siehe 'git help config' und suche nach..." because the second
> doesn't sound good to me. Perhaps someone else has a better
> idea.
>
> Thanks,
> Ralf
>
> #: builtin/push.c:151
> msgid ""
> "push.default is unset; its implicit value is changing in\n"
> "Git 2.0 from 'matching' to 'simple'. To squelch this message\n"
> "and maintain the current behavior after the default changes, use:\n"
> "\n"
> "  git config --global push.default matching\n"
> "\n"
> "To squelch this message and adopt the new behavior now, use:\n"
> "\n"
> "  git config --global push.default simple\n"
> "\n"
> "See 'git help config' and search for 'push.default' for further "
> "information.\n"
> "(the 'simple' mode was introduced in Git 1.7.11. Use the similar mod=
e\n"
> "'current' instead of 'simple' if you sometimes use older versions of=
 Git)"
>
>  po/de.po | 20 ++++++++++++++++++--
>  1 Datei ge=C3=A4ndert, 18 Zeilen hinzugef=C3=BCgt(+), 2 Zeilen entfe=
rnt(-)
>
> diff --git a/po/de.po b/po/de.po
> index f3d232e..df5187e 100644
> --- a/po/de.po
> +++ b/po/de.po
> @@ -4431,6 +4431,23 @@ msgid ""
>  "(the 'simple' mode was introduced in Git 1.7.11. Use the similar mo=
de\n"
>  "'current' instead of 'simple' if you sometimes use older versions o=
f Git)"
>  msgstr ""
> +"'push.default' ist nicht gesetzt; der implizit gesetzte Wert wird i=
n\n"
> +"Git 2.0 von 'matching' nach 'simple' ge=C3=A4ndert. Um diese Meldun=
g zu unter-\n"
> +"dr=C3=BCcken und das aktuelle Verhalten nach =C3=84nderung des Stan=
dardwertes\n"
> +"beizubehalten, benutze:"
> +"\n"
> +"  git config --global push.default matching\n"
> +"\n"
> +"Um diese Meldung zu unterdr=C3=BCcken und das neue Verhalten jetzt =
zu =C3=BCbernehmen,\n"
> +"benutze:\n"
> +"\n"
> +"  git config --global push.default simple\n"
> +"\n"
> +"F=C3=BChre 'git help config' aus und suche nach 'push.default' f=C3=
=BCr weitere "
> +"Informationen.\n"
> +"(Der Modus 'simple' wurde in Git 1.7.11 eingef=C3=BChrt. Benutze de=
n gleichartigen"
> +" Modus 'current' anstatt 'simple', falls du gelegentlich =C3=A4lter=
e Versionen von"
> +" Git benutzt)"
>
>  #: builtin/push.c:199
>  msgid ""
> @@ -4453,7 +4470,6 @@ msgstr ""
>  "f=C3=BCr weitere Details."
>
>  #: builtin/push.c:212
> -#, fuzzy
>  msgid ""
>  "Updates were rejected because a pushed branch tip is behind its rem=
ote\n"
>  "counterpart. If you did not intend to push that branch, you may wan=
t to\n"
> @@ -4465,7 +4481,7 @@ msgstr ""
>  "beabsichtigt hast, diesen Zweig zu versenden, kannst du auch den zu=
 "
>  "versendenden\n"
>  "Zweig spezifizieren oder die Konfigurationsvariable 'push.default' =
zu "
> -"'current'\n"
> +"'simple', 'current'\n"
>  "oder 'upstream' setzen, um nur den aktuellen Zweig zu versenden."
>
>  #: builtin/push.c:218
> --
> 1.7.12
>



--=20
=E8=92=8B=E9=91=AB

=E5=8C=97=E4=BA=AC=E7=BE=A4=E8=8B=B1=E6=B1=87=E4=BF=A1=E6=81=AF=E6=8A=80=
=E6=9C=AF=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8
=E9=82=AE=E4=BB=B6: worldhello.net@gmail.com
=E7=BD=91=E5=9D=80: http://www.ossxp.com/
=E5=8D=9A=E5=AE=A2: http://www.worldhello.net/
=E5=BE=AE=E5=8D=9A: http://weibo.com/gotgit/
=E7=94=B5=E8=AF=9D: 010-51262007, 18601196889
