From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [ANNOUNCE] Stacked GIT 0.8.1
Date: Sun, 22 Jan 2006 10:20:31 +0000
Message-ID: <b0943d9e0601220220t59e30c18h@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sun Jan 22 11:20:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0cKs-0004xg-1T
	for gcvg-git@gmane.org; Sun, 22 Jan 2006 11:20:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWAVKUd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jan 2006 05:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbWAVKUd
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jan 2006 05:20:33 -0500
Received: from xproxy.gmail.com ([66.249.82.199]:62743 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932190AbWAVKUc convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jan 2006 05:20:32 -0500
Received: by xproxy.gmail.com with SMTP id i30so510361wxd
        for <git@vger.kernel.org>; Sun, 22 Jan 2006 02:20:32 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=DALDT2wglrzYcG0gBqujKT0GWm/Fg1IiWGl0ST8sVRsKjdoTyBiP2zMItc+HQg5mkuIIC2yZ1yEz5EbMbEmLRNJrpl0Wba7ohCya3Dz69ErB0Ek/tVMbvlrETSRxwjGV74v1tuT3bvG+qXsXLI4WAP4z6Xbua+W4MBr7YQ2ce/U=
Received: by 10.70.60.17 with SMTP id i17mr4632932wxa;
        Sun, 22 Jan 2006 02:20:31 -0800 (PST)
Received: by 10.70.53.11 with HTTP; Sun, 22 Jan 2006 02:20:31 -0800 (PST)
To: git <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15046>

Stacked GIT 0.8.1 release is available from http://www.procode.org/stgit/

StGIT is a Python application providing similar functionality to Quilt
(i.e. pushing/popping patches to/from a stack) on top of GIT. These
operations are performed using GIT commands and the patches are stored
as GIT commit objects, allowing easy merging of the StGIT patches into
other repositories using standard GIT functionality.

This is a bug-fix release:

- Fix the removal vs. change merging conflict
- 'clone' command fixed
- 'status --reset <file>' command fixed
- typos corrected

Acknowledgements (generated with 'git shortlog'):

Catalin Marinas:
      Fix the clone command failure
      Fix the 'status --reset' for individual files
      Release 0.8.1

Kirill Smelkov:
      [trivial]  fix spelling typos

Paolo 'Blaisorblade' Giarrusso:
      Stgit - gitmergeonefile.py: handle removal vs. changes

Pavel Roskin:
      stgit: typo fixes

--
Catalin
