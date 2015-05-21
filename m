From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule documentation: Rewrite introductory paragraphs
Date: Thu, 21 May 2015 12:01:48 -0700
Message-ID: <1432234908-32310-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jrnieder@gmail.com, git@vger.kernel.org, hvoigt@hvoigt.net,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu May 21 21:02:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvVjE-0003IQ-US
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 21:02:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755405AbbEUTB4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 May 2015 15:01:56 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:34983 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753643AbbEUTBz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 15:01:55 -0400
Received: by iesa3 with SMTP id a3so15477658ies.2
        for <git@vger.kernel.org>; Thu, 21 May 2015 12:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=Y9ebd/fsEg+bPzbfl58JgbBERAwrxGmJibTOjukOxxo=;
        b=PPAR/JCyr4F5mmnFHvkqi0kxmoMYk8YAOHlNUMssIfqnVBFFCnKulsFkk2W9zh0i1l
         dpPCFsiVIXIJH8wDmt1SwaWI4eQk1a1MdSsIsnNh1U+6UvlMDZOPEB1hJN0Hm8UA+IvI
         aWWPB76I9+HCkoUPEfRgFD03HE/R+LqFP9/HFVbNTyMKaLUlVl+FsuZBtUPGhgv0qGrJ
         2Qq8G9iMWSxG855IeNjBXyWyWt7quR30XZWRkMax856ZBulpCkp/tmKX80X+kFE/YJac
         rATkIF9PMyY6sHH4PNnxIE/JrLX+kUrOxOZegJuf/398ZKzQFY6VwZhd5nyAJ3hvOMUf
         jUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=Y9ebd/fsEg+bPzbfl58JgbBERAwrxGmJibTOjukOxxo=;
        b=HdZPRyRirOYlGo9522U2L2LHXP7iPEwKTKZ9gmClkdlmIiYuGyXR5YvoaE8gZpkWso
         TIE9GYsHc5hD+8XYhwq31sZG9OZ9FqAb305E/w//GlGyhfaghsTYIq589vx9ci1VSo9Q
         CeQg08jTI1/hqCNy88teIkGVFUIGxXDuPwVmeUtlkVFhAAo3xxJqHA0VrNWLCH39sPYb
         Dc/8gwgKlDfrK4GtWFEkaoWk0CPH3RGVf3VgOxwTGTyiHDee7VQaFMFklKJkUG+s/E2A
         6KzWUA5u+EzUwa0NL4q4hwRQtvmzGv14blqkxRwP0ROySGMGiybgoysYbv1op+U+ls+Q
         B4Mw==
X-Gm-Message-State: ALoCoQn/ZPTNv5cMhpuRFe8ts/f3pmmfCQst1KPloC6MpW7SoUTwCuhjFeXo30JSBv73A5z8B1kX
X-Received: by 10.43.24.76 with SMTP id rd12mr4958073icb.84.1432234915175;
        Thu, 21 May 2015 12:01:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:55d0:e2d7:635c:be62])
        by mx.google.com with ESMTPSA id r4sm1960459igh.9.2015.05.21.12.01.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 21 May 2015 12:01:54 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.194.gc518059
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269647>

It's better to start the man page with a description of what submodules
actually are instead of saying what they are not.

Reorder the paragraphs such that
the first short paragraph introduces the submodule concept,
the second paragraph highlights the usage of the submodule command,
the third paragraph giving background information,
and finally the fourth paragraph discusing alternatives such
as subtrees and remotes, which we don't want to be confused with.

This ordering deepens the knowledge on submodules with each paragraph.
=46irst the basic questions like "How/what" will be answered, while the
underlying concepts will be taught at a later time.

Making sure it is not confused with subtrees and remotes is not really
enhancing knowledge of submodules itself, but rather painting the big
picture of git concepts, so you could also argue to have it as the seco=
nd
paragraph. Personally I think this may confuse readers, specially newco=
mers
though.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

