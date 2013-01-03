From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 0/5] nd/maint-branch-desc-doc reroll
Date: Thu,  3 Jan 2013 21:03:06 +0700
Message-ID: <1357221791-7496-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 03 15:03:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqlOL-00018C-7J
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 15:03:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753336Ab3ACODK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jan 2013 09:03:10 -0500
Received: from mail-da0-f49.google.com ([209.85.210.49]:59053 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753045Ab3ACODJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 09:03:09 -0500
Received: by mail-da0-f49.google.com with SMTP id v40so6970879dad.8
        for <git@vger.kernel.org>; Thu, 03 Jan 2013 06:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=HIjwQeOMdD17EtulmiC9ZZGvNSXP0gpHuCHX/kvWXJo=;
        b=PwBo1dtdKCUUuGRp0SIlw8Kif620MpX0d+r8KFxmdDWr2QnwYxYVugZdxckuy3bf4P
         1kO7vGy7RE4oxpjP+4LmnfUkTsMu33SCVFbna/9zBr7mYKXxJiLKg5YY8VeGztA8JZkG
         AiTHIMzOR4IkAFJvxW5ej7pAcoN09jBfIjJXpKQZi/+E01svjmnERIJJl89esKMtBUDp
         cTJAfwStInpvg4O290MMY+skTLScm7RMsFq46nQfQlDU+S4CBrr99wvb13omK7RYsw6J
         w9hd5JwIEniJOmXnZXg3bHovl4nHkmPumsVQ5bHq7LCmxxt8DIUQQFSVtkQ3dcBcJY5A
         QefA==
X-Received: by 10.68.232.101 with SMTP id tn5mr154655535pbc.125.1357221786217;
        Thu, 03 Jan 2013 06:03:06 -0800 (PST)
Received: from lanh ([115.74.34.31])
        by mx.google.com with ESMTPS id j8sm31304479paz.30.2013.01.03.06.03.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 Jan 2013 06:03:05 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 03 Jan 2013 21:03:12 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212583>

 - move the comment in 5/5 into the commented code block
 - resolve branch name for "HEAD" in 4/5

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (5):
  config.txt: a few lines about branch.<name>.description
  branch: delete branch description if it's empty
  t4014: a few more tests on cover letter using branch description
  format-patch: pick up correct branch name from symbolic ref
  format-patch: pick up branch description when no ref is specified

 Documentation/config.txt |  6 ++++++
 builtin/branch.c         |  2 +-
 builtin/log.c            | 33 ++++++++++++++++++++-------------
 t/t4014-format-patch.sh  | 42 ++++++++++++++++++++++++++++++++++++++++=
++
 4 files changed, 69 insertions(+), 14 deletions(-)

--=20
1.8.0.rc2.23.g1fb49df
