From: maximilian attems <max@stro.at>
Subject: commit --amend neglecting return value
Date: Mon, 22 Mar 2010 05:36:16 +0100
Message-ID: <20100322043616.GF21406@baikonur.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 22 05:44:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtZV3-0000er-UT
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 05:44:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098Ab0CVEoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 00:44:21 -0400
Received: from baikonur.stro.at ([213.239.196.228]:60487 "EHLO
	baikonur.stro.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896Ab0CVEoU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 00:44:20 -0400
Received: by baikonur.stro.at (Postfix, from userid 1001)
	id 9D4815C00B; Mon, 22 Mar 2010 05:36:16 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by Amavis (ClamAV) at stro.at
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142897>

hello,

bug is easily reproducible by

> foo
git add foo
git commit --amend
:q!
 1 files changed, 1 insertions(+), 8 deletions(-)
 create mode 100644 test

git --version
 git version 1.7.0.2

aboves is usage with vim as patch editor.
The expected behaviour would be to have not foo add to repo.
afair this feature^Wbug exists since loooong.

thanks + kind regards

-- 
maks
