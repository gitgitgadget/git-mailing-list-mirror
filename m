From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git pull manpage: don't include -n from fetch-options.txt
Date: Fri, 25 Jan 2008 00:24:19 +0100
Message-ID: <20080124232418.GC4475@genesis.frugalware.org>
References: <72481CA3A5A6474EA49CFD2CF28A5D5D02CA348A@hektor.iplbath.com> <alpine.LSU.1.00.0801241058330.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 00:25:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIBRW-0007hG-6B
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 00:25:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754697AbYAXXYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 18:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754021AbYAXXYi
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 18:24:38 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:55106 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751984AbYAXXYh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 18:24:37 -0500
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1JIBQo-000304-7Y
	from <vmiklos@frugalware.org>; Fri, 25 Jan 2008 00:24:35 +0100
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 0F6B3176C045; Fri, 25 Jan 2008 00:24:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0801241058330.5731@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0002]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71669>

The -n option stands for --no-summary in git pull

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 Documentation/fetch-options.txt |    2 ++
 Documentation/git-pull.txt      |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 61e48cc..0a1ce68 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -23,11 +23,13 @@
 	fetches is a descendant of `<lbranch>`.  This option
 	overrides that check.
 
+ifndef::git-pull[]
 -n, \--no-tags::
 	By default, `git-fetch` fetches tags that point at
 	objects that are downloaded from the remote repository
 	and stores them locally.  This option disables this
 	automatic tag following.
+endif::git-pull[]
 
 -t, \--tags::
 	Most of the tags are fetched automatically as branch
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 77fdaf1..f9f1e0d 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -25,6 +25,7 @@ OPTIONS
 -------
 include::merge-options.txt[]
 
+:git-pull: 1
 include::fetch-options.txt[]
 
 include::pull-fetch-param.txt[]
-- 
1.5.4.rc4-dirty
