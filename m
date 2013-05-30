From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/4] Trivial patches
Date: Thu, 30 May 2013 08:56:17 -0500
Message-ID: <1369922181-31016-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 30 15:58:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui3Mp-00075T-BY
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 15:58:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756628Ab3E3N6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 09:58:07 -0400
Received: from mail-ye0-f171.google.com ([209.85.213.171]:41416 "EHLO
	mail-ye0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755832Ab3E3N6E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 09:58:04 -0400
Received: by mail-ye0-f171.google.com with SMTP id l2so52991yen.30
        for <git@vger.kernel.org>; Thu, 30 May 2013 06:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=rYIF1P6EYMV/EeeJGSRWQKpHanxNyOg3VNetW6lvCh0=;
        b=bWfMAZBIrIFQ+1YEiY9t3zi9hCp3Z8mgPRabvuVteNGUJwXzWfwH3p9i5REi65Auel
         NurrLcr2gwqQaVVO+wEprtx0qnjroW9edDP5xQhDUDzFgHaVZCJYpc56GVvOmkunb8Em
         7w1tFiQGr2/3Z4rxheIMdFQpONG4Rr1pU0n7CmNZzcht8Uc4Rv3SsTlGj98tev5xfUgE
         wKFpsOxL2HFQBaYKrRSBqnYyEnZNuUMi8vsQQehSdmwTg+lbrOjMIfvtUw0jlnXhUiIU
         LQaoWlaB1H+tjhnLvIDTRMiI0186bJExPX/Ba9iKDArPBzcmcaxJqzOSWJDuf+bwI/uS
         eprw==
X-Received: by 10.236.121.172 with SMTP id r32mr3733949yhh.2.1369922283523;
        Thu, 30 May 2013 06:58:03 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id d51sm60082060yho.14.2013.05.30.06.58.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 30 May 2013 06:58:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225996>

Hi,

Here's a bunch of  trivial patches, mostly syle, but the first one might be
important.

Felipe Contreras (4):
  read-cache: fix wrong 'the_index' usage
  read-cache: trivial style cleanups
  unpack-trees: trivial cleanup
  sha1_file: trivial style cleanup

 read-cache.c   | 6 +++---
 sha1_file.c    | 2 +-
 unpack-trees.c | 3 +--
 3 files changed, 5 insertions(+), 6 deletions(-)

-- 
1.8.3.rc3.312.g47657de
