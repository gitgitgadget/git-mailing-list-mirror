From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 16/17] po/pl.po: add Polish translation
Date: Mon, 30 Aug 2010 21:28:22 +0000
Message-ID: <1283203703-26923-17-git-send-email-avarab@gmail.com>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 30 23:30:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqBvg-0000N5-FO
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 23:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756047Ab0H3VaE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 17:30:04 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41451 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754666Ab0H3V34 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 17:29:56 -0400
Received: by mail-ww0-f44.google.com with SMTP id 28so136823wwb.1
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 14:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=SnD5K0PszDWAiZ8Fuffnv5PoxlefuXiyXMhXF0cnGkU=;
        b=U8qoKq6Bt+OA5R/GIJODNwgoP6r8ng6v6dANbLnSzMrKzrIB5LlF/+PTE/+Tf1NjM9
         W1l/pwfN0DBG/11vNx6zu2KTf4GgwnRrh3Al53IaIPXDVtAMlayvkBNKsLc+qzcMRqxb
         qnnoL3eS4YX24ExrkXyfjHOSh4hCYOkpFwQf4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=GUz6Zi4eKWItAmfPADjoI2Iyxhn9ituhp6B+ih7mHFVQYEImsGVKMv7iKQtzBdpl7g
         rzDVNCkc00M3moIxwTAWs+t2oeIMhrbSXn4eybnc0Dcm/4+QzCFZNJBibf6PKPqN8guL
         uwFMPHtAS9wG4TELV76exH3S7cL6ZqwEGEmIg=
Received: by 10.227.42.4 with SMTP id q4mr5049266wbe.156.1283203764766;
        Mon, 30 Aug 2010 14:29:24 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id b23sm6923116wbb.22.2010.08.30.14.29.20
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 30 Aug 2010 14:29:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.536.g3f548
In-Reply-To: <1283203703-26923-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154862>

=46rom: Marcin Cie=C5=9Blak <saper@saper.info>

Translate all the translatable messages currently in Git, except for
the 10 TEST messages that shouldn't be translated.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
Signed-off-by: Marcin Cie=C5=9Blak <saper@saper.info>
---
 po/pl.po |  187 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 187 insertions(+), 0 deletions(-)
 create mode 100644 po/pl.po

diff --git a/po/pl.po b/po/pl.po
new file mode 100644
index 0000000..dfdd416
--- /dev/null
+++ b/po/pl.po
@@ -0,0 +1,187 @@
+msgid ""
+msgstr ""
+"Project-Id-Version: Git\n"
+"Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
+"POT-Creation-Date: 2010-08-30 18:16+0000\n"
+"PO-Revision-Date: 2010-08-30 17:02+0200\n"
+"Last-Translator: Marcin Cie=C5=9Blak <saper@saper.info>\n"
+"Language-Team: Git Mailing List <git@vger.kernel.org>\n"
+"Language: pl\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+"Plural-Forms: nplurals=3D3; plural=3D(n=3D=3D1 ? 0 : n%10>=3D2 && n%1=
0<=3D4 && (n%100<10 || n%100>=3D20) ? 1 : 2);\n"
+
+#: builtin/init-db.c:34
+#, c-format
+msgid "Could not make %s writable by group"
+msgstr "Nie mog=C4=99 da=C4=87 prawa zapisu grupie w %s"
+
+#: builtin/init-db.c:61
+#, c-format
+msgid "insanely long template name %s"
+msgstr "beznadziejnie d=C5=82uga nazwa szablonu %s"
+
+#: builtin/init-db.c:66
+#, c-format
+msgid "cannot stat '%s'"
+msgstr "nie mog=C4=99 tkn=C4=85=C4=87 '%s'"
+
+#: builtin/init-db.c:72
+#, c-format
+msgid "cannot stat template '%s'"
+msgstr "nie mog=C4=99 tkn=C4=85=C4=87 szablonu '%s'"
+
+#: builtin/init-db.c:79
+#, c-format
+msgid "cannot opendir '%s'"
+msgstr "nie mog=C4=99 otworzy=C4=87 katalogu '%s'"
+
+#: builtin/init-db.c:96
+#, c-format
+msgid "cannot readlink '%s'"
+msgstr "readlink nie zadzia=C5=82a=C5=82o dla '%s'"
+
+#: builtin/init-db.c:98
+#, c-format
+msgid "insanely long symlink %s"
+msgstr "beznadziejnie d=C5=82ugi link symboliczny %s"
+
+#: builtin/init-db.c:101
+#, c-format
+msgid "cannot symlink '%s' '%s'"
+msgstr "nie mog=C4=99 za=C5=82o=C5=BCy=C4=87 symbolicznego link z '%s'=
 do '%s'"
