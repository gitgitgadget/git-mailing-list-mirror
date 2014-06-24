From: Aidan Feldman <aidan.feldman@gmail.com>
Subject: Feature request: git commit -A
Date: Tue, 24 Jun 2014 15:01:19 -0400
Message-ID: <CAPgiXS7AizvtVNWR4dPXZ6nUQh7ujrrRFmd2SAktsUB0pidFVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 24 21:01:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzVyV-0000fX-9r
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 21:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205AbaFXTBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2014 15:01:41 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:56122 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040AbaFXTBl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2014 15:01:41 -0400
Received: by mail-lb0-f178.google.com with SMTP id 10so1068367lbg.37
        for <git@vger.kernel.org>; Tue, 24 Jun 2014 12:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=XeFmiuYktzsD02bVPKQx7stTv6Mm3NmB2WTZXF3Q3V0=;
        b=dkoucc7+YAc2j6tBkXeuRcuflQWJPJpOAQHRaeJTfJsc8X7kutXouYb8vKWm3s4c89
         8vtDgPjh8FplSp8cSmzkfgOu85tZf8HnX1vbw0BhNuuG+wOic8cypX9FpMudrNaJ6q9x
         WsvlR3DmMHkTqYhY05656dMaokmFwQlLKyu0/vAutApbbVbYCrY9+EV0kxCf+UIdgwOy
         Ad2T1XqOeWE1Y4UVSHypZkLlRuybbgrCjWwhlpvdHDOyGh4JUxjcTqhlUo3Y7FwdgsZ7
         fAE7TSSU64jJC9EEQmszpjoLvebj62SXvjQO5/6esU34jJUCDJHh/jgr3KxgRJKmwyma
         3Dsg==
X-Received: by 10.112.202.167 with SMTP id kj7mr1713796lbc.91.1403636499549;
 Tue, 24 Jun 2014 12:01:39 -0700 (PDT)
Received: by 10.112.130.129 with HTTP; Tue, 24 Jun 2014 12:01:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252418>

Hi all-
I work on the education team at GitHub and do a fair number of Git
workshops.  One thing that I've always found difficult to explain to
newbies is how the staging area works, and why it's useful.  As a
hand-wave to simplify things, I usually have them use

git add -A
git commit -m "..."

to not really have to worry about untracked vs. modified/removed files
aren't included with `git commit -a` or `git add .`.  I would like to
add a `-A` flag to the `commit` command, which effectively does a `git
add -A` before committing.

I was trying to submit a patch myself, but couldn't even manage to
find where the various flags are defined :-)  Does the feature sound
reasonable?  Mind pointing me in the right direction of where this
would be added?

Thanks!
-Aidan Feldman
