From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: [PATCH 0/5] New for_each_revision() helper
Date: Fri, 27 Apr 2007 14:00:07 -0300
Message-ID: <11776932123749-git-send-email-lcapitulino@mandriva.com.br>
Cc: git@vger.kernel.org
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Apr 27 19:01:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhTod-0000v6-5R
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 19:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756114AbXD0RA7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 13:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756110AbXD0RA6
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 13:00:58 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:47013 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756137AbXD0RAU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 13:00:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 72043181BC;
	Fri, 27 Apr 2007 14:00:18 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id d9bOgNbFDUqz; Fri, 27 Apr 2007 14:00:13 -0300 (BRT)
Received: from doriath.conectiva (doriath.conectiva [10.0.2.48])
	by perninha.conectiva.com.br (Postfix) with ESMTP id C974C181B1;
	Fri, 27 Apr 2007 14:00:12 -0300 (BRT)
Received: by doriath.conectiva (Postfix, from userid 500)
	id 708B668B589; Fri, 27 Apr 2007 14:00:12 -0300 (BRT)
X-Mailer: git-send-email 1.5.1.1.372.g4342
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45729>

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
