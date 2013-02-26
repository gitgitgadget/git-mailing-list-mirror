From: Ben McCann <ben@benmccann.com>
Subject: git subtree workflow
Date: Tue, 26 Feb 2013 01:04:28 -0800
Message-ID: <CAH3cagOtcR3fgoXK-Xd8vm48q0GPQtYMkWiqQGgydb27HeO0wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 26 10:05:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAGT4-0008Qn-3h
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 10:04:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759753Ab3BZJEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 04:04:31 -0500
Received: from mail-ve0-f173.google.com ([209.85.128.173]:48127 "EHLO
	mail-ve0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759465Ab3BZJE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 04:04:29 -0500
Received: by mail-ve0-f173.google.com with SMTP id oz10so3122892veb.4
        for <git@vger.kernel.org>; Tue, 26 Feb 2013 01:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:date:x-google-sender-auth:message-id
         :subject:from:to:content-type;
        bh=drSXzsN7ILfoO1xIsqumxIdhZMNiTjDpT1r2c1x6JZc=;
        b=K3X4xmyHWPuz9mqXSUjAzxyabaiWkB3nvQol2a7OZxJIIPyK+T/8YT/C7M2fJ4yM0P
         FU03bLBE1sM3wT7cL2eIBMwyA8HBIzA0olptIIPuNw0se5LH8g1o0dZWg8Azm/JWJk3r
         zBUm/Y7/PhFkAiwZ/XGgE30K4LiJ2v33qrFNZYCPL0HcImuIEysEUli9/HA9sgXabRgJ
         YnHaxNd4EEVoEJJUFSjkvcBumCP4OEuRTeSZQzNnMwlk/WiSCVwTPsHP3vXNOg5PQnMN
         WLWj+zztvSNn0+2rQY4AjJkBj8q6w21Xw6yj29yWn0BO19FBi/5asiKygs7oQkW8RZQz
         MHAw==
X-Received: by 10.58.19.232 with SMTP id i8mr11299184vee.53.1361869468314;
 Tue, 26 Feb 2013 01:04:28 -0800 (PST)
Received: by 10.58.116.201 with HTTP; Tue, 26 Feb 2013 01:04:28 -0800 (PST)
X-Google-Sender-Auth: 4x7YzjC_AnO6tSE9-vFxpaeaEMI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217131>

I'm fairly new to git and am trying to determine if git subtree would
be helpful for managing our company's codebase, which has several
repos some of which depend on each other. All the examples I've seen
make sense to me as a one-time operation to merge separate repos into
one monolithic one or to split one monolithic repo into separate
repos. I'm having a harder time understanding how this fits into a
larger picture and what the workflow for working with subtree would
be.

If I have a bunch of repos on GitHub and some depend on each other,
how would I set them up to work with subtree? Would GitHub continue to
host them as is, host a merged monolithic repo, or host both a
monolithic repo and the splitted out repos? The exact answer probably
varies, but I imagine there's basic workflow that would satisfy 80% of
users.  If I have GitHub host both monolithic and splitted out repos,
it seems unclear as to how I keep those repos in sync and make sure
all the developers in our company push their changes to both repos.

Thanks,
Ben
