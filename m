From: Kristian Freed <kristian.freed@gmail.com>
Subject: How can I automatically create a GIT branch that represents a
 sequence of tags?
Date: Sat, 10 Aug 2013 23:29:45 +0100
Message-ID: <CAFw3YtRLgUGGn9JV5K3P9XtMBcBeO7=VSM7PekSxtW6xCsfZ1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 11 00:30:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8HgG-0006VZ-8S
	for gcvg-git-2@plane.gmane.org; Sun, 11 Aug 2013 00:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758902Ab3HJWaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 18:30:08 -0400
Received: from mail-we0-f171.google.com ([74.125.82.171]:61625 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758881Ab3HJWaH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 18:30:07 -0400
Received: by mail-we0-f171.google.com with SMTP id q55so4543047wes.30
        for <git@vger.kernel.org>; Sat, 10 Aug 2013 15:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=31Pr+2Q6TWEy9qyaMOks+yvGYdLRPnUNFz4CKhz3ZQ4=;
        b=MBpiNgYIWxbrZlGcAPn0uiBwZn81jPzwKe6BQDA8U0yqalvDPNYLsUBhLK0zeel+DS
         l2R86Hw5MW6WsaqzxXTlYDtieNpnvEJw9YEp3cIcxr/f7PkVNx2nMKfYKUu29i6jQOxu
         zuntQVJXR9a+pauqzcdsNGRp/2HoxUQtqpdnFreiB3BYNPM9ep244CIwMBT3RPmWKEIi
         bdr0CyfRnNELHNegQSsiyQFSQF6cJ30ChcO8qLw9tXnl0EMIPmPqVh1uAx1LioG22cGl
         jjocKyYGvPExrm+dKJ44CHEtgRmZjsyWJLSKpiA93ROoiBFvSQJD3Djz3K/6ohWpEH59
         qNDw==
X-Received: by 10.180.149.239 with SMTP id ud15mr3181209wib.16.1376173805291;
 Sat, 10 Aug 2013 15:30:05 -0700 (PDT)
Received: by 10.194.172.101 with HTTP; Sat, 10 Aug 2013 15:29:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232114>

In our current setup, we have automatic tagging in git of all
successful release builds. This makes it easy to go back to stable
points in history and compare functionality, check when bugs were
introduced etc.

To help with this process further, it would be useful to be able to
use git bisect, but as these are just a sequence of tags, not commits
on a branch, git bisect will not work as is.

Is there any tooling for automatically recreating a branch from a
sequence of tags, where each generated commit is the calculated delta
between each two neighbouring tags?

Thanks,
Kristian
