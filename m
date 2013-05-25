From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/4] remote-helpers: test reorganization
Date: Fri, 24 May 2013 21:38:23 -0500
Message-ID: <1369449507-18269-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	David Aguilar <davvid@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:40:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4P5-00075g-A9
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:40:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754551Ab3EYCkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:40:08 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:40317 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280Ab3EYCkG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:40:06 -0400
Received: by mail-oa0-f41.google.com with SMTP id n9so6946691oag.28
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=LKJKgQMu/jV/jsdwC+N7lfzxPncUGJP1D3/HtuQhnnY=;
        b=F+CTuH1L82rKi2vgka1Bz2nCcfOSN//+8c9ou+VKzTNOMz114KuSxtbYcR5WXI46IV
         ampIRR0fVKpQz7O47hSktpiu3brRrS9ZBYCCYHOKBf4rY/giONY01KPw/xR9xLIVisZj
         o9KlcJE50ce6VUgAnruprVKl4HPhJfXm90pYfH+EKy9JRHLCsMoNDFosF6+ebZ3iNqsM
         xQEkln5whyS62BHxTjmsxfPFnCi51ZUxKGKUqNnrYm9B3HTKK6xRdWmGTaDRgt1pf2hs
         qbPZeic1SS4AtkXOS8I0lKBqwgvZyy3Kxv3o4m7P34b8jWzX9WxXKL8X4bCviQTMD6yM
         o5Jw==
X-Received: by 10.182.209.71 with SMTP id mk7mr13507217obc.83.1369449606051;
        Fri, 24 May 2013 19:40:06 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id h4sm20612533oel.2.2013.05.24.19.40.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:40:04 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225463>

Now we use PYTHON_PATH properly, and also we are able to do:

  make -C contrib/remote-helpers install

Felipe Contreras (4):
  remote-helpers: generate scripts
  remote-helpers: rename tests
  remote-helpers: allow direct test execution
  remote-helpers: add exec-path links

 .gitignore                                         |  2 ++
 contrib/remote-helpers/.gitignore                  |  2 ++
 contrib/remote-helpers/Makefile                    | 25 +++++++++++++++++-----
 .../{git-remote-bzr => git-remote-bzr.py}          |  0
 .../{git-remote-hg => git-remote-hg.py}            |  0
 contrib/remote-helpers/{test-bzr.sh => test-bzr.t} |  3 ++-
 .../{test-hg-bidi.sh => test-hg-bidi.t}            |  3 ++-
 .../{test-hg-hg-git.sh => test-hg-hg-git.t}        |  3 ++-
 contrib/remote-helpers/{test-hg.sh => test-hg.t}   |  3 ++-
 9 files changed, 32 insertions(+), 9 deletions(-)
 create mode 100644 contrib/remote-helpers/.gitignore
 rename contrib/remote-helpers/{git-remote-bzr => git-remote-bzr.py} (100%)
 rename contrib/remote-helpers/{git-remote-hg => git-remote-hg.py} (100%)
 rename contrib/remote-helpers/{test-bzr.sh => test-bzr.t} (98%)
 rename contrib/remote-helpers/{test-hg-bidi.sh => test-hg-bidi.t} (98%)
 rename contrib/remote-helpers/{test-hg-hg-git.sh => test-hg-hg-git.t} (99%)
 rename contrib/remote-helpers/{test-hg.sh => test-hg.t} (97%)

-- 
1.8.3.rc3.312.g47657de
