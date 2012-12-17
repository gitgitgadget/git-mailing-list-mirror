From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH 0/2] Documentation: clarify usage of checkout
Date: Mon, 17 Dec 2012 00:45:00 -0600
Message-ID: <1355726702-27974-1-git-send-email-chris@rorvick.com>
Cc: Chris Rorvick <chris@rorvick.com>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>,
	Woody Wu <narkewoody@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 17 07:46:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkUTE-0003EZ-Ms
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 07:46:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805Ab2LQGqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 01:46:19 -0500
Received: from mail-ia0-f174.google.com ([209.85.210.174]:51268 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303Ab2LQGqT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 01:46:19 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so5175525iay.19
        for <git@vger.kernel.org>; Sun, 16 Dec 2012 22:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=m79dnoOf/QVDo7FF4ul3/RWErTaYzywY5grJTX1GkMw=;
        b=Jnt6ZLg/MfHmF+H1EyVPx0X78OKpOuz56cZcilK9SHKRoO7vehQ/R2y1v8I/9Nbu+w
         /mS9dPfhAE7ZxOx1HQe5kQlF0srghK2X9+ZDoBsQmWy4eKSTlB2OoTSRPegPXjCEhccG
         FUk9PTlEnj4M+AeYAPcl8m2kuMeevebq+j16zDDTRk8RTQfKEZECgXMTH0UZzYKDogXp
         m6Bz+K4rqpyBdsyeLXBX9qMyx/Q0bzfam7mgEOUdGnC8jjcHylle0tws9sXz2njqFnuB
         ynXKr3rnNEemecDu4w6kGzVwB6UV++NxBOPKWHMPOhY08Uk/XgeUTXN6293wGXHLnoTX
         XS9w==
Received: by 10.50.149.131 with SMTP id ua3mr8331415igb.5.1355726778974;
        Sun, 16 Dec 2012 22:46:18 -0800 (PST)
Received: from marlin.localdomain (adsl-70-131-98-170.dsl.emhril.sbcglobal.net. [70.131.98.170])
        by mx.google.com with ESMTPS id aa6sm5087935igc.14.2012.12.16.22.46.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 16 Dec 2012 22:46:18 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc1.203.g1ddc124
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211636>

This is response to the questions posed in:

  http://thread.gmane.org/gmane.comp.version-control.git/211624

It doesn't seem like the behavior implemented in 70c9ac2 is documented.

Chris Rorvick (2):
  Documentation/git-checkout.txt: clarify usage
  Documentation/git-checkout.txt: document 70c9ac2 behavior

 Documentation/git-checkout.txt | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

-- 
1.8.1.rc1.203.g1ddc124
