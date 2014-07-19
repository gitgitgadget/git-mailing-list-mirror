From: Yi EungJun <semtlenori@gmail.com>
Subject: [PATCH v4 0/1] http: Add Accept-Language header if possible
Date: Sun, 20 Jul 2014 02:58:49 +0900
Message-ID: <1405792730-13539-1-git-send-email-eungjun.yi@navercorp.com>
Cc: Yi EungJun <eungjun.yi@navercorp.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	Peter Krefting <peter@softwolves.pp.se>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 19 20:00:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8YwI-0007cx-2o
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 20:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbaGSSAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2014 14:00:49 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:51192 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932192AbaGSSAs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2014 14:00:48 -0400
Received: by mail-pa0-f44.google.com with SMTP id eu11so7343967pac.3
        for <git@vger.kernel.org>; Sat, 19 Jul 2014 11:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=coaeaSmYG/KxHaTq7sGtKuLnRM9nd8KfGSrKF5E5s6I=;
        b=T/LfX6I3S26uoXeVcwmwjlnesFGy1eeP0vfuZdm+bT7GL98lHfmJWVhpW4C14wfuQ6
         0chjz3ptM+8DzrHFJu6urpPiipYz0cx0m1zuTGAtUBBG+gvBZaPCBtBkn/u7Wa5VJ8XT
         hLL6XZwFgqTpfOVD+j8IUa7b4HWpC/luiT5H9y76xRdi3odmC6fNGsuhjmO5+ECpS7yc
         ArPs2iLli+KmWHhAXbp7Z5NVYqwnXRQ5xEBgoqjo2GzunxJIexnbYqe6gF4U+ooYHShG
         FwVekAmVwHXhwwtUXu0M9cGPSkJgCTUpEU06X5Revij+Gqzg6QXVGNNpAgeFgB9QTSEZ
         3C1g==
X-Received: by 10.70.98.167 with SMTP id ej7mr13907987pdb.70.1405792847281;
        Sat, 19 Jul 2014 11:00:47 -0700 (PDT)
Received: from gmail.com ([222.234.94.10])
        by mx.google.com with ESMTPSA id oa17sm12257241pdb.46.2014.07.19.11.00.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 19 Jul 2014 11:00:46 -0700 (PDT)
X-Google-Original-From: Yi EungJun <eungjun.yi@navercorp.com>
X-Mailer: git-send-email 2.0.1.473.g731ddce.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253901>

Changes since v3:

* Fix styles and syntax. (Thanks to Jeff King and Eric Sunshine)
* Cache Accept-Language header. (Thanks to Jeff King)
* Remove floating point numbers. (Thanks to Junio C Hamano)
* Make the for-loop to get the value of the header simpler.
* Add more comments.

Yi EungJun (1):
  http: Add Accept-Language header if possible

 http.c                     | 134 +++++++++++++++++++++++++++++++++++++++++++++
 remote-curl.c              |   2 +
 t/t5550-http-fetch-dumb.sh |  31 +++++++++++
 3 files changed, 167 insertions(+)

-- 
2.0.1.473.g731ddce.dirty
