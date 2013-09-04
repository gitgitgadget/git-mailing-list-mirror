From: Francis Moreau <francis.moro@gmail.com>
Subject: Transfer notes when rebasing
Date: Wed, 4 Sep 2013 09:51:26 +0200
Message-ID: <CAC9WiBiSLMO+JM3aEHZ8xdwKE=jh+mDuo4REQ7rnQ-rTDNb9qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 04 09:51:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VH7sC-00030H-DR
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 09:51:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762194Ab3IDHv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 03:51:28 -0400
Received: from mail-vc0-f169.google.com ([209.85.220.169]:59416 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762057Ab3IDHv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 03:51:27 -0400
Received: by mail-vc0-f169.google.com with SMTP id ib11so4929818vcb.28
        for <git@vger.kernel.org>; Wed, 04 Sep 2013 00:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=+j9Uq2OSnqiqfLj9XeodCbqMSzvutPO7/PjGPnKta0s=;
        b=bPYDsTc/tQaDqulLn4lqhd8kkHYnoj7/+hZH+eyBmDsNAUvuHgXNNG1s2GaCnDLc1+
         vdmMauFFDNSracXsxWNkNdJkWTWQ5GgI4F2VIO1j+5+VBUi4ZqeoogQwOn6S7TnMn2ff
         J9CZSLeDiy5IYMzyFKFj4SqEQpLUrPPqTmtB7lAw4MQehe1ZBKCpiCxhxjkJo1wDBbI0
         CWqbQsJIpPC8DEJh+94ygVM3UL4/bEgbhSm49uL6d62ExzSvyd8Sp3o9aMeSbszvUTYr
         F3pzr3VRDInqqs/RRSoDk4f+EhLPYypKvc7KmWNPpm11GJKjZYOizEzzztQ6n8ZvXFb1
         5tKA==
X-Received: by 10.58.161.116 with SMTP id xr20mr1411192veb.2.1378281086927;
 Wed, 04 Sep 2013 00:51:26 -0700 (PDT)
Received: by 10.58.96.109 with HTTP; Wed, 4 Sep 2013 00:51:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233813>

Hello,

When rebasing a branch which contains commits with notes onto another
branch it happens that some commits are already presents in the target
branch.

In that case git-rebase correctly drops those (already present)
commits but it also drops the notes associated with them.

Can the notes be transfered somehow in the target branch on the
already present commits ?

Thanks
-- 
Francis
