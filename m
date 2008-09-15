From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 1/3] t9700/test.pl: no longer requires File::Basename
Date: Mon, 15 Sep 2008 11:20:54 -0500
Message-ID: <T5Id5zYBlKyKEhZkMsE3QTI2aU3XMiwpfpsPq89cvXrakbyGShLtQw@cipher.nrlssc.navy.mil>
References: <48CE4CFE.1010106@statsbiblioteket.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>,
	"Tom G. Christensen" <tgc@statsbiblioteket.dk>
X-From: git-owner@vger.kernel.org Mon Sep 15 18:22:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfGpw-0004Mr-JD
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 18:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754441AbYIOQU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 12:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754444AbYIOQU5
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 12:20:57 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:33141 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754430AbYIOQU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 12:20:56 -0400
Received: by mail.nrlssc.navy.mil id m8FGKsPM008025; Mon, 15 Sep 2008 11:20:54 -0500
In-Reply-To: <48CE4CFE.1010106@statsbiblioteket.dk>
X-OriginalArrivalTime: 15 Sep 2008 16:20:54.0838 (UTC) FILETIME=[0741D560:01C9174F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95916>

Since ff30fff3 removed the call to basename(), we don't need to
'use File::Basename'.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t9700/test.pl |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index 851cea4..732133e 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -8,7 +8,6 @@ use strict;
 use Test::More qw(no_plan);
 
 use Cwd;
-use File::Basename;
 use File::Temp;
 
 BEGIN { use_ok('Git') }
-- 
1.6.0.1.244.gdc19
