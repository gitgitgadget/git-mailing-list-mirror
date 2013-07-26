From: Daniele Segato <daniele.segato@gmail.com>
Subject: Re: [PATCH] git-tag man: when to use lightweight or annotated tags
Date: Fri, 26 Jul 2013 10:46:22 +0200
Message-ID: <51F2375E.1080003@gmail.com>
References: <51EFA9A9.4010103@gmail.com> <7vtxjj66kn.fsf@alter.siamese.dyndns.org> <51F12BE6.80606@gmail.com> <51F13A8F.9040400@xiplink.com> <51F23706.5040009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 26 10:46:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2dfV-0005xb-3K
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 10:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757776Ab3GZIq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 04:46:29 -0400
Received: from mail-bk0-f49.google.com ([209.85.214.49]:60043 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757338Ab3GZIq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 04:46:27 -0400
Received: by mail-bk0-f49.google.com with SMTP id r7so646537bkg.22
        for <git@vger.kernel.org>; Fri, 26 Jul 2013 01:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=QUnBO8EaF8aF01YtcnwOP4E855UkQtEn8UxqU7JH+Vo=;
        b=oYBjZ4CHO0Dw4Rk6BRz029EuuujhGsM+x3IhkKCavOmGdSdCvRqhmUjONznisYpW9M
         HzaQMz+EI7bajTSVAVf6DU8rIoCcOHraN8usw/Ziasvqle8hGrz3nOdP7IfuMwgwOx5Y
         ZaPNaAK6w4atMX1+1mmGKgIqrGDM/nsedDaQkyDpbxnwDFuOA2Ct7zu/c+P99GRHISQE
         Jus6OPWz4NaYfK9oqbjea2pcUJ0ZfTa7NBRmUncekA97F4Zqeo9zN7uvOixnCoowOEeT
         cFDg18hAAu4l5YbGDYiciic3aQp+BpvtWz8YbxTMTklZA/GsKYe0j195r0RSfarcdMJm
         87jQ==
X-Received: by 10.205.20.133 with SMTP id qo5mr6738891bkb.6.1374828385776;
        Fri, 26 Jul 2013 01:46:25 -0700 (PDT)
Received: from [192.168.1.16] (host22-75-dynamic.4-87-r.retail.telecomitalia.it. [87.4.75.22])
        by mx.google.com with ESMTPSA id if11sm12109052bkc.15.2013.07.26.01.46.23
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 26 Jul 2013 01:46:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <51F23706.5040009@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231174>

 From 34fdcb56e5784699ffa327ebfcd2c5cd99b61d2d Mon Sep 17 00:00:00 2001
From: Daniele Segato <daniele.segato@gmail.com>
Date: Thu, 25 Jul 2013 15:33:18 +0200
Subject: [PATCH] git-tag man: when to use lightweight or annotated tags

stress the difference between the two with suggestion on when the user
should use one in place of the other.

Signed-off-by: Daniele Segato <daniele.segato@gmail.com>
---
  Documentation/git-tag.txt |    7 ++++++-
  1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 22894cb..5c6284e 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -26,7 +26,7 @@ to delete, list or verify tags.
  Unless `-f` is given, the named tag must not yet exist.

  If one of `-a`, `-s`, or `-u <key-id>` is passed, the command
-creates a 'tag' object, and requires a tag message.  Unless
+creates a 'tag' object called 'Annotated tag', and requires a tag 
message. Unless
  `-m <msg>` or `-F <file>` is given, an editor is started for the user 
to type
  in the tag message.

@@ -36,6 +36,11 @@ are absent, `-a` is implied.
  Otherwise just a tag reference for the SHA-1 object name of the commit 
object is
  created (i.e. a lightweight tag).

+'Annotated' and 'Lightweight' tags are not the same thing for git and 
you shouldn't
+mix them up. Annotated tags are meant for release while lightweight 
tags are
+meant for private or temporary object labels. Most git commands only 
consider
+Annotated tags by default.
+
  A GnuPG signed tag object will be created when `-s` or `-u
  <key-id>` is used.  When `-u <key-id>` is not used, the
  committer identity for the current user is used to find the
-- 
1.7.10.4
