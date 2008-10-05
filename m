From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: git rebase -- a suggestion
Date: Sun, 05 Oct 2008 22:26:54 +0900
Message-ID: <20081005222654.6117@nanako3.lavabit.com>
References: <b19eae4e0810021710v14a3901an1f793de00c439ba1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: "Robin Burchell" <w00t@inspircd.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Oct 05 15:28:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmTfD-0000u1-B9
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 15:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796AbYJEN1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 09:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752687AbYJEN1g
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 09:27:36 -0400
Received: from karen.lavabit.com ([72.249.41.33]:55055 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752015AbYJEN1f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 09:27:35 -0400
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id E030BC840E;
	Sun,  5 Oct 2008 08:27:34 -0500 (CDT)
Received: from 8144.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id ONBG4L2XY09Z; Sun, 05 Oct 2008 08:27:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=ncLpOr5/nMY6A8RG2pz/blQ80bUQPR+C8uSRPXsFJuO8QCuW7gUcEm4N6e+YrQqBqvZs11N+xMaDZZe7KrLRWXDnZOd4uyv3fSpyhFR5wQG0e/N5oPr3QxYV0Jhw6MtyZGhiUz0mk7sBMJ4Mft71DkHZpJe/DIsX+Oo8Ws+XbI4=;
  h=From:To:Cc:Date:Subject:In-reply-to:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-reply-to: <b19eae4e0810021710v14a3901an1f793de00c439ba1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97508>

Documentation/git-rebase.txt talks about pre-rebase hook, but
it appears that Documentation/git-hooks.txt does not have corresponding
entry for it.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 "Robin Burchell" <w00t@inspircd.org> writes:

 > would it perhaps be an idea to have a way to mark a tree 'public', and
 > disallow rebase *unless* --force was passed, or it was a public tree?

 Documentation/githooks.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 046a2a7..567ec03 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -130,6 +130,13 @@ parameter, and is invoked after a commit is made.
 This hook is meant primarily for notification, and cannot affect
 the outcome of 'git-commit'.
 
+pre-rebase
+----------
+
+This hook is called by 'git-rebase' and can be used to prevent a branch
+from getting rebased.
+
+
 post-checkout
 -----------
 

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
