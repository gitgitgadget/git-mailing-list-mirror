From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH/RFC v2 0/4] *** SUBJECT HERE ***
Date: Sat, 25 Sep 2010 19:04:10 +1000
Message-ID: <1285405454-12521-2-git-send-email-jon.seymour@gmail.com>
References: <1285405454-12521-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: robbat2@gentoo.org, casey@nrlssc.navy.mil, git@vger.kernel.org,
	brian@gernhardtsoftware.com
X-From: git-owner@vger.kernel.org Sat Sep 25 11:01:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzQdZ-0001gS-56
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 11:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753430Ab0IYJBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 05:01:36 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49042 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120Ab0IYJBe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 05:01:34 -0400
Received: by pvg2 with SMTP id 2so866410pvg.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 02:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=aosV2Gfkx+hvFMR8aLI2PR8NogThYECFSATC7fY1LMI=;
        b=RvveVP68OLtDr8U0U/AeULxAcW2rOs+AQaho/xlRDtMHbGOd+hehP0QkwbRle1HfP1
         1SW93SIfmHjBaru8aXDMzl0+J3SmFWV0l04Gq0rtrOAy7T4htRjSTBVkXQSL27aeqA1w
         yabaTTU5y5IsnqCWJv0MAsTI4wcZufJ3F0UQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=M2wd8NqYFrVl+yB2+uU1rWCLHW8Uy9fKTMWRZI11GGQ3Z1gmZDOYZ33tG6qjsJZe+r
         Fr8M51D64D8oiYsmb45TdG7+Ys1Xg8/GXDzxIM6Ka/R+zZg344QF0ExkbVptTHy/9Wrg
         nJ+wd2TeXfRlh7fnCiyoWb3KBSFVkow+x3vKU=
Received: by 10.142.49.12 with SMTP id w12mr3819559wfw.160.1285405294414;
        Sat, 25 Sep 2010 02:01:34 -0700 (PDT)
Received: from localhost.localdomain ([120.16.93.90])
        by mx.google.com with ESMTPS id y36sm3574521wfd.6.2010.09.25.02.01.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Sep 2010 02:01:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.gc81ce.dirty
In-Reply-To: <1285405454-12521-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157134>

*** BLURB HERE ***

Jon Seymour (4):
  rev-parse: stop interpreting flags as options to rev-parse once
    --flags is specified
  rev-parse: Don't recognise --flags as an option if --no-flags has
    been specified.
  rev-parse: add tests for git rev-parse --flags.
  rev-parse: update documentation of --flags and --no-flags options

 Documentation/git-rev-parse.txt |   10 +++-
 builtin/rev-parse.c             |   11 ++++
 t/t1510-rev-parse-flags.sh      |  116 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 135 insertions(+), 2 deletions(-)
 create mode 100755 t/t1510-rev-parse-flags.sh

-- 
1.7.3.1.gc81ce.dirty
