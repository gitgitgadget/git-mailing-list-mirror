From: david@statichacks.org
Subject: [PATCH 0/4] replace unsinged long with time_t
Date: Thu,  6 Nov 2008 09:48:44 -0800
Message-ID: <1225993728-4779-1-git-send-email-david@statichacks.org>
Cc: David Bryson <david@statichacks.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 06 18:50:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ky8zk-0005K1-D5
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 18:50:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbYKFRtA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 12:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbYKFRs6
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 12:48:58 -0500
Received: from cryptobackpack.org ([64.105.32.74]:38697 "EHLO
	mail.cryptobackpack.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbYKFRsx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 12:48:53 -0500
Received: by mail.cryptobackpack.org (Postfix, from userid 1000)
	id 7FEDA10D00BA; Thu,  6 Nov 2008 09:48:52 -0800 (PST)
X-Spam-Checker-Version: SpamAssassin 3.2.1-gr1 (2007-05-02) on
	ptolemy.cryptobackpack.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	DNS_FROM_SECURITYSAGE autolearn=no version=3.2.1-gr1
Received: from eratosthenes.statichacks.org (heliosphan.cryptobackpack.org [10.6.6.6])
	by mail.cryptobackpack.org (Postfix) with ESMTP id CF97310D00BA;
	Thu,  6 Nov 2008 09:48:49 -0800 (PST)
Received: by eratosthenes.statichacks.org (Postfix, from userid 1000)
	id 830BA14462; Thu,  6 Nov 2008 09:48:48 -0800 (PST)
X-Mailer: git-send-email 1.6.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100256>

From: David Bryson <david@statichacks.org>

Here is a patch set from the Janitor page to replace unsigned long with time_t.
Since it overlaps slightly with a patch I made previously, I wrote this to
apply to next.  Comments welcome.

David Bryson (4):
  Changed timestamps to time_t instead of unsigned
  Changed timestamps to time_t in header files
  Changed timestamps to time_t instead of unsigned long for
    approxidate()
  Changed timestamps to time_t

 builtin-gc.c          |    2 +-
 builtin-prune.c       |    2 +-
 builtin-reflog.c      |   14 +++++++-------
 builtin-show-branch.c |    4 ++--
 cache.h               |    2 +-
 parse-options.c       |    2 +-
 refs.h                |    2 +-
 revision.h            |    4 ++--
 8 files changed, 16 insertions(+), 16 deletions(-)
