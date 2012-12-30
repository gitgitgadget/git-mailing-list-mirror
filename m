From: Jason Holden <jason.k.holden.swdev@gmail.com>
Subject: [PATCH 0/2] Add MAINTAINERS file and clarify gui workflows
Date: Sun, 30 Dec 2012 13:18:53 -0500
Message-ID: <1356891535-5647-1-git-send-email-jason.k.holden.swdev@gmail.com>
Cc: gitster@pobox.com, paulus@samba.org,
	patthoyts@users.sourceforge.net,
	Jason Holden <jason.k.holden.swdev@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 30 19:50:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpNxf-0003tj-Nk
	for gcvg-git-2@plane.gmane.org; Sun, 30 Dec 2012 19:50:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754813Ab2L3StN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2012 13:49:13 -0500
Received: from mail-vb0-f46.google.com ([209.85.212.46]:63191 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754715Ab2L3StM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2012 13:49:12 -0500
Received: by mail-vb0-f46.google.com with SMTP id b13so12290492vby.33
        for <git@vger.kernel.org>; Sun, 30 Dec 2012 10:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=hnVgWoR3qMFTl7QWScw39ak9XryelQHQ4lzOX77/4og=;
        b=c1hKCVklwR4sMLbHRF90aYjxnnkipaSy1+5iGTSNKuCYbJ7kAx3AOVMLBl+NNEyPJc
         WhZnWRMCKpGw41TMC5BTcgo9xUWhRGh3xg14muEVNlI5mHwRB6GXv3fWLIX824GH2Fdg
         k52lrPFbENTuI4/jpUS0OJ06NEPX4SQs2UpvZtAoFOqKYcCeejpd4zXaEDaEqUki0gd9
         ABCBCE2opdhWBlZIYHKtKlvQhUcTVGCbk3AT92NjLo+Kd8TeppPJnPfEWx1JHCtFhlxP
         MgWE1hUniHWUC5srrdB9i5PYarlYRWmek+9Fldanz4KIK2+4eI30MA8J4s6+BZRup83X
         wKZQ==
X-Received: by 10.221.9.202 with SMTP id ox10mr60692758vcb.40.1356891584131;
        Sun, 30 Dec 2012 10:19:44 -0800 (PST)
Received: from rowblue.hsd1.nh.comcast.net (c-75-69-185-21.hsd1.nh.comcast.net. [75.69.185.21])
        by mx.google.com with ESMTPS id a10sm34079005vez.10.2012.12.30.10.19.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 30 Dec 2012 10:19:43 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc3.28.g0ab5d1f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212339>

I spent a good amount of time yesterday figuring out the correct workflow
to submit a change to gitk.  As I understand it, gitk (and I think git-gui)
are maintained upstream of git, and patches should be sent to the git email
list against the upstream repo.  I think a top-level MAINTAINERS file would 
help new contributers like me get orientated, especially in the cases of these
upstream projects that require a somewhat non-standard workflow

I also added some additional clarifications to SubmittingPatches that 
clarifies the additional steps required to submit patches against the guis.

Please double check that I've got the correct email addresses and canonical
repositories

I'm guessing there are additional Maintainers who should be added to the 
MAINTAINERS file, I just haven't followed to email list closely enough to
know all the formal/informal workflows that should be observed.

Jason Holden (2):
  Add top-level maintainers file with email/canonical repository
    information
  Provide better guidance for submitting patches against git-gui, gitk

 Documentation/SubmittingPatches | 11 +++++++++++
 MAINTAINERS                     | 17 +++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 MAINTAINERS

-- 
1.8.1.rc3.28.g0ab5d1f
