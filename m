From: Jon Seymour <jon.seymour@gmail.com>
Subject: git on 64bit windows - state of the art?
Date: Tue, 19 Jun 2012 18:40:56 +1000
Message-ID: <CAH3AnrrzKycCGprrWxiu5S5fuTHA8-cuNTi14Wz5WdtG+6FNJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 19 10:41:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sgtzn-00089A-Hg
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 10:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753576Ab2FSIlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 04:41:00 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:63931 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752553Ab2FSIk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 04:40:58 -0400
Received: by wibhn6 with SMTP id hn6so2985105wib.1
        for <git@vger.kernel.org>; Tue, 19 Jun 2012 01:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=c7phK0ve8aktae9F0y8Wn6zBZNMSlM2OxJn52ycRumg=;
        b=NJQTB5xkcdrCTF3TEzmGH8y4mE9TANCyZCeIAj+SCTrdsmd6hPLiQHCtFOACcxRpr8
         BE+1NYptVIT53kx6G8YMEqtbXoM2j2Iov0Y9q9tVn5oNt08vmRX9zS8jH+moLrb1m4Cf
         03nyZmvlITp/tuhtULCnWTU6J5f+JenbqptxnWx6dTvJ6qV654ZLiX2oc4l4/Px1WJZZ
         rWwcl3kbvKMyxMyYETHzj5Xh/3xonDD/5egSPqqOCm6ifXhG1m6VDQg4wPJJx3yvEeRU
         YqNZVM3dH6lK4V8W7RdBADcxHzoFoFB6FAZYKZ5nUZmMyz2PEohas4VU+P3FJ2GkqM16
         lAIg==
Received: by 10.216.216.148 with SMTP id g20mr9833572wep.187.1340095257379;
 Tue, 19 Jun 2012 01:40:57 -0700 (PDT)
Received: by 10.180.146.166 with HTTP; Tue, 19 Jun 2012 01:40:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200184>

Hi,

I was wondering what the state of the art for running git on 64 bit Windows is?

I haven't tried it myself - my Windows VMs are 32bit - but colleagues
are reporting persistent problems with the cygwin build because of
(cygwin) rebasing issues [ the issue most often reveals itself as a
failure to fork subprocesses while executing git svn ]

We have tried to use cygwin's rebaseall to address the issue per the
advice on stackoverflow.com amongst other places, but this "solution"
doesn't seem to produce permanent results (even if the installed
cygwin code base remains stable). We tried msysgit to see if this
provided any relief, but it had similar issues (perhaps because cygwin
was also active at the time - I haven't had a chance to diagnose this
particular more thoroughly yet).

Has anyone got a recipe that provides a permanent and stable solution
to the (cygwin) 32/64bit rebasing issues?

jon.
