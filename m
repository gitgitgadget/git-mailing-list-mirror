From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 0/9] remote-helpers: fixes and cleanups
Date: Fri, 26 Apr 2013 16:12:30 -0500
Message-ID: <1367010759-17928-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 23:14:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVpxw-0006ya-Ir
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 23:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757155Ab3DZVN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 17:13:56 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:55358 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754936Ab3DZVN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 17:13:56 -0400
Received: by mail-oa0-f43.google.com with SMTP id k7so4421508oag.30
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 14:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=5D5qU6ptzK23qkaT8mCNdfIZGuntOygK0cOGhXM1qUE=;
        b=pSDo7fkRevNhZGhdu9dXwVGtonHPjnxhk+d0jOVvvVnW9Wf5vu+cfJ4qVJrtRpEeRi
         kBUu29OHCjfGKGpVhxMzNx10jaTRhBzOqBgCh1mpgh8n9+S8Q/5jsmua7oMwDDtkamYx
         Cu4mszMSJnJhy3RjeOK44HVTqIGI37fc3NFFWA/xiOSaaGe/sX/OEZ1mgK/24fbxWXnn
         aPsmq0jQyCpKaHMl1Q+yDzxkoG90V+dr55MN41HqGnHVqjPUtqGhXqJQ21QiURYK2Izk
         QxpysjBHfcUACU0HnuNUZX4CZWfJsY011sUMSPJ/r/zFFOk/2Yqr+/dmswNW5XUZHVtB
         RMXQ==
X-Received: by 10.60.37.36 with SMTP id v4mr2723287oej.53.1367010835729;
        Fri, 26 Apr 2013 14:13:55 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id qj8sm9736027oeb.2.2013.04.26.14.13.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 26 Apr 2013 14:13:54 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.1031.g2ee5873
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222582>

Updated the commit messages, so we say Bazaar instead of Mercurial, and stuff.

Here's a bunch of cleanups mostly to synchronize remote-bzr and remote-hg.

Felipe Contreras (9):
  remote-helpers: trivial cleanups
  remote-hg: remove extra check
  remote-bzr: fix bad state issue
  remote-bzr: add support to push URLs
  remote-hg: use hashlib instead of hg sha1 util
  remote-bzr: store converted URL
  remote-bzr: tell bazaar to be quiet
  remote-bzr: strip extra newline
  remote-bzr: use proper push method

 contrib/remote-helpers/git-remote-bzr | 55 ++++++++++++++++++++++++++++-------
 contrib/remote-helpers/git-remote-hg  | 10 ++-----
 2 files changed, 48 insertions(+), 17 deletions(-)

-- 
1.8.2.1.1031.g2ee5873
