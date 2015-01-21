From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH 0/2] Fix typos in various places
Date: Wed, 21 Jan 2015 15:13:24 +0600
Message-ID: <1421831604-28674-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 10:13:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDrM2-0003OY-RX
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 10:13:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752496AbbAUJNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 04:13:34 -0500
Received: from mail-la0-f49.google.com ([209.85.215.49]:61332 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752336AbbAUJNc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 04:13:32 -0500
Received: by mail-la0-f49.google.com with SMTP id hs14so39091824lab.8
        for <git@vger.kernel.org>; Wed, 21 Jan 2015 01:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=RHUxUuIyFqC53/xj9PCrHg7YQKxkqb5i01HV2f/oZz0=;
        b=b5HtssJ/BqNCfS4RhBE4QWzhhxsxCp5akNGptu3525L8zIuRybZi43rxg6Y9+K5djC
         YbOIVXd76nlH1czacwYG+LXxAWIfHpet82VwZByulQfzRQid4EOgiplrn3ys6PeQ7qLT
         RANC9wW1+sXvFc1Zw+cpnXSONvv+jcPEx9TK7f7Hi0bsfCc3dyqQ+HF47aCYiR7upTZD
         Gn5Wz511LdY/OSq9wGrVhUcxy0M4KS0wYpAUFh8Pp9J+Tlcf82yYyE+FVQ89ikJ7qNE+
         78P0MisPN7fUupAN+6V0uCOXM1MUy0a+1E/P/GCSRNH+gq72Yht3KoB04mptN27DRQiV
         Jejw==
X-Received: by 10.112.47.135 with SMTP id d7mr42850810lbn.54.1421831611395;
        Wed, 21 Jan 2015 01:13:31 -0800 (PST)
Received: from localhost.localdomain ([147.30.53.164])
        by mx.google.com with ESMTPSA id w1sm1691378lal.49.2015.01.21.01.13.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Jan 2015 01:13:30 -0800 (PST)
X-Mailer: git-send-email 2.3.0-rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262721>

These patches provides two minor typo fixes in pack-bitmap.c and 
t/lib-terminal.sh

Alexander Kuleshov (2):
  pack-bitmap: fix typo
  t/lib-terminal.sh: fix typo

 pack-bitmap.c     | 2 +-
 t/lib-terminal.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.3.0-rc1
