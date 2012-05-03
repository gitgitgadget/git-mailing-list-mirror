From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: Please pull git-po master branch
Date: Thu, 3 May 2012 12:31:57 +0800
Message-ID: <CANYiYbH+N3k_=FWyeS_HfBWSBeBdOUqW5qrHFe=qV4ECtYABpA@mail.gmail.com>
References: <CANYiYbHtKKWw9LPnr+1khC5Oms-kOtA2WEucoNoE3Njzqiahzw@mail.gmail.com>
	<87d36n2f2r.fsf@thomas.inf.ethz.ch>
	<7vtxzyilid.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Byrial Jensen <byrial@vip.cybercity.dk>,
	Vincent van Ravesteijn <vfr@lyx.org>,
	Marco Sousa <marcomsousa@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Thu May 03 06:32:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPniW-0008Ry-QQ
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 06:32:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941Ab2ECEcA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 May 2012 00:32:00 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:52135 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826Ab2ECEb7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 May 2012 00:31:59 -0400
Received: by yhmm54 with SMTP id m54so1436321yhm.19
        for <git@vger.kernel.org>; Wed, 02 May 2012 21:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=UzySUbxSdZ4xvgjWqzMbKx2bOYN2xLH0zn2fBQ3Gcyk=;
        b=SrnW8RFjFP0vK8U4ozq/LL7DJ6dQPKXCN74+dmDUApbd7Bg26YeA4clHzh4J3KRB+g
         3PSOaKMogMsmd5jv40FWc5IndukuRo/VFIb6gEGrwnJH4FJ8z9nTzv/SyoeVE24Y/YM/
         S4f06YT7uM0JZGYRA5EaZyYvdk5aA/zDj7+Jk+vSDT97yR55gQnbnGbK1npsT7cRWv6e
         u6jG/coLs2bzAdiZywOEXvP8IBvWRj0JtNtX+hBp7TtClNHTIbD3Ahp/apzZCECxe0Qa
         q+Hf0Onouak0g6zVEpJyTQOb8kOsGDTmg3el0WBOOXyUFDMHHro2LoCmxTFjGAoP8QyB
         S0lA==
Received: by 10.42.28.135 with SMTP id n7mr303811icc.46.1336019517990; Wed, 02
 May 2012 21:31:57 -0700 (PDT)
Received: by 10.50.207.40 with HTTP; Wed, 2 May 2012 21:31:57 -0700 (PDT)
In-Reply-To: <7vtxzyilid.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196886>

2012/5/3 Junio C Hamano <gitster@pobox.com>:
> Thomas Rast <trast@student.ethz.ch> writes:
>
>> Hi Xin (is that how you are properly addressed?)
Yeah, as a Chinese, surname is always before given name.

>> Junio C Hamano <gitster@pobox.com> writes:
> There is nothing to "Sigh" about. =A0Mistakes happen, and we learn fr=
om it.

What I have learned from this:

 * Only pull reqests with updates of already exists language are accept=
ed
   for the 'maint' branch of git-po. If a new l10n language support wan=
ts to
   be added to 'maint' branch or to the RC version, it must be fully
   discussed int this list.

 * Pull requests with a initial XX.po (untranslated) and updated TEAMS =
file
   will not merge to the master branch, but merge to a work in progress
   branch, such as WIP/XX.

   In order to coordinate works of potential contributors for a new l10=
n
   language, l10n team leader (the 1st contributor send me a pull reque=
st)
   will send a pull requst with a untranslated XX.po and update TEAMS
   file with URL of the dedicated repository for the new language XX.
   Nobody can guarantee how long XX.po will 100% translated. If merge
   this initial commit too soon to the master branch, unfinished *.po w=
ill
   be released, like da.po from Byrial Jensen, nl.po from
   Vincent van Ravesteijn, and pt_PT.po from Marco Sousa.
   So create a WIP/XX branch may resolved this problem.

Update the po/README file as follows, does it make sense?

