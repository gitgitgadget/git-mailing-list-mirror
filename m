From: Sean Krauth <spkrauth@gmail.com>
Subject: fatal: Unable to read current working directory: No error
Date: Tue, 27 Oct 2015 19:29:39 -0400
Message-ID: <CAPkB0GxPghR9Y7YrB9yYq3rA9XZ2HJGN-sxbQgERGsBA2iOX_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 00:29:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrDgY-00028t-7x
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 00:29:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101AbbJ0X3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 19:29:42 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:34347 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbbJ0X3l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 19:29:41 -0400
Received: by lfaz124 with SMTP id z124so180331788lfa.1
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 16:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=TA48RYqrHmYaScmtZisu3nLdR07bcjv3eiZWIQKofdY=;
        b=g4awadpMSM1vVAuIKMtp6meC8VTroebUvD/U+KbUz1jQOyXrmS2gIIZVBFjNyFzkiA
         R8uE/yIGpeK3V0+/KuSxNkoc0Ynrp92vyP3p3VBgCvQATTXbJssdN7gVx2a1pTjl8x5D
         bIREW8N+MkqRPz3jCYfooMyUSjuRpNbPZTkAHOPwrAFV7f0D7++4CvbwE4mSLWp3Qv+h
         Hnc4olAn34jk5Lltcad991sPMMint8gSAlZD0gIeA9ibQnu8ZMnQQNeLdbR1DgWoA8uC
         gi2ajEsRV4NXBxdb3gStBTzL8hezof81fQmErfCu69gin4J9puFjztOpY6aPaV3Sr+E0
         /yGg==
X-Received: by 10.25.165.84 with SMTP id o81mr14328625lfe.80.1445988579743;
 Tue, 27 Oct 2015 16:29:39 -0700 (PDT)
Received: by 10.114.82.68 with HTTP; Tue, 27 Oct 2015 16:29:39 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280316>

Dear magic git bug solver,

I've encountered a problem and I haven't had any success with my own
troubleshooting or googling so I'd appreciate some help. I noticed the
issue originally when I changed a file name in windows explorer. I was
working on a website and I named my Public folder with a capital P and
wrote my file routes as public. So being a little lazy I decided to
open windows explorer and rename Public to public. This was after I
had used Git Bash to create a local repository. I'm almost positive
this action broke Git. The next time I tried to run Git Bash I got an
error that I believe said something similar to "fatal build error" or
"fatal load error" and Git was really broke.

This seemed like about as good of an excuse as any to update Git. I
was running v. 2.5.1-32-bit and so I downloaded v. 2.6.2-32-bit,
installed it. And it ran, kinda. I no longer seem to have access to
any of my old commits and when I try to "git init" or "git status" I
get the above error, "fatal: Unable to read current working directory:
No error". This error pops up for anything, even new files that never
had a repository.

I'm sorry if this wasn't very well documented or explained, but it
kinda caught me off guard. Any thoughts or possible solutions on how
to get Git running again would be greatly appreciated.

Sincerely,
Sean Krauth
