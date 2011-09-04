From: Michael Witten <mfwitten@gmail.com>
Subject: Lost association between TAGS and COMMITs when rebased a git(1) repository
Date: Sun, 04 Sep 2011 14:03:12 -0000
Message-ID: <3c10d6593152436c9dd3a5b5773e3c79-mfwitten@gmail.com>
References: <FF0364F3D5244CA4987EDDCFE7244BF3@urbanjsPC>
Cc: git@vger.kernel.org
To: "John S. Urban" <urbanjost@comcast.net>
X-From: git-owner@vger.kernel.org Sun Sep 04 16:07:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0DMF-0003x2-MR
	for gcvg-git-2@lo.gmane.org; Sun, 04 Sep 2011 16:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754174Ab1IDOH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Sep 2011 10:07:29 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47712 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753861Ab1IDOH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2011 10:07:28 -0400
Received: by fxh19 with SMTP id 19so3090819fxh.19
        for <git@vger.kernel.org>; Sun, 04 Sep 2011 07:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:cc:message-id:in-reply-to:references;
        bh=dwidqZYFr22qQxZEHEy+d0R0gkpYd8zhZ8FwaFR/AeY=;
        b=mikOegiXfW40nhVzh0bxPdLt8viU2htD0BJBd+Pqtlh96JB5G9bLEi+z5EDhQLnlH1
         LyYX8lBOuxD+j8aWQvgtllCidGL0YTa7xSyxSTZKxNvufDIeIGWtBYIo2hR5IwkffZsm
         eS27G2LsJ5eA7oUma5WJsKhk9mOv43sOQN9Sc=
Received: by 10.223.102.11 with SMTP id e11mr1404869fao.8.1315145246894;
        Sun, 04 Sep 2011 07:07:26 -0700 (PDT)
Received: from gmail.com (zoe.desire.se [85.8.28.11])
        by mx.google.com with ESMTPS id m8sm2930865fae.17.2011.09.04.07.07.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 04 Sep 2011 07:07:25 -0700 (PDT)
In-Reply-To: <FF0364F3D5244CA4987EDDCFE7244BF3@urbanjsPC>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180682>

On Sat, 3 Sep 2011 21:32:03 -0400, John S. Urban wrote:

> With my first use of git(1) I  created a small project with about 200
> "commits".  When this was complete, I needed to label each commit with
> information pointing it to a section of a document.

What exactly does that mean?

> I used tags for this.

It sounds like `git notes' or rewritten commit messages would be what is
appropriate.

> So far, everything was fine. I was then asked to merge two commits
> into one. I then did a "rebase" (for the first time).

You mean `squash'; the term `merge' has a specific meaning in git
nomenclature.

> Also, I have some commits with multiple tags pointing to them. It has come
> to my attention that might not be an intentional feature. I could find
> nothing in the documentation explicitly stating multiple tags were allowed
> to point to a commit; but the tags seem to be unique "objects" so I
> see no reason this should not be an expected feature?

Well, everybody, it sounds like John's confusion is a good example for
why `tag' is another TERRIBLE choice of terminology.

See here:

  http://article.gmane.org/gmane.comp.version-control.git/179609
  Message-ID: <CAMOZ1Btmk86vmp1gRuCfG7yRuc6fD3_oYBvtq2VKK9Ywu8ay0A@mail.gmail.com>

  http://article.gmane.org/gmane.comp.version-control.git/179942
  Message-ID: <CAMOZ1Bti3ZtAEOtLiUYSkWE+rO_VQd09NAn58Cn4hZBu8f-aFQ@mail.gmail.com>
