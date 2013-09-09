From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] version-gen: fixes and cleanups
Date: Mon,  9 Sep 2013 00:01:27 -0500
Message-ID: <1378702889-21638-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 09 07:06:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VItgR-00037b-O8
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 07:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999Ab3IIFGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 01:06:37 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:39528 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848Ab3IIFGg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 01:06:36 -0400
Received: by mail-ob0-f176.google.com with SMTP id uz19so5563925obc.35
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 22:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=SQxdP6b8e0BPhnEJvU1/1h95kGY3Q7E4IU7Oo39AcQ4=;
        b=bAsLc9jwvPGrCFCNia6I8UR+KsAUH5167OE+KaLpawiIEBRC2UX75ZMuaLvamlWwvz
         hvMYn3GMi05SEGsMaEuLZ8hSGJ4AKt1yPL7a0lN2vMeDG4LvtePTtFK1y1CrTGN/rDwt
         dM7mvRhefY0+9JgoE8WXRVgTjOi/AqidHz2wVR2WvNtO/tqre/gSkM1vkF4e0GgQVjXU
         rCHjjxHYtibj+y9JmSeTZ/Swa5l2DBZmIIPhYFI5oCNgQP3t9Jr/RDoQr48N5KcohBpE
         gKw2Fixyuet6Z5tAMjxddsX04Jfgy3a6EsBDRa+xXpTIq0sTiFQ/GXlSe5P16YYj5hiS
         FCdA==
X-Received: by 10.182.46.232 with SMTP id y8mr9968551obm.13.1378703195964;
        Sun, 08 Sep 2013 22:06:35 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id u3sm11819226oeq.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 22:06:29 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-338-gefd7fa6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234310>

Felipe Contreras (2):
  version-gen: cleanup
  version-gen: avoid messing the version

 GIT-VERSION-GEN | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

-- 
1.8.4-338-gefd7fa6
