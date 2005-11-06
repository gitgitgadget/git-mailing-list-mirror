From: Jon Loeliger <jdl@freescale.com>
Subject: Documentation Directions
Date: Sun, 06 Nov 2005 11:35:14 -0600
Message-ID: <E1EYoQE-0002QX-VM@jdl.com>
X-From: git-owner@vger.kernel.org Sun Nov 06 18:36:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYoQW-0005jd-KV
	for gcvg-git@gmane.org; Sun, 06 Nov 2005 18:35:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbVKFRfU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 12:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbVKFRfU
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 12:35:20 -0500
Received: from colo.jdl.com ([66.118.10.122]:48316 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S932188AbVKFRfT (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Nov 2005 12:35:19 -0500
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1EYoQE-0002QX-VM
	for git@vger.kernel.org; Sun, 06 Nov 2005 11:35:15 -0600
To: git@vger.kernel.org
X-Spam-Score: -105.9 (---------------------------------------------------)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11218>

Couple of questions regarding documentation direction:

- Is the plan to update all docs to use $GIT_DIR instead of .git?

- Do we intend on adding explicit support for '--help' on most,
  if not all, of the git commands?  In some cases (git-branch)
  a -*) case tacitly catches --help and usage()'s it.  In other
  cases (git-pull) this can't be done as -*) passes options
  on to git-fetch.  I think that we should catch --help directly
  so that it doesn't emit git-fetch's *) catch-all usage:

    % git pull --help
    usage: git-fetch-pack [-q] [-v] [--exec=upload-pack] [host:]directory <refs>...
    Fetch failure: --help

- Do you want to head in the per-man-page-"Now What?" direction
  as suggested by Junio?

Thanks,
jdl
