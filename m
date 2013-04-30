From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 0/6] New @ shortcut for HEAD
Date: Tue, 30 Apr 2013 16:49:08 -0500
Message-ID: <1367358554-4257-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, "Duy Nguyen\"" <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 30 23:50:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXIRY-0003D3-CT
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 23:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933750Ab3D3Vud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 17:50:33 -0400
Received: from mail-ye0-f179.google.com ([209.85.213.179]:45737 "EHLO
	mail-ye0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760697Ab3D3Vub (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 17:50:31 -0400
Received: by mail-ye0-f179.google.com with SMTP id l2so163862yen.38
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 14:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=HfQtawXE4sWwCN7yYPLbre77n9LTYmFPQ4zxyLmaqnY=;
        b=n+irKwNr8SMaKCtBKum5ixqXJXBS2dmDbhFXYKq273WxwlFn7JJiw752VXyzuCt2s2
         FZGzuMwMYLwew45biUVryBJdJnnEw3D2pr4JRSTNc1Wj5BM99g06z0xfB4TVt27iqjJ6
         BzjD9nvcdEP0H1YqqZIluasqECGSWeaL1MDxlswfTTMz+v/54VfRc7iqAcoQkC4746+8
         UgCkhK9CVB1R+ncTPFZxn+JWBpY66LQwIDjETzRYUxwDB3CZLbQjJN4BQLWv1ttupriq
         be7kKX2wGpEKsOAocfgIwSqaiu5uKqV0sqO+XcXDFkAY5kbZHvZWxRe3mzxTdnFu1GPq
         WyGg==
X-Received: by 10.236.198.73 with SMTP id u49mr213773yhn.35.1367358631201;
        Tue, 30 Apr 2013 14:50:31 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id a24sm301675yhj.23.2013.04.30.14.50.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 14:50:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.395.gfe9a10d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223013>

Hi,

Same as before, except that now only '@' changes, 'master@' remains the same as
before.

Also, cleanups for sha1_name, and an update so '@@{u}' works.

Felipe Contreras (6):
  sha1_name: remove no-op
  sha1_name: remove unnecessary braces
  sha1_name: avoid Yoda conditions
  sha1_name: refactor reinterpret()
  Add new @ shortcut for HEAD
  sha1_name: allow @@{u} to work

 Documentation/git-check-ref-format.txt |  2 +
 Documentation/revisions.txt            |  3 ++
 refs.c                                 |  4 ++
 sha1_name.c                            | 78 +++++++++++++++++++++++-----------
 t/t1508-at-combinations.sh             |  3 ++
 5 files changed, 65 insertions(+), 25 deletions(-)

-- 
1.8.3.rc0.395.gfe9a10d
