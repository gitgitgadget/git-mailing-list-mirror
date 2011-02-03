From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH] git-p4 : Small improvement patches
Date: Thu,  3 Feb 2011 01:01:52 +0000
Message-ID: <1296694913-7844-1-git-send-email-vitor.hda@gmail.com>
Cc: Thomas Berg <merlin66b@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 03 02:02:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pknai-00062w-5R
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 02:02:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755345Ab1BCBC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Feb 2011 20:02:26 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48957 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754474Ab1BCBCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Feb 2011 20:02:25 -0500
Received: by wwa36 with SMTP id 36so667822wwa.1
        for <git@vger.kernel.org>; Wed, 02 Feb 2011 17:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=vOqtDZSQTa9D+A7BZYNcpcboecVwIRwILCZwz6MOSHw=;
        b=epkfLdBFdy9mYiNtEMJfTktnWVcu2SQMdZbkt/HGhG/ftUH0svYsDwMFi6ipsx6Y1Y
         OG4YASq8W7L6dd4GTA4dgDh+si5ZH1cuuE+eyUEdompW4rkx2waE4QC9Wxwlva9JFArB
         4IG8gNMGk2AoRIZtKe/++gLRZcVATsKIl3dKE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=htcD0T8bi040wzUrXvl8FIwOMeSxm25YkWnvKqAuBkEyEw+2+Uui7kY6FowRTw4suf
         fp8F20508nXNQWUdJVRO86rkqao80f3Qf7+2vyurc1eRtt/UJAhnc5jBaalEoflMjiM0
         l5If/nm3edlCsqjMCxdrUF/qICAvdyi7jXsPU=
Received: by 10.227.183.203 with SMTP id ch11mr9925285wbb.214.1296694944130;
        Wed, 02 Feb 2011 17:02:24 -0800 (PST)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id f35sm171094wbf.20.2011.02.02.17.02.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Feb 2011 17:02:22 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165944>

This patch finishes all the changes that I've done to git-p4 script and that
I've been using in my daily work. Although most of the changes are trivial, it
would be nice if someone could test these updates and provide feedback.

The script, as it is, still has one limitation: when it detects a new branch it
will base it on the last commit of the origin branch. This may not be true,
because the branch may have been created from an old change list. My idea would
be to find a commit to which the new branch would have a null diff... but I
don't know what would be the best way to do something like this through git
commands. Suggestions are welcome on this point :)

Thank in advance,
Vitor

Vitor Antunes (1):
  git-p4: Improve branch support.

 contrib/fast-import/git-p4 |   27 +++++++++++++++++++++++----
 1 files changed, 23 insertions(+), 4 deletions(-)

-- 
1.7.2.3
