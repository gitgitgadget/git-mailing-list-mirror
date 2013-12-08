From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/7] Trivial patches
Date: Sat,  7 Dec 2013 23:56:53 -0600
Message-ID: <1386482220-18558-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 08 07:05:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpXUy-0004b3-70
	for gcvg-git-2@plane.gmane.org; Sun, 08 Dec 2013 07:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752764Ab3LHGFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Dec 2013 01:05:42 -0500
Received: from mail-oa0-f49.google.com ([209.85.219.49]:44649 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561Ab3LHGEc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Dec 2013 01:04:32 -0500
Received: by mail-oa0-f49.google.com with SMTP id i4so2547194oah.22
        for <git@vger.kernel.org>; Sat, 07 Dec 2013 22:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=BVrNlDWXxv2uRhLVPNWocvaNgLzAh4Zb22KHcU2z+mM=;
        b=sJyZ+VN/62sJW9kl47Cuc32AoLeqx6poZCh5TnswOc5qVgaP0wcleaqsB7nvz3DVRD
         UBTnUr3Z32S+FL0mG8RYlsKhmTjb4WfxQDuNydVKR0Beapz4eFn12TbQNbCQHXzMuGNn
         tpP0gW5F1pqsNUw/zjlVtCYYbkXj1iMPJapFR6rERTDNYUPcdfJzcNezP03kvxN3U7dW
         fQeny3WbJKSW11tFC6GV8iu0Tb7Eoai7joNVDVlDzvgwtOxR5KgxUXscK0JdJfmWM1ai
         TKUdnkqpmbpDn29Hu1pajJaHKOD0Za1fGgKUmMQjPqTOxapa1NGCFkpHfXUjvClrgaZP
         BjnQ==
X-Received: by 10.182.153.226 with SMTP id vj2mr8769691obb.26.1386482671815;
        Sat, 07 Dec 2013 22:04:31 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id ru3sm8214668obc.2.2013.12.07.22.04.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2013 22:04:30 -0800 (PST)
X-Mailer: git-send-email 1.8.5.1+fc1.2.gebd1fb1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239034>

Felipe Contreras (7):
  config: avoid yoda conditions
  add: avoid yoda conditions
  abspath: trivial style fix
  t: trivial whitespace cleanups
  fetch: add missing documentation
  sha1_name: cleanup interpret_branch_name()
  sha1_name: simplify track finding

 Documentation/git-fetch.txt |  3 +++
 abspath.c                   |  2 +-
 builtin/add.c               |  2 +-
 config.c                    |  4 ++--
 sha1_name.c                 | 33 +++++++++++++++++----------------
 t/t0002-gitfile.sh          |  3 +--
 t/t0003-attributes.sh       |  1 -
 7 files changed, 25 insertions(+), 23 deletions(-)

-- 
1.8.5.1+fc1.2.gebd1fb1
