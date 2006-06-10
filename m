From: Yann Dirson <ydirson@altern.org>
Subject: [BUG?] git-clone fails on .git/refs/foo
Date: Sun, 11 Jun 2006 00:50:40 +0200
Message-ID: <20060610225040.GA7766@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jun 11 00:50:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpCI4-0004sb-VJ
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 00:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbWFJWuq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Jun 2006 18:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161047AbWFJWuq
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jun 2006 18:50:46 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:23490 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751006AbWFJWuq (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Jun 2006 18:50:46 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 24229224F3
	for <git@vger.kernel.org>; Sun, 11 Jun 2006 00:50:45 +0200 (CEST)
Received: from dwitch by bylbo.nowhere.earth with local (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1FpCHw-0002Gq-Sf
	for git@vger.kernel.org; Sun, 11 Jun 2006 00:50:40 +0200
To: GIT list <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21627>

Could it be that git-clone has a problem when a ref is not inside a
subdir of .git/refs ?

Both 1.3.3 and 1.4.0 show the following problem, which prevents
cloning from this repo:

$ git-clone http://ydirson.free.fr/soft/git/cvsps.git test
Getting alternates list for http://ydirson.free.fr/soft/git/cvsps.git/
Getting pack list for http://ydirson.free.fr/soft/git/cvsps.git/
Getting index for pack 5d9ec186a71fb6a464878518335275fe7d061a1f
Getting pack 5d9ec186a71fb6a464878518335275fe7d061a1f
 which contains de4e8c0aa352effae581924d07d2613799c2a5de
walk de4e8c0aa352effae581924d07d2613799c2a5de
walk 3e2d77cddea626fd4513087e0352ff9116f6d93b
walk a21e7d37b22621c626faf25b32006bb1e6f7055b
walk 1affe7d46c773d7a2136e66e927b09fa3c6a61d7
walk fdf44680988ce53173262c8f6cb6b478a6ab04a9
walk 4e3aa38681c849d6931dd56d958fff6abf3ea38e
walk bb6b1ea1a785e10bee7bfba294012a821ddc3bd1
walk ab0095940796152f171d2de4fbd60ecc6ed433c3
walk cb7644a9650ef8521d5befb5ee43b7525445dc97
error: Can't lock ref posted0

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
