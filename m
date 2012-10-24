From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: git commit-tree man page
Date: Wed, 24 Oct 2012 14:45:46 +0200
Message-ID: <CAB9Jk9BMndLj_nHW=EQbSS96Gp5+5NA3Vyb0r-EfVd+OPyQhnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 24 14:46:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TR0LP-0001AC-PK
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 14:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933533Ab2JXMpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 08:45:47 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58260 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933361Ab2JXMpq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2012 08:45:46 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so1187394pbb.19
        for <git@vger.kernel.org>; Wed, 24 Oct 2012 05:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=n4VZe7il7462fEEYyHZbjU+TZT21B5ee9/snFiiHB1U=;
        b=VRucIfOtN+f81vH2/+LBNqz0jEmLa+TcOWDqh5kyjS6hjryAQqPLtLjSOUYni+hHez
         3mOxhnBWkLTyX3+6dDCal6Tsrnugzo7bctWgwMaz80TUPJkBQ7UVJ39JNIdRGKqsiBCZ
         b2r2me9JNtIgQeQhKEllzgyt3U0BtVc31N6A9XCojtgwhSWA4r2+gmrMc40M8+Dtq4Un
         yb5VvbEqnq9teYyPeO1iqr4HxTzrZGOSaXnoNQ9qpYPaTWPxY/ercDEB5SnIVRl4SLaB
         luBHGYZ+ZunwoGO3FNqm1nArMFnpebsdMN7E0gAHtING6hN/9EZYSqFVyHumBfaDGffV
         t7hw==
Received: by 10.66.76.98 with SMTP id j2mr43652991paw.65.1351082746313; Wed,
 24 Oct 2012 05:45:46 -0700 (PDT)
Received: by 10.67.3.101 with HTTP; Wed, 24 Oct 2012 05:45:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208305>

Hello,

the man page of git commit-tree SYNOPSIS is:

    git commit-tree <tree> [(-p <parent>)...] < changelog
    git commit-tree [(-p <parent>)...] [(-m <message>)...] [(-F
<file>)...] <tree>

The second form is incorrect: the <tree> must be specified before the options.
E.g.

$ git commit-tree -m B 88f7dbd47
fatal: Not a valid object name -m

$ git commit-tree 88f7dbd47 -m B
2f7619ed932787a128a84c4809d7b72ef38257a5

-Angelo Borsotti
