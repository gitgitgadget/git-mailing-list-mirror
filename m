From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH v3 0/3] Detection of directory renames
Date: Sat, 01 Nov 2008 23:03:08 +0100
Message-ID: <20081101215739.1116.59319.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 01 23:04:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwOaI-0005Jz-TY
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 23:04:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbYKAWDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 18:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbYKAWDZ
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 18:03:25 -0400
Received: from smtp7-g19.free.fr ([212.27.42.64]:56824 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751307AbYKAWDY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 18:03:24 -0400
Received: from smtp7-g19.free.fr (localhost [127.0.0.1])
	by smtp7-g19.free.fr (Postfix) with ESMTP id D68F7B00F9
	for <git@vger.kernel.org>; Sat,  1 Nov 2008 23:03:22 +0100 (CET)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp7-g19.free.fr (Postfix) with ESMTP id BF0ABB00B5
	for <git@vger.kernel.org>; Sat,  1 Nov 2008 23:03:22 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 6B7DD1F0C1
	for <git@vger.kernel.org>; Sat,  1 Nov 2008 23:03:09 +0100 (CET)
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99780>

This new version fixes handling of moves to and from tree toplevel,
adds supports for detecting bulk moves of files into a subdirectory of
their original dir, and adds a couple of other testcases showing what
still has to be done to properly handle moves of directories with
subdirs.

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
