From: Forrest Galloway <f.galloway@gmail.com>
Subject: git rev-list --pretty=format:"" issue
Date: Wed, 17 Apr 2013 16:11:18 -0500
Message-ID: <CAH2yXXYggB=Wv-w4B9qU=ZxAuqjPVa5WRNZRnMRrWShkTp0UFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 17 23:11:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USZdT-0001tn-VQ
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 23:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756877Ab3DQVLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 17:11:19 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:56796 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756521Ab3DQVLS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 17:11:18 -0400
Received: by mail-ie0-f172.google.com with SMTP id c10so2507935ieb.17
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 14:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=NGPYb2bmkXOgGQK+bDtT76ty12QTjTEg1WCMLE7jj9g=;
        b=n55XUyK1y1XTP8sLJkUoKd7COTRLQBwsfGAbFuGRKPr+2UFCaiSRyjh+Iz0TPdlwgU
         6QvPSkxG4cpy3f47Bjsrcun7LT4goAgyYM1hnYACLh9MJCSwhN+WQJiJX6AeOdOgcau/
         KjdH85I4RVPVzyRNiOuJFSkg29L6iIYe6aWBgj5BqGL0m3fMTn8++ZVGRjTl3LJyOquV
         D4xRskfohVkdMp1MDw4bsTIcPnCDVNiWMwlXeXlcGc5aJk8fCIqJ6PpLGwDye8eT78L5
         EQMq2EB5DhFJp8C+pE5gWeQlfeIck0KLuUof0ZQ+tqWXYXF/RcQYAcmDX2sGpbJaJ3FX
         IKSg==
X-Received: by 10.50.115.42 with SMTP id jl10mr5241507igb.71.1366233078329;
 Wed, 17 Apr 2013 14:11:18 -0700 (PDT)
Received: by 10.64.226.132 with HTTP; Wed, 17 Apr 2013 14:11:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221573>

git 1.8.2.1 on OSX(Mountain Lion) installed with Homebrew

I am seeing an issue when trying to format the output from rev-list command.
git log --pretty=format:"%H - %an, %ar : %s" When I attempt the above
string, instead of printing to the shell, LESS is opened and the
output is displayed there.


Got the command from here:
http://git-scm.com/book/en/Git-Basics-Viewing-the-Commit-History

git log --pretty=format:"%h - %an, %ar : %s" The string above works
fine when I change the %h to %H the issue shoes up.
