From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 1/3] Fix probing for already installed Error.pm
Date: Fri, 30 Jun 2006 01:09:23 -0400
Message-ID: <20060630050923.701.37665.stgit@dv.roinet.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Fri Jun 30 07:09:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwBG0-0002Lx-Il
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 07:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbWF3FJ0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 01:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbWF3FJ0
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 01:09:26 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:4759 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750853AbWF3FJZ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 01:09:25 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FwBFs-0004a0-N8
	for git@vger.kernel.org; Fri, 30 Jun 2006 01:09:24 -0400
Received: from [127.0.0.1] (helo=dv.roinet.com)
	by dv.roinet.com with esmtp (Exim 4.62)
	(envelope-from <proski@gnu.org>)
	id 1FwBFs-0000BQ-3f
	for git@vger.kernel.org; Fri, 30 Jun 2006 01:09:24 -0400
To: git@vger.kernel.org
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22957>

From: Pavel Roskin <proski@gnu.org>

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 perl/Makefile.PL |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/perl/Makefile.PL b/perl/Makefile.PL
index d401a66..b3fbb73 100644
--- a/perl/Makefile.PL
+++ b/perl/Makefile.PL
@@ -12,7 +12,7 @@ my %pm = ('Git.pm' => '$(INST_LIBDIR)/Gi
 
 # We come with our own bundled Error.pm. It's not in the set of default
 # Perl modules so install it if it's not available on the system yet.
-eval { require 'Error' };
+eval { require Error };
 if ($@) {
 	$pm{'Error.pm'} = '$(INST_LIBDIR)/Error.pm';
 }
