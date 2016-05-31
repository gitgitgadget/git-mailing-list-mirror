From: Jordan DE GEA <jordan.de-gea@grenoble-inp.org>
Subject: [RFC/PATCH] Triangular Workflow UI improvement: Documentation
Date: Tue, 31 May 2016 14:28:37 +0200
Message-ID: <1464697717-5751-1-git-send-email-jordan.de-gea@grenoble-inp.org>
References: <9A874F00-ABD8-43D5-A32E-6A39ED333E6D@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org,
	erwan.mathoniere@grenoble-inp.org, samuel.groot@grenoble-inp.org,
	tom.russello@grenoble-inp.org, Matthieu.Moy@grenoble-inp.fr,
	Jordan DE GEA <jordan.de-gea@grenoble-inp.org>
To: philipoakley@iee.org
X-From: git-owner@vger.kernel.org Tue May 31 14:29:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7inP-0000N5-1J
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 14:29:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbcEaM3O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 May 2016 08:29:14 -0400
Received: from zm-smtpout-2.grenet.fr ([130.190.244.98]:32971 "EHLO
	zm-smtpout-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227AbcEaM3N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 08:29:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 5658C20A5;
	Tue, 31 May 2016 14:29:10 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id shunCJLN-nTl; Tue, 31 May 2016 14:29:10 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 3FA4E2071;
	Tue, 31 May 2016 14:29:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 38ED22077;
	Tue, 31 May 2016 14:29:10 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hKAIxFhavXu5; Tue, 31 May 2016 14:29:10 +0200 (CEST)
Received: from eduroam-033023.grenet.fr (eduroam-033023.grenet.fr [130.190.33.23])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 1B33A2064;
	Tue, 31 May 2016 14:29:10 +0200 (CEST)
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <9A874F00-ABD8-43D5-A32E-6A39ED333E6D@grenoble-inp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295973>

Currently, Triangular Workflow can be configured, but there is no
Documentation about it. A documentation is useful to keep
configuration possibilities up-to-date.
The new documentation file gittriangularworkflow explains
how to configure a triangular workflow.

Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Signed-off-by: Jordan DE GEA <jordan.de-gea@grenoble-inp.org>
---
 Documentation/Makefile                  |   1 +
 Documentation/gittriangularworkflow.txt | 120 ++++++++++++++++++++++++=
++++++++
 2 files changed, 121 insertions(+)
 create mode 100644 Documentation/gittriangularworkflow.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index f6e288b..e9f6c80 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -34,6 +34,7 @@ MAN7_TXT +=3D gitrevisions.txt
 MAN7_TXT +=3D gittutorial-2.txt
 MAN7_TXT +=3D gittutorial.txt
 MAN7_TXT +=3D gitworkflows.txt
+MAN7_TXT +=3D gittriangularworkflow.txt
=20
 MAN_TXT =3D $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
 MAN_XML =3D $(patsubst %.txt,%.xml,$(MAN_TXT))
diff --git a/Documentation/gittriangularworkflow.txt b/Documentation/gi=
ttriangularworkflow.txt
new file mode 100644
index 0000000..803eee3
--- /dev/null
+++ b/Documentation/gittriangularworkflow.txt
@@ -0,0 +1,120 @@
+gittriangularworkflow(7)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+NAME
+----
+gittriangularworkflow - A tutorial about the configuration of a
+Triangular Workflow
+
+SYNOPSIS
+--------
+[verse]
+git fetch
+git remote
+git config
+Options in git-config:
+- `remote.pushDefault`
+- `branch.<branch>.pushRemote`
+- `branch.<branch>.origin`
+
+DESCRIPTION
+-----------
+
+Triangular Workflow (or Asymmetric Workflow) is a workflow which gives
+the possibility to:
+
+- fetch (or pull) from a repository
+- push to another repository
+
+In some projects, you don't have to push directly to the project but
+have to suggest your commits to the maintainer (e.g. pull requests).
+Using Triangular Workflow is a common way for these projects.
+
+This document attempts to help you configure a Triangular Workflow.
+Here is an example of configuration:
+
+........................................
+------------               -----------
+| UPSTREAM |  maintainer   | ORIGIN  |
+|  git/git |- - - - - - - -|  me/git |
+------------       =E2=86=90       -----------
+         \                   /
+          \                 /
+     fetch=E2=86=93\               /=E2=86=91push
+            \             /
+             \           /
+             -------------
+             |   LOCAL   |
+             -------------
+........................................
+
+CREATE YOUR REPOSITORY
+----------------------
+The first step is to create your own repository. To do that you can:
+
+- a. fork (e.g. GitHub) the main project (e.g git/git), or
+- b. create an empty repository
+
+a. Fork the project
+~~~~~~~~~~~~~~~~~~~
+Go to the repository of the project (e.g. git/git) you want
+and fork it.
+
+b. Create from scratch
+~~~~~~~~~~~~~~~~~~~~~~
+Create a repository on your prefered Git repository hosting service.
+
+Clone it
+~~~~~~~~
+Clone your repository on your machine.
+
+
+CONFIGURE BRANCHES
+------------------
+In many projects, the branch `master` have to be pulled from
+the main repository(e.g. git/git) and pushed to your repository
+(e.g. me/git).
+
+Adding the main project remote
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Add a new remote (e.g. upstream):
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+`git remote add upstream <main_project_url>`
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Pull from upstream by default
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+`git config branch.master.remote upstream`
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+
+Push to origin by default
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+`git config branch.master.pushRemote origin`
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+
+GET YOUR PROJECT UP TO DATE
+---------------------------
+
+Now that `branch.master.remote` and `branch.master.pushRemote` are
+set, you can use the following commands to be up to date:
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * `git pull`
+ * `git push`
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+
+SEE ALSO
+--------
+linkgit:git-config[1]
+linkgit:git-remote[1]
+linkgit:git-fetch[1]
+
+
+
--=20
2.7.4 (Apple Git-66)
