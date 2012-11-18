From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: [ANNOUNCE] namespace support in gitolite
Date: Sun, 18 Nov 2012 17:11:27 +0530
Message-ID: <CAMK1S_hGPb5nMs1-w9qtjwGnS4VrgfxG-yRP2b0p7Y=DRk=2Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 18 12:41:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ta3Fx-0001No-FD
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 12:41:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596Ab2KRLl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2012 06:41:29 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:36522 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361Ab2KRLl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2012 06:41:29 -0500
Received: by mail-lb0-f174.google.com with SMTP id gi11so385404lbb.19
        for <git@vger.kernel.org>; Sun, 18 Nov 2012 03:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=kGm/vs4/dgTGzlXe5taNN39jcTbS7BTlBM2Aqycv/Ug=;
        b=ZRzUdrZx8Oit5+xaBC/7YnTJiAlDm4QPggM5O2ECX1700LvQDd1XrhEVIJ2B/9V3zx
         +SjehpwU0i1mQEAWopBLCJXGKTvRaIg/RKpjgVGPR8iYA3/sf6gtmtC+B28CxmBMftRS
         3YFfsfQkMJXJuLpKWbIhDyz48N1ke2x69ehsxxvnS9KUl5yoYrkSxndcISbs9aj+fckX
         JHmea8CrIYvlQ9XvmR6KOeyPJ1ibaAp1/0f0h0uHVnd+X2eGMbk4laGneKJWiRECWiKg
         8sEn7nxPgirBOVwIPYqdmajSPX0y19CdtFsObbm2YVfToFPbePl2swN0I37XZDalObYB
         jiKw==
Received: by 10.112.29.129 with SMTP id k1mr4006682lbh.102.1353238887531; Sun,
 18 Nov 2012 03:41:27 -0800 (PST)
Received: by 10.112.113.103 with HTTP; Sun, 18 Nov 2012 03:41:27 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210025>

Hello all,

Gitolite now supports namespaces on the server side (invisible
to the client side of course).  See [1] for details.

A simple way to describe it would be that all the repos in the
top row of the picture in the "integration manager workflow" at
[2] are stored in one physical repo on the server, which saves a
lot of disk space as well as network traffic for pushes to a
"new" repo.

This is all on the server side.  On the client side they
continue to look like separate repos, so nothing changes.

In addition, gitolite's 'upstream' trigger can be used to keep
the main repo in sync with the real upstream (somewhere on the
internet) if you wish.

A bit more detail and a small example is at [3].

[1]: http://sitaramc.github.com/gitolite/namespaces.html
[2]: http://git-scm.com/book/en/Distributed-Git-Distributed-Workflows#Integration-Manager-Workflow
[3]: http://groups.google.com/group/gitolite/browse_thread/thread/5efcbfb5ff3ebe88

-- 
Sitaram