I rewrote the first 2 paragraphs as well now. I think it doesn't make s=
ense
to mention any subcommand in the description section, so I removed=20
 "When adding a new submodule to the tree, the 'add' subcommand is to b=
e used."
though I kept the warning about submodules not being autmatically updat=
ed by
clone and pull. All other subcommands are gone from the description.


>> Not a new problem, but does the command really "manage them for
>> you"? =C2=A0I view it more like "You can use this command to manage,
>> inspect and update the submodules".
>
> I agree.

Trying to find a better wording I looked more closely at other man page=
s to get
consistent with them. Most of them (e.g. add, status, rebase, revert) j=
ust describe
what they do in a short manner.

Now I am looking at the subtree man page and it looks as if it written =
in a similar style
to the submodules man page, the first 2 paragraphs give a short descrip=
tion what
subtrees do (not the command, but the concept) including an example.
The third paragraph then starts with "Subtrees are not to be confused
with submodules, ..." which I'd not want to see as early in a man page.
So in the subtree man page there is no such paragraph as
=C2=A0
=C2=A0 =C2=A0 This command can do this and that.

but rather the concept and examples are given.

 Documentation/git-submodule.txt | 50 ++++++++++++++++++---------------=
--------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submod=
ule.txt
index 2c25916..97718cf 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -25,22 +25,17 @@ SYNOPSIS
=20
 DESCRIPTION
 -----------
-Submodules allow foreign repositories to be embedded within
-a dedicated subdirectory of the source tree, always pointed
-at a particular commit.
+This command will inspect, update and manage submodules.
=20
-They are not to be confused with remotes, which are meant mainly
-for branches of the same project; submodules are meant for
-different projects you would like to make part of your source tree,
-while the history of the two projects still stays completely
-independent and you cannot modify the contents of the submodule
-from within the main project.
-If you want to merge the project histories and want to treat the
-aggregated whole as a single project from then on, you may want to
-add a remote for the other project and use the 'subtree' merge strateg=
y,
-instead of treating the other project as a submodule. Directories
-that come from both projects can be cloned and checked out as a whole
-if you choose to go that route.
+Submodules allow you to keep another Git repository in a subdirectory
+of your repository. The other repository has its own history, which do=
es not
+interfere with the history of the current repository. This can be used=
 to
+have external dependencies such as libraries for example.
+
+When cloning or pulling a repository containing submodules however,
+these will not be checked out by default; the 'init' and 'update'
+subcommands will maintain submodules checked out and at
+appropriate revision in your working tree.
=20
 Submodules are composed from a so-called `gitlink` tree entry
 in the main repository that refers to a particular commit object
@@ -51,19 +46,18 @@ describes the default URL the submodule shall be cl=
oned from.
 The logical name can be used for overriding this URL within your
 local repository configuration (see 'submodule init').
=20
-This command will manage the tree entries and contents of the
-gitmodules file for you, as well as inspect the status of your
-submodules and update them.
-When adding a new submodule to the tree, the 'add' subcommand
-is to be used.  However, when pulling a tree containing submodules,
-these will not be checked out by default;
-the 'init' and 'update' subcommands will maintain submodules
-checked out and at appropriate revision in your working tree.
-You can briefly inspect the up-to-date status of your submodules
-using the 'status' subcommand and get a detailed overview of the
-difference between the index and checkouts using the 'summary'
-subcommand.
-
+Submodules are not to be confused with remotes, which are meant
+mainly for branches of the same project; submodules are meant for
+different projects you would like to make part of your source tree,
+while the history of the two projects still stays completely
+independent and you cannot modify the contents of the submodule
+from within the main project.
+If you want to merge the project histories and want to treat the
+aggregated whole as a single project from then on, you may want to
+add a remote for the other project and use the 'subtree' merge strateg=
y,
+instead of treating the other project as a submodule. Directories
+that come from both projects can be cloned and checked out as a whole
+if you choose to go that route.
=20
 COMMANDS
 --------
--=20
2.4.0.194.gc518059
