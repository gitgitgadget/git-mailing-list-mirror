From: Yann Dirson <ydirson@altern.org>
Subject: [WIP PATCH 0/2] format-patch / send-mail thrading documentation
Date: Mon,  6 Jul 2009 01:05:27 +0200
Message-ID: <cover.1246834883.git.ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 01:04:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNakj-0007iA-FB
	for gcvg-git-2@gmane.org; Mon, 06 Jul 2009 01:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754993AbZGEXDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jul 2009 19:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754824AbZGEXDw
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jul 2009 19:03:52 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:37133 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754579AbZGEXDw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jul 2009 19:03:52 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 93D3E9400A4;
	Mon,  6 Jul 2009 01:03:48 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g21.free.fr (Postfix) with ESMTP id A70D49400B3;
	Mon,  6 Jul 2009 01:03:46 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 85DCBA003; Mon,  6 Jul 2009 01:05:33 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122764>

While sending patches, it took me time to realize that it was not just
the format-patch --thread documentation being inaccurate, but that the
interactions with send-email were not obvious - and that the config
items specific to send-email were not at all described in the central
config.txt.

Now that bizarre interaction may just be due to a bug that we'd like
to fix instead ?

Yann Dirson (2):
  List send-email config options in config.txt.
  Improve doc for format-patch threading options.

 Documentation/config.txt           |   40 ++++++++++++++++++++++++++++++++++++
 Documentation/git-format-patch.txt |   15 +++++++++---
 Documentation/git-send-email.txt   |   16 +++++++++----
 3 files changed, 62 insertions(+), 9 deletions(-)
