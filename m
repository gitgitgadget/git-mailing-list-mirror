From: Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH] Update t/.gitignore to ignore all trash directories
Date: Wed, 20 Aug 2008 23:10:55 -0400
Message-ID: <48ACDCBF.5040801@griep.us>
References: <1219076740-24236-1-git-send-email-marcus@griep.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 21 05:12:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW0b8-00076r-JR
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 05:12:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754696AbYHUDLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 23:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754722AbYHUDLJ
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 23:11:09 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:9720 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755383AbYHUDLG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 23:11:06 -0400
Received: by wr-out-0506.google.com with SMTP id 69so671326wri.5
        for <git@vger.kernel.org>; Wed, 20 Aug 2008 20:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=HIuPP/QYTR+kxXK75maX7gm4M2g+dkYq7PA4gwAYLts=;
        b=XiC2hwLTmCosjwmhELXlc4UwGn/63IRKfREXdNdPIy3ltFOjyvQwDS291xhvQZvIM7
         AfDtEa8e+tW0szMmYAcoEiByBBWHRAFFtxHzgfDQneAYyg/jJVX5FGlKYsal/aMhwhfO
         q009IdPdE7AREbZ+c699KOBa9Cy3gpaDsgiwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=W0Qh69946dc58t1tqQu59ISIO8Nx7pnnRbQi8b/gWQHDB5mUi3hrFAvPtyqi6gtbyM
         YEZYvX/FSbbrLTwZZFUCcCKSo1gndW/fSMZkNILDt2agzUz/QYzbR5gHQoyeBmLVHdyT
         rPv017mN6tOUAsvd/hLXrsTAOLYGBA0nBrGzM=
Received: by 10.90.106.6 with SMTP id e6mr1101413agc.31.1219288264140;
        Wed, 20 Aug 2008 20:11:04 -0700 (PDT)
Received: from ?192.168.1.3? ( [71.184.250.180])
        by mx.google.com with ESMTPS id 71sm1900194wry.16.2008.08.20.20.11.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Aug 2008 20:11:02 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <1219076740-24236-1-git-send-email-marcus@griep.us>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93097>

The current .gitignore only ignores the old "trash directory" and
not the new "trash directory.[test]".  This ignores both forms.

Signed-off-by: Marcus Griep <marcus@griep.us>
---

 Bump. This is based on next, and leaves my git status with an
 untracked directory should I ever abort in the middle of a test.

 t/.gitignore |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/.gitignore b/t/.gitignore
index b27e280..7dcbb23 100644
--- a/t/.gitignore
+++ b/t/.gitignore
@@ -1,2 +1,2 @@
-/trash directory
+/trash directory*
 /test-results
