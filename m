From: Aubrey <aubreylee@gmail.com>
Subject: Newbie question: git tag failure
Date: Thu, 2 Mar 2006 23:51:04 +0800
Message-ID: <6d6a94c50603020751v4bb96b75q1686d36b32e2c40f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Mar 02 16:52:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEq58-0008Qp-Dh
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 16:51:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbWCBPvH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 10:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbWCBPvG
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 10:51:06 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:24892 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751547AbWCBPvF convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 10:51:05 -0500
Received: by zproxy.gmail.com with SMTP id 13so456288nzp
        for <git@vger.kernel.org>; Thu, 02 Mar 2006 07:51:04 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=jhGfSpVlY3wYaocUcIF2S0oaLHyxOofaO6FU8GVRMsCzjJX9yIgGAAKtK/hiRYoP6M0+ccnyvFtiw0RXERhNr9xniF1uxWoiNPVv7ZVxcP1hnoJ5OaYQ/2eiFQ8xYu0txuoPbsiTi5uXpL3IHZEmGZmENPzE1BTotUpnCkeEO5Q=
Received: by 10.65.148.14 with SMTP id a14mr748637qbo;
        Thu, 02 Mar 2006 07:51:04 -0800 (PST)
Received: by 10.65.185.6 with HTTP; Thu, 2 Mar 2006 07:51:04 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17082>

There are two commit. I want to tag one commit by commit id, but failed.
Thanks for any hints.

Regards,
-Aubrey

aubrey@linux:~/local/mygit> git log
===============================================================
commit a8ac6540cf96f79225cc8457b02cb90d40ac7991
Author: Aubrey.Li <aubrey@linux.site>
Date:   Thu Mar 2 23:34:18 2006 +0800

    add commit log

commit 43368b967bd838292b8cc6b576c5aa13850551cc
Author: Aubrey.Li <aubrey@linux.site>
Date:   Thu Mar 2 22:24:55 2006 +0800

    Initial commit
===============================================================
aubrey@linux:~/local/mygit>git tag -u
43368b967bd838292b8cc6b576c5aa13850551cc v2.5
gpg: directory `/home/aubrey/.gnupg' created
gpg: new configuration file `/home/aubrey/.gnupg/gpg.conf' created
gpg: WARNING: options in `/home/aubrey/.gnupg/gpg.conf' are not yet
active during this run
gpg: keyring `/home/aubrey/.gnupg/secring.gpg' created
gpg: keyring `/home/aubrey/.gnupg/pubring.gpg' created
gpg: skipped "43368b967bd838292b8cc6b576c5aa13850551cc": secret key
not available
gpg: signing failed: secret key not available
failed to sign the tag with GPG.
