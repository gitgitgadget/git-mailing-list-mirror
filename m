From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 03/11] completion; remove unuseful comments
Date: Sat, 27 Apr 2013 05:19:46 -0500
Message-ID: <1367057994-19887-4-git-send-email-felipe.contreras@gmail.com>
References: <1367057994-19887-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 27 12:21:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UW2GC-0003IE-Ks
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 12:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755638Ab3D0KV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 06:21:26 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:43746 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755670Ab3D0KVU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 06:21:20 -0400
Received: by mail-ob0-f177.google.com with SMTP id ef5so4173762obb.22
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 03:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=wSEDXNZx5Jqk35aF3dw6Ssz546PVj5N8JNGQBwjoglk=;
        b=cmQKQtFUfF4r70x2enrOwKpUfsgQ8O3Sf+1qy21fYwl4WhNrZwZk1DfY9ZyC/54/XN
         oZyRPZKIyDBYCBiK+i1JSYa9a8ao5xdcRdTc4JoPxf+/8gAM21Za5aDsZHP3VF/uRAEk
         H5yxZDW/vaA0tosL+Ac5M/qTGuvtFYyYZC5UScFWaB/ITUMy3OMROnyRLbL/xtUzN0eg
         oUUrre25p1HCr7q8p0CrarDEqf8HqhOWiDbjrvr3lCnXg+Mr7cKrctny7t3txFQz6dce
         +nwsJ2C4bp/Ztmg3uslM4yfQnPei2kekXJVfjAmUd7G4AFKUOfJjGRq8Q5XWs2QeYDvJ
         311Q==
X-Received: by 10.60.79.161 with SMTP id k1mr5702368oex.106.1367058079891;
        Sat, 27 Apr 2013 03:21:19 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id zc8sm11666532obc.8.2013.04.27.03.21.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 03:21:19 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.1031.g2ee5873
In-Reply-To: <1367057994-19887-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222629>

The only caller, __git_complete_index_file() doesn't specify any limits
to the options for 'git ls-files', neither should this function.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 2 --
 1 file changed, 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index bc3fc9e..f7b0f3c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -323,8 +323,6 @@ __git_diff_index_helper ()
 
 # __git_index_files accepts 1 or 2 arguments:
 # 1: Options to pass to ls-files (required).
-#    Supported options are --cached, --modified, --deleted, --others,
-#    and --directory.
 # 2: A directory path (optional).
 #    If provided, only files within the specified directory are listed.
 #    Sub directories are never recursed.  Path must have a trailing
-- 
1.8.2.1.1031.g2ee5873
