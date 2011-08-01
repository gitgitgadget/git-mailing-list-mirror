From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 0/2] Minor userdiff stuff
Date: Mon,  1 Aug 2011 12:37:47 +0200
Message-ID: <1312195069-10782-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 01 12:38:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnpt3-0008QF-3U
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 12:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753935Ab1HAKiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 06:38:13 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39829 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546Ab1HAKiL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 06:38:11 -0400
Received: by wwe5 with SMTP id 5so5480638wwe.1
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 03:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=ljutNralaHUaBdtz0BnhS6fruwbrZ/29dMTD95bUA3Q=;
        b=P6dv/YVbuYWy5qGN3h2rW2kHAZV9OwdZ+DtQEOB8Rf37Frfnn7WpShb2wtJgwJTj63
         +jecfB53NrYf6sOzmCZgJk4Jih3UoUWc3zLvoc8+uv/hnE9PcA/+ZBRtQq9ccufSmVfr
         NupUTVdVo4SQ8ZelkJLgUohjNKaTCfxgCU6wk=
Received: by 10.227.7.80 with SMTP id c16mr6036726wbc.40.1312195090565;
        Mon, 01 Aug 2011 03:38:10 -0700 (PDT)
Received: from localhost ([151.54.121.1])
        by mx.google.com with ESMTPS id b13sm4057121wbh.41.2011.08.01.03.38.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 01 Aug 2011 03:38:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.451.gcb935.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178325>

The first commit introduces diff patterns for POSIX shells.

The second defines diff types for C, Perl and shell scripts in git.git

Giuseppe Bilotta (2):
  Diff patterns for POSIX shells
  Use specific diff rules for repo files

 .gitattributes |    5 +++--
 userdiff.c     |    3 +++
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
1.7.6.451.gcb935.dirty
