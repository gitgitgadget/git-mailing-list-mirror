From: Techlive Zheng <techlivezheng@gmail.com>
Subject: [PATCH/RFC 0/7] mutiple improvements
Date: Sun, 13 Jan 2013 09:52:31 +0800
Message-ID: <1358041958-1998-1-git-send-email-techlivezheng@gmail.com>
Cc: apenwarr@gmail.com, greened@obbligato.org,
	Techlive Zheng <techlivezheng@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 13 02:58:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuCqW-0000Qz-7i
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 02:58:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754223Ab3AMB61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 20:58:27 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35277 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753795Ab3AMB61 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 20:58:27 -0500
Received: by mail-pa0-f49.google.com with SMTP id bi1so1629712pad.22
        for <git@vger.kernel.org>; Sat, 12 Jan 2013 17:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=KE5ZtZzq26jEpfxiWCaFC4LuilBX6aDNu+IXCo4EKm8=;
        b=KHdK8f4V04txrFIN/DzU/Fwq/7lvIpt8yIFlYs4xA5xbtftu8MaavunjmnSLyg4kCr
         gDAVOUPAcMe8YboYinO7B2Jxh3qVFvm04FXk4zj47UskdlXSfAV2i58WkmFJWQvpYJVn
         dJWMaAUjGwHSVev+FF6h2usMWdAhvaBnzpGXIdY8FgiUUOwU8smYtaeypiXKCISQryVr
         fL7oLWY1Uk72sTNIOyMmEoDElVjAJDU3m2u0vRr9R6eqn9USGSOBuznZhnf/F+IcMjg4
         jhRQaFdUj3tXV59jGb1Hk6uMw4aJ6ycR3OzKCRVot5UCiLsQ2oky0WBWaUe+MUO4OERB
         Wtog==
X-Received: by 10.68.242.225 with SMTP id wt1mr239259995pbc.65.1358042306642;
        Sat, 12 Jan 2013 17:58:26 -0800 (PST)
Received: from home.techlive.me ([122.244.155.16])
        by mx.google.com with ESMTPS id d8sm5908882pax.23.2013.01.12.17.58.23
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Jan 2013 17:58:25 -0800 (PST)
X-Mailer: git-send-email 1.8.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213320>

* refactor tests for 'git subtree'
  * rearrange some tests
  * clean up unnecessary quotes
  * make each test self-contained
* keep commit intact after the split by using '%B'
* handle '--prefix' argument with slash appended correctly

David A. Greene (1):
  contrib/subtree: Remove test number comments

Techlive Zheng (6):
  contrib/subtree: Add vim modeline
  contrib/subtree: Ignore testing directory
  contrib/subtree: Code cleaning and refactoring
  contrib/subtree: Make each test self-contained
  contrib/subtree: Use %B for the split commit message
  contrib/subtree: Handle '--prefix' argument with a slash appended

 contrib/subtree/.gitignore         |    5 +-
 contrib/subtree/git-subtree.sh     |   83 ++-
 contrib/subtree/git-subtree.txt    |   13 +
 contrib/subtree/t/t7900-subtree.sh | 1233 +++++++++++++++++++++++-------------
 4 files changed, 872 insertions(+), 462 deletions(-)

-- 
1.8.1
