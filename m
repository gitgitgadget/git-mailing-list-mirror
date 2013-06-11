From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [PATCH 0/2] module_list enhancements
Date: Wed, 12 Jun 2013 01:04:12 +0200
Message-ID: <1370991854-1414-1-git-send-email-iveqy@iveqy.com>
Cc: gitster@pobox.com, git@vger.kernel.org, jens.lehmann@web.de,
	hvoigt@hvoigt.net
To: iveqy@iveqy.com
X-From: git-owner@vger.kernel.org Wed Jun 12 01:01:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmXZO-0001Md-9X
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 01:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756306Ab3FKXBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 19:01:36 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:63479 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140Ab3FKXBf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 19:01:35 -0400
Received: by mail-la0-f47.google.com with SMTP id fe20so7244167lab.6
        for <git@vger.kernel.org>; Tue, 11 Jun 2013 16:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=GCkLHqfFDhBVcSUeUkLP7ooltMPBfQlizDCXzs7ePUk=;
        b=fHSpYNmOMNGaAT20tadcDOqFDxVulxYtkaxU/cy4/DrkzmY1wYnROe3LZwIYJfdKzg
         CvXmCrYQguvtipb+6bX8dL6uAClkTvivt6awpag1RFcTdLiT9PEarj6biNuOl4SkiOJs
         Yz3jm/T4iCgyJVN3NUCuTn8IOwW8lX9M8WcHEpFpxr3TXklltLBZMpNzQJtritoTgrfF
         Q45G8GogdsiS0DHq4y3om+UlIxrk3dnwWZ0Du+/slO0W/VaJrXHX6mVkynD1VGHzKUH3
         ygHsxhNaLjqYROcgaa4LbY3PDDK+KLP9+ypLXqv67UsMmM2k2MmHPntFxt8Wxjm+RTGK
         GChg==
X-Received: by 10.152.28.40 with SMTP id y8mr8629305lag.15.1370991693988;
        Tue, 11 Jun 2013 16:01:33 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id x8sm7043106lae.10.2013.06.11.16.01.32
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 11 Jun 2013 16:01:33 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UmXc3-0000NV-VO; Wed, 12 Jun 2013 01:04:27 +0200
X-Mailer: git-send-email 1.8.3.253.g20b40b5.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227572>

Cleanup and enhanced module_list (see patches for details). All new functionality is
in the first patch, the second one deals only with cleanup. I would prefer if both
got applied.

Fredrik Gustafsson (2):
  [submodule] handle multibyte characters in name
  [submodule] Replace perl-code with sh

 git-submodule.sh           | 55 +++++++++++++++++++++-------------------------
 t/t7400-submodule-basic.sh |  5 +++++
 2 files changed, 30 insertions(+), 30 deletions(-)

-- 
1.8.3.253.g20b40b5.dirty
