From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH 0/2] .mailmap organization
Date: Fri,  9 Aug 2013 20:18:23 +0200
Message-ID: <1376072305-15255-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 09 20:18:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7rGe-0006wf-QB
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 20:18:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758621Ab3HISSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 14:18:24 -0400
Received: from mail-ee0-f54.google.com ([74.125.83.54]:60184 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758614Ab3HISSX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 14:18:23 -0400
Received: by mail-ee0-f54.google.com with SMTP id e53so2273715eek.41
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 11:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=NYi3Gk4ljjFWRUG5lZtuljxHrL/VxvgNWI+VIQNWrvY=;
        b=l9ZBTl08KB+STt66S+eMCinjmDgEpdaWXaSn21I5PRWOz75J9y5yqsqnqUIcrZ+QEA
         WOBBZhjjyq7H0Dge1STTwHTQ8FLofXd2VLMHLin7s7Dv1dvOZ6t19wniMk0n+8CG/gTL
         bWf5WJlvWtWlqxTbSjEb0lTTx6QwFJFRTAvIijPuTVFZsOiuu9nXS19AKFKS3/hRpMF9
         G93mf+ojO7+dvaHIOWOTiJvnU1q7MT+mMtFdn/cpx+fXwXexl12xPofMhOhxCapQwglg
         RzVYbsXq8r4XSwJAh+WioU80WQ0xnJiVo3sJhlEBKjpcb9DLSgviLfv4ebKRHMd6fxOf
         eiYA==
X-Received: by 10.15.49.72 with SMTP id i48mr14264160eew.37.1376072302422;
        Fri, 09 Aug 2013 11:18:22 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id bq1sm30820798eeb.9.2013.08.09.11.18.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 09 Aug 2013 11:18:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232005>

Hello,

Patch 1 is fixing up the mistakes of the previous series.

Patch 2 should really be discussed as I am unsure about the approach.

During the time trying to get the .mailmap file in shape I wrote lots
of emails. There have been many bounces, because some addresses are no
longer valid. Sometimes even all email addresses of one name bounced. 
These people cannot be contacted easily, but we can also not be sure,
whether these are one person or indeed 2 persons with the same name having
different mail addresses.
So that patch is a proposal to just mark those authors in the .mailmap
as unreachable via a comment.

Stefan Beller (2):
  .mailmap: fixup entries
  .mailmap: mark bouncing email addresses

 .mailmap | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

-- 
1.8.4.rc2
