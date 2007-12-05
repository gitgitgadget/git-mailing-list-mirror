From: Anton Korobeynikov <asl@math.spbu.ru>
Subject: How to fix this error
Date: Wed, 05 Dec 2007 15:04:02 +0300
Organization: Saint Petersburg State University
Message-ID: <1196856242.10880.8.camel@asl.dorms.spbu.ru>
Reply-To: asl@math.spbu.ru
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 05 13:04:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Izsze-0006lN-0Y
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 13:04:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbXLEMEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 07:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbXLEMEX
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 07:04:23 -0500
Received: from star.math.spbu.ru ([195.19.226.178]:1555 "EHLO
	star.math.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474AbXLEMEW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 07:04:22 -0500
Received: from [195.19.254.136] (asl.dorms.spbu.ru [195.19.254.136])
	by star.math.spbu.ru (8.13.6/8.13.6) with ESMTP id lB5C4Ek3036878
	for <git@vger.kernel.org>; Wed, 5 Dec 2007 15:04:17 +0300 (MSK)
X-Mailer: Evolution 2.12.2 
X-Virus-Scanned: ClamAV 0.88.7/5011/Wed Dec  5 12:42:23 2007 on star.math.spbu.ru
X-Virus-Status: Clean
X-Spam-Checker-Version: SpamAssassin 3.1.0 (2005-09-13) on star.math.spbu.ru
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67149>

Hello, Everyone

Today I discovered, that one of my git-svn-pulled trees cannot sync
anymore:

$ git-svn rebase -A ../authors 
Index mismatch: cc94b590c0a458a610fca10fa01e7461c627b63b !=
09ac82e1a756c11865eca3e23c5704f73dc45244
rereading dc25ba706a6edaa0cc51dd376952b694559137c0
        D       test/Sema/undecl-objc-h.m
        M       Basic/FileManager.cpp
        M       Basic/SourceManager.cpp
        M       include/clang/Basic/FileManager.h
        M       include/clang/Basic/SourceManager.h
        M       include/clang/AST/Expr.h
        M       Sema/SemaChecking.cpp
        M       Sema/SemaType.cpp
        M       Sema/Sema.h
        M       Sema/SemaDecl.cpp
        M       Sema/SemaStmt.cpp
        M       Driver/Targets.cpp
        M       Driver/RewriteTest.cpp
Last fetched revision of refs/remotes/git-svn was r44583, but we are
about to fetch: r44571!

Maybe the actual reason were some fs transactions being rollbacked after
power loss, but I'm not sure. Any idea how this can be fixed without
repulling everything from scratch?

Thanks in advance.

-- 
With best regards, Anton Korobeynikov.

Faculty of Mathematics & Mechanics, Saint Petersburg State University.
