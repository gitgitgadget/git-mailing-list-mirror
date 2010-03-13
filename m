From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH/RFC 10/12] diff: use brackets for optional args in usage
Date: Fri, 12 Mar 2010 23:53:02 -0500
Message-ID: <1268455984-19061-11-git-send-email-lodatom@gmail.com>
References: <1268455984-19061-1-git-send-email-lodatom@gmail.com>
Cc: Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 13 05:54:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqJMk-0007qX-46
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 05:54:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933694Ab0CMExr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 23:53:47 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:41193 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757388Ab0CMExV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 23:53:21 -0500
Received: by qw-out-2122.google.com with SMTP id 9so447877qwb.37
        for <git@vger.kernel.org>; Fri, 12 Mar 2010 20:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=4aUYVyMZKTKiOjf0wi4FyPdrn4jtMZrIc3kIL8lfDsI=;
        b=lYhKU4jAm+wH7KSVbxuKH5eXYJ2Jnu1/teICc+J0ju1ESW3a5/nzPF3VftLlfwEvNT
         ltvg1hQV173HkD6WS2pV5mfST6eNkVw5iSR/NfA/MiAGQhi4NvH5Lojvmie4qAwxoM5C
         qOUfoyk+OCZ2bJNAk6K7Dq+x13G2GFamo0CnU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hXnwsvQwvTKLaj7Hno/bt9gC2rjF4tG0u7TOEUFqSSjm5K5sBBS5IwrvwlgyY3bpRs
         tS76q87tBIPxg4iRcWvz2devP05TBOgDJVS8m5ho3MRKcEVRul1Yl/RR51iXmAo3xNud
         CL+hv6ZIKR2pKfw3XTjejWy7e9hGY7t0kiJP0=
Received: by 10.224.86.141 with SMTP id s13mr765380qal.130.1268456001588;
        Fri, 12 Mar 2010 20:53:21 -0800 (PST)
Received: from localhost.localdomain (c-68-50-174-152.hsd1.dc.comcast.net [68.50.174.152])
        by mx.google.com with ESMTPS id 22sm1694110qyk.10.2010.03.12.20.53.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Mar 2010 20:53:21 -0800 (PST)
X-Mailer: git-send-email 1.7.0.2
In-Reply-To: <1268455984-19061-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142083>

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
 builtin/diff.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index ffcdd05..a716704 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -21,7 +21,7 @@ struct blobinfo {
 };
 
 static const char builtin_diff_usage[] =
-"git diff <options> <rev>{0,2} -- <path>*";
+"git diff [<options>] <rev>{0,2} [--] [<path>]*";
 
 static void stuff_change(struct diff_options *opt,
 			 unsigned old_mode, unsigned new_mode,
-- 
1.7.0.2
