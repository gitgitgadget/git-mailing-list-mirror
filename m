From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] githooks documentation: add a note about the +x mode
Date: Wed, 17 Dec 2008 22:29:06 +0100
Message-ID: <1229549346-17863-1-git-send-email-vmiklos@frugalware.org>
References: <200812172055.45905.markus.heidelberg@web.de>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 17 22:28:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD3wo-0004ek-OU
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 22:28:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbYLQV1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 16:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbYLQV1a
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 16:27:30 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:49942 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbYLQV1a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 16:27:30 -0500
Received: from vmobile.example.net (dsl5401C5EE.pool.t-online.hu [84.1.197.238])
	by yugo.frugalware.org (Postfix) with ESMTPA id 83ACA446CDE;
	Wed, 17 Dec 2008 22:27:27 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id D1ECA19DBE1; Wed, 17 Dec 2008 22:29:06 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc1.35.gae26e.dirty
In-Reply-To: <200812172055.45905.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103394>

In a freshly initialized repo it is only necessary to rename the .sample
hooks, but when using older repos (initialized with older git init)
enabled the +x mode is still necessary - docuement this.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Wed, Dec 17, 2008 at 08:55:45PM +0100, Markus Heidelberg <markus.heidelberg@web.de> wrote:
> When you want to learn how to use hooks, you will probably rather read
> githooks(5), where the need for the executable bit is not even
> explicitly mentioned. Maybe it should be added there?

I think so.

 Documentation/githooks.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 5faaaa5..cfdae1e 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -20,6 +20,10 @@ directory to trigger action at certain points.  When
 all disabled.  To enable a hook, rename it by removing its `.sample`
 suffix.
 
+NOTE: It is also a requirement for a given hook to be executable.
+However - in a freshly initialized repository - the `.sample` files are
+executable by default.
+
 This document describes the currently defined hooks.
 
 applypatch-msg
-- 
1.6.1.rc1.35.gae26e.dirty
