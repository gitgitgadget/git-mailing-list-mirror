From: Jon Seymour <jon.seymour@gmail.com>
Subject: git svn dcommit <branch> committed to trunk anyway
Date: Sun, 6 May 2012 18:30:53 +0530
Message-ID: <CAH3AnroP+ckzgijibPDEupBCfUFu5Bwsq8YP58h+igXoJyJEyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 06 15:01:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SR158-0001S0-Ua
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 15:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753604Ab2EFNAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 09:00:54 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:46074 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753589Ab2EFNAy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 09:00:54 -0400
Received: by wgbdr13 with SMTP id dr13so4069792wgb.1
        for <git@vger.kernel.org>; Sun, 06 May 2012 06:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=PNm33SRGK8sK7Gf8jAyGV/WbyJE4CLnwVDEPWMWLyog=;
        b=G82mWqyEdS/+yzYkAeyN74M9aHcaPe6dcPuSv4Z5k+FQ5h4BSug0zN/9tJl08jkxLw
         XKYs5rbGvvS8QqPhVZGpLyoIy/mMaCYfv6A8fbZGVdA31ClulGf1ylhIbrwr4IkA6zJf
         IRbxxZv04Sa9Pdy5DgSrKUq/NbSXLBxZauQ2l4R6NIhrIq9B7HaKHtNX/nDBV6mBi4BW
         LGOyGA+ULqYgEvtw1kLinT4cs9vM4acFUA88sNMmlTaLvTSE4UymUMtd+szxE3t4zAZi
         eCeppOlXara9y5xCVYwXiRTTI8sTuPIkK73pmnWTgvs9AVfO4bV1ZfxEvJkT+9OZgQYE
         wpOQ==
Received: by 10.180.92.130 with SMTP id cm2mr27466039wib.4.1336309253305; Sun,
 06 May 2012 06:00:53 -0700 (PDT)
Received: by 10.180.82.35 with HTTP; Sun, 6 May 2012 06:00:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197181>

I expected git svn dcommit <branch> to push commits into the svn
branch called <branch> (a repo relative URL of
/branches/foobar1/foobar2/<branch>)

However, it decided to push into trunk instead, which was not the
intended effect.

What have I misunderstood about how git svn dcommit is supposed to work?

jon.
