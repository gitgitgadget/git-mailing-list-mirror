From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v4 0/7] i18n miscellaneous updates
Date: Thu, 12 May 2016 19:59:21 +0000
Message-ID: <1463083168-29213-1-git-send-email-vascomalmeida@sapo.pt>
References: <1461071964-323-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 22:00:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0wmZ-0006CX-K4
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 22:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbcELUAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 16:00:23 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:53376 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750711AbcELUAW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 16:00:22 -0400
Received: (qmail 10108 invoked from network); 12 May 2016 20:00:20 -0000
Received: (qmail 28970 invoked from network); 12 May 2016 20:00:20 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 12 May 2016 20:00:18 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1461071964-323-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294440>

This re-roll upadates patch
  i18n: unpack-trees: mark strings for translation

I have decoupled/untangled some strings to mark entire sentences instead of
assemble them using placeholders "%s". This makes the translation work
easier and more reliable.

Vasco Almeida (7):
  i18n: index-pack: use plural string instead of normal one
  i18n: unpack-trees: mark strings for translation
  i18n: git-parse-remote.sh: mark strings for translation
  i18n: builtin/pull.c: mark placeholders for translation
  i18n: builtin/pull.c: split strings marked for translation
  i18n: builtin/rm.c: remove a comma ',' from string
  i18n: builtin/branch.c: mark option for translation

 Makefile             |  2 +-
 builtin/branch.c     |  2 +-
 builtin/index-pack.c |  4 ++-
 builtin/pull.c       | 14 +++++-----
 builtin/rm.c         |  2 +-
 git-parse-remote.sh  | 46 ++++++++++++++++++++------------
 unpack-trees.c       | 74 ++++++++++++++++++++++++++++++++++++++--------------
 7 files changed, 96 insertions(+), 48 deletions(-)

-- 
2.7.3
