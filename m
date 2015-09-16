From: larsxschneider@gmail.com
Subject: [PATCH v2] git-p4: improve path encoding verbose output
Date: Wed, 16 Sep 2015 14:37:03 +0200
Message-ID: <1442407024-33516-1-git-send-email-larsxschneider@gmail.com>
Cc: gitster@pobox.com, luke@diamand.org,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 16 14:37:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcBxb-00081d-I8
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 14:37:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752362AbbIPMhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 08:37:08 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:32895 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734AbbIPMhH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 08:37:07 -0400
Received: by wiclk2 with SMTP id lk2so71001511wic.0
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 05:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=D3SAAy8wUB4uz/41IwSKWZqhfXg1aH9xJoGVsnZ3goI=;
        b=tCAgTZGgPMqMdd9FUmYKjBemtL7WsgD7JSXCV6kzOGQ5YhuDNJuznwaUrDh6d5cWlB
         EUrGxwFT4lETYaDBiihZ9g0yUfatsRN9knOecD6i8YgGgLNbCb2z33FfiyFUJI47IrE/
         Y9v2sx74eq5FpxcaxQnr7nmThReORdOUA1b2R8KoctSDFDjrGei7AVFhT+5e/RgnzWKN
         dhje3RQnCZCFpJCUkV78+dPJ6xwIcCpO07VD/lzkvZi7WdX5M1yBKDEwGC5KoQU9ZX/v
         Zfh5IEgkVGUdjcclCqskrHx63txgWyogOWGro/G6ww7rq/c0TLXx14+HIyK5ifr81N5L
         o/NQ==
X-Received: by 10.180.89.99 with SMTP id bn3mr17836154wib.61.1442407026349;
        Wed, 16 Sep 2015 05:37:06 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id bi6sm26402377wjc.25.2015.09.16.05.37.05
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Sep 2015 05:37:05 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278025>

From: Lars Schneider <larsxschneider@gmail.com>

Follow up patch for a9e38359 (git-p4: add config git-p4.pathEncoding,
2015-09-03) which is already on 'next'.

diff to v1 (wrongly called v7 in "[PATCH v7] git-p4: add config git-p4.pathEncoding")
* make path encoding for utf-8 default case more explicit (thanks Junio!)
* improve commit message (thanks Luke!)

Cheers,
Lars

Lars Schneider (1):
  git-p4: improve path encoding verbose output

 git-p4.py | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

--
2.5.1
