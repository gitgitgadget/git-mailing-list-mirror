From: Tarmigan <tarmigan+git@gmail.com>
Subject: [PATCH] Add hints to revert documentation about other ways to undo changes
Date: Tue, 19 Aug 2008 10:06:47 -0700
Message-ID: <905315640808191006y6defa44fu2fdd41c034ffc263@mail.gmail.com>
References: <1219165591-19969-1-git-send-email-tarmigan+git@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 19:09:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVUgZ-0001cB-2U
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 19:07:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753AbYHSRGu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Aug 2008 13:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753586AbYHSRGu
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 13:06:50 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:18405 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415AbYHSRGt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Aug 2008 13:06:49 -0400
Received: by nf-out-0910.google.com with SMTP id d3so26592nfc.21
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 10:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=1FmYStPBOXen65lYQ/zXDB0P+ppeIvhU9mzB2Jf+Mqg=;
        b=wbiAMGf9h87qb4VoxMYv+aK/dKsGU2ZBsA/iz1vPG4idIp91ttkit2Pt0Wa3/t6S9S
         XbMw2NKUTR6asG8GBZM/1q/wo1zX9texpe2ECPbcYEdXJsJo19VCU/yOy97Hi2bVuFE+
         18f7CNEXjCFuS+S8U6bbXXDNUyOxpxg4LynbM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=f6kARGoDjPOBzAetoi4w3KHnUgOCraS/blgRhmVh0ZsyzlHEJPRqwMGy74CNhMG02m
         mvi+2LDKOr0ncvg3SKCQJFSJW+ghC4yy99OG+ZY+Czq4PQHAkYKlgxTE4ztQ3pAgh3Ci
         0UiuKQJKJkL0zuKuIEPDvt3VR77GtTvpuW5HM=
Received: by 10.210.49.19 with SMTP id w19mr2779797ebw.47.1219165607275;
        Tue, 19 Aug 2008 10:06:47 -0700 (PDT)
Received: by 10.210.28.18 with HTTP; Tue, 19 Aug 2008 10:06:47 -0700 (PDT)
In-Reply-To: <1219165591-19969-1-git-send-email-tarmigan+git@gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: cef44d3ac59d437a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92882>

[Resending to git list.  Original was rejected by vger with
Message headers can not have 8-bit non-ASCII characters in it; Use
MIME encodings if such are needed!
so trying to mail list directly for discussion.  This copy is probably
mangled in the forward.]

=46rom: Tarmigan Casebolt <tarmigan+git@gmail.com>
Date: Tue, Aug 19, 2008 at 10:06 AM
Subject: [PATCH] Add hints to revert documentation about other ways to
undo changes
To: gitster@pobox.com

Based on its name, people may read the 'git revert' documentation when
they want to undo local changes, especially people who have used other
SCM's.  'git revert' may not be what they had in mind, but git
provides several other ways to undo changes to files.  We can help
them by pointing them towards the git commands that do what they might
want to do.

Cc: Daniel Barkalow <barkalow@iabervon.org>
Cc: "Peter Valdemar M=F8rch (Lists)" <4ux6as402@sneakemail.com>
Cc: Lea Wiemann <lewiemann@gmail.com>
Signed-off-by: Tarmigan Casebolt <tarmigan+git@gmail.com>
---

I put this in a Note: in the DESCRIPTION section.  If there is
consensus about moving it somewhere else, I can send another patch.

 Documentation/git-revert.txt |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.tx=
t
index 98cfa3c..d46f090 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -15,6 +15,15 @@ Given one existing commit, revert the change the
patch introduces, and record a
 new commit that records it.  This requires your working tree to be cle=
an (no
 modifications from the HEAD commit).

+Note: Despite its name, 'git revert' may not undo changes in the way
+that you expect.  If you want to throw away all uncommitted changes in
+your working directory, you should see linkgit:git-reset[1],
+particulary the '--hard' option.  If you want to extract specific
+files as they were in another commit, you should see
+linkgit:git-checkout[1], specifically the 'git checkout <commit> --
+<filename>' syntax.  Take care with these alternatives as both will
+discard uncommitted changes in your working directory.
+
 OPTIONS
 -------
 <commit>::
--
1.6.0
