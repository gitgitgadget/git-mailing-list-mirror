From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 0/3] Add a testsuite to stgit
Date: Wed, 12 Apr 2006 23:16:33 +0200
Message-ID: <20060412211633.14579.98008.stgit@gandelf.nowhere.earth>
X-From: git-owner@vger.kernel.org Wed Apr 12 23:19:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTmjy-0004lO-Gr
	for gcvg-git@gmane.org; Wed, 12 Apr 2006 23:19:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWDLVTD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Apr 2006 17:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWDLVTD
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Apr 2006 17:19:03 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:8583 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S932253AbWDLVTB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Apr 2006 17:19:01 -0400
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 8A36F1910E
	for <git@vger.kernel.org>; Wed, 12 Apr 2006 23:19:00 +0200 (CEST)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by nan92-1-81-57-214-146 with esmtp (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1FTmsx-0008P1-Ef
	for git@vger.kernel.org; Wed, 12 Apr 2006 23:28:23 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18639>

The following steals the testsuite system from git-core and adapts it to stgit,
adds a couple of items to the TODO file, and adds a first testsuite to
demonstrate a problem with branch renaming, to serve as a non-reg test.

To run the testsuite, just "make -C t", there is no integration in the python-generated
toplevel Makefile.

--
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
