From: Luiz Fernando N Capitulino <lcapitulino@mandriva.com.br>
Subject: [PATCH 0/5] RFC: for_each_revision() helper
Date: Thu, 26 Apr 2007 16:46:35 -0300
Message-ID: <11776168001253-git-send-email-lcapitulino@mandriva.com.br>
Cc: git@vger.kernel.org
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Apr 26 21:47:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hh9w7-0000ZF-Dt
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 21:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754882AbXDZTqp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 15:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754964AbXDZTqo
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 15:46:44 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:45815 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754960AbXDZTqn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 15:46:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 29FFE17D4E;
	Thu, 26 Apr 2007 16:46:41 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id Qn3WP7I4OnfL; Thu, 26 Apr 2007 16:46:40 -0300 (BRT)
Received: from doriath.conectiva (doriath.conectiva [10.0.2.48])
	by perninha.conectiva.com.br (Postfix) with ESMTP id E2ECB17D27;
	Thu, 26 Apr 2007 16:46:40 -0300 (BRT)
Received: by doriath.conectiva (Postfix, from userid 500)
	id B869468B586; Thu, 26 Apr 2007 16:46:40 -0300 (BRT)
X-Mailer: git-send-email 1.5.1.1.320.g1cf2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45650>

 Hi,

 [This' also a git-send-email test, so, if this fail by showing just
  the first e-mail in the series, do not blame me :)]

 This series introduces a helper macro to help programs to walk through
revisions (details on the first patch).

 Shawn has already alerted me that some people don't like to
'hide C constructs', but I think that in this case it's useful, as explained
in the next e-mail.

 The complete diff stat is:

 builtin-fmt-merge-msg.c |    3 +--
 builtin-log.c           |   12 ++++--------
 builtin-shortlog.c      |    3 +--
 reachable.c             |    3 +--
 revision.h              |   11 +++++++++++
 5 files changed, 18 insertions(+), 14 deletions(-)

 But if we subtract the for_each_revision() macro's code we get:

 4 files changed, 7 insertions(+), 14 deletions(-)
