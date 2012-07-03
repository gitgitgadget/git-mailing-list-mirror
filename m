From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: How do I delete a remote branch with a period in the name?
Date: Mon, 2 Jul 2012 23:09:17 -0400
Message-ID: <CAKON4OwnUKQ6MT8HBNDyfhZLZS5xGKA2Ss1krY9OQGG1gaFhDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 03 05:09:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SltUS-0000zz-R9
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 05:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755895Ab2GCDJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jul 2012 23:09:19 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:53171 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754092Ab2GCDJS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2012 23:09:18 -0400
Received: by vcbf11 with SMTP id f11so3926305vcb.19
        for <git@vger.kernel.org>; Mon, 02 Jul 2012 20:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=yvY+OR65sKjH7C266v/B1rlz0CRFt3eYnBW4r+Hl7MM=;
        b=LeqsV4KqEI4YOM0D5j8MgfupBe/sMz8HOn4HWFjZXgTKAF6asb3CFPyYDpwqbfaege
         +HjUX4Ex7KnOC/MTZTti1gevAQDOP+AXyiVu6hLAUKT8XzXGsQ3IOf2599xtY4dAh1f4
         ZFPTgLNUINExIX8W8rlhiODLMvARnSYHtXhZOLomgDHa9/6/kL9X2o2YHofkjKduN9Zd
         8Q5RxbtfDcaqjVAU2WghJ9frqEeEnAgvG7kChDSsEa1erthemVkbE7D4tlgb+Zs0mGJE
         SKmgNAtZKC76sppcu9XRbIzZxNnpS0bDo8z7HjoAmd/zwnJcLyxWNQdFV1qOaNDNdjns
         Rnqw==
Received: by 10.220.222.74 with SMTP id if10mr7328535vcb.27.1341284957754;
 Mon, 02 Jul 2012 20:09:17 -0700 (PDT)
Received: by 10.52.65.143 with HTTP; Mon, 2 Jul 2012 20:09:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200893>

How do I delete a remote branch with a period in the name?

jonsmirl@smirl2:/home/apps/florida/lpc31xx$ git push origin :fl
To git@github.com:jonsmirl/lpc31xx.git
 - [deleted]         fl

jonsmirl@smirl2:/home/apps/florida/lpc31xx$ git push origin :fl.stg
error: unable to push to unqualified destination: fl.stg
The destination refspec neither matches an existing ref on the remote nor
begins with refs/, and we are unable to guess a prefix based on the source ref.
error: failed to push some refs to 'git@github.com:jonsmirl/lpc31xx.git'
jonsmirl@smirl2:/home/apps/florida/lpc31xx$

jonsmirl@smirl2:/home/apps/florida/lpc31xx$ git branch -r
  linus/master
  origin/HEAD -> origin/master
  origin/bar.stgit
  origin/dt-test
  origin/fl.stgit
  origin/foo.stgit
  origin/lpc313x-stg
  origin/lpc313x-stg.stgit
  origin/master
  origin/master.stgit
  origin/temp.stgit
  origin/v3.4-stg
  origin/v3.4-stg.stgit
  origin/v3.5-stg
  origin/v3.5-stg.stgit


--
Jon Smirl
jonsmirl@gmail.com
