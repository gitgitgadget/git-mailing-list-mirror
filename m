From: Yi EungJun <semtlenori@gmail.com>
Subject: [PATCH v7 0/1] http: Add Accept-Language header if possible
Date: Sun, 18 Jan 2015 21:23:25 +0900
Message-ID: <1421583806-3563-1-git-send-email-eungjun.yi@navercorp.com>
References: <xmqqegri1lbs.fsf@gitster.dls.corp.google.com>
Cc: Yi EungJun <eungjun.yi@navercorp.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	Peter Krefting <peter@softwolves.pp.se>,
	Michael Blume <blume.mike@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 18 13:23:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCotG-0008HN-Ee
	for gcvg-git-2@plane.gmane.org; Sun, 18 Jan 2015 13:23:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011AbbARMXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2015 07:23:34 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:55317 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbbARMXd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2015 07:23:33 -0500
Received: by mail-pa0-f43.google.com with SMTP id lj1so7476700pab.2
        for <git@vger.kernel.org>; Sun, 18 Jan 2015 04:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=noX36RLFDuZuSWL/wE2SXn6383rwnlnei+fKVdK0fgo=;
        b=iUdZ0v9pVUrZL30glVzu9/Z5NyDsw9V52eSJDdoIUs/CQZQyBdRDhcq0iBYy4iYZ2G
         17zlsNSWXKXfCkRuiBm7d+yiloKjhiOCBDCt0vvHe6faMSnnzXNQPes7Lrxt+K9zax9m
         lA+SNZK6SU2FnjbrRKqF9txtYuCyTyBHA6LvX1aF+S023yZ14lFobtHOl3XZ5Iaj1bnR
         x3H2aVPBX4wUOzeE0Y+uPrUG7e7HBvKOs6SFP1Yz1qDtsR4gatKqtDO83eZFF6XyEBE9
         CDut4nSYvZDZ7AWN4f5z/wPvIAZ+wP/yg+Fhg7/KCMpl9PsK8iLvR6TeeeOBPKR7Sjth
         mZUQ==
X-Received: by 10.66.253.168 with SMTP id ab8mr36396003pad.153.1421583812878;
        Sun, 18 Jan 2015 04:23:32 -0800 (PST)
Received: from gmail.com ([121.130.252.34])
        by mx.google.com with ESMTPSA id nk6sm8886695pdb.89.2015.01.18.04.23.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Jan 2015 04:23:32 -0800 (PST)
X-Google-Original-From: Yi EungJun <eungjun.yi@navercorp.com>
X-Mailer: git-send-email 2.2.0.44.g37b3e56.dirty
In-Reply-To: <xmqqegri1lbs.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262598>

From: Yi EungJun <eungjun.yi@navercorp.com>

Changes since v6

>From Junio C Hamano's review:

* Fix check_language() in t5550-http-fetch-dumb.sh as his suggestion.

>From Eric Sunshine's review:

* Rewrite the parser without state.

Yi EungJun (1):
  http: Add Accept-Language header if possible

 http.c                     | 152 +++++++++++++++++++++++++++++++++++++++++++++
 remote-curl.c              |   2 +
 t/t5550-http-fetch-dumb.sh |  42 +++++++++++++
 3 files changed, 196 insertions(+)

-- 
2.2.0.44.g37b3e56.dirty
