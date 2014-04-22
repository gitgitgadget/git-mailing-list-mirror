From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v4 0/2] peroper align of datetime filed of git-blame
Date: Tue, 22 Apr 2014 22:39:08 +0800
Message-ID: <cover.1398177411.git.worldhello.net@gmail.com>
References: <xmqq38h6a3sk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Brian Gesiak <modocache@gmail.com>, Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 16:39:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcbrE-0007yi-Eq
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 16:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756258AbaDVOjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 10:39:32 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:36734 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756085AbaDVOjb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 10:39:31 -0400
Received: by mail-pd0-f172.google.com with SMTP id w10so598503pde.31
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 07:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ZndqLObonBDhSQduk4xklX3rpg5kdBRC9bDB8/lGDaY=;
        b=paB65J4AJsunrr3/MwG78pMI2qlAxgceW6ZgVOFZw3JEneTZ4HhNLO+mhnvsuir9s/
         +X9cIKY0ODci8fPc4g6nwrSDMd7LcVhoKn8PZq4VwsTzY8INyv12j63oG9ntiLivdk3k
         RC0yZNhznctoq0P/u+e1YI7Nf4nm8tYKs1tB+n/b8jABOCQMPZXo+4yrjtuzMmaSGNEW
         iXoSM4YSaCxvukp09sDRg+PVGmXjdK9rageCxP36r72Qy6t0c2XFebnzxzlHulamlYbw
         jvI8wXLayHnGxu4TLwslHqdsliTO7ykHrjEcPRWIQb8gC7pKmvOHTG0zkwY1qd/HYiTw
         OO/A==
X-Received: by 10.68.186.33 with SMTP id fh1mr9860802pbc.140.1398177570688;
        Tue, 22 Apr 2014 07:39:30 -0700 (PDT)
Received: from localhost.localdomain ([124.207.10.6])
        by mx.google.com with ESMTPSA id ry10sm149802179pab.38.2014.04.22.07.39.24
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Apr 2014 07:39:29 -0700 (PDT)
X-Mailer: git-send-email 1.9.2.476.gff10cf3.dirty
In-Reply-To: <xmqq38h6a3sk.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246739>

Changes since V3:

 * rollback patch 2/2 to v2, but with a nicer comment for translators.

Jiang Xin (2):
  bugfix: fix broken time_buf paddings for git-blame
  blame: dynamic blame_date_width for different locales

 builtin/blame.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

-- 
1.9.2.476.gff10cf3.dirty
