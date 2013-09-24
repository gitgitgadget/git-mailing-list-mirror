From: Amit Bakshi <ambakshi@gmail.com>
Subject: git clone -c core.sharedRepository=group not working as expected (git
 v1.8.4 linux/osx)
Date: Tue, 24 Sep 2013 11:27:23 -0700
Message-ID: <CAFGOX=UiqqeZMxY_TCdA5ns0HpWxVUHHYmUBiEg+Zr1R5ZfHVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 24 20:27:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOXKa-0000ns-Tt
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 20:27:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754262Ab3IXS1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 14:27:25 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:49452 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752933Ab3IXS1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 14:27:24 -0400
Received: by mail-pb0-f42.google.com with SMTP id un15so4954197pbc.1
        for <git@vger.kernel.org>; Tue, 24 Sep 2013 11:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=cPHnC6qS8Q0B4QwZHvMyjGWSx9wpybdUE1Yl46iQgDY=;
        b=IEgeAuMFp6j3nI44ZkxadQN7eiwZHNKcYDe+gCZukXKhmtSt8S+7Rl7HCK/86tMu55
         KEKfuxGq0YrxGuyTvpkGXrwkNZzmxvq0fTK3N9xZlsI5C8agXdrzUIfOD07TTEFwWU1s
         MYX4MOHlDej0WoNumilSvzLp296jFNClxLV0m1NArhyLQdlqYkQFa0Pg+tBf7fNN9wLJ
         7gwX1EyiwMdq/gMVZSGfNKZqff1pW/3cxlt2WDghuS7EaaDkEhrR1iCR00XiY2bHs7Wr
         oiSIBxruUoH/fBCouY8mTd4Ep7VWOhHoGB5f5d/M5CWvfIaHtfInPNSPm4A9h4bz9MeL
         85Wg==
X-Received: by 10.68.189.98 with SMTP id gh2mr6583567pbc.181.1380047243809;
 Tue, 24 Sep 2013 11:27:23 -0700 (PDT)
Received: by 10.70.135.4 with HTTP; Tue, 24 Sep 2013 11:27:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235306>

Hi,

 I'm trying to use this to create a shared repo (group r/w), but it's
not working as expected. The help for git clone says "Set a
configuration variable in the newly-created repository; this takes
effect immediately after the repository is initialized, but before the
remote history is fetched or any files checked out.", but I'm
definitely not seeing this. Checked out files have umask applied.

 When I use the -c flag to git (ie, git -c core.sharedRepository=group
clone ...) it does work as expected.

Not a big deal just thought I'd report it.


Amit
