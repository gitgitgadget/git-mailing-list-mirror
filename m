From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH 8/9 v11] difftool: teach difftool to handle directory diffs
Date: Wed, 4 Apr 2012 15:31:25 -0400
Message-ID: <CAFouetjn9hW6YruCvsBQR+a4dcsCfV8nQ8Wma=3reSu__84_UQ@mail.gmail.com>
References: <1333567265-23986-1-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org, davvid@gmail.com,
	ramsay@ramsay1.demon.co.uk
X-From: git-owner@vger.kernel.org Wed Apr 04 21:31:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFVvh-0003Cn-8j
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 21:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932723Ab2DDTb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 15:31:26 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43142 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932505Ab2DDTb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 15:31:26 -0400
Received: by iagz16 with SMTP id z16so705879iag.19
        for <git@vger.kernel.org>; Wed, 04 Apr 2012 12:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=JcsxGbxtmDcnpt/R1YLRturA24EdTIka8HObQeNnosk=;
        b=fIo5Cw5WOAGZzINpkwTq4mIazbGd2QxsYvXXeGT3SoibyxpKBIlvRnHMtt99iGx2tb
         Z6v4TJKULXFl8/sjau191H8vgBSwgR6hZYTmrDfbuJhhXscg8DOVNIpbYEvzBKxuVNC+
         bb/59vEqb2bQfZM21ef4gl1Tsf9wwsAN2sUYrDrqPEPJYy8mwELDMbU+uRYJBtB6knEB
         TTzbjBisCam46AVIWP7ib7gAeBtUEXbiCsR2SGVZDHxUs7uD8a4jLGNx/6BUYPXSz+lI
         26NHEnRtiE5z4zgvhQBt6UeJ8o5hKMSeYSHd1VcIoIqmvmUaghjLRlh3rL2WJpqH/atQ
         4ZNA==
Received: by 10.42.97.194 with SMTP id p2mr1435900icn.36.1333567885762; Wed,
 04 Apr 2012 12:31:25 -0700 (PDT)
Received: by 10.42.225.193 with HTTP; Wed, 4 Apr 2012 12:31:25 -0700 (PDT)
In-Reply-To: <1333567265-23986-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194723>

> This replaces commit 4d6efe0 in the 'th/difftool-diffall' branch based
> on pu. This version corrects some problems with submodule support in
> difftool.

Please s/4d6efe0/4b6efe0/.  Sorry for the confusion.
