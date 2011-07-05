From: Adam Bourg <adam.bourg@gmail.com>
Subject: Trying to clone a repository in git, getting a error.
Date: Tue, 5 Jul 2011 15:21:05 -0600
Message-ID: <CAGGoUy__mjY3S-DUkV59sstaU5Z__EVgFdCuumfVuSTa0XWavQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 05 23:21:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeD3r-00073w-CW
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jul 2011 23:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752691Ab1GEVVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jul 2011 17:21:08 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64372 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754Ab1GEVVH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2011 17:21:07 -0400
Received: by bwd5 with SMTP id 5so5079556bwd.19
        for <git@vger.kernel.org>; Tue, 05 Jul 2011 14:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=5KqWWficXTDjYmtNPHEuyd64IsyGC51f2nneO34a9TY=;
        b=gP4L0/S9l8NtGjiW380qA6BTM5g5PwaRhD8D4kc4kVFRJuIAqu8ecaZUmV/I9Cb9zZ
         ulUPNRIpr34Lruz9jm0tISVxrrx6/K5wU25g/Zx78MjY7WhUBxxoyC05sY2ODxM1sl6r
         STW4xdUKg1qgB3cNeqBHXwj/6EbHCnoJPG+Yc=
Received: by 10.204.16.139 with SMTP id o11mr467535bka.177.1309900865597; Tue,
 05 Jul 2011 14:21:05 -0700 (PDT)
Received: by 10.205.82.78 with HTTP; Tue, 5 Jul 2011 14:21:05 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176626>

I have two boxes, one is my local machine and the other is my dev
server. Right now I'm testing this method of deploying apps using Git:
http://blog.wekeroad.com/2009/11/23/deploying-a-web-application-with-git-and-ftp

I setup my local repository, added the files then committed. I am on
Windows 7 & my server is Windows Server 2008.

The server is mapped as the W:\ Drive with my 'bare' repository and my
target 'mock' production folder as child folders. -- I can get to each
just fine, no connection problems.

Here's what I did to setup everything:

    Local dir git remote add origin w:\gitCentral

    Local dir git push origin master

    Type C:, then type CD testDeployment

    Now I'm in my test folder.

    A. I do git clone w:/gitCentral

    Cloning into gitCentral... done. error: refs/remotes/origin/master
does not point to a valid object! error: Trying to write ref
refs/heads/master with nonexistant object 559e2165845
06e14ebef1121059e9461a86dd4f8 fatal: Cannot update the ref 'HEAD'.
