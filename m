From: Johan Herland <johan@herland.net>
Subject: [PATCH 0/2] Fix remaining issue when deleting symrefs
Date: Sun, 21 Oct 2012 12:40:30 +0200
Message-ID: <1350816032-16312-1-git-send-email-johan@herland.net>
References: <7vpq4flb1c.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, rene.scharfe@lsrfire.ath.cx, vmiklos@suse.cz,
	Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Oct 21 12:40:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPsxh-00074P-W2
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 12:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752453Ab2JUKkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 06:40:42 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:36531 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752381Ab2JUKkl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 06:40:41 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so1071471lag.19
        for <git@vger.kernel.org>; Sun, 21 Oct 2012 03:40:40 -0700 (PDT)
Received: by 10.112.100.40 with SMTP id ev8mr2481366lbb.43.1350816040074;
        Sun, 21 Oct 2012 03:40:40 -0700 (PDT)
Received: from gamma.herland (cm-84.208.177.71.getinternet.no. [84.208.177.71])
        by mx.google.com with ESMTPS id gk11sm2010244lab.3.2012.10.21.03.40.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 21 Oct 2012 03:40:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.1.609.g5cd6968
In-Reply-To: <7vpq4flb1c.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208117>

The following two patches are based on rs/branch-del-symref, and fixes
the remaining failure to delete a packed ref through a symref.

The first patch demonstrates the bug with a testcase, and the second
patch fixes the bug.

Feel free to squash the two patches into one, if you prefer to keep
both the testcase and subsequent fix in a single commit.


Have fun! :)

...Johan

Johan Herland (2):
  t1400-update-ref: Add test verifying bug with symrefs in delete_ref()
  Fix failure to delete a packed ref through a symref

 refs.c                |  2 +-
 t/t1400-update-ref.sh | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

--
1.7.12.1.609.g5cd6968
