From: larsxschneider@gmail.com
Subject: [PATCH v6] git-p4: add config git-p4.pathEncoding
Date: Thu,  3 Sep 2015 11:14:06 +0200
Message-ID: <1441271647-67824-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: luke@diamand.org, tboegi@web.de, sunshine@sunshineco.com,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 03 11:14:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXQb3-0008Eu-Gm
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 11:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752995AbbICJOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 05:14:12 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35447 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752966AbbICJOK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 05:14:10 -0400
Received: by wicge5 with SMTP id ge5so66550395wic.0
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 02:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=qwpeRv+NnZBrv23sEmwgYq9+BynBZnJavqssECSB8rA=;
        b=mFu6bwqnrkndTLJhI+P493qxM009GNp17gQdanZ83FjzIccX+Hpis5WRWx1upp3zXR
         6pPz6c/9KFC/w6xOEWWb14Otmo/56xHjyxB59qmZLphEWzccaKGIvZAWYUqfk3R5u6oQ
         zdq/sJEv26FqYhi7h6QhfRpTZyC1yVfgtEPVAWE9nbcHO/79jFY3kqostKnisZDa0L6Y
         SqBwePzKRd9QTjyCMWThBJWKOYHhu5/Nn0zs0CYUlX1sNMApHw4QpCb1ImDiaLcqIgOu
         zJZEGxvLX/XBhxty0CZCvEZkdyGg7Om02f+eOlKyj6hrlUOhAza1g/+cY4h5o85Hffu8
         WHPw==
X-Received: by 10.180.182.112 with SMTP id ed16mr12375893wic.19.1441271649176;
        Thu, 03 Sep 2015 02:14:09 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id h6sm7952474wiy.3.2015.09.03.02.14.07
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Sep 2015 02:14:08 -0700 (PDT)
X-Mailer: git-send-email 1.9.5 (Apple Git-50.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277188>

From: Lars Schneider <larsxschneider@gmail.com>

Diff to v5:
* use "test_config" (Thanks Remi! I am still learning all the tools...)
* removed whitespaces (Thanks Luke! I added this to my "generate patch" script. Won't happen again :-)
* added ACK from Luke (I interpreted "Looks good to me" that way. I hope this is OK.)

Thanks,
Lars

Lars Schneider (1):
  git-p4: add config git-p4.pathEncoding

 Documentation/git-p4.txt        |  7 +++++
 git-p4.py                       | 11 ++++++++
 t/t9822-git-p4-path-encoding.sh | 60 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+)
 create mode 100755 t/t9822-git-p4-path-encoding.sh

--
1.9.5 (Apple Git-50.3)
