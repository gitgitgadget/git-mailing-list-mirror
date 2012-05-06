From: Jon Seymour <jon.seymour@gmail.com>
Subject: git svn fetch uses http proxy, but git svn branch does not
Date: Sun, 6 May 2012 18:03:15 +0530
Message-ID: <CAH3Anrr_V1mMYe3KroDpiM+r_25+Pjrb6SYU7-g_SyGHQOZ1kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 06 14:33:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SR0eQ-0005k8-HF
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 14:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753479Ab2EFMdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 08:33:17 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:54336 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753391Ab2EFMdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 08:33:16 -0400
Received: by wgbdr13 with SMTP id dr13so4057040wgb.1
        for <git@vger.kernel.org>; Sun, 06 May 2012 05:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=LC2/x0Qnm7+qnZzlT33eNHlNSxg4vhZnM44hWHnGdbs=;
        b=U/cHZPxV74Jyhyu5knoQZMi/tzneTmrDLqqfx5in77TTuWc5voR0mC17Ro+Puv8bJi
         1O3HAaLqk/p7sQTyDDY9WK6PyGZwFOW8Q47elTPQ+9caMpABg/mhlSHUtfFGXmMGmljd
         l8GEISQN3NQZp4NpKo4VzHXKxtZ+yBmcLasklVPjFXH+mqSusO6NJClBaA0Kt/jk0t70
         F7n86GieVLQf8lt+tv5S8CbajHcYgzwXg1g8rGSFqWm7Bn9IYu5hWxCqkOegBKOmnZ/P
         nA0+Pw1//DiN/72SWWEGb6bM8eiHPNlB3i3Fa+EUbY9mejuv6BAQhuKtGHgo/9L+MrbV
         69wA==
Received: by 10.180.100.2 with SMTP id eu2mr18776757wib.1.1336307595530; Sun,
 06 May 2012 05:33:15 -0700 (PDT)
Received: by 10.180.82.35 with HTTP; Sun, 6 May 2012 05:33:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197173>

I have noticed that git svn fetch uses the configured http proxy (in
.subversion/servers) but git svn branch does not.

Is this a known issue? Is the issue with git-svn or the underlying
perl SVN package?

Is there a known workaround?

jon.
