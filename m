From: Patrick Grimard <pgrimard@gmail.com>
Subject: delete remote branches
Date: Tue, 8 Dec 2009 15:35:27 -0500
Message-ID: <9cdb17250912081235m2b061ca5x70fe42749b49670f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 08 21:35:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI6mU-0008M9-IJ
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 21:35:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966034AbZLHUfX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 15:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936949AbZLHUfW
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 15:35:22 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:53534 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936711AbZLHUfV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 15:35:21 -0500
Received: by fxm5 with SMTP id 5so6699194fxm.28
        for <git@vger.kernel.org>; Tue, 08 Dec 2009 12:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=9iicqkYfeE4KEBESYWm2CZ6wWD1SFPBMHX2Epl3c/+w=;
        b=ZRFJ4KIySGDy0Rv3CJcSAhWUOrJdA6bHGIxXBWC8VX2x0xCYQEH4eCWoZvVISl05Si
         sNTwPdPg5/oe+BhUba4mJnEi71VkRdPBqX9WHhP59EchbdrWV4HMykVnTRc6YU033KzU
         iwP9h8NBkBTdSr0fyLa/+HY/wbKV+iZ9IGcKk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=T8MZJTqKp2SYDb4FHmcRDxWpv1aJKe+CkZb4qGa6WIgk6pt9k1wBigxLr7yM4Ck4kx
         R2RL7AJbCrb+fxESpOINBYGuXmbmM9tpq6/vGjZ9l8piK5SVElnadmWMoS4W+xItg/mw
         BQYAs/vQRzQcmAMZpLSwa4nBH+RId01O8+tMY=
Received: by 10.223.4.144 with SMTP id 16mr1323557far.36.1260304527509; Tue, 
	08 Dec 2009 12:35:27 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134911>

I'm experimenting with Git, just trying to get a feel for it.  I
created a bare git repo on a server and pushed a local git repo (let's
call it DIR1) from my PC to the server.  Then from another directory
on my local PC (let's call it DIR2), I cloned the repo on the server
and checked out a new branch named testBranch.  Did some playing with
branches to see how they worked, like pushing the branch to the server
from DIR2 and fetching it from DIR1, merging it into master and then
pushing master back to the server.  Now from DIR2, I fetched master
from the server, merged in the changes and deleted the remote branch
called testBranch using the command "git push origin :testBranch"
which seemed to work fine since the command "git branch -r" no longer
lists the remote branch.  However from DIR1 if I do "git branch -r" I
still see the remote branch and can't seem to delete it using the
above method.  Any idea why this is happening?

Thanks in advance.

Patrick
