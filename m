From: Yamada Saburo <devil.tamachan@gmail.com>
Subject: Re: [PATCH v2 1/3] Add translation ("yes","no","ask")
Date: Fri, 19 Jul 2013 21:30:54 +0900
Message-ID: <CAPM==H+bXd8HNEd6u4C0nhGyM76q9aH258vokPUJQJm1jVGSiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 19 14:31:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V09pz-0005cP-DG
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 14:31:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760321Ab3GSMa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 08:30:58 -0400
Received: from mail-ve0-f177.google.com ([209.85.128.177]:54759 "EHLO
	mail-ve0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760312Ab3GSMaz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 08:30:55 -0400
Received: by mail-ve0-f177.google.com with SMTP id cz10so3289180veb.8
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 05:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=2orLXyCCRv3XFyWcpkx1KDW7rCik8oc8MUjjSQ/2cDY=;
        b=Xi33ihzv1f2Aa1JvL4LYOsXVHEcEyVe0VjRB5n0z61qdWWenf3B+I9DUYgl/CupYhl
         l5Dyjh7HDycgAaw9lOv0ytE0Dmi0PsH8KAK+wfy53EToxjnlDZDwUe+0x7EmR7qt8KAL
         Hd5gW4H/qqKFFDaT25WL600gBfYL2g1aKttNEO7ojbAjFbuv0Ix/uvZ6knSEoDEvqRtv
         r0G8kzkpVrQmlGyFB9OEgPj/53dSHBkWiamW4w/XP+jjDFEofGI+XZ+mhxaUxWEvvsYG
         +dg9C6wps8uRwY/NXIq3Bg7Bg8mDUVmUQKHS/1PUsuJZcLUIRWtrxRy+MfsYNgce7jw+
         UNqw==
X-Received: by 10.221.63.2 with SMTP id xc2mr5628046vcb.74.1374237054887; Fri,
 19 Jul 2013 05:30:54 -0700 (PDT)
Received: by 10.221.24.7 with HTTP; Fri, 19 Jul 2013 05:30:54 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230796>

Signed-off-by: Yamada Saburo <devil.tamachan@gmail.com>
---
 lib/option.tcl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/option.tcl b/lib/option.tcl
index 0cf1da1..7af858c 100644
--- a/lib/option.tcl
+++ b/lib/option.tcl
@@ -158,7 +158,7 @@ proc do_options {} {
 		{t gui.newbranchtemplate {mc "New Branch Name Template"}}
 		{c gui.encoding {mc "Default File Contents Encoding"}}
 		{b gui.warndetachedcommit {mc "Warn before committing to a detached head"}}
-		{s gui.stageuntracked {mc "Staging of untracked files"} {list "yes"
"no" "ask"}}
+		{s gui.stageuntracked {mc "Staging of untracked files"} {list [mc
"yes"] [mc "no"] [mc "ask"]}}
 		} {
 		set type [lindex $option 0]
 		set name [lindex $option 1]
-- 
1.8.1.msysgit.1
