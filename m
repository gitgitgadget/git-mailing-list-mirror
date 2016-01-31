From: Aaron Gray <aaronngray.lists@gmail.com>
Subject: [bug] Possible Windows 'git mv' bug
Date: Sun, 31 Jan 2016 14:03:17 +0000
Message-ID: <CANkmNDd8GJmKGw9zToKS1ML3tg9Cx2iYQM0E8iHCO2TuQfwmAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 31 15:04:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPsbz-0001p5-TI
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 15:04:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757481AbcAaODk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 09:03:40 -0500
Received: from mail-lf0-f43.google.com ([209.85.215.43]:34712 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757435AbcAaODj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 09:03:39 -0500
Received: by mail-lf0-f43.google.com with SMTP id j78so11808618lfb.1
        for <git@vger.kernel.org>; Sun, 31 Jan 2016 06:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=iZ5QtEsRRIvfQUNkk+u8wmNWodHcCWJl0S/3uNhR6ls=;
        b=jgkdTh7U9i2CHz0C7khP4A2cnhKznwqYwfcCteS/DTflWBaNaqSR5OmBbAFd6RNpTc
         cXbVWno0m8UsMgTSrjkhhzPS7phl2eda/Lz7VkiYcA7dfbfBrvh5u1V3zJCa+6Fu+8Mx
         rdwHClXoO85cgL9pGxDNgi5DhpGdFSacQukq6h5kvAOIHn0bWyggY5tWfCpDv4fDSs/g
         mLykeOUiPuHKeSkFFc6ZETN0D4eBIBnKG62TW1+QAMH2Rv+dfs469pUpWoprgEgGCXgG
         TYzuTXGTCCXiyn9cTC+ZRTwBFSNLgOxM5NS3BSIpwKD9mrMWSImUfCaxUaTiP0s3R5rH
         +xJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=iZ5QtEsRRIvfQUNkk+u8wmNWodHcCWJl0S/3uNhR6ls=;
        b=kdREtnt4Z2QcolH4e3FpLujxePiw2HtAij4ItjHpNYNU0Af6b5776avPgwl5ELdnLc
         2koAbLPIqzpRBAsj6UyrySVxu1q9Y7TT2xBFtBsBJAVAOsgQSib0jYp8RlBLIhxKiYU5
         EHvEXfC+92gAKcxEeYFgpyuRv7wODNA7bORGDXI07okhFHPb3hxlHcTblB8glRf0zbxy
         8vsyGw7S4MhJh9kICq2JAV6/mKY8W5cPPtH3+giMlDmiqzXsXY/mCmE+PhKN0mxcBynR
         +eoSt115dGgKHpug6ju0n3h9/sXuplXggmvCZbLBhpNmhRqortBlK5fGLnJ03ent4/a5
         /3ng==
X-Gm-Message-State: AG10YORFizP5CD1Lj9TKaKQVNQopoy/blomZhKi5zL9sFf+2Y+a1mzkkU6pGzLUgN+e1LBlZwX2iVkRw/NDW5A==
X-Received: by 10.25.167.74 with SMTP id q71mr5414349lfe.22.1454249016859;
 Sun, 31 Jan 2016 06:03:36 -0800 (PST)
Received: by 10.25.207.195 with HTTP; Sun, 31 Jan 2016 06:03:17 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285148>

Hi,

I think I have found a possible difference in behaviour between
Windows git commandline distro and Linux git

basically If I do a :-

    git mv logger.h Logger.h

I get the following :-

    fatal: destination exists, source=lib/logger.h, destination=lib/Logger.h

It looks and smells like a bug to me !

Regards,

Aaron
