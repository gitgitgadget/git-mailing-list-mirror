From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 0/5] My set of stgit companion scripts.
Date: Fri, 05 Jan 2007 00:39:34 +0100
Message-ID: <20070104233934.13580.17744.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 05 00:47:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2cJM-0004Bv-AS
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 00:47:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030283AbXADXrt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 18:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030287AbXADXrt
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 18:47:49 -0500
Received: from postfix1-g20.free.fr ([212.27.60.42]:50436 "EHLO
	postfix1-g20.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030283AbXADXrs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 18:47:48 -0500
Received: from smtp2-g19.free.fr (smtp2-g19.free.fr [212.27.42.28])
	by postfix1-g20.free.fr (Postfix) with ESMTP id EE17E74747E
	for <git@vger.kernel.org>; Fri,  5 Jan 2007 00:47:47 +0100 (CET)
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 975ED7CFE;
	Fri,  5 Jan 2007 00:46:46 +0100 (CET)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by bylbo.nowhere.earth with esmtp (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1H2cIJ-0001l0-7i; Fri, 05 Jan 2007 00:46:47 +0100
To: Catalin Marinas <catalin.marinas@gmail.com>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35960>

The following series adds to contrib/ a set of bash scripts I find useful
for my daily use of stgit.  They are probably closely tied to my workflow,
but others may find them useful as well.  Some of them may be useful to
pythonize and integrate in some form or another.


stg-show-old is a trivial thing, but since I often need that functionnality,
it is much less comfortable than forging the same command-line over and over
again.  It is also used by some of the other scripts.

stg-fold-files-from and stg-swallow are invaluable when shuffing changes
between patches.

stg-what-changed is invaluable when shuffling patches in the stack.

stg-cvs is a very young script, and probably very fragile.  It allows a
lightweight way of preparing changes with stgit before committing them into
a CVS tree.

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
