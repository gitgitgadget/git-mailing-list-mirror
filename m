From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git-read-tree: document -v option.
Date: Mon,  9 Jun 2008 22:25:15 +0200
Message-ID: <1213043115-29236-1-git-send-email-vmiklos@frugalware.org>
References: <7vhcc2gyp6.fsf@gitster.siamese.dyndns.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 09 22:27:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5nx8-0003xk-U4
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 22:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754856AbYFIUZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 16:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753731AbYFIUZS
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 16:25:18 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:42032 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912AbYFIUZO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 16:25:14 -0400
Received: from vmobile.example.net (dsl5401C409.pool.t-online.hu [84.1.196.9])
	by yugo.frugalware.org (Postfix) with ESMTP id 2574B1DDC5B
	for <git@vger.kernel.org>; Mon,  9 Jun 2008 22:25:12 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 3BD4218E2A7; Mon,  9 Jun 2008 22:25:15 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc0.dirty
In-Reply-To: <7vhcc2gyp6.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84419>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Mon, Jun 09, 2008 at 01:06:45PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> >> +-v::
> >> +        Be verbose.
> >> +
> >
> > Ping? ;-)
> >
> > I guess this was just lost.
>
> Most likely it was, especially because the signal content of that
> patch is
> next to nil.  "Be verbose" in what sense?

It's about the progress info, when git shows the progress of checking
out a lot of files.

Maybe this one is better?

 Documentation/git-read-tree.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index cbe6835..58fb906 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -50,6 +50,9 @@ OPTIONS
 	trees that are not directly related to the current
 	working tree status into a temporary index file.
 
+-v::
+	Show the progress of checking files out.
+
 --trivial::
 	Restrict three-way merge by `git-read-tree` to happen
 	only if there is no file-level merging required, instead
-- 
1.5.6.rc0.dirty
