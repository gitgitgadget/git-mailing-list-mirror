From: David Bryson <david@statichacks.org>
Subject: [PATCH 0/3] Change timestamps to time_t not unsigned long
Date: Sat, 4 Oct 2008 21:29:04 -0700
Message-ID: <cover.1223180798.git.david@statichacks.org>
Reply-To: David Bryson <david@statichacks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 05 06:30:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmLGH-0001L9-Ab
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 06:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbYJEE3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 00:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbYJEE3I
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 00:29:08 -0400
Received: from cryptobackpack.org ([64.105.32.74]:55744 "EHLO
	mail.cryptobackpack.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbYJEE3I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 00:29:08 -0400
Received: by mail.cryptobackpack.org (Postfix, from userid 1000)
	id C79A310D01F5; Sat,  4 Oct 2008 21:29:06 -0700 (PDT)
X-Spam-Checker-Version: SpamAssassin 3.2.1-gr1 (2007-05-02) on
	ptolemy.cryptobackpack.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	DNS_FROM_DOB,RCVD_IN_DOB autolearn=no version=3.2.1-gr1
Received: from eratosthenes.statichacks.org (heliosphan.cryptobackpack.org [10.6.6.6])
	by mail.cryptobackpack.org (Postfix) with ESMTP id 7532610D00FC
	for <git@vger.kernel.org>; Sat,  4 Oct 2008 21:29:04 -0700 (PDT)
Received: by eratosthenes.statichacks.org (Postfix, from userid 1000)
	id 46D9314464; Sat,  4 Oct 2008 21:29:04 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97497>

This patch does not change very many lines, but it does it in several
different files.  Per the Janitor page on the wiki it changes the 
unsigned long values returned by approxidate() to time_t.

Feedback and comments welcome.

David Bryson (3):
  Changed timestamps to time_t instead of unsigned
  Changed timestamps to time_t instead of unsigned
  Changed timestamps to time_t in header files

 builtin-prune.c       |    2 +-
 builtin-reflog.c      |    8 ++++----
 builtin-show-branch.c |    4 ++--
 cache.h               |    2 +-
 date.c                |    2 +-
 parse-options.c       |    2 +-
 reflog-walk.c         |    2 +-
 refs.c                |    4 ++--
 refs.h                |    2 +-
 revision.h            |    4 ++--
 sha1_name.c           |    4 ++--
 11 files changed, 18 insertions(+), 18 deletions(-)
