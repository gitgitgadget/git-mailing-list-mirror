From: Chris Angelico <rosuav@gmail.com>
Subject: git bisect/checkout and changes to .gitignore
Date: Fri, 22 Jun 2012 17:51:00 +1000
Message-ID: <CAPTjJmq4zv6dBR2Z-HfM7CJoxfprSdJEYYELuyBfahw2PkZ4Lw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 22 09:51:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Shye6-0002xT-VR
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 09:51:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761552Ab2FVHvC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 03:51:02 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:60031 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761550Ab2FVHvB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 03:51:01 -0400
Received: by obbuo13 with SMTP id uo13so1591405obb.19
        for <git@vger.kernel.org>; Fri, 22 Jun 2012 00:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Ic9tvCAQ98bqWrY9S+b2rgB634CkFGTrKePLjQuNtq8=;
        b=tPCnrKxBIgyxzCdHq+QRxDEXnd7q73G2/iLEoyunmcjfF3Bl4LdOfHcFEiGwPiZNez
         1XXhbDJRNKa8kZRLW80Noq0NzhomyM0zOkFXipX/p6BS5j272VZ2e8K7qaB8s6g50V1O
         UNVXEvL8EO7Ay9d/LWdGBZ4UZ1TUrSjMxR10YMbqDRu6XwjUy/bqbaRlM30nTAiYWciE
         XO80MAlvukr26Oj2a1tkxianygqmv0YR6EqkRA6G/XKRSCGaWpfSVPRDy9ODOTHDDjqJ
         zh4GJ97lmVRo5m9xrbbaF9iGuDHoK5Tj4iVuZLjpX+G/kJP2dTj/uRb+Awfk3KPMbK/o
         4UiA==
Received: by 10.182.18.137 with SMTP id w9mr866577obd.75.1340351460603; Fri,
 22 Jun 2012 00:51:00 -0700 (PDT)
Received: by 10.182.232.6 with HTTP; Fri, 22 Jun 2012 00:51:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200422>

Greetings! I'm not certain if this list or the git-users group is more
appropriate; my apologies if I've picked wrong.

At my workplace we use git to manage all of our source code. Every now
and then, we decide that some particular file oughtn't to be
git-managed, and add it into .gitignore and remove it from the
repository (for instance, configuration files that become
per-developer).

Is there a way to checkout an old version of the repository (before
the file was added to .gitignore), then return to the current state,
without destroying these sorts of files? Currently, checking out the
old version quietly "takes control" of the file, and then checking out
a newer one deletes it.

I've read through the man pages for 'git checkout' and 'gitignore' and
searched the one for 'git config' (it's a little large to read all
of), without seeing an option to preserve files on checkout. Is there
a way to do this, and if so, where can I find it?

Thanks in advance!

Chris Angelico