+
+#: builtin/init-db.c:105
+#, c-format
+msgid "cannot copy '%s' to '%s'"
+msgstr "nie mog=C4=99 skopiowa=C4=87 '%s' to '%s'"
+
+#: builtin/init-db.c:109
+#, c-format
+msgid "ignoring template %s"
+msgstr "pomijam szablon %s"
+
+#: builtin/init-db.c:132
+#, c-format
+msgid "insanely long template path %s"
+msgstr "beznadziejnie d=C5=82uga =C5=9Bie=C5=BCka do wzorca %s"
+
+#: builtin/init-db.c:140
+#, c-format
+msgid "templates not found %s"
+msgstr "nie znaleziono szablon=C3=B3w %s"
+
+#: builtin/init-db.c:153
+#, c-format
+msgid "not copying templates of a wrong format version %d from '%s'"
+msgstr "nie b=C4=99d=C4=99 kopiowa=C4=87 szablon=C3=B3w oznaczonych ni=
ew=C5=82a=C5=9Bciwym numerem wersji %d z '%s'"
+
+#: builtin/init-db.c:191
+#, c-format
+msgid "insane git directory %s"
+msgstr "beznadziejny katalog gita %s"
+
+#. TRANSLATORS: The first '%s' is either "Reinitialized
+#. existing" or "Initialized empty", the second " shared" or
+#. "", and the last '%s%s' is the verbatim directory name.
+#: builtin/init-db.c:355
+#, c-format
+msgid "%s%s Git repository in %s%s\n"
+msgstr "%s%s repozytorium Gita w %s%s\n"
+
+#: builtin/init-db.c:356
+msgid "Reinitialized existing"
+msgstr "Ponownie zainicjowa=C5=82em istniej=C4=85ce"
+
+#: builtin/init-db.c:356
+msgid "Initialized empty"
+msgstr "Utworzy=C5=82em puste"
+
+#: builtin/init-db.c:357
+msgid " shared"
+msgstr " wsp=C3=B3=C5=82dzielone"
+
+#: builtin/init-db.c:376
+msgid "cannot tell cwd"
+msgstr "nie wiem w kt=C3=B3rym katalogu jestem"
+
+#: builtin/init-db.c:450 builtin/init-db.c:457
+#, c-format
+msgid "cannot mkdir %s"
+msgstr "nie mog=C4=99 utworzy=C4=87 katalogu %s"
+
+#: builtin/init-db.c:461
+#, c-format
+msgid "cannot chdir to %s"
+msgstr "nie mog=C4=99 wej=C5=9B=C4=87 do katalogu %s"
+
+#: builtin/init-db.c:483
+#, c-format
+msgid "%s (or --work-tree=3D<directory>) not allowed without specifyin=
g %s (or --git-dir=3D<directory>)"
+msgstr "nie mo=C5=BCna u=C5=BCy=C4=87 %s (or --work-tree=3D<katalog>) =
bez podania %s (or --git-dir=3D<katalog>)"
+
+#: builtin/init-db.c:509
+msgid "Cannot access current working directory"
+msgstr "Nie mog=C4=99 dobra=C4=87 si=C4=99 do bie=C5=BC=C4=85cego kata=
logu"
+
+#: builtin/init-db.c:512
+#, c-format
+msgid "Cannot access work tree '%s'"
+msgstr "Nie mog=C4=99 dosta=C4=87 si=C4=99 do drzewa roboczego '%s'"
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#: t/t0200/test.c:5
+msgid "See 'git help COMMAND' for more information on a specific comma=
nd."
+msgstr ""
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#: t/t0200/test.c:10
+msgid "TEST: A C test string"
+msgstr ""
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#: t/t0200/test.c:13
+#, c-format
+msgid "TEST: A C test string %s"
+msgstr ""
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#: t/t0200/test.c:16
+#, c-format
+msgid "TEST: Hello World!"
+msgstr ""
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#: t/t0200/test.c:19
+#, c-format
+msgid "TEST: Old English Runes"
+msgstr ""
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#: t/t0200/test.c:22
+#, c-format
+msgid "TEST: =E2=80=98single=E2=80=99 and =E2=80=9Cdouble=E2=80=9D quo=
tes"
+msgstr ""
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#: t/t0200/test.sh:8
+msgid "TEST: A Shell test string"
+msgstr ""
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#: t/t0200/test.sh:11
+#, sh-format
+msgid "TEST: A Shell test $variable"
+msgstr ""
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#: t/t0200/test.perl:8
+msgid "TEST: A Perl test string"
+msgstr ""
+
+#. TRANSLATORS: This is a test. You don't need to translate it.
+#: t/t0200/test.perl:11
+#, perl-format
+msgid "TEST: A Perl test variable %s"
+msgstr ""
--=20
1.7.2.2.536.g3f548
