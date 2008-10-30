From: Yann Dirson <ydirson@altern.org>
Subject: [RFC PATCH v2 0/2] Detection of directory renames
Date: Thu, 30 Oct 2008 23:16:40 +0100
Message-ID: <20081030220532.3325.54457.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 30 23:19:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvfqH-0002ZT-04
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 23:18:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754770AbYJ3WQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 18:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754597AbYJ3WQz
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 18:16:55 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:46146 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754219AbYJ3WQy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 18:16:54 -0400
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 36D871978C
	for <git@vger.kernel.org>; Thu, 30 Oct 2008 23:16:53 +0100 (CET)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 1E15B19746
	for <git@vger.kernel.org>; Thu, 30 Oct 2008 23:16:52 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id CD3F61F0C2
	for <git@vger.kernel.org>; Thu, 30 Oct 2008 23:16:40 +0100 (CET)
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99529>

This is an update of my previous patch.  It brings:
* a couple of fixes to annoying segfaults
* a testsuite showing where we're standing.
* getting rid of POSIX dirname
* improvement of debug messages

The code is still full of FIXME's, not ready for inclusin into any
branch whatsoever, and I'd be happy to hear about it if you can make
it break in a way or another - at least in a way not yet shown by the
testsuite :)

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
