From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] Simple default fixes for v2.0
Date: Sun, 20 Apr 2014 19:17:32 -0500
Message-ID: <1398039454-31193-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 21 02:28:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wc26B-0001zm-W9
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 02:28:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbaDUA15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 20:27:57 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:43580 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908AbaDUA14 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 20:27:56 -0400
Received: by mail-yk0-f169.google.com with SMTP id 142so2952201ykq.14
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 17:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ziVtcXVkB0s6udoaUc4j4KIYhS+e3Rkj8EMiclawMNk=;
        b=RMoC5RooSBxSiUZP8ZLPEOAQ/govE+ElZQaxJ12A43UG5FciLqIaZpZMQKaUUIb4W7
         8lrEvPZATwkGUgiRWWdOuiDpr/bL8ZpQe2arcgxK1eNhp+St1sll6M39Ko+vgHgZ1Ce+
         C+5SZAhJZyLGRXpxvwTeiBG72vb2eBvFu45mLP232w46VGtyzTMkr1sNt2al/8M/N3Ht
         zEPFLS6X1BFB5bccn4zcA6hBDNjdKEhmErCp8FiQQRjq1QuwQ5rkIQevZdUFW8gDhJH9
         0ycR/yYwg0Q0B5CpobW416GwbbrHXoMH8XbEDGNEsbUdL+FiZWaFkGlv21BHZYDI8yYg
         Zw0g==
X-Received: by 10.236.200.67 with SMTP id y43mr817288yhn.77.1398040075905;
        Sun, 20 Apr 2014 17:27:55 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id s68sm38505084yhk.22.2014.04.20.17.27.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Apr 2014 17:27:54 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.1.g5c924db
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246600>

I don't see why people need to set these to have sensible behavior:

  merge.defaulttoupstream = true
  mergetool.prompt = false

Let's change them to sane defaults so they are not needed.

Felipe Contreras (2):
  merge: enable defaulttoupstream by default
  mergetool: run prompt only if guessed tool

 Documentation/git-merge.txt |  5 ++---
 builtin/merge.c             |  2 +-
 git-mergetool.sh            | 14 +++++++++++---
 3 files changed, 14 insertions(+), 7 deletions(-)

-- 
1.9.2+fc1.1.g5c924db
