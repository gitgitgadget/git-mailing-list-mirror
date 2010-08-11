From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/4] Eliminate =?utf-8?B?4oCcRmlu?=
	=?utf-8?Q?ished_cherry-pick=2Frevert=E2=80=9D?= message
Date: Wed, 11 Aug 2010 03:36:07 -0500
Message-ID: <20100811083607.GB16495@burratino>
References: <20100725005443.GA18370@burratino>
 <AANLkTilnQhsopnuAf0nja8Qq63VrOlt0_uCJrqYv5X-v@mail.gmail.com>
 <201007251122.41166.trast@student.ethz.ch>
 <20100729235151.GB6623@burratino>
 <AANLkTi=ao2RY8NGm4cACqz3_5zfT2zvXB4JHOopBD9T5@mail.gmail.com>
 <20100811083100.GA16495@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jeff King <peff@peff.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 10:37:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oj6on-0001vf-2y
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 10:37:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932653Ab0HKIhm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 04:37:42 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:37807 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932640Ab0HKIhl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 04:37:41 -0400
Received: by yxg6 with SMTP id 6so4027144yxg.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 01:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=UKX3LaNq6hAQp9ECwK+t9A+eaiQhbAhbepKYR1G7Fps=;
        b=m87K1bXBwxMsCSyILNNdeQ46bEZw/qMCJN9+JZ+sxL8ri1ptfrcGG3ajZ+SSwtu3j1
         +T9vcsHpNKHTE24aB2RUZ1zmArUcakpWBWyCsfEC4t4koewBqySmbB4ywWg788SI3PsG
         V164mjUma72YVvYuTXVAuHNpg+uxbFMHst9G8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=hxWx99ozLnmhbpEkgK/g6R0C+WVEJY0mmn1004kOZhq29WIyU08N75I65iV2G+DvkS
         n4CYodLu4wv2gQ0VhMwM+ZHUv+T7HV58mQo4ZZF+srL72MM8xasQcxjQdrUMiVPCWIIU
         2DBTtCH/nn7bzfC6bMjnpKdCO/VbfNabYh9yo=
Received: by 10.100.244.1 with SMTP id r1mr17730900anh.96.1281515860811;
        Wed, 11 Aug 2010 01:37:40 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id a12sm12264965and.36.2010.08.11.01.37.40
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 01:37:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100811083100.GA16495@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153205>

When cherry-pick was written (v0.99.6~63, 2005-08-27), =E2=80=9Cgit com=
mit=E2=80=9D
was quiet, and the output from cherry-pick provided useful information
about the progress of a rebase.

Now next to the output from =E2=80=9Cgit commit=E2=80=9D, the cherry-pi=
ck notification
is so much noise (except for the name of the picked commit).

 $ git cherry-pick ..topic
 Finished cherry-pick of 499088b.
 [detached HEAD 17e1ff2] Move glob module to libdpkg
  Author: Guillem Jover <guillem@debian.org>
  8 files changed, 12 insertions(+), 9 deletions(-)
  rename {src =3D> lib/dpkg}/glob.c (98%)
  rename {src =3D> lib/dpkg}/glob.h (93%)
 Finished cherry-pick of ae947e1.
 [detached HEAD 058caa3] libdpkg: Add missing symbols to Versions scrip=
t
  Author: Guillem Jover <guillem@debian.org>
  1 files changed, 2 insertions(+), 0 deletions(-)
 $

The noise is especially troublesome when sifting through the output of
a rebase or multiple cherry-pick that eventually failed.

With the commit subject, it is already not hard to figure out where
the commit came from.  So drop the =E2=80=9CFinished=E2=80=9D message.

Cc: Christian Couder <chriscool@tuxfamily.org>
Cc: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/howto/revert-branch-rebase.txt |    6 ----
 builtin/revert.c                             |    2 -
 contrib/examples/git-revert.sh               |    1 -
 t/t3508-cherry-pick-many-commits.sh          |   42 ++++++++++++++++++=
-------
 4 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/Documentation/howto/revert-branch-rebase.txt b/Documentati=
on/howto/revert-branch-rebase.txt
index 8c32da6..093c656 100644
--- a/Documentation/howto/revert-branch-rebase.txt
+++ b/Documentation/howto/revert-branch-rebase.txt
@@ -112,25 +112,19 @@ $ git tag pu-anchor pu
 $ git rebase master
 * Applying: Redo "revert" using three-way merge machinery.
 First trying simple merge strategy to cherry-pick.
-Finished one cherry-pick.
 * Applying: Remove git-apply-patch-script.
 First trying simple merge strategy to cherry-pick.
 Simple cherry-pick fails; trying Automatic cherry-pick.
 Removing Documentation/git-apply-patch-script.txt
 Removing git-apply-patch-script
