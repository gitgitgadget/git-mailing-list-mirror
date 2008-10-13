From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] rebase: Document --no-verify option to bypass pre-rebase hook
Date: Tue, 14 Oct 2008 08:17:16 +0900
Message-ID: <20081014081716.6117@nanako3.lavabit.com>
References: <20081012212543.GG4856@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 14 01:19:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpWgw-0002Oe-11
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 01:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757416AbYJMXR4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 19:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757038AbYJMXR4
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 19:17:56 -0400
Received: from karen.lavabit.com ([72.249.41.33]:52950 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753986AbYJMXRy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 19:17:54 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 7596EC7AFF;
	Mon, 13 Oct 2008 18:17:53 -0500 (CDT)
Received: from 7688.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id FXV8Y2F5QVYG; Mon, 13 Oct 2008 18:17:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=Gt5YqS4GedDioVKGu3xf/IGDOXGyZDXxPfMSiEGQvuBUbDt6cfPJdSnGLlbbmjgh0K5QD1rUmPgxkGmfUMudgDoRch4pbyg5oTBj2wJP2I5SJuHKI0DWduGtI7oLKhjagQOZZ4ePRA8Aj0opNaSO1apfHfhVKxOnsnzii/VUxCI=;
  h=From:To:Cc:Date:Subject:In-reply-to:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-reply-to: <20081012212543.GG4856@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98162>

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---

"Shawn O. Pearce" <spearce@spearce.org> writes:

> * ns/rebase-noverify (Mon Oct 6 14:14:29 2008 +0900) 1 commit
>  + rebase --no-verify
>
> This adds --no-verify to git rebase, to avoid the pre-rebase hook.
> Lacks documentation but otherwise looks sound.

Here it is.

 Documentation/git-rebase.txt |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 32f0f12..4e84380 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git rebase' [-i | --interactive] [-v | --verbose] [-m | --merge]
-	[-s <strategy> | --strategy=<strategy>]
+	[-s <strategy> | --strategy=<strategy>] [--no-verify]
 	[-C<n>] [ --whitespace=<option>] [-p | --preserve-merges]
 	[--onto <newbase>] <upstream> [<branch>]
 'git rebase' --continue | --skip | --abort
@@ -232,6 +232,9 @@ OPTIONS
 --verbose::
 	Display a diffstat of what changed upstream since the last rebase.
 
+--no-verify::
+	This option bypasses the pre-rebase hook.  See also linkgit:githooks[5].
+
 -C<n>::
 	Ensure at least <n> lines of surrounding context match before
 	and after each change.  When fewer lines of surrounding
-- 
1.6.0.2

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
