From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: l10n: Update Catalan translation
Date: Mon, 05 Oct 2015 22:38:23 -0700
Message-ID: <xmqqk2r0wo8g.fsf@gitster.mtv.corp.google.com>
References: <1444105572-20580-1-git-send-email-alexhenrie24@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: paulus@samba.org, git@vger.kernel.org
To: Alex Henrie <alexhenrie24@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 06 07:38:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjKxK-0002Pk-Dq
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 07:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbbJFFi0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Oct 2015 01:38:26 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:32814 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbbJFFiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2015 01:38:25 -0400
Received: by pacex6 with SMTP id ex6so199424633pac.0
        for <git@vger.kernel.org>; Mon, 05 Oct 2015 22:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=ABEEw2n3cw5hvgjy3UFMV4a+Ftbf+oXwwYZ5zTsMXuc=;
        b=xVNQRIKW3sjicXar84Vi/i+Exd2Q6WFC09IWNHSty/x7khFMGuOx8cf087xueQbnGL
         oUDNL77DiTahZ/FNM2ICh6GKKVGL3zX2aRZMATa2kOPNv4pNFFq9d793DwuhA5c4hZTE
         NO6LIPIiD4ENAnbBNdlbeeYCY1EVp6T/FZQ1ZRZFKNrFZXvkmgp4bbszpuCDvjguyBYb
         k7VOyKhqws8nlGeXV1rkN6tu6BE3sdvmY0McdoSCYIbRh8O3NANs6bhPsU4qEjx3tAIv
         LGyzceUkJ21AQwKO/hJbtTLgk3XNqtJ/A026Oh15hAyDUoQUpOfElTmegHeJ5ow8sBsK
         8jdg==
X-Received: by 10.68.139.194 with SMTP id ra2mr45676694pbb.6.1444109905222;
        Mon, 05 Oct 2015 22:38:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:a14c:f96c:97d2:eee0])
        by smtp.gmail.com with ESMTPSA id b7sm29088888pas.31.2015.10.05.22.38.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 05 Oct 2015 22:38:24 -0700 (PDT)
