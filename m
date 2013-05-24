From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 0/2] Replacement for rr/die-on-missing-upstream
Date: Fri, 24 May 2013 13:12:02 +0530
Message-ID: <1369381324-10206-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 24 09:40:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ufmbz-0005Gp-M3
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 09:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759944Ab3EXHkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 03:40:24 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:37309 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759496Ab3EXHkX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 03:40:23 -0400
Received: by mail-pb0-f53.google.com with SMTP id un4so3880815pbc.26
        for <git@vger.kernel.org>; Fri, 24 May 2013 00:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=7pgXydLuPY0e0sKuaqBeBJxbzTd9e9KiAxVfDK8VXFg=;
        b=0u3ae6JAXa6pHqXsP76ic6yreTXcATvqVgXD5sNxURy/72yuOKqn8QXlMaUorVmvVq
         C0Hde1IZ4b06zpQmu/yTOWtQ+7DpngtgAMVGWR4Sfn6h+J4r60Bt8+tpJOxPde0NmIBE
         JFEygw3kfYWL1qqvdXsTXWMU9kZQNNIhQB0LK7VoE4aCRuslRvHhA5EkTt5bExhkcn6W
         GQpty2YyyhzlbmmcIqx2tV+WELxFK/yWa0Q+/EZh8hEfAqBtyKVoZJJ8Jl0gPGqjLfk4
         tmH3yTrjo+BJAFcTPTTQMNL+Lmf73q9fc1ajNry0OAHtWxmRM8uBt0SQgUomu+V3etcW
         XnzA==
X-Received: by 10.66.255.99 with SMTP id ap3mr17305522pad.102.1369381222937;
        Fri, 24 May 2013 00:40:22 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id wt5sm15136412pbc.38.2013.05.24.00.40.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 24 May 2013 00:40:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.17.gd95ec6c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225330>

[1/2] clarifies the commit message to say that a grep didn't find
"@{u}" or "@{upstream}" hard-coded by any callers.  Thanks to Junio.

[2/2] fixes a small grammar error in the commit message.  Thanks to
Eric Sunshine.

Ramkumar Ramachandra (2):
  sha1_name: fix error message for @{u}
  sha1_name: fix error message for @{<N>}, @{<date>}

 sha1_name.c                   | 21 +++++++++++++++------
 t/t1507-rev-parse-upstream.sh | 15 +++++----------
 2 files changed, 20 insertions(+), 16 deletions(-)

-- 
1.8.3.rc3.17.gd95ec6c.dirty
