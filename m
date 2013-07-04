From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH v9 0/5] Incremental updates against 'next' branch
Date: Thu,  4 Jul 2013 16:45:45 +0400
Message-ID: <cover.1372939482.git.Alex.Crezoff@gmail.com>
References: <cover.1372719264.git.Alex.Crezoff@gmail.com>
Cc: John Keeping <john@keeping.me.uk>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 04 14:46:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuivK-0000zZ-Mn
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 14:46:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961Ab3GDMp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 08:45:59 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:53291 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964901Ab3GDMp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 08:45:57 -0400
Received: by mail-lb0-f178.google.com with SMTP id y6so1179002lbh.9
        for <git@vger.kernel.org>; Thu, 04 Jul 2013 05:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=7VuBGbFBPU81IzJyLcMRcMnfGNYaEccXemmY6R57tfs=;
        b=JbRaemd9Fm+VriPhC+gp2ndA3PTE8vL5H8PWJLXfLrHPSnOYaGKkQmdR/fgg6zq9ZY
         52cYAcZYIBwx4w8AzNHU57jyKIxcIikt1ADma6IR01Y2IaMrLVMX2Q79MfabAXpgG8p8
         UTVN8xkiam8mKmFt1h5KPKSxgGC4OfTvknyK6kcgykK281ip73LxAgWVfF6JZkTaHVBO
         YL9RdfyCDFD7O2iyYr5H5vmlN1+grQOCz9O4Yp0Urhif4+0V+d+hUHEUjfr5Gs7FSlrI
         r9+f3lQ42kn8iEkXzqs1eef4wgb+tKgOP6nefBDmc2OTFFLUW2+sawNec7KcC3Ir4Q07
         7Q9g==
X-Received: by 10.112.150.68 with SMTP id ug4mr3385353lbb.81.1372941955317;
        Thu, 04 Jul 2013 05:45:55 -0700 (PDT)
Received: from localhost ([85.21.218.130])
        by mx.google.com with ESMTPSA id n17sm1230150lbv.2.2013.07.04.05.45.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Jul 2013 05:45:54 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.15.g5c23c1e
In-Reply-To: <cover.1372719264.git.Alex.Crezoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229575>

This patch series is an incremental updates on top of (7c375214 t4205:
replace .\+ with ..* in sed commands, 2013-07-01) as far as v7 patches
were applied to the 'next' branch but there were more improvements made
in v8.

Alexey Shumkin (5):
  t4041, t4205, t6006, t7102: use iso8859-1 rather than iso-8859-1
  t4205: revert back single quotes
  t4205, t6006, t7102: make functions more readable
  t6006: add two more tests for the case i18n.commitEncoding is not set
  t4205: avoid using `sed`

 t/t4041-diff-submodule-option.sh |   4 +-
 t/t4205-log-pretty-formats.sh    | 145 +++++++++++++++++++--------------------
 t/t6006-rev-list-format.sh       |  69 ++++++++++---------
 t/t7102-reset.sh                 |  22 +++---
 4 files changed, 121 insertions(+), 119 deletions(-)

-- 
1.8.3.1.15.g5c23c1e
