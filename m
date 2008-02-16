From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Git rebase/pull questions
Date: Fri, 15 Feb 2008 23:10:03 -0500
Message-ID: <76718490802152010udd11567v25ae456db0a59f3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 16 05:11:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQEOK-0004Po-Mc
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 05:11:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756517AbYBPEKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 23:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754104AbYBPEKF
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 23:10:05 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:7309 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756087AbYBPEKE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 23:10:04 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1512225wah.23
        for <git@vger.kernel.org>; Fri, 15 Feb 2008 20:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=7r+5JCz9+ZkUAcnvP7pcj2dmvKCR5l0niD6mg6BjbAU=;
        b=KXsYK+EdkaDtGpTr9VISt/uK0p1BWPmGs3bXn4t6b/cmxMqN/LAnGC1UxLz95x4kmDp3d5Rf6qlopzQmmNAWsG7cSgUaxwC2xIZGf1xxvr29GPJv8NnJhAZ7jNWZUeTGLHxOJKKy7jTdp5YPYONBJ+vQ4bwXDiuDlU+br64wjEs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=MsO1QaGL9jcWTMzgUuHogRS4Rb5X4+hLcjRspH6DD0y4jpgb5N8H5xNYqKxsIwn+uA+k91eI1qDPDMzVZWKW7Ocl/IO3Bqtc77wBkfp1wkQgCz2ReYcTainWfhtvCBGbuwJHTlI1ZSR5mvFUQ4l3jtdQ8zriaawnv7iEDiU6yLM=
Received: by 10.114.102.1 with SMTP id z1mr3817681wab.56.1203135003493;
        Fri, 15 Feb 2008 20:10:03 -0800 (PST)
Received: by 10.114.255.11 with HTTP; Fri, 15 Feb 2008 20:10:03 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74005>

First, I notice that git-rebase supports a --s/--strategy option (which
implies -m/--merge). I wonder whether it should respect
branch.<name>.mergeoptions as the default for this setting?

(BTW, git-rebase's USAGE/LONG_USAGE doesn't match its man page. Also,
the man page synopsis doesn't include all the options the man page
documents later on.)

Second, git-pull completely ignores -s/--strategy if also give --rebase,
but I wonder if it shouldn't just pass the strategy along to git-rebase.

Thoughts?

j.
