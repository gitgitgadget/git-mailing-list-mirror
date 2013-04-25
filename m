From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/9] remote-helpers: fixes and cleanups
Date: Thu, 25 Apr 2013 06:20:40 -0500
Message-ID: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 25 13:22:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVKFi-0003i9-4O
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 13:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757997Ab3DYLWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 07:22:09 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:41180 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756519Ab3DYLWI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 07:22:08 -0400
Received: by mail-ob0-f170.google.com with SMTP id eh20so2400140obb.1
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 04:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=fkoI/wmQAjwRSAFHo0yY03Yi469Jpv8uDH/U2ZMlhLo=;
        b=cgrYyfrgjab5B+q64Nv7hyd4zaGff5xZl6g50sor2H/4tkyVaxcddMKRPeM2kJWyax
         7XvmZqVjWF3cU2Ccm0OSUZ+EOnUidLluzyZAO3xT2MkhaRFKnJvkr+yCs40tQfUDJwbI
         vzHbrlrv13ce9SleZja+but5D9qU/qaT4VqYE6aA5UZyjJ6DKrvd/yirqzbtuYAcnvBK
         8Nn9+2F+OUkPd88DKyEmZjUbGU6fBkFsRbAD1nURzhyXPMFjpU1N1tLssfXRKpkAdNZD
         tmCWihIoNy1dJvdxLhJGiIIPQtdgA2xqFh88XwhSrGoZdv0VERCt6/M7QlgffcJZdrDN
         S83A==
X-Received: by 10.182.107.200 with SMTP id he8mr3169854obb.40.1366888927635;
        Thu, 25 Apr 2013 04:22:07 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id dt3sm3004937obb.12.2013.04.25.04.22.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 04:22:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222368>

Hi,

Here's a bunch of cleanups mostly to synchronize remote-bzr and remote-hg.

One of these might conflict with a series already in pu, if so, the code here
should be the prefered one.

Felipe Contreras (9):
  remote-bzr: trivial cleanups
  remote-hg: remove extra check
  remote-bzr: fix bad state issue
  remote-bzr: add support to push URLs
  remote-hg: use hashlib instead of hg sha1 util
  remote-bzr: store converted URL
  remote-hg: use python urlparse
  remote-bzr: tell bazaar to be quiet
  remote-bzr: strip extra newline

 contrib/remote-helpers/git-remote-bzr | 47 ++++++++++++++++++++++++++++++-----
 contrib/remote-helpers/git-remote-hg  | 17 ++++++-------
 2 files changed, 48 insertions(+), 16 deletions(-)

-- 
1.8.2.1
