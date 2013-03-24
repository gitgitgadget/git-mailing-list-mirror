From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH v2 0/3] git-merge-one-file error reporting
Date: Sun, 24 Mar 2013 14:26:22 +0200
Message-ID: <1364127985-13366-1-git-send-email-kevin@bracey.fi>
References: <CAJDDKr4swZzzv3e+Huz72CVmisFKU8T74jFj3-uGmZHReRGVBw@mail.gmail.com>
Cc: David Aguilar <davvid@gmail.com>, Kevin Bracey <kevin@bracey.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 24 13:27:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJk0s-00070I-Kl
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 13:27:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472Ab3CXM0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 08:26:35 -0400
Received: from 16.mo4.mail-out.ovh.net ([188.165.55.104]:40345 "EHLO
	mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753410Ab3CXM0e (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 08:26:34 -0400
X-Greylist: delayed 905 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Mar 2013 08:26:33 EDT
Received: from mail643.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id 43C2F104D343
	for <git@vger.kernel.org>; Sun, 24 Mar 2013 13:38:10 +0100 (CET)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 24 Mar 2013 14:25:47 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 24 Mar 2013 14:25:47 +0200
X-Ovh-Mailout: 178.32.228.4 (mo4.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.2.rc3.21.g744ac65
In-Reply-To: <CAJDDKr4swZzzv3e+Huz72CVmisFKU8T74jFj3-uGmZHReRGVBw@mail.gmail.com>
X-Ovh-Tracer-Id: 17350961991222661342
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: 42
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrieeiucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecuudcurhgrnhguohhmuchsthhrihhnghdlshdmucdlgedvmd
X-Spam-Check: DONE|U 0.500129/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 42
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrieeiucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecuudcurhgrnhguohhmuchsthhrihhnghdlshdmucdlgedvmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218949>

Style clean up, as requested, followed by the fix to the "both sides added"
handling for git-merge-one-file.

This is based on v4 of my p4merge series, as they touch the same area.

Kevin Bracey (3):
  git-merge-one-file: style cleanup
  git-merge-one-file: send "ERROR:" messages to stderr
  git-merge-one-file: revise merge error reporting

 git-merge-one-file.sh | 50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

-- 
1.8.2.rc3.21.g744ac65
