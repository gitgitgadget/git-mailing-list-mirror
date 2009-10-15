From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH] push: fix usage: --tags is incompatible with --all and --mirror
Date: Thu, 15 Oct 2009 18:39:05 +0200
Message-ID: <4AD75029.1010109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Oct 15 18:50:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyTU1-00033m-Cz
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 18:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934720AbZJOQjp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Oct 2009 12:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934632AbZJOQjp
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 12:39:45 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:38422 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933480AbZJOQjo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 12:39:44 -0400
Received: by ewy4 with SMTP id 4so719912ewy.37
        for <git@vger.kernel.org>; Thu, 15 Oct 2009 09:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=yy57bVwpKtHFhNSc8S6KVpi4BYjThiVUNcE44KWnoZ0=;
        b=mEVNJZAy7Sp7E7zqeDh2WKr3m85nVUANsRqmSab3/4LnotHzGkAszWmJlrZEdsQPW/
         d4MRo4gFtDYFjXtc8uECCFruQlxxb8igkoWLw+aS/3GlSqO7NJ65u2qgB1bKWut8q2YY
         YJaPfevTgjGgwlWkGtztKj82xIuBPJzyg37MM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=VYrtMIW60CfW+LB0jYZi8Mq06UwZfSaRNtLi7CEnJZlPxGz71jHuosPQuFEIRJ8KnC
         Md18fsOH69a4akMb52S2ytygbNUm3NqhX720jj92OtoN0mWB8MDauHslBcu9Q+Xt3I6Y
         xCKbDAOk3JEhF10PAw7Jda7PoZTeWzzOjrF8Y=
Received: by 10.211.131.34 with SMTP id i34mr363962ebn.35.1255624747454;
        Thu, 15 Oct 2009 09:39:07 -0700 (PDT)
Received: from bitis.local (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 7sm2816935eyg.3.2009.10.15.09.39.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Oct 2009 09:39:06 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130400>

Correct the usage text to make it clear that --tags cannot
be combined with --all or --mirror.

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
 builtin-push.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index 3cb1ee4..425594a 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -10,7 +10,7 @@
 #include "parse-options.h"
=20
 static const char * const push_usage[] =3D {
-	"git push [--all | --mirror] [-n | --dry-run] [--porcelain] [--tags] =
[--receive-pack=3D<git-receive-pack>] [--repo=3D<repository>] [-f | --f=
orce] [-v] [<repository> <refspec>...]",
+	"git push [--all | --mirror | --tags] [-n | --dry-run] [--porcelain] =
[--receive-pack=3D<git-receive-pack>] [--repo=3D<repository>] [-f | --f=
orce] [-v] [<repository> <refspec>...]",
 	NULL,
 };
=20
--=20
1.6.5.2.gd6127
