From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Makefile: add merge_recursive.h to LIB_H
Date: Wed,  3 Sep 2008 01:49:05 +0200
Message-ID: <1220399345-21135-1-git-send-email-vmiklos@frugalware.org>
References: <7vfxoii342.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 01:50:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kafda-0003fg-Ii
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 01:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754152AbYIBXtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 19:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754142AbYIBXtJ
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 19:49:09 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:37832 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754140AbYIBXtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 19:49:09 -0400
Received: from vmobile.example.net (catv-80-98-230-81.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id B07E31DDC5B;
	Wed,  3 Sep 2008 01:49:06 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 2E06C84CA; Wed,  3 Sep 2008 01:49:05 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1
In-Reply-To: <7vfxoii342.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94741>

When modifying merge-recursive.h, for example builtin-merge-recursive.c
have to be recompiled which was not true till now, causing various
runtime errors using an incremental build.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

n Tue, Sep 02, 2008 at 03:39:57PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> > While testing this one, I got some weird errors, finally they gone
> > after
> > a 'touch builtin-merge-recursive.c', I guess this is the right fix.
>
> Thanks.

Ugh, typo. It is called 'merge-recursive.h'.

Sorry.

 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index f697618..1647831 100644
--- a/Makefile
+++ b/Makefile
@@ -362,6 +362,7 @@ LIB_H += list-objects.h
 LIB_H += ll-merge.h
 LIB_H += log-tree.h
 LIB_H += mailmap.h
+LIB_H += merge-recursive.h
 LIB_H += object.h
 LIB_H += pack.h
 LIB_H += pack-refs.h
-- 
1.6.0.1
