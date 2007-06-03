From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [ANNOUNCE] qgit new "smart browsing" feature
Date: Sun, 3 Jun 2007 22:39:51 +0200
Message-ID: <e5bfff550706031339v5ffda0a6u6f520f0c7b49f442@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 03 22:40:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Huwro-00087u-CR
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 22:40:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbXFCUjy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 16:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbXFCUjy
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 16:39:54 -0400
Received: from nz-out-0506.google.com ([64.233.162.231]:4074 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbXFCUjx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 16:39:53 -0400
Received: by nz-out-0506.google.com with SMTP id n1so823015nzf
        for <git@vger.kernel.org>; Sun, 03 Jun 2007 13:39:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mq4ypXvJjRX0w8sEQijGscT62cCGBzjqmaur2ftJ/96N8tKyG+nLCh90ztmeOPEe7s3Y7rOoUVcQB6xLQZGfvYuyqERtunICNq2UdvovWPR8ch3VFi3h+O5eYYb/MdIOCdEqoKevhcem3zocFy3yIklXpyGeBjzY7LkKinW5q54=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ccI5LZJTca+I08GKcUowzVOXYg7plqP66NCNXf+vzsGx4isMOkntV96CFMnAeiZFiIh8giw5tk63JtlkwmWyN+kHprpF3T0mDUjrd+x3Z8qF5M1O1XiRFHr0MF3YA8SEB57qpEOl9i1+cLAkw+CY78J37KxzFH8FA9UjXg9Bj/o=
Received: by 10.114.60.19 with SMTP id i19mr4041422waa.1180903191213;
        Sun, 03 Jun 2007 13:39:51 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Sun, 3 Jun 2007 13:39:51 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49034>

I've pushed a patch series to
git://git.kernel.org/pub/scm/qgit/qgit4.git that implement a new and
much improved way to browse a repo.

What
-------

- Possibility to switch from revision message to diff content in
bottom left pane of main view

- Possibility to jump to next/previous revision with link labels at
the pane corners

- Optional use of mouse wheel to perform all of the above actions


How
------

In the bottom left pane two labels have been added. Both contain some
links, a default one (big) and a secondary one (small), mouse wheel
action performs the default link action when scrolled out, above or
below the content view.

Links could be switched right clicking on them by the means of a popup
context menu.

Finally in Edit->settings menu a check box called 'Show always
revision message as first' has been added. When checked (suggested),
on jumping to a new revision the log message is shown first,
regardless of the previous pane content.


Notes
--------

Care has been taken to allow the wheel browsing experience to be as
natural as possible, in particular a way to avoid to switch when user
just wants to scroll has been implemented. Also, getting a responsive
scroll and switch command avoiding false positives was not immediate.

I have found, to my surprise, that more the natural behaviour was
obtained more the code amount was big. At the end a quite not trivial
class has been added just to let the user browsing without thinking on
how to do it.

Hope you enjoy it. Of course feedback is, a always, welcomed.


Marco
