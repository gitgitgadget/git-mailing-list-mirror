From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH (resend) 0/3] Minor f-e-r enhacements
Date: Thu, 31 Oct 2013 15:16:11 +0530
Message-ID: <1383212774-5232-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 31 10:54:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VboxS-0007oq-IH
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 10:54:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680Ab3JaJy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 05:54:26 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:56161 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807Ab3JaJyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 05:54:25 -0400
Received: by mail-pa0-f41.google.com with SMTP id rd3so2273873pab.14
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 02:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id;
        bh=SrZ7HKEm0C6afjfz9SX6DI3anp0lXff3ac4dDdMwkcI=;
        b=bKPosTLZGj71WwA7AhoR2dOnWcjBEQ7gTUIpmrIjb/86F5vNIxL2aQIl5uBdr9B8Wf
         oybtw38xwSlHCIZTPNrRefJqvqNLYWnht+qiwgHN3NvzrJnfJA+qtRHmeiCYHnYTQCnk
         SMMxCIloRhcQz3ZIAniRTmQF7q7rMubuY9Ss2+zJeJ1MaTroJ8RJ5c2NZLY8p4f2RRF1
         OkQOsinw9xzH/kAwD8ZW44lRZX5vdlES2miSBlX+wLUGAzOtzu4COp3NskYxyFGNYgrL
         3MO2z5ursQ+wJk5KbZ8emEeQk1QQXRCdvpdy5GFlBQtAQHCLtDtLbWUYJjaUOgx57zfH
         MWrA==
X-Received: by 10.66.123.5 with SMTP id lw5mr952816pab.83.1383213264793;
        Thu, 31 Oct 2013 02:54:24 -0700 (PDT)
Received: from localhost.localdomain ([122.164.233.197])
        by mx.google.com with ESMTPSA id i10sm4106533pat.11.2013.10.31.02.54.22
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2013 02:54:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.5.rc0.3.gb488857
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237114>

Hi,

I've been running git with these patches applied locally for a long
time. Although I've sent them to the list before, they've been
overlooked.

Thanks.

Ramkumar Ramachandra (3):
  for-each-ref: introduce %C(...) for color
  for-each-ref: introduce %(HEAD) asterisk marker
  for-each-ref: introduce %(upstream:track[short])

 Documentation/git-for-each-ref.txt | 14 ++++++-
 builtin/for-each-ref.c             | 75 ++++++++++++++++++++++++++++++++++----
 2 files changed, 79 insertions(+), 10 deletions(-)

-- 
1.8.5.rc0.3.gb488857
