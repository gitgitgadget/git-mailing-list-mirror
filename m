From: Jan Engelhardt <jengelh@inai.de>
Subject: Restore hostname logging in inetd mode
Date: Sat,  8 Sep 2012 19:09:32 +0200
Message-ID: <1347124173-14460-1-git-send-email-jengelh@inai.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 08 19:09:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAOXV-0004Vv-B9
	for gcvg-git-2@plane.gmane.org; Sat, 08 Sep 2012 19:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965Ab2IHRJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Sep 2012 13:09:37 -0400
Received: from seven.inai.de ([5.9.24.206]:40175 "EHLO seven.medozas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751119Ab2IHRJg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2012 13:09:36 -0400
Received: by seven.medozas.de (Postfix, from userid 25121)
	id D08EA96A1800; Sat,  8 Sep 2012 19:09:33 +0200 (CEST)
X-Mailer: git-send-email 1.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205020>


The following changes since commit 0ce986446163b37c7f663ce7a408e7f94c31ba63:

  The fourth batch for 1.8.0 (2012-09-07 11:25:22 -0700)

are available in the git repository at:

  git://git.inai.de/git master

for you to fetch changes up to 864633738f6432574402afc43b6bd83c83fc8916:

  daemon: restore getpeername(0,...) use (2012-09-08 19:00:35 +0200)

----------------------------------------------------------------
Jan Engelhardt (1):
      daemon: restore getpeername(0,...) use

 daemon.c |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 4 deletions(-)
