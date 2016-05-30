From: Benjamin Dopplinger <b.dopplinger@gmail.com>
Subject: [PATCH] README.md: format CLI commands with code syntax
Date: Mon, 30 May 2016 03:08:16 +0000
Message-ID: <01020154ffa221f6-c45ab36e-cc26-46a8-b2fa-2c40e54959f1-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 30 05:08:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7DZH-0004lU-FD
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 05:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753288AbcE3DIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 May 2016 23:08:19 -0400
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:53921
	"EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752025AbcE3DIS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2016 23:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1464577696;
	h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=954F2x8GtCIcKsJqn2DQCSjaUZfXtubolbRqCzmxd/8=;
	b=ArXrRJwnX8R+uyfx27WE14NF0WYLYZvqryvYb3LT59akyhfovkwBoNS15CULQ/CL
	BjQ2FooF9kjH49QXbtdLK+InHnO1DWb5drsYkEnKhHhIvfyK2FrC7jV8u6XoNI1B7P5
	KoPV/whi/n7PntLaFeKq2DURIECmxtLZKNNj9yD4=
X-SES-Outgoing: 2016.05.30-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295851>

CLI commands which are mentioned in the readme are now formatted with
the Markdown code syntax to make the documentation more readable.

Signed-off-by: Benjamin Dopplinger <b.dopplinger@gmail.com>
---
 README.md | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/README.md b/README.md
index 2087748..bd8a918 100644
--- a/README.md
+++ b/README.md
@@ -17,14 +17,14 @@ including full documentation and Git related tools.
 
 See [Documentation/gittutorial.txt][] to get started, then see
 [Documentation/giteveryday.txt][] for a useful minimum set of commands, and
-Documentation/git-*commandname*.txt for documentation of each command.
+Documentation/git-<commandname>.txt for documentation of each command.
 If git has been correctly installed, then the tutorial can also be
-read with "man gittutorial" or "git help tutorial", and the
-documentation of each command with "man git-*commandname*" or "git help
-*commandname*".
+read with `man gittutorial` or `git help tutorial`, and the
+documentation of each command with `man git-<commandname>` or `git help
+<commandname>`.
 
 CVS users may also want to read [Documentation/gitcvs-migration.txt][]
-("man gitcvs-migration" or "git help cvs-migration" if git is
+(`man gitcvs-migration` or `git help cvs-migration` if git is
 installed).
 
 The user discussion and development of Git take place on the Git

--
https://github.com/git/git/pull/247
