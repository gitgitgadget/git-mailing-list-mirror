From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH 00/10] Various fixes and improvements
Date: Thu, 15 Mar 2007 01:26:29 +0100
Message-ID: <20070315001808.9094.68529.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 01:26:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRdne-0002tb-5q
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 01:26:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbXCOA0b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 20:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964930AbXCOA0b
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 20:26:31 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:58989 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964863AbXCOA0b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 20:26:31 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id EAF7B81A1;
	Thu, 15 Mar 2007 01:26:29 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 75A261F095;
	Thu, 15 Mar 2007 01:26:29 +0100 (CET)
User-Agent: StGIT/0.12.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42255>

I found a couple of issues involving stack deletion, here are fixes
for the most annoying ones.
Also includes some small cleanups involving parent information, as
well as mostly-unrelated small improvements gathered while hacking on
the other patches.


Note: since I have seen the patch entitled 'git-fetch: Support the
local remote "."', I'm much less sure about my patch that stops
recording this type of information (the "Stop recording
branch.*.remote to '.' for local parents." one), but I add it
nevertheless, mostly for discussion.

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
