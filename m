From: Olivier Revollat <revollat@gmail.com>
Subject: GIT Hooks and security
Date: Sat, 26 Oct 2013 00:02:34 +0200
Message-ID: <CA+nXgrUZk=_wtQ2yQnxwCZ3Mazdz=ZH2FJV+V92PVa0a4+A1hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 26 00:02:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZpSq-0002Xo-0B
	for gcvg-git-2@plane.gmane.org; Sat, 26 Oct 2013 00:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935Ab3JYWCf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 18:02:35 -0400
Received: from mail-we0-f169.google.com ([74.125.82.169]:43492 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541Ab3JYWCf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 18:02:35 -0400
Received: by mail-we0-f169.google.com with SMTP id q58so4488916wes.28
        for <git@vger.kernel.org>; Fri, 25 Oct 2013 15:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=lCj7cC4fcUV/+5ny6A+DtiX1hH4HpEXYST8z44ISVDM=;
        b=VFsHL+DwT/Y8bJXULD9+wcrmxKqmW1hQYGfCZ1aKb9Gg3K8v37S8OCxSqaiI4+pXuj
         dtlXecWvs/+Lrta9qhMgFF4HxAQxeWke6kxhxePSBnG/VyB8aCHmJU02cbk2w1G1AR2T
         S5wV1KygI5t8x9e2z4LaAxbtdWsZ0AXK6/T3KZpQJ7XJ/xRe7v/lxpCoS/NDV4NuY9S3
         Xcz9qo/wEZrYoHdcr5eCC0oOL9Z0ruo4FnHBW6/D9nqIFiNlRDdzWA7+5xdFK8qAj14S
         KWTsKbJCHx3fD9jhcSKgRZB2ms9pt2QcuSFxsxEBQolxe+QhjeBCkERQjKUfkHYMO6tR
         dK8Q==
X-Received: by 10.180.189.49 with SMTP id gf17mr275723wic.23.1382738554072;
 Fri, 25 Oct 2013 15:02:34 -0700 (PDT)
Received: by 10.216.33.3 with HTTP; Fri, 25 Oct 2013 15:02:34 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236719>

I was wondering : What if I had a "malicious" GIT repository who can
"inject" code  via git hooks mechanism : someone clone my repo and
some malicious code is executed when a certain GIT hook is triggered
(for example on commit ("prepare-commit-msg' hook)) ? What if I email
/etc/passwd for exemple ?

Does GIT's hooks security is assured by the GIT user privileges ? but
git user can still read /etc/passwd and make something fun with it :)

Is it by the trust relationship ? I mean, If I clone a repo, I
certainly knew the source and I trusted it ... isn't it ?
But if I have a website with file injection vulnerability and I can
replace the git hook script with another (malicious) content ...

I'm maybe "paranoid" :) but I'm just asking the question ... just for
my curiosity's sake :)

Thanks for your comments and explanations :)

-- 

Mathematics is made of 50 percent formulas, 50 percent proofs, and 50
percent imagination.