In-Reply-To: <1444105572-20580-1-git-send-email-alexhenrie24@gmail.com> (Alex
	Henrie's message of "Mon, 5 Oct 2015 22:26:12 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279120>

Alex Henrie <alexhenrie24@gmail.com> writes:

> The gitk included in git 2.6.0 crashes if run from a Catalan locale.
> I'm hoping that a translation update will fix this.

I seriously hope that l10n files would not "crash" applications.

I wonder if you are hitting $gmane/278863 perhaps?


>
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  po/ca.po | 53 +++++++++++++++++++++++++----------------------------
>  1 file changed, 25 insertions(+), 28 deletions(-)
>
> diff --git a/po/ca.po b/po/ca.po
> index 976037a..1106a30 100644
> --- a/po/ca.po
> +++ b/po/ca.po
> @@ -9,7 +9,7 @@ msgstr ""
>  "Project-Id-Version: gitk\n"
>  "Report-Msgid-Bugs-To: \n"
>  "POT-Creation-Date: 2015-05-17 14:32+1000\n"
> -"PO-Revision-Date: 2015-02-01 22:49-0700\n"
> +"PO-Revision-Date: 2015-10-05 22:23-0600\n"
>  "Last-Translator: Alex Henrie <alexhenrie24@gmail.com>\n"
>  "Language-Team: Catalan\n"
>  "Language: ca\n"
> @@ -17,7 +17,7 @@ msgstr ""
>  "Content-Type: text/plain; charset=3DUTF-8\n"
>  "Content-Transfer-Encoding: 8bit\n"
>  "Plural-Forms: nplurals=3D2; plural=3D(n !=3D 1);\n"
> -"X-Generator: Poedit 1.7.3\n"
> +"X-Generator: Poedit 1.8.5\n"
> =20
>  #: gitk:140
>  msgid "Couldn't get list of unmerged files:"
> @@ -136,7 +136,7 @@ msgstr "Edita la vista..."
> =20
>  #: gitk:2086
>  msgid "Delete view"
> -msgstr "Suprimeix vista"
> +msgstr "Suprimeix la vista"
> =20
>  #: gitk:2088 gitk:4043
>  msgid "All files"
> @@ -330,7 +330,7 @@ msgstr "Elimina aquesta branca"
> =20
>  #: gitk:2649
>  msgid "Copy branch name"
> -msgstr ""
> +msgstr "Copia el nom de branca"
> =20
>  #: gitk:2656
>  msgid "Highlight this too"
> @@ -350,7 +350,7 @@ msgstr "Culpabilitat de la comissi=C3=B3 mare"
> =20
>  #: gitk:2660
>  msgid "Copy path"
> -msgstr ""
> +msgstr "Copia el cam=C3=AD"
> =20
>  #: gitk:2667
>  msgid "Show origin of this line"
> @@ -408,11 +408,11 @@ msgstr "<Fi>\t\tV=C3=A9s a l'=C3=BAltima comiss=
i=C3=B3"
> =20
>  #: gitk:3052
>  msgid "<Up>, p, k\tMove up one commit"
> -msgstr "<Amunt>, p, k\tMou-te una comissi=C3=B3 amunt"
> +msgstr "<Amunt>, p, k\tMou-te cap amunt per una comissi=C3=B3"
> =20
>  #: gitk:3053
>  msgid "<Down>, n, j\tMove down one commit"
> -msgstr "<Avall>, n, j\tMou-te una comissi=C3=B3 avall"
> +msgstr "<Avall>, n, j\tMou-te cap avall per una comissi=C3=B3"
> =20
>  #: gitk:3054
>  msgid "<Left>, z, h\tGo back in history list"
> @@ -430,11 +430,11 @@ msgstr ""
> =20
>  #: gitk:3057
>  msgid "<PageUp>\tMove up one page in commit list"
> -msgstr "<ReP=C3=A0g>\tBaixa una p=C3=A0gina en la llista de comissio=
ns"
> +msgstr "<ReP=C3=A0g>\tMou-te cap amunt per una p=C3=A0gina en la lli=
sta de comissions"
> =20
>  #: gitk:3058
>  msgid "<PageDown>\tMove down one page in commit list"
> -msgstr "<AvP=C3=A0g>\tBaixa per una p=C3=A0gina en la llista de comi=
ssions"
> +msgstr "<AvP=C3=A0g>\tMou-te cap avall per una p=C3=A0gina en la lli=
sta de comissions"
> =20
>  #: gitk:3059
>  #, tcl-format
> @@ -449,50 +449,50 @@ msgstr "<%s-Fi>\tDespla=C3=A7a't a la part infe=
rior
> de la llista de comissions"
>  #: gitk:3061
>  #, tcl-format
>  msgid "<%s-Up>\tScroll commit list up one line"
> -msgstr "<%s-Amunt>\tDespla=C3=A7a la llista de comissions una l=C3=AD=
nia cap amunt"
> +msgstr "<%s-Amunt>\tDespla=C3=A7a la llista de comissions cap amunt =
per una l=C3=ADnia"
> =20
>  #: gitk:3062
>  #, tcl-format
>  msgid "<%s-Down>\tScroll commit list down one line"
> -msgstr "<%s-Avall>\tDespla=C3=A7a la llista de comissions una l=C3=AD=
nia cap avall"
> +msgstr "<%s-Avall>\tDespla=C3=A7a la llista de comissions cap avall =
per una l=C3=ADnia"
> =20
>  #: gitk:3063
>  #, tcl-format
>  msgid "<%s-PageUp>\tScroll commit list up one page"
> -msgstr "<%s-ReP=C3=A0g>\tDespla=C3=A7a la llista de comissions amunt=
 per una p=C3=A0gina"
> +msgstr "<%s-ReP=C3=A0g>\tDespla=C3=A7a la llista de comissions cap a=
munt per una p=C3=A0gina"
> =20
>  #: gitk:3064
>  #, tcl-format
>  msgid "<%s-PageDown>\tScroll commit list down one page"
> -msgstr "<%s-AvP=C3=A0g>\tDespla=C3=A7a la llista de comissions una p=
=C3=A0gina cap avall"
> +msgstr "<%s-AvP=C3=A0g>\tDespla=C3=A7a la llista de comissions cap a=
vall per una p=C3=A0gina"
> =20
>  #: gitk:3065
>  msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
> -msgstr "<Maj-Amunt>\tCerca cap enrere (amunt, les comissions m=C3=A9=
s noves)"
> +msgstr "<Maj-Amunt>\tCerca cap enrere (cap amunt, les comissions m=C3=
=A9s noves)"
> =20
>  #: gitk:3066
>  msgid "<Shift-Down>\tFind forwards (downwards, earlier commits)"
> -msgstr "<Maj-Avall>\tCerca cap endavant (avall, les comissions m=C3=A9=
s velles)"
> +msgstr "<Maj-Avall>\tCerca cap endavant (cap avall, les comissions m=
=C3=A9s velles)"
> =20
>  #: gitk:3067
>  msgid "<Delete>, b\tScroll diff view up one page"
> -msgstr "<Supr>, b\tDespla=C3=A7a la vista de difer=C3=A8ncia una p=C3=
=A0gina cap amunt"
> +msgstr "<Supr>, b\tDespla=C3=A7a la vista de difer=C3=A8ncia cap amu=
nt per una p=C3=A0gina"
> =20
>  #: gitk:3068
>  msgid "<Backspace>\tScroll diff view up one page"
> -msgstr "<Retroc=C3=A9s>\tDespla=C3=A7a la vista de difer=C3=A8ncia u=
na p=C3=A0gina cap amunt"
> +msgstr "<Retroc=C3=A9s>\tDespla=C3=A7a la vista de difer=C3=A8ncia c=
ap amunt per una p=C3=A0gina"
> =20
>  #: gitk:3069
>  msgid "<Space>\t\tScroll diff view down one page"
> -msgstr "<Espai>\t\tDespla=C3=A7a la vista de difer=C3=A8ncia una p=C3=
=A0gina cap avall"
> +msgstr "<Espai>\t\tDespla=C3=A7a la vista de difer=C3=A8ncia cap ava=
ll per una p=C3=A0gina"
> =20
>  #: gitk:3070
>  msgid "u\t\tScroll diff view up 18 lines"
> -msgstr "u\t\tDespla=C3=A7a la vista de difer=C3=A8ncia 18 l=C3=ADnie=
s cap amunt"
> +msgstr "u\t\tDespla=C3=A7a la vista de difer=C3=A8ncia cap amunt per=
 18 l=C3=ADnies"
