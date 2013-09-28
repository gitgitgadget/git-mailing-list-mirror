From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 00/10] trivial style and other fixes
Date: Sat, 28 Sep 2013 16:51:36 -0500
Message-ID: <1380405106-29430-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 28 23:57:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2W7-000248-Lq
	for gcvg-git-2@plane.gmane.org; Sat, 28 Sep 2013 23:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755104Ab3I1V5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 17:57:30 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:46078 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755078Ab3I1V52 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 17:57:28 -0400
Received: by mail-oa0-f45.google.com with SMTP id o17so2998825oag.4
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 14:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=1vhXO2N4W+26ipPySMXqRgyRy8dqmSKtyxXM2bKMy6c=;
        b=gouc+qteXgp8EqsK0USiEur//ou+3pCf1c4DbmIPJEbjCpzZssVxZQrPDU93igPtAC
         9OyyNyrmnGJePyjSeIiW9tJrNm5PePnEPPsIu4mjJkqUaNl1/J2l6mnhXsWTigMldVdx
         GV73/GfV0cOGyRY5HOzJSjTbiG2r3EF1LNIH0stcu4jJKAoWp1omS+ZZG6ozfdPM1mDk
         vYO2D2+gUBvW5eCPQUHqJ450iZer5uGBqwgSq/gLzSbWO2oWX2WAmpx26rgqjZ2W+p0D
         0RBEGTX81iEve447J0WyYA789Ae98Etme4LJ93KhnCaJepV3aI3lzNL9XBJri7a9h1s6
         eMqQ==
X-Received: by 10.182.129.42 with SMTP id nt10mr12131469obb.19.1380405448139;
        Sat, 28 Sep 2013 14:57:28 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s9sm19464072obu.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 14:57:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235509>

Felipe Contreras (10):
  transport-helper: trivial style fix
  describe: trivial style fixes
  pretty: trivial style fix
  revision: trivial style fixes
  revision: add missing include
  shortlog: add missing declaration
  diff: trivial style fix
  run-command: trivial style fixes
  revision: trivial style fixes
  setup: trivial style fixes

 builtin/describe.c |  7 +++----
 builtin/diff.c     |  2 +-
 pretty.c           |  2 +-
 revision.c         | 14 ++++++--------
 revision.h         |  1 +
 run-command.c      | 13 +++++--------
 setup.c            |  4 ++--
 shortlog.h         |  2 ++
 transport-helper.c |  1 +
 9 files changed, 22 insertions(+), 24 deletions(-)

-- 
1.8.4-fc
