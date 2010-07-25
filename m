From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: git-remote-svn: Call for manpower
Date: Sun, 25 Jul 2010 15:59:10 +0530
Message-ID: <20100725102908.GA2726@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 25 12:31:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcyUK-0005Y3-Is
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 12:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058Ab0GYKbD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 06:31:03 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:37722 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797Ab0GYKbA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 06:31:00 -0400
Received: by pzk26 with SMTP id 26so680632pzk.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 03:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=xkAt1U8TSbs46baHgYkLXgdBP00b2Ere1aDA72ilCII=;
        b=tW0XLHzCn5U/44YJCTjqZQ9uZ812GD50jmcL+ZjVTX+5CVgz+0AikQHulPQFn3fFc2
         N/qbAykUWHwvEHoWKPUkrN13LeM0rwa6DXFbukkNhSkLL3DlCIN0YrLdsNmVCUYwagHo
         qVNMgydSkNkKhWs7b0lJgoYLu/H0QQ0y+DPFM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=ZbXGm8o7eUiFVHx9mpzT6CeFlrYGWyDpJ5Ww42FUTYtQkKDZ3a5oJh/B8LpcIdkkf7
         8S99MGCWqrNPcJkeH2lZ9IDlk45HSp1BhZqWzTq32QVY+m6rikilE+BrOICU34NedUJh
         j4ziWZxNjmyfn1/x2/tzeJwz8aKXZvNFeaPuA=
Received: by 10.142.153.8 with SMTP id a8mr7005129wfe.245.1280053860098;
        Sun, 25 Jul 2010 03:31:00 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id w27sm2695113wfd.5.2010.07.25.03.30.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Jul 2010 03:30:59 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151722>

Hi,

I know I've asked for this time and again, but I'll make another
request.

Short version: If there's anyone interested in git-remote-svn and has
some free time, please join the team. We currently have more work than
the team can handle, and the deadline is drawing closer.

Longer "what's cooking" version:
1. svnrdump: The version merged into trunk at subversion/svnrdump is
   in excellent shape, thanks to the Subversion developers. This week,
   we fixed the dump output to include missing headers, revision 0,
   match the newlines from the output of `svnadmin dump`, included
   authentication support, and thoroughly scrubbed the codebase.
2. Regression tests for svnrdump: Since I'm only a partial committer,
   I need approval to commit outside svnrdump/ - I've already sent
   patches for tests to the mailing list and am waiting for
   approval. Instead of validating against 10k revisions of a
   repository, there are reduced tests cases to test just the edge
   cases in the trunk and we're using these- it will make the tests
   easier to run, and debugging much easier.
3. svnrload: I just started working on this in branches/svnrload,
   designing it as the inverse version of svnrdump. This is very
   non-trivial work, and will take us atleast a few weeks to complete.
4. Dumpfilev3 support for svn-fe: Since we're running out of time,
   I've decided to depend on libsvn for parsing the svndiff0, and
   remove the dependency later. I should be able to finish this off in
   a a few days; my current work is in the dumpfilev3 branch.
5. Zero-tree refactor: I don't really know if we'll be able to
   complete this in time. I've asked Jonathan to do as little as
   possible to make svn-fe Git-aware.
6. Ternary-treap refactor: This isn't strictly necessary either, and
   I've decided to let David work on it in his own time.
7. Modifications to svn-fast-import: Sverre, and Jonathan: what's the
   status of this?
8. Exporter for converting the fast-export stream into a dumpfilev3 to
   feed svnrload: Can someone work on this?
9. Trunk/ branch/ tag mapper: I'm dropping all post-processing for the
   moment. We don't have anyone to work on this, and it's independent
   of everything else- it can easily be worked on later.

Thanks for reading.

-- Ram