-Finished one cherry-pick.
 * Applying: Document "git cherry-pick" and "git revert"
 First trying simple merge strategy to cherry-pick.
-Finished one cherry-pick.
 * Applying: mailinfo and applymbox updates
 First trying simple merge strategy to cherry-pick.
-Finished one cherry-pick.
 * Applying: Show commits in topo order and name all commits.
 First trying simple merge strategy to cherry-pick.
-Finished one cherry-pick.
 * Applying: More documentation updates.
 First trying simple merge strategy to cherry-pick.
-Finished one cherry-pick.
 ------------------------------------------------
=20
 The temporary tag 'pu-anchor' is me just being careful, in case 'git
diff --git a/builtin/revert.c b/builtin/revert.c
index e261fb2..c3d64af 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -521,8 +521,6 @@ static int do_pick_commit(void)
 	} else {
 		if (!no_commit)
 			res =3D run_git_commit(defmsg);
-		if (!res)
-			fprintf(stderr, "Finished %s.\n", mebuf.buf);
 	}
=20
 	strbuf_release(&mebuf);
diff --git a/contrib/examples/git-revert.sh b/contrib/examples/git-reve=
rt.sh
index 49f0032..60a05a8 100755
--- a/contrib/examples/git-revert.sh
+++ b/contrib/examples/git-revert.sh
@@ -181,7 +181,6 @@ Conflicts:
 	esac
 	exit 1
 }
-echo >&2 "Finished one $me."
=20
 # If we are cherry-pick, and if the merge did not result in
 # hand-editing, we will hit this commit and inherit the original
diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-=
many-commits.sh
index 0f61495..8e09fd0 100755
--- a/t/t3508-cherry-pick-many-commits.sh
+++ b/t/t3508-cherry-pick-many-commits.sh
@@ -35,36 +35,54 @@ test_expect_success setup '
 '
=20
 test_expect_success 'cherry-pick first..fourth works' '
-	cat <<-EOF >expected &&
-	Finished cherry-pick of commit $(git rev-parse --short second).
-	Finished cherry-pick of commit $(git rev-parse --short third).
-	Finished cherry-pick of commit $(git rev-parse --short fourth).
+	cat <<-\EOF >expected &&
+	[master OBJID] second
+	 Author: A U Thor <author@example.com>
+	 1 files changed, 1 insertions(+), 0 deletions(-)
+	[master OBJID] third
+	 Author: A U Thor <author@example.com>
+	 1 files changed, 1 insertions(+), 0 deletions(-)
+	[master OBJID] fourth
+	 Author: A U Thor <author@example.com>
+	 1 files changed, 1 insertions(+), 0 deletions(-)
 	EOF
=20
 	git checkout -f master &&
 	git reset --hard first &&
 	test_tick &&
-	git cherry-pick first..fourth 2>actual &&
+	git cherry-pick first..fourth >actual &&
 	git diff --quiet other &&
 	git diff --quiet HEAD other &&
-	test_cmp expected actual &&
+
+	sed -e "s/$_x05[0-9a-f][0-9a-f]/OBJID/" <actual >actual.fuzzy &&
+	test_cmp expected actual.fuzzy &&
 	check_head_differs_from fourth
 '
=20
 test_expect_success 'cherry-pick --strategy resolve first..fourth work=
s' '
-	cat <<-EOF >expected &&
-	Finished cherry-pick of commit $(git rev-parse --short second) with s=
trategy resolve.
-	Finished cherry-pick of commit $(git rev-parse --short third) with st=
rategy resolve.
-	Finished cherry-pick of commit $(git rev-parse --short fourth) with s=
trategy resolve.
+	cat <<-\EOF >expected &&
+	Trying simple merge.
+	[master OBJID] second
+	 Author: A U Thor <author@example.com>
+	 1 files changed, 1 insertions(+), 0 deletions(-)
+	Trying simple merge.
+	[master OBJID] third
+	 Author: A U Thor <author@example.com>
+	 1 files changed, 1 insertions(+), 0 deletions(-)
+	Trying simple merge.
+	[master OBJID] fourth
+	 Author: A U Thor <author@example.com>
+	 1 files changed, 1 insertions(+), 0 deletions(-)
 	EOF
=20
 	git checkout -f master &&
 	git reset --hard first &&
 	test_tick &&
-	git cherry-pick --strategy resolve first..fourth 2>actual &&
+	git cherry-pick --strategy resolve first..fourth >actual &&
 	git diff --quiet other &&
 	git diff --quiet HEAD other &&
-	test_cmp expected actual &&
+	sed -e "s/$_x05[0-9a-f][0-9a-f]/OBJID/" <actual >actual.fuzzy &&
+	test_cmp expected actual.fuzzy &&
 	check_head_differs_from fourth
 '
=20
--=20
1.7.2.1.544.ga752d.dirty
