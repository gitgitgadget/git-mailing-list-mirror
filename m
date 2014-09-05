From: Sandy Carter <sandy.carter@savoirfairelinux.com>
Subject: [PATCH 0/2] Translations for ambiguous refname warning
Date: Fri,  5 Sep 2014 14:57:23 -0400
Message-ID: <1409943445-12283-1-git-send-email-sandy.carter@savoirfairelinux.com>
Cc: sandy.carter@savoirfairelinux.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 05 21:02:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPymB-0001R5-Ga
	for gcvg-git-2@plane.gmane.org; Fri, 05 Sep 2014 21:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbaIETCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2014 15:02:15 -0400
Received: from mail.savoirfairelinux.com ([209.172.62.77]:55591 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbaIETCN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2014 15:02:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id D2C9DC96011
	for <git@vger.kernel.org>; Fri,  5 Sep 2014 14:54:01 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yibU37oQBwMk; Fri,  5 Sep 2014 14:54:01 -0400 (EDT)
Received: from scarter-X220.mtl.sfl (mtl.savoirfairelinux.net [208.88.110.46])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 6BE3BC9600B;
	Fri,  5 Sep 2014 14:54:01 -0400 (EDT)
X-Mailer: git-send-email 2.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256515>

Here is a pair of commit which allow messages from git to be translated when
running an ambiguous checkout such as when a branch name and a tag name are the
same.


Sandy Carter (2):
  i18n: ambiguous refname message is not translated
  i18n translate builtin warning, error, usage, fatal messages

 sha1_name.c | 6 +++---
 usage.c     | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)
