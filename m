From: Andrei Purdea <purdea.andrei@gmail.com>
Subject: [bug, git-svn] error: too many matches for svn-remote.svn.added-placeholder
Date: Mon, 17 Jun 2013 08:59:17 +0300
Message-ID: <CACzjUoX0X6vx58C0Gi2-aQNq7wdHXsEJY4KtUHJTM8_e-9HH4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andrei Purdea <andrei@purdea.ro>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 17 07:59:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoSTL-0002dU-Bd
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 07:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754166Ab3FQF7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 01:59:19 -0400
Received: from mail-wg0-f49.google.com ([74.125.82.49]:53221 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937Ab3FQF7T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 01:59:19 -0400
Received: by mail-wg0-f49.google.com with SMTP id a12so2050388wgh.16
        for <git@vger.kernel.org>; Sun, 16 Jun 2013 22:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=tLP3ldmE9Y6HERCze1XK+M36NiAV+bj+G+ZxUkXbZ4g=;
        b=maC9SRAUYRw6f/mlBfgxZAgJGq4zAAsblH6Cta7RoOEa+U1tkwCwwTwX+RUmTbkUuY
         0n0ckBny0itmcLVFpO4YA1u9kYWoUCXGq+rNdsd8+i3Vb4eW+Cpi+HcYXnIjUQfuRvl8
         p5HIPemAAt6r/gkv+jE4B9G9PkMUWUJrnZGvlEYiTpFdXypd4GbkSTuaZ7P6khNmdLvJ
         O+vDJIMTrVc5wmiD/BBn92lHa2QxqkQWcZ2p6bibvnjHRfJK2TOVLNiKlsSt7f8F4F/W
         QsaAlSbIkjfWFzphC0k5CJetc1Wxp6bK0ZZfPTexSOKlzIoQXqRshl9GYryuc15eGsri
         4H+g==
X-Received: by 10.180.74.146 with SMTP id t18mr4049443wiv.3.1371448757810;
 Sun, 16 Jun 2013 22:59:17 -0700 (PDT)
Received: by 10.194.237.40 with HTTP; Sun, 16 Jun 2013 22:59:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228045>

When trying to clone a big svn repository using git-svn, with many
empty folders,
after a while I started getting many
"error: too many matches for svn-remote.svn.added-placeholder" errors.

The following url has a suggestion for a temporary fix:
http://stackoverflow.com/questions/14512292/git-svn-clone-prints-hundreds-of-error-too-many-matches-for-svn-remote-svn-add

Still I think this should be fixed in git.
I don't think a limit of less then 512 empty folders is a realistic limit.
Is it even a good idea to store lists that are this big in .git/config?
Shouldn't this get it's own file?

Andrei
