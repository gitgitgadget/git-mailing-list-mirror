From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH v2 0/2] git-web--browser: avoid errors in terminal when running
Date: Sat, 26 Jan 2013 04:40:31 +0400
Message-ID: <cover.1359160531.git.Alex.Crezoff@gmail.com>
References: <7v1ud93uw8.fsf@alter.siamese.dyndns.org>
Cc: Jeff King <peff@peff.net>, Alexey Shumkin <Alex.Crezoff@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 01:41:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tytpc-0000xW-6l
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jan 2013 01:41:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754773Ab3AZAkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 19:40:53 -0500
Received: from mail-lb0-f177.google.com ([209.85.217.177]:59387 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754412Ab3AZAkw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 19:40:52 -0500
Received: by mail-lb0-f177.google.com with SMTP id go11so1610743lbb.22
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 16:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=iHsdQmPmvSwxOub3Kq6jRw7yG+g88TGpnj21+YlW9sA=;
        b=uiSkffUUsRDE7ijsAaK2P+6yIbM/6d8fFUbOQLbFkZ++g0+plA9C898SN4C/DxC9+H
         0ffnomHMJ/gBrtiAI6gjR1VDG7JpSbI9jBoa514pADD/7934wauG8++IeG6yrrrk1dqQ
         oSxtqfr04JNveCTFFLJ9NZCwJz+eUUjIgiNL7tzGbUlIPFZfkJqSbh9rgeTrPSxzwvuR
         xdh3m43cogPFcH7iXd8aJLf22OaYnUnFONu9DwFLB6AM/zg55ez5zAqA/VXsq/WssxVJ
         rXXVVoIrRSZ8zb4Hr2ptLhGa8lIsNUYi5lzscMpavY9CFYVP35mAVWDgkbx725ptsZsv
         2XTw==
X-Received: by 10.152.134.243 with SMTP id pn19mr6735106lab.11.1359160850474;
        Fri, 25 Jan 2013 16:40:50 -0800 (PST)
Received: from ds212plus (ppp91-77-32-144.pppoe.mtu-net.ru. [91.77.32.144])
        by mx.google.com with ESMTPS id go4sm550699lbb.16.2013.01.25.16.40.48
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 25 Jan 2013 16:40:49 -0800 (PST)
Received: from localhost.localdomain (unknown [192.168.1.5])
	by ds212plus (Postfix) with ESMTPS id 72A7D6005C;
	Sat, 26 Jan 2013 04:41:38 +0400 (MSK)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.14.5/8.14.5) with ESMTP id r0Q0efTL009993;
	Sat, 26 Jan 2013 04:40:41 +0400
Received: (from alex@localhost)
	by localhost.localdomain (8.14.5/8.14.5/Submit) id r0Q0efi1009992;
	Sat, 26 Jan 2013 04:40:41 +0400
X-Mailer: git-send-email 1.8.1.1.10.g71fa0b7
In-Reply-To: <7v1ud93uw8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214601>

Reroll patch after all suggestions

Alexey Shumkin (2):
  t9901-git-web--browse.sh: Use "write_script" helper
  git-web--browser: avoid errors in terminal when running Firefox on
    Windows

 git-web--browse.sh         |  2 +-
 t/t9901-git-web--browse.sh | 59 ++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 55 insertions(+), 6 deletions(-)

-- 
1.8.1.1.10.g71fa0b7