> =20
>  #: gitk:3071
>  msgid "d\t\tScroll diff view down 18 lines"
> -msgstr "d\t\tDespla=C3=A7a la vista de difer=C3=A8ncia 18 l=C3=ADnie=
s cap avall "
> +msgstr "d\t\tDespla=C3=A7a la vista de difer=C3=A8ncia cap avall per=
 18 l=C3=ADnies"
> =20
>  #: gitk:3072
>  #, tcl-format
> @@ -509,9 +509,8 @@ msgid "<Return>\tMove to next find hit"
>  msgstr "<Retorn>\tMou-te a la propera coincid=C3=A8ncia de la cerca"
> =20
>  #: gitk:3075
> -#, fuzzy
>  msgid "g\t\tGo to commit"
> -msgstr "<Fi>\t\tV=C3=A9s a l'=C3=BAltima comissi=C3=B3"
> +msgstr "g\t\tV=C3=A9s a l'=C3=BAltima comissi=C3=B3"
> =20
>  #: gitk:3076
>  msgid "/\t\tFocus the search box"
> @@ -668,9 +667,8 @@ msgid "Matches all Commit Info criteria"
>  msgstr "Coincideix amb tots els criteris d'informaci=C3=B3 de comiss=
i=C3=B3"
> =20
>  #: gitk:4086
> -#, fuzzy
>  msgid "Matches no Commit Info criteria"
> -msgstr "Coincideix amb tots els criteris d'informaci=C3=B3 de comiss=
i=C3=B3"
> +msgstr "No coincideix amb cap criteri d'informaci=C3=B3 de comissi=C3=
=B3"
> =20
>  #: gitk:4087
>  msgid "Changes to Files:"
> @@ -1310,7 +1308,7 @@ msgstr "fons de la l=C3=ADnia marcada"
> =20
>  #: gitk:11450
>  msgid "Select bg"
> -msgstr "fons de la selecci=C3=B3"
> +msgstr "Fons de la selecci=C3=B3"
> =20
>  #: gitk:11459
>  msgid "Fonts: press to choose"
> @@ -1354,6 +1352,8 @@ msgid ""
>  "Sorry, gitk cannot run with this version of Tcl/Tk.\n"
>  " Gitk requires at least Tcl/Tk 8.4."
>  msgstr ""
> +"Perd=C3=B3, el gitk no pot executar-se amb aquesta versi=C3=B3 de T=
cl/Tk.\n"
> +" El Gitk requereix com a m=C3=ADnim el Tcl/Tk 8.4."
> =20
>  #: gitk:12269
>  msgid "Cannot find a git repository here."
> @@ -1367,6 +1367,3 @@ msgstr "Par=C3=A0metre ambigu '%s': =C3=A9s tan=
t revisi=C3=B3 com nom de fitxer"
>  #: gitk:12328
>  msgid "Bad arguments to gitk:"
>  msgstr "Par=C3=A0metres dolents al gitk:"
> -
> -#~ msgid "mc"
> -#~ msgstr "mc"
