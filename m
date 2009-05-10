From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH 2/2] ls-tree manpage: output of ls-tree is compatible with
	update-index
Date: Sun, 10 May 2009 18:14:49 +0200
Message-ID: <20090510161449.GB26327@blimp.localdomain>
References: <20090510161345.GA26327@blimp.localdomain>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 10 18:20:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3BlS-0006w3-Mf
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 18:20:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754198AbZEJQP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 12:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754275AbZEJQPZ
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 12:15:25 -0400
Received: from mout0.freenet.de ([195.4.92.90]:57001 "EHLO mout0.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754198AbZEJQPX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 12:15:23 -0400
Received: from [195.4.92.26] (helo=16.mx.freenet.de)
	by mout0.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #88)
	id 1M3BgP-0006an-Q3; Sun, 10 May 2009 18:15:21 +0200
Received: from x697e.x.pppool.de ([89.59.105.126]:38159 helo=tigra.home)
	by 16.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 587) (Exim 4.69 #79)
	id 1M3BgP-00013z-L4; Sun, 10 May 2009 18:15:21 +0200
Received: from blimp.localdomain (blimp.home [192.168.1.28])
	by tigra.home (Postfix) with ESMTP id A7289277D8;
	Sun, 10 May 2009 18:15:15 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id D056F36D2A; Sun, 10 May 2009 18:14:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090510161345.GA26327@blimp.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118724>

Such format relationships are very useful things to remember for
script writers.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 Documentation/git-ls-tree.txt |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index 8292059..c3fdccb 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -84,6 +84,8 @@ Output Format
 
 Unless the `-z` option is used, TAB, LF, and backslash characters
 in pathnames are represented as `\t`, `\n`, and `\\`, respectively.
+This output format is compatible with what '--index-info --stdin' of
+'git update-index' expects.
 
 When the `-l` option is used, format changes to
 
-- 
1.6.3.28.ga852b
