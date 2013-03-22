From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/2] Fix a couple of minor things in pull test
Date: Fri, 22 Mar 2013 18:01:46 +0530
Message-ID: <1363955508-13368-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 22 13:31:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ17k-0006bA-UV
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 13:31:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933109Ab3CVMaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 08:30:39 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:56101 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932249Ab3CVMah (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 08:30:37 -0400
Received: by mail-pb0-f49.google.com with SMTP id xa12so2988941pbc.8
        for <git@vger.kernel.org>; Fri, 22 Mar 2013 05:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:subject:date:message-id:x-mailer;
        bh=PwuL6k51gpgyxiwURrlvyaMxoRCq7iS4XH5sl02f4DE=;
        b=lt0xQq3Xl7YVsMi/At1JYobyGi6hkHol2sXQSQiEHkGJIH1NiDDOUyqXsQhwL92Vsr
         uT594WJdW2Xrvf34eCJS8OA8Pq7oKI4LZJf5EbbBxeRIjwuofTcjpbQfB9vyLuexDZAH
         /w9ULyM6FzhMs+GN5MMAn8veUgLT+AzrhcFT0AwyCoUVYJI4SRuS6fsCG9EcqBpxM1uk
         NnTpzEaqJ+oSjUCZn1xTI9E8W2fvuXOpmsEp0khHf7+AgqPmB0UEhUu0MPNeal96rk2t
         yiFO7ikf0ut66v/tdZ3Z7aYZindWTsx9yKCT6qWb61zVWO2IAHL6RvOqNrLXvZwqzpiJ
         /ilw==
X-Received: by 10.68.143.197 with SMTP id sg5mr2372257pbb.101.1363955436953;
        Fri, 22 Mar 2013 05:30:36 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id ky17sm2808786pab.23.2013.03.22.05.30.34
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 22 Mar 2013 05:30:36 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.141.gad203c2.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218798>

I just happened to open the file when searching for the right file to
put my autostash tests.

Ramkumar Ramachandra (2):
  t5520 (pull): update test description
  t5520 (pull): use test_config where appropriate

 t/t5520-pull.sh | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

-- 
1.8.2.141.gad203c2.dirty
