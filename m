From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH 0/5] Remove unused #include "sigchain.h"
Date: Thu, 22 Oct 2015 14:43:25 +0200
Message-ID: <1445517810-13998-1-git-send-email-tklauser@distanz.ch>
To: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 22 14:43:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpFDW-0006wk-It
	for gcvg-git-2@plane.gmane.org; Thu, 22 Oct 2015 14:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757299AbbJVMne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2015 08:43:34 -0400
Received: from mail.zhinst.com ([212.126.164.98]:42942 "EHLO mail.zhinst.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751957AbbJVMnd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2015 08:43:33 -0400
Received: from ziws06.zhinst.com ([10.42.0.71])
	by mail.zhinst.com (Kerio Connect 8.5.2);
	Thu, 22 Oct 2015 14:43:30 +0200
X-Mailer: git-send-email 2.6.1.148.g7927db1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280045>

This series removes the #include of sigchain.h from several modules
after they were changed to use the tempfile module and they thus no
longer use any declarations from sigchain.h

Tobias Klauser (5):
  gc: remove unused #include "sigchain.h"
  credential-cache--daemon: remove unused #include "sigchain.h"
  diff: remove unused #include "sigchain.h"
  read-cache: remove unused #include "sigchain.h"
  shallow: remove unused #include "sigchain.h"

 builtin/gc.c               | 1 -
 credential-cache--daemon.c | 1 -
 diff.c                     | 1 -
 read-cache.c               | 1 -
 shallow.c                  | 1 -
 5 files changed, 5 deletions(-)

-- 
2.6.1.148.g7927db1
