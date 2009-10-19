From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] git push: say that --tag can't be used with --all or --mirror in help text
Date: Mon, 19 Oct 2009 12:57:01 +0900
Message-ID: <20091019125701.6117@nanako3.lavabit.com>
References: <7v8wfi1fya.fsf@alter.siamese.dyndns.org>
	<4ADB4AE8.5070007@hartwork.org>
	<20091018235240.GU6115@genesis.frugalware.org>
	<20091019115412.6117@nanako3.lavabit.com>
	<7vpr8kcc00.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Sebastian Pipping <webmaster@hartwork.org>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Bjorn Gustavsson <bgustavsson@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 05:57:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzjN3-0004hn-2K
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 05:57:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755756AbZJSD5K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Oct 2009 23:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755732AbZJSD5K
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 23:57:10 -0400
Received: from karen.lavabit.com ([72.249.41.33]:57441 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750985AbZJSD5J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 23:57:09 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 79F5511B92F;
	Sun, 18 Oct 2009 22:57:14 -0500 (CDT)
Received: from 7492.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id BHGNKLDEJHAK; Sun, 18 Oct 2009 22:57:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=vNVxtDVl52qfuxsD9mApzCpR/iWH068YveKP7ZycgN1ya5jRI/awJNkMJKVGxkoCkuGVkj36V2IwGcrruYGwvBUpFTJA6qNg4twRoXlXSz0q3wYuQaLARer2ihvCnhN0UaJwnPT/2HQVELGrEm1ef1MMrQQQ0EYP7sXAKt7eKyY=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vpr8kcc00.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130643>

This replaces an earlier patch by Bj=C3=B6rn Gustavsson,

  Message-ID: <4AD75029.1010109@gmail.com>

Signed-off-by: =E3=81=97=E3=82=89=E3=81=84=E3=81=97 =E3=81=AA=E3=81=AA=E3=
=81=93 <nanako3@lavabit.com>
---
 builtin-push.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index 6686b79..d7248f2 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -181,7 +181,7 @@ int cmd_push(int argc, const char **argv, const cha=
r *prefix)
 		OPT_BIT( 0 , "all", &flags, "push all refs", TRANSPORT_PUSH_ALL),
 		OPT_BIT( 0 , "mirror", &flags, "mirror all refs",
 			    (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE)),
-		OPT_BOOLEAN( 0 , "tags", &tags, "push tags"),
+		OPT_BOOLEAN( 0 , "tags", &tags, "push tags (can't be used with --all=
 nor --mirror"),
 		OPT_BIT('n' , "dry-run", &flags, "dry run", TRANSPORT_PUSH_DRY_RUN),
 		OPT_BIT( 0,  "porcelain", &flags, "machine-readable output", TRANSPO=
RT_PUSH_PORCELAIN),
 		OPT_BIT('f', "force", &flags, "force updates", TRANSPORT_PUSH_FORCE)=
,
--=20
1.6.5.rc1.18.g53a9a




--=20
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
