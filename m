From: Mathieu Malaterre <mathieu.malaterre@gmail.com>
Subject: duplicate commits after git rebase -i HEAD~10
Date: Fri, 3 Dec 2010 16:04:53 +0100
Message-ID: <AANLkTi=W9MyCuOuk49AtCxR7nTa5xkddY_2HkhOvQip-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 03 16:05:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POXCO-0002wR-OZ
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 16:05:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807Ab0LCPFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 10:05:17 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33106 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837Ab0LCPFP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 10:05:15 -0500
Received: by bwz15 with SMTP id 15so8410195bwz.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 07:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=r5ixcZ6wLHUGVMmteNFO59kSxLb6/mHR2NpOPpqUmAk=;
        b=E00Qd4cOIftj5SJUjcbFu/tmN3SVTMe7j0Kwo12EJhC3dIypTX/jvbPbH1hAwSXQgD
         i7sk82iSSKjXM1Py8eVhAm+96gLiRZ2TFp4SyGVrvxoE2NwXbkNQFnuDIFdCvY433BHg
         FLxeohSq5+fQ3aMA5q80l9HapXp7Bio7MsBfs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=Vw3Sb9KFHQnGaX+Mpcf1g3uMOIO/EOHRnQMNpniVrUPVKoe1II+/jhmPUsEL02rwRT
         HxQXhJ5T90S6Zvf9/2chXKFtoUor7w345N0TVMfNiGPeNni87VVYOJLV5SmgpbQCrX8y
         mTfdMju8+IOxFeGQL/NG53+4lJZOEXqW9UqmY=
Received: by 10.204.118.207 with SMTP id w15mr2429803bkq.197.1291388714563;
 Fri, 03 Dec 2010 07:05:14 -0800 (PST)
Received: by 10.204.123.204 with HTTP; Fri, 3 Dec 2010 07:04:53 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162804>

Hi,

  I am trying to understand what I did wrong in my git rebase and
eventually I would like to repair my mistakes. Basically after a git
rebase, I ended up with duplicate *identical* commits. One was on the
master branch and one was on a local branch which was merge to master.

$ git log --graph
...
| * commit 662be6a57a6a64840ba0f1b29d422ab6b129ff04
| | Author:
| | Date:   Fri Dec 3 15:27:10 2010 +0100
| |
| |     BUG: 122 Work toward a better framework for Java wrapping testing
| |
* | commit 1f639b9fd6c04eb48a69d84749bb30d7dd816382
| | Author:
| | Date:   Fri Dec 3 15:42:16 2010 +0100
| |
| |     BUG: 122 Work toward a better framework for Java wrapping testing
| |

Is there a way to properly merge identical commit back together ?

Thanks !

-- 
Mathieu
