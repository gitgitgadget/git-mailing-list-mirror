From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCH 0/2] Improve "git submodule add" documentation.
Date: Mon,  6 Jun 2011 16:49:11 -0400
Message-ID: <1307393353-32389-1-git-send-email-marcnarc@xiplink.com>
References: <4DED314C.3000203@web.de>
Cc: Jens.Lehmann@web.de, gitster@pobox.com, mlevedahl@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 22:50:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTgkL-0002SZ-26
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 22:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758047Ab1FFUtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 16:49:47 -0400
Received: from 208-85-112-101.zerofail.com ([208.85.112.101]:32816 "EHLO
	farnsworth.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757302Ab1FFUtr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2011 16:49:47 -0400
Received: from rincewind.xiplink.com ([192.168.1.136])
	by farnsworth.xiplink.com (8.14.2/8.14.2/Debian-2build1) with ESMTP id p56KnVBH002061;
	Mon, 6 Jun 2011 16:49:31 -0400
X-Mailer: git-send-email 1.7.6.rc0.17.g3eac3
In-Reply-To: <4DED314C.3000203@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175164>

This series applies atop Jens's 2/3 patch.  Jens, please feel free to
squash these into your commit if you like.

The first commit makes the documentation (hopefully) more accurately
describe how git chooses which superproject remote to use.

The second commit moves the paragraph describing the utility of relative
submodule URLs right after their description, making it more likely for
readers to see it (instead of assuming it's part of the <path> parameter's
documentation -- as I did on previous occasions).

		M.
