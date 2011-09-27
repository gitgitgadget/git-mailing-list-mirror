From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH] Docs: git checkout --orphan: `root commit' and `branch head'
Date: Tue, 27 Sep 2011 14:43:55 -0000
Message-ID: <e88b6e560cab4ed1937dd191b4180387-mfwitten@gmail.com>
References: <1316960136073-6829212.post@n2.nabble.com>
            <1316961212.4388.5.camel@centaur.lab.cmartin.tk>
            <7vaa9r2jii.fsf@alter.siamese.dyndns.org>
            <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 27 16:59:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8Z8M-0004eW-NR
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 16:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747Ab1I0O7m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Sep 2011 10:59:42 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59428 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815Ab1I0O7l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 10:59:41 -0400
Received: by gyg10 with SMTP id 10so5281356gyg.19
        for <git@vger.kernel.org>; Tue, 27 Sep 2011 07:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:cc:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=eSCWe1pJToRJF812dIqdNFrm3dkP0jptI8LAI2LvRGo=;
        b=fSQEOPc7v/hG7Iijc3fGFibkkRzcmV/kWlmjUerrG99gb4+Lbnp6PtJIE6CJrnbs7K
         OaGQbOOT6pCf3UVXt7ZFw95g1JRG/WVtxIiZVo6NyZ+pWvLJNZDOHVkfrPo5Xl8RTs7r
         vrr/yDCMjxemeOXJo9ajARpA11IU79QJM1T0Q=
Received: by 10.236.180.167 with SMTP id j27mr5983033yhm.109.1317135580800;
        Tue, 27 Sep 2011 07:59:40 -0700 (PDT)
Received: from gmail.com (exit-01d.noisetor.net. [173.254.216.69])
        by mx.google.com with ESMTPS id n18sm26767312yhi.14.2011.09.27.07.59.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 27 Sep 2011 07:59:40 -0700 (PDT)
In-Reply-To: <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182240>

See:

  Re: Can a git changeset be created with no parent
  Carlos Mart=C3=ADn Nieto <cmn@elego.de>
  Message-ID: <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
  http://article.gmane.org/gmane.comp.version-control.git/182170

and:

  git help glossary

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/git-checkout.txt |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkou=
t.txt
index c0a96e6..c963a0f 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -125,19 +125,16 @@ explicitly give a name with '-b' in such a case.
 	below for details.
=20
 --orphan::
-	Create a new 'orphan' branch, named <new_branch>, started from
-	<start_point> and switch to it.  The first commit made on this
-	new branch will have no parents and it will be the root of a new
-	history totally disconnected from all the other branches and
-	commits.
+	Tell git to make the next commit you make a root commit referenced by
+	the branch head <new_branch>.
 +
 The index and the working tree are adjusted as if you had previously r=
un
 "git checkout <start_point>".  This allows you to start a new history
-that records a set of paths similar to <start_point> by easily running
+that records a set of paths similar to <start_point> by just running
 "git commit -a" to make the root commit.
 +
-This can be useful when you want to publish the tree from a commit
-without exposing its full history. You might want to do this to publis=
h
+This can be useful when you want to publish a tree without exposing it=
s
+full history; for instance, you might want to do this to publish
 an open source branch of a project whose current tree is "clean", but
 whose full history contains proprietary or otherwise encumbered bits o=
f
 code.
--=20
1.7.6.409.ge7a85
