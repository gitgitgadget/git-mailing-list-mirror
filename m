From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 0/6] web--browse cleanups and extensions
Date: Mon, 29 Nov 2010 15:47:49 +0100
Message-ID: <1291042075-19983-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 29 15:48:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PN51b-00081n-0m
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 15:48:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221Ab0K2OsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 09:48:09 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59473 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990Ab0K2OsI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 09:48:08 -0500
Received: by wyb28 with SMTP id 28so4498258wyb.19
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 06:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=nUk5UojAwwf480ROSAwdPeZUVbCMCmdsxCKMm6CL3S8=;
        b=ZHXzbKuE6psmKWtbgx1TF2w2fU3iyPvIYjOWMZfqpsdobJdlWgEnQdeVAiqZxLkuAJ
         Rs01sR4f6nY4+n+/pfGHF5YozidfwamhRnjGBTh8AN9FAW5A6vN24a7ORQboxiib54Tf
         2hKbuOnAukXPU2jZxS3PeZ0mMKRZRNVn6IyI8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=X7cg8e0HMYfWC2YL4Zpu37vpdJL1LecJAuu9+mbVhKAuGthrsvPMEWsEAK2cP4I3co
         Hb1jFWoPwB55cImKUKXTlhC+aBz7iiL1eRTJu5FuzjeJdQCKdZsfKtSi+QNUO8sZx3R1
         i6SCkaa6+CcCISzFWj+Z5xQlfrEnbfUZDIrTE=
Received: by 10.216.173.7 with SMTP id u7mr457215wel.50.1291042086433;
        Mon, 29 Nov 2010 06:48:06 -0800 (PST)
Received: from localhost (nat.ct.ingv.it [193.206.223.100])
        by mx.google.com with ESMTPS id y80sm2425702weq.27.2010.11.29.06.48.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Nov 2010 06:48:04 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.624.gec6c7.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162388>

This patches introduces support for Opera, Seamonkey/Iceape and elinks
to git web-browse, after a little reformatting to adhere to the shell
script coding guidelines (guidelines which were not explicit in the
documentation, and which are made so).

The last two patches are somewhat more system-specific (AFAIK, only
Debain & friends have /usr/bin/{x-,}www-browser, and not many other
distributions have chromium under the chromium-browser executable name),
but I believe it still makes sense to include them in the mainstream
version of git.

Giuseppe Bilotta (6):
  CodingGuidelines: mention whitespace preferences for shell scripts
  web--browse: coding style
  web--browse: split valid_tool list
  web--browse: support opera, seamonkey and elinks
  web--browse: use (x-)www-browser if available
  web--browse: special-case chromium path

 Documentation/CodingGuidelines    |    6 +
 Documentation/git-web--browse.txt |   10 ++
 git-web--browse.sh                |  202 +++++++++++++++++++++----------------
 3 files changed, 133 insertions(+), 85 deletions(-)

-- 
1.7.3.2.624.gec6c7.dirty
