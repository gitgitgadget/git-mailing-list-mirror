From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] Remove deprecated OPTION_BOOLEAN
Date: Mon, 29 Jul 2013 17:38:00 +0200
Message-ID: <1375112281-3935-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 29 17:37:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3pWE-00072M-Pc
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 17:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756015Ab3G2Phu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 11:37:50 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:60919 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754076Ab3G2Phu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 11:37:50 -0400
Received: by mail-wi0-f177.google.com with SMTP id hq12so2572257wib.4
        for <git@vger.kernel.org>; Mon, 29 Jul 2013 08:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=3f+4/FAiKSlINVDu2ekxyOvENFz5A1X6AD8s1kwefhE=;
        b=zadM4xLS0GctDkq5SolSj48iTshFFDNJm8U+wI2H/JKsVufjIhDSjwBSwY9kF49dTa
         WFZrpVk5KjlmcWyN+SQFYYLUtMYKHiSsFbPWuJwptzQKBsoNE8S41mKY+kovNfRhfHB4
         M/++/H194dsMHNZduwqzJqu/vxdnsZM0BQT+sqnQ/0Mr3BcYtr00zQxvH7FQd7rAb+J9
         PsRoFjOBXX3c0UWWW/nJ7WPbIOPayW1nmR34bI5RPTicMZYXYS2kDxrcTlbeJDCICuWS
         lQB6IOM7+XHi0JL+5G0mDQ3Mi+/59INyes7Rfbn/ln6nokNoPUUbtieT8MCWcQUtr+rj
         Uv6w==
X-Received: by 10.194.190.201 with SMTP id gs9mr2632364wjc.82.1375112268757;
        Mon, 29 Jul 2013 08:37:48 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id r6sm625955wiw.0.2013.07.29.08.37.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Jul 2013 08:37:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc0.1.g8f6a3e5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231290>

Hi,
the following patch removes the OPTION_BOOLEAN from 
all commands.

So recently Junio released -rc0. Is that a reason to not
send out patches, which do not do bugfixes? So the following 
commit for example doesn't fix a bug nor does it add a feature.
Is it fine to send out such kind of commits during the -rc
times or better wait for the next development cycle?

Stefan

Stefan Beller (1):
  Remove deprecated OPTION_BOOLEAN for parsing command line arguments

 builtin/checkout.c |  5 ++---
 builtin/clone.c    |  7 +++----
 builtin/commit.c   | 10 ++++------
 builtin/log.c      |  4 ++--
 builtin/notes.c    |  8 ++++----
 builtin/show-ref.c |  5 ++---
 parse-options.h    |  5 ++---
 7 files changed, 19 insertions(+), 25 deletions(-)

-- 
1.8.4.rc0.1.g8f6a3e5
