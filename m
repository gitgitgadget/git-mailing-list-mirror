From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/4] t: rev-parse-parents: cleanups
Date: Mon,  2 Sep 2013 01:30:35 -0500
Message-ID: <1378103439-3225-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 02 08:35:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGNjT-0003hp-EN
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 08:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755298Ab3IBGfX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 02:35:23 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:32946 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755120Ab3IBGfX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 02:35:23 -0400
Received: by mail-ob0-f170.google.com with SMTP id eh20so4173503obb.1
        for <git@vger.kernel.org>; Sun, 01 Sep 2013 23:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=oUPPiiOv+DdgkR+WKSrBulmmo4ydqFxS1y2cWG/WvpM=;
        b=hBI+P1UBF2GAnQHmIbEGfhziqJKm979Uog1SPTT+b6l8maE9/8vwTClKywFhF9Ff7b
         eIT7OuQXRT/q5N5vKyD0xqQ+e7m/4D1O3RxoRP2fh0iYPuceUplz/aJy7jp6VQW7kQ1l
         fhfCU29LU4LjMCSXmHPbVAY7N1IPcy3xA3EuFNsthgyQdr97psvrm1iwzsBSuke/Bu8c
         USehR1vhDMGQg0e3p8ZhgPY2+bX1+hp1SDcaHxtjNHd+vVN4+j7i8i1Zs/m5qI7xkPlg
         I7XpwL0M942jOynJThv4Rcq2TV3tAAj4uOwo9zlSmM8AjvIO1MSOZkeYw/7LLz490sL0
         UfbQ==
X-Received: by 10.60.33.74 with SMTP id p10mr15839528oei.18.1378103722840;
        Sun, 01 Sep 2013 23:35:22 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id z2sm11961040obi.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 01 Sep 2013 23:35:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-338-gefd7fa6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233610>

Felipe Contreras (4):
  t: rev-parse-parents: fix style
  t: rev-parse-parents: fix weird ! notation
  t: rev-parse-parents: avoid yoda conditions
  t: rev-parse-parents: simplify setup

 t/t6101-rev-parse-parents.sh | 96 +++++++++++++++++++++++++++++++-------------
 1 file changed, 69 insertions(+), 27 deletions(-)

-- 
1.8.4-338-gefd7fa6
