From: Richard Quirk <richard.quirk@gmail.com>
Subject: [PATCH] Documentation gitk: Describe what --merge does
Date: Mon, 28 Apr 2008 22:58:35 +0200
Message-ID: <1209416315-13925-1-git-send-email-richard.quirk@gmail.com>
References: <7vlk2zf304.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org, Richard Quirk <richard.quirk@gmail.com>
To: <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 22:59:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqaRh-0007hf-Si
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 22:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935156AbYD1U6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 16:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934881AbYD1U6k
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 16:58:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:57219 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935119AbYD1U6k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 16:58:40 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1996003nfb.21
        for <git@vger.kernel.org>; Mon, 28 Apr 2008 13:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=9W1fvdMBmOCi8aGJQ52Zks0u0PhDvey1yOWenN156rI=;
        b=ilaVhj726l27Km5LavpVk10TsMZhfphb43GxcgAQGVqWHuWQTlC5ZSaqz7CzUvPICQRrOqvy9ttrjIMWv7tg/caJQV0K0T6dRuU55qB3Ryou259ZPGaVxqQtq2enJeIXOe8xQGWGdFUPUzGYdJ1CGYiRLAVWHhSWhzQQkJTVCf8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=GJN/3rCV0fj/ySyJqArwjYmu/l0YQrB6nESB9HHVrCi5dGPmu8OX2BsAbxF0h6b0GaXLs4cohpnZ/rwNlhd5FrN28W7S2x9f5PMXaa4IJrw2y0VU3LkxiPM6eiddiLHM4zfPFev/ydEs+rSX69N3htJapfnrroKsWGebxk5Grlk=
Received: by 10.210.120.17 with SMTP id s17mr6301658ebc.90.1209416318551;
        Mon, 28 Apr 2008 13:58:38 -0700 (PDT)
Received: from localhost ( [84.77.29.188])
        by mx.google.com with ESMTPS id g17sm9165703nfd.10.2008.04.28.13.58.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Apr 2008 13:58:38 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.91.gb5ae
In-Reply-To: <7vlk2zf304.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80609>

Signed-off-by: Richard Quirk <richard.quirk@gmail.com>
---

On Sun, Apr 27, 2008 at 10:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
>  Hmm. "the differences" is technically correct in that it shows the
>  commits on the diverged histories, but I suspect it would be more
>  understandable if we used more explicit wording

Yes, and your explicit wording was much clearer.

I'm not sure if resending this is strictly the Right Thing given that the
words are actually yours. But here's the updated patch so --merge might get
some documentation, just in case.

 Documentation/gitk.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index ed3ba83..c40f997 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -41,6 +41,12 @@ frequently used options.
 
 	Show all branches.
 
+--merge::
+
+	After an attempt to merge stops with conflicts, show the commits on
+	the history between two branches (i.e. the HEAD and the MERGE_HEAD)
+	that modify the conflicted files.
+
 <revs>::
 
 	Limit the revisions to show. This can be either a single revision
-- 
1.5.5.1.91.gb5ae
