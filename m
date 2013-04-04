From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 0/4] remote-helpers: trivial test fixes
Date: Thu,  4 Apr 2013 09:36:15 -0600
Message-ID: <1365089779-9726-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>, Antoine Pelisse <apelisse@gmail.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 04 17:37:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNmEZ-0000WM-Vc
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 17:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760604Ab3DDPhS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 11:37:18 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:49217 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760391Ab3DDPhR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 11:37:17 -0400
Received: by mail-ob0-f170.google.com with SMTP id uy19so511557obc.1
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 08:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=NLf2WmT98aow97QJjcZ89XkOUv2h29j3GvxQreE6FE4=;
        b=GEXh01Igk7GlDNmBl381M1kv5P3uVa7TqNdKT5wxIBa1EeY5dlSR/XgUkNWI2uWe5B
         VGFJYjN21CvDDJehVB4QGVon8R+KxhTbLCiG3lnDe02HwLqEFgwtWoclw/0fYY1FOTlQ
         paIiUX09M4zF8YaZL0tcqQHwUHURTjMX6WpXj7rrykjO0TcfT/+EDPHNkLpAKXrCUeod
         kk/Q8Hw+f/BfDbKAZfKAB2lot0Jj5NNWudOqDmBJmZGMZ+9xymSCol/AUPdRvk/7FzKV
         8P7LV5ZLfWAbjHX7LkCtVW+VJ8im6y3RBa+KI8fNio0F70KmhBS4zcqmJS52hPTFnno5
         hl4Q==
X-Received: by 10.60.24.197 with SMTP id w5mr4594432oef.6.1365089836204;
        Thu, 04 Apr 2013 08:37:16 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id be1sm6812256obb.11.2013.04.04.08.37.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 08:37:15 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220019>

Hi,

A reroll, now we do some checks, just avoid test-lint-duplicates, and fix the
outsanding shell portability issue. The rest is the same.

Felipe Contreras (4):
  remote-bzr: avoid echo -n
  remote-helpers: fix the run of all tests
  remote-bzr: remove stale check code for tests
  remote-hg: fix hg-git test-case

 contrib/remote-helpers/Makefile          |  1 +
 contrib/remote-helpers/test-bzr.sh       | 16 +---------------
 contrib/remote-helpers/test-hg-hg-git.sh |  1 -
 3 files changed, 2 insertions(+), 16 deletions(-)

-- 
1.8.2
