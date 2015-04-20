From: Pawel Por <porparek@gmail.com>
Subject: git stash merge
Date: Mon, 20 Apr 2015 18:36:02 +0200
Message-ID: <CAJmOuEwEgA-9NCtBXjij-rLhsCWMyw+DcRVGo4=0b1V2nC==cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 20 18:36:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkEgm-0003or-Qv
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 18:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166AbbDTQgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 12:36:06 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37463 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042AbbDTQgE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 12:36:04 -0400
Received: by widdi4 with SMTP id di4so98684871wid.0
        for <git@vger.kernel.org>; Mon, 20 Apr 2015 09:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=W4zJMZ1X6fG7OIeewWT04pEbdlSm9ZXYJJhnUVhw+Kc=;
        b=iqsR1b1KiasviiKanp04qd5PyEPDUEsYQeNhELnxJ/GAoxxWwol8Cep4LBG1H9I+H3
         iB2dL5ii3HETZ65ZKc0yFewkzYCnABMf5+IRvD6BZwmCAL03yAVWiLC6hVidqaPB0gTy
         vc+H2Prp8tWbiRJ5Wuj9WS+KxIbRXwpJxrcP7pBpN+7CAbAhrFzETxvWCy0vAV2SU1fD
         Lqo2TAwba5obevhWH7p4e3LEjsbGuMRrDoyViib/g6ezfrfx7l89xXcGeF98HeB5wLrz
         AxpO9wi9lLB8Vdepw6cKdCnI43md0dcOVJTuWrqTEH2MU4cr6mbDP6Ztib+TWg/A8nql
         gbZg==
X-Received: by 10.180.231.4 with SMTP id tc4mr12260088wic.27.1429547763014;
 Mon, 20 Apr 2015 09:36:03 -0700 (PDT)
Received: by 10.27.143.23 with HTTP; Mon, 20 Apr 2015 09:36:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267475>

Hi,

I've just upgraded the linux kernel git source tree and I want to
"pop" my stashed work. I do the following:
git stash pop

and I got the following message:
mm/Makefile: needs merge
unable to refresh index

I also tried:
git stash pop --index

How can I overcome this obstacle.
I did "git stash" before "git pull".


Thanks for help.
