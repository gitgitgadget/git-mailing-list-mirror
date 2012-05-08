From: Jiang Xin <worldhello.net@gmail.com>
Subject: Pull request for master branch with update of de.po
Date: Tue, 8 May 2012 09:09:20 +0800
Message-ID: <CANYiYbHhgdQgJajR-_moQuiX8ZEfdAWQ8+z1AHJDFa3HO5sQgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Tue May 08 03:09:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRYvf-0003vM-AW
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 03:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755718Ab2EHBJW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 May 2012 21:09:22 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:61561 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754061Ab2EHBJV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2012 21:09:21 -0400
Received: by yenm10 with SMTP id m10so4342802yen.19
        for <git@vger.kernel.org>; Mon, 07 May 2012 18:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jHa8c+SKx2BXCm26KGUoTSReE2b+LAnxHt4yPwId9Kw=;
        b=uB73Mrb9YVxbFa01hfcqX4F8EZ+BK4zcKNrcY7LxPJzAyalgKZWz8sDJad7om7nVB7
         2QLLPsQ4ruqLVDweqK1OWkSZtVOn5w6CkAXsW8gJ+ONntDIcue/h6nGYS0TsqtmRhMZZ
         UUkwv1HcXr5lACD0G527XwH1gYJzTH+nHm7qNJ+bJJqa0jOoNkTlEJu5EFIZvNnJbDIP
         zw1IC5hiHIZG9DBGnm5TDLTp6lkilrmPpSlUNUG3Pt9G2JlCGpTc4iKDX3hvSCUNK2N7
         JWt09oTUuQt6+ozy38lhqgGEJmSFljhOIKBHSEqyTu/3JErJK89Ssu2F5ZHKM7eQVoLH
         Dm7w==
Received: by 10.50.168.8 with SMTP id zs8mr3012834igb.37.1336439360526; Mon,
 07 May 2012 18:09:20 -0700 (PDT)
Received: by 10.50.134.102 with HTTP; Mon, 7 May 2012 18:09:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197334>

Hi Junio and members of German l10n team,

This pull request for master branch includes update of German translati=
ons.
Ralf merged their hacks on maint branch to master branch, and resolved
conflicts in de.po which are hard for me to resolved. Thanks Ralf.

The same issue needs Junio to make the final decision:
One commit (fbd994d) by Thomas hacks a file "git-gui/po/de.po",
which is outside of "po/" directory.

The following changes since commit 34875f4a53b9e495622553a671776f66dc37=
eb2b:

  The eighth batch of topics graduated to 'master' (2012-05-02 14:38:43=
 -0700)

are available in the git repository at:

  https://github.com/git-l10n/git-po/ master

for you to fetch changes up to 80e4ba8ddb3224f40a1a896b2db8aa3a83cc0dab=
:

  Merge branch 'maint' into master (2012-05-07 20:44:21 +0200)

----------------------------------------------------------------

Jiang Xin (1):
      l10n: Update git.pot (273 new, 15 removed messages)

Ralf Thielow (6):
      l10n: add new members to German translation team
      l10n: de.po: translate "track" as "beobachten"
      l10n: de.po: translate "remote" as "extern"
      l10n: de.po: collection of improvements
      l10n: de.po: unify translation of "ahead" and "behind"
      Merge branch 'maint' into master

Thomas Rast (4):
      de.po: translate "bare" as "blo=DF"
      de.po: hopefully uncontroversial fixes
      de.po: translate "bad" as "ung=FCltig" ("invalid")
      de.po: collection of suggestions

 git-gui/po/de.po |    2 +-
 po/TEAMS         |    3 +
 po/de.po         |  479 +++++-----
 po/git.pot       | 2724 ++++++++++++++++++++++++++++++++++++++++------=
--------
 4 files changed, 2245 insertions(+), 963 deletions(-)

--=20
Jiang Xin
