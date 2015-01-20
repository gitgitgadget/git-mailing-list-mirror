From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] show-branch: fix indentation of usage string
Date: Tue, 20 Jan 2015 20:30:28 +0100
Message-ID: <1421782228-24005-1-git-send-email-ralf.thielow@gmail.com>
References: <CANYiYbGL4A+ut8NjKmq6U8ADVf2M9Lq-5DOG3qxbKBp5srtrJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kuleshovmail@gmail.com, jn.avila@free.fr, worldhello.net@gmail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jan 20 20:30:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDeVb-0007hx-8B
	for gcvg-git-2@plane.gmane.org; Tue, 20 Jan 2015 20:30:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752774AbbATTae convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2015 14:30:34 -0500
Received: from mail-wi0-f177.google.com ([209.85.212.177]:47816 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778AbbATTac (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2015 14:30:32 -0500
Received: by mail-wi0-f177.google.com with SMTP id r20so19305130wiv.4
        for <git@vger.kernel.org>; Tue, 20 Jan 2015 11:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=BJx436nHOFtBWGfld8jPAXS+Slc0XqiMTbT74KyWGg4=;
        b=AJTcyGRMF/kpZrDUeawxcqqRC1lriu3TxgefHKppdKm9vg24+yFpNI+mhCoSYBxM+q
         PWKUyPyUz+1JkevGSG7faVXhseM5HFEX9/mNGgGsUvrhAIy3v7XzgDhVJIwkoTNDXLfq
         J2STM7ZkHTb8ZJ9obCglOrsYI0Qnol1hdwpv6Thvo93nfjLGjvcVK+UUx14/C9Q5vyBP
         sgZfSytsvQuNFrtvF5WcZbv7zJ/kFLClgY5O2/NZDRHXMaq21liZvFF1Mcx6Tcl6ENkp
         ep6RZExX+AMggFReTAVHRIYzuqHncVc7aQB4wkffc3aCCJtYjBOsewmmnWHv5orLi4BO
         p1NA==
X-Received: by 10.180.107.195 with SMTP id he3mr50299748wib.44.1421782231684;
        Tue, 20 Jan 2015 11:30:31 -0800 (PST)
Received: from localhost (dslb-088-073-235-175.088.073.pools.vodafone-ip.de. [88.73.235.175])
        by mx.google.com with ESMTPSA id j1sm22498722wjw.25.2015.01.20.11.30.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 20 Jan 2015 11:30:30 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc0.211.g05e7197
In-Reply-To: <CANYiYbGL4A+ut8NjKmq6U8ADVf2M9Lq-5DOG3qxbKBp5srtrJQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262684>

Noticed-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
Jiang Xin <worldhello.net@gmail.com> wrote:
> 2015-01-18 23:53 GMT+08:00 Jean-No=C3=ABl AVILA <jn.avila@free.fr>:
> Yes, it's wrong to using mixed tabs and spaces in the message. It com=
es
> from commit v2.0.5-5-g9990273, and it should be fixed.

This also breaks the indentation of the command output.

 builtin/show-branch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 691eeda..365228a 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -7,9 +7,9 @@
=20
 static const char* show_branch_usage[] =3D {
     N_("git show-branch [-a|--all] [-r|--remotes] [--topo-order | --da=
te-order]\n"
-       "		       [--current] [--color[=3D<when>] | --no-color] [--spar=
se]\n"
-       "		       [--more=3D<n> | --list | --independent | --merge-base=
]\n"
-       "	       [--no-name | --sha1-name] [--topics] [(<rev> | <glob>)=
=2E..]"),
+       "		[--current] [--color[=3D<when>] | --no-color] [--sparse]\n"
+       "		[--more=3D<n> | --list | --independent | --merge-base]\n"
+       "		[--no-name | --sha1-name] [--topics] [(<rev> | <glob>)...]")=
,
     N_("git show-branch (-g|--reflog)[=3D<n>[,<base>]] [--list] [<ref>=
]"),
     NULL
 };
--=20
2.3.0.rc0.211.g05e7197