diff --git a/po/README b/po/README
index c1520..6e047 100644
--- a/po/README
+++ b/po/README
@@ -10,19 +10,36 @@ coordinates our localization effort in the l10
coordinator repository:

         https://github.com/git-l10n/git-po/

-As a contributor for a language XX, you should first check TEAMS file =
in
-this directory to see whether a dedicated repository for your language=
 XX
-exists. Fork the dedicated repository and start to work if it exists.
+As a contributor for a language XX, you should first check whether a
+dedicated repository for your language XX already exists.
+
+ * Check po/TEAMS file in the master branch of git-po to see whether a
+   dedicated repository for your language XX exists.
+
+ * If a work in progress branch 'WIP/XX' exists in the l10n coordinato=
r
+   repository, check po/TEAMS file in it.
+
+When you find the dedicated repository, fork it and start to work.

 If you are the first contributor for the language XX, please fork this
-repository, prepare and/or update the translated message file po/XX.po
-(described later), and ask the l10n coordinator to pull your work.
+repository, make a initial commit with the po/XX.po file (based on the
+po/git.pot in the master branch, and untranslated is fine) and a updat=
ed
+po/TEAMS file (indent with TABS, no SPACES), and ask the l10n
+coordinator to pull your work.
+
+The l10n coordinator will prepare a new branch, WIP/XX, for your langu=
age,
+so other contributors can find your team easily.

 If there are multiple contributors for the same language, please first
 coordinate among yourselves and nominate the team leader for your
 language, so that the l10n coordinator only needs to interact with one
 person per language.

+After translations on po/XX.po is 100% complete, l10n team leader for
+language XX should send a pull request again. If the translations pass
+the basic syntax check, the l10n coordinator will merge your work to
+the master branch of git-po, and delete the WIP/XX branch.
+
 The overall data-flow looks like this:

     +-------------------+            +------------------+
@@ -52,11 +69,20 @@ Maintaining the po/git.pot file

 The po/git.pot file contains a message catalog extracted from Git's
 sources. The l10n coordinator maintains it by adding new translations =
with
-msginit(1), or update existing ones with msgmerge(1).  In order to upd=
ate
-the Git sources to extract the messages from, the l10n coordinator is
-expected to pull from the main git repository at strategic point in
-history (e.g. when a major release and release candidates are tagged),
-and then run "make pot" at the top-level directory.
+msginit(1), or update existing ones with msgmerge(1).
+
+The two branches (maint and master) in git-po are used for tracking l1=
0n
+of the counterparts of git.git. The update of po/git.pot for these two
+branches are slight different.
+
+ * When there are significant i18n updates in git.git master branch, t=
he
+   l10n coordinator will pull from the master branch of the main git
+   repository, and then run "make pot" at the top-level directory.
+
+ * When there are significant i18n updates in git.git maint branch, up=
date
+   the po/git.pot file like the above. Then, the l10n coordinator shou=
ld
+   merge updates in the maint branch back to the master branch, and ch=
oose
+   local po/git.pot as a conflict resolution.

 Language contributors use this file to prepare translations for their
 language, but they are not expected to modify it.
@@ -68,7 +94,8 @@ Initializing a XX.po file
 (This is done by the language teams).

 If your language XX does not have translated message file po/XX.po yet=
,
-you add a translation for the first time by running:
+you add a translation (based on the po/git.pot file in the master bran=
ch)
+for the first time by running:

     msginit --locale=3DXX

@@ -116,6 +143,14 @@ in the po/ directory, where XX.po is the file you
want to update.
 Once you are done testing the translation (see below), commit the resu=
lt
 and ask the l10n coordinator to pull from you.

+Please note:
+
+ * commits to the master branch will go into the next release;
+ * commits to the maint branch will go into the next "maintenance
+   release"; and
+ * commits to the maint branch will merge back to the master branch by=
 the
+   l10n coordinator.
+

--=20
Jiang Xin
