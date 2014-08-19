From: Steven Evergreen <i.stevenevergreen@gmail.com>
Subject: Fwd: Shallow clone
Date: Tue, 19 Aug 2014 04:11:19 -0700
Message-ID: <CAEfjWpHmLXx7Cpyn-Pd+G7VpaXZhFSS741BFKY0kANrh49xt9g@mail.gmail.com>
References: <CAEfjWpHhLKpghGRFtzstndk_vYMkLSLAGfXx8agoQmakC-6Otg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 13:11:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJhKX-00037d-FO
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 13:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752657AbaHSLLW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 07:11:22 -0400
Received: from mail-wg0-f52.google.com ([74.125.82.52]:50076 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651AbaHSLLU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 07:11:20 -0400
Received: by mail-wg0-f52.google.com with SMTP id a1so6196473wgh.23
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 04:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=ZyGMu3kEYtT3UFX+xmYsnE0EnLHCTMoh7PvzSj/bzM0=;
        b=M2kckdWfN0QGoOZK4Zj5wKYJUeB7HLt1riNjnTJT5Rq+Vrjz4V0OfGsNUF4QlxenKH
         bU1d5GlSqwk1l8DLegdj7o0/Zf0q86Gc3ACdIDueYJh6sf7VBszGFvsX6xOFB+03I8wG
         W3TU7P2OoYexdnoxN3vQYdvdkEIvuKMa0kD5TMb4d1TULILRU+sk30fP0RkOko4e8Rfy
         vS4ApxQjW9KQxG3fU8w/ZpigadIoLYmOE+oOJ8MEi4Js+97RtZv8daByjdjxrIWeGw8/
         nlwiCKDp0aDup2lf13q9L/l5qRNdKf2mvR4jC1D5uB3WYWZjcDs3trV5rPpskh6FIHA0
         J1ZQ==
X-Received: by 10.180.14.170 with SMTP id q10mr5894000wic.56.1408446679397;
 Tue, 19 Aug 2014 04:11:19 -0700 (PDT)
Received: by 10.194.156.165 with HTTP; Tue, 19 Aug 2014 04:11:19 -0700 (PDT)
In-Reply-To: <CAEfjWpHhLKpghGRFtzstndk_vYMkLSLAGfXx8agoQmakC-6Otg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255453>

Hi, everyone. I'm trying to perform a shallow clone with visibility of
all remote branches.

git clone REPO --depth 1 --no-single-branch

is consistently giving me

Cloning into 'REPONAME'...
fatal: (null) is unknown object
remote: Total 0 (delta 0), reused 0 (delta 0)
fatal: recursion detected in die handler
remote: aborting due to possible repository corruption on the remote side.
fatal: error in sideband demultiplexer

with 2.0.3 .

Is this command not supported? Have I hit a bug?

Thanks!
