From: Victor Engmark <victor.engmark@gmail.com>
Subject: git-gui Ctrl-U (unstage) broken
Date: Fri, 27 Jan 2012 15:03:03 +0100
Message-ID: <CAA5Ydx-mi7i7mWDYO=Cbw4g1b7LR0hw4Tcqe9gMtBoCkDRuvYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 27 15:03:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqmOW-0007AQ-Kw
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 15:03:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755192Ab2A0ODH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jan 2012 09:03:07 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58726 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408Ab2A0ODE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2012 09:03:04 -0500
Received: by bkas6 with SMTP id s6so1403560bka.19
        for <git@vger.kernel.org>; Fri, 27 Jan 2012 06:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=CGr9+cIeZk9I5gqLGTOgU25rXbXhQmUH7LumX3i/xQY=;
        b=eDQ//QItlm+5lDYTu2yFcWX8sMHj/iT7m0xvpTMV0JJEgTqh3gujE7VmDjw99e8bO6
         blef9FTr6/2ckaRI9n7wAJjDV9/afY2kV2OMI4Y42EOhMzU3H2g/QInXz7CHn2A+qRFM
         3LYW3dFtTv+IHwf4Ky0aHz3CnMdMYyrQeSpL4=
Received: by 10.205.137.14 with SMTP id im14mr30148bkc.133.1327672983167; Fri,
 27 Jan 2012 06:03:03 -0800 (PST)
Received: by 10.204.167.1 with HTTP; Fri, 27 Jan 2012 06:03:03 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189221>

Using the git-gui available with the default Ubuntu 10.10 repos, I'm
not able to unstage files with the default keyboard shortcut. To
reproduce:
1. Change a file in the repository
2. Run `git gui`
3. Stage the changed file
4. Select the changed file in the "Staged Changes (Will Commit)" list
5. Click Ctrl-U

Expected outcome: The selected file should be unstaged.

Actual outcome: Nothing at all changes in the GUI.

Verified that other keyboard shortcuts work: Ctrl-T, Ctrl-I, Ctrl--,
Ctrl-+, F5. These (except Ctrl-T, obviously) were tested in* both the
"Unstaged Changes" and "Staged Changes (Will Commit)" listsp

* That is, after focusing a single element in that list.

Version info:

git-gui version 0.12.0.64.g89d6
git version 1.7.1

Tcl/Tk version 8.5.8
Aspell 0.60.6, en_US

Cheers,
V
