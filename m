From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] fetch: trivial fixes
Date: Sat, 21 Sep 2013 09:09:21 -0500
Message-ID: <1379772563-11000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 21 16:15:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNNxr-0000sy-7r
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 16:15:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083Ab3IUOOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Sep 2013 10:14:52 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:41087 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959Ab3IUOOv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 10:14:51 -0400
Received: by mail-ob0-f181.google.com with SMTP id gq1so1904792obb.40
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 07:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=FVYDSH3F6s+lPf2qsz908V0xPHDspO7gFFzUjQ4fVmw=;
        b=OBd1wLWRzWS5SiThGQ/UruDJOzWZLchwSi8SWx1aSkogR7RjUCzbV1xQglYbI77wOh
         A/pm4dv5WvwLOph9d0+G70UO92z395BJbI2yCoNc/s3OolpTTsGQQO/v0gT2aK/13ATy
         ZMqAMvoLf4pQCNUlSjoAsoVt5gYd+N9efBwgCwYOC7fzZqrTAfkoBeXlN7qvzJKCnCbA
         sBNNHim6yzYYEykajTgZGkdm0sbKK+2BuQJQ+SKiQP8KIR2FCbRlf9UNNPyI8PLWnZto
         dWxMkTAbNl//BLRPQuGJznqkLxAY18x3e6MaD+Q0jD/OKlDbTwN0GjurxmHf9OuP5paP
         AXKg==
X-Received: by 10.182.114.231 with SMTP id jj7mr818949obb.33.1379772888773;
        Sat, 21 Sep 2013 07:14:48 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id hl3sm8327348obb.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Sep 2013 07:14:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.2.gac946cf.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235119>

Felipe Contreras (2):
  fetch: add missing documentation
  remote: fix trivial memory leak

 Documentation/git-fetch.txt | 3 +++
 remote.c                    | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
1.8.4.2.gac946cf.dirty
