From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH (v2)] Mention "local convention" rule in the CodingGuidelines
Date: Mon, 26 Jan 2009 17:32:22 +0900
Message-ID: <20090126173222.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 26 09:34:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRMvL-0005sd-6C
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 09:34:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbZAZIdB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Jan 2009 03:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbZAZIdB
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 03:33:01 -0500
Received: from karen.lavabit.com ([72.249.41.33]:57384 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750861AbZAZIdA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 03:33:00 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 1F1E3C843B;
	Mon, 26 Jan 2009 02:33:00 -0600 (CST)
Received: from 8192.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id 24OVX8UX8DDR; Mon, 26 Jan 2009 02:33:00 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=fhp24NqcYFWa9yMJ+DLT48oELXZvCc0ERHhduCsmZFcg20areYHHiAk//dOMqFLb2RdHDtRvOfbpt+tTdbGOCLZulKbYYygWXVMoWqAlj18ybjcqP57wnFJWArvuAz211RzuiQeegYVVDHX39XhU4ytCkTJ0tewpwwG4fvFyys0=;
  h=From:To:cc:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107176>

The document suggests to imitate the existing code, but didn't
say which existing code it should imitate. This clarifies.

Signed-off-by: =E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=
=81=93 <nanako3@lavabit.com>
---
Quoting Junio C Hamano <gitster@pobox.com>:

> It is always preferable to match the _local_ convention.  I'd expect =
a new
> script added to git suite to match my preference (the one I showed yo=
u in
> my comments to you that is used in git-am, which is what you suggeste=
d
> above), but I'd expect a modification to mergetool to match the style
> mergetool already uses.

Sverre fixed some typo for me.

 Documentation/CodingGuidelines |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuide=
lines
index f628c1f..664c6c2 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -21,8 +21,13 @@ code.  For git in general, three rough rules are:
=20
 As for more concrete guidelines, just imitate the existing code
 (this is a good guideline, no matter which project you are
-contributing to).  But if you must have a list of rules,
-here they are.
+contributing to). It is always preferable to match the _local_
+convention. New code added to git suite is expected to match
+the overall style of existing code. Modifications to existing
+code is expected to match the style the surrounding code already
+uses (even if it doesn't match the overall style of existing code).
+
+But if you must have a list of rules, here they are.
=20
 For shell scripts specifically (not exhaustive):

--=20
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
