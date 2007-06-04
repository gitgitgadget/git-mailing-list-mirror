From: "Pelle Svensson" <pelle2004@gmail.com>
Subject: Git pull/merge question
Date: Mon, 4 Jun 2007 14:51:06 +0200
Message-ID: <6bb9c1030706040551l12a867f2r2788805afaf6104d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 04 14:51:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvC1i-0006oA-3K
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 14:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249AbXFDMvJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 08:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751976AbXFDMvJ
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 08:51:09 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:53214 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352AbXFDMvI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 08:51:08 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1776748wah
        for <git@vger.kernel.org>; Mon, 04 Jun 2007 05:51:06 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=DT0HsYn8WW4ntzZRA2AS+7AmOeLqUETGCCcWjzG25HfJORucFJKrdyOyhHfMsuXwd6a4VyADSJ/pl40AYO17R2nGDIULS5FnRIl9J/tZ7FMcwHFOiyaZ07CDZGYezt7Gtxubh/NNg8w5FcqonTKgyI7+G1wFKGQWgC5q3jA8Tbo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=IB+aWQMle1kZ3hR+xBUMKxPzjqZB1UDBqvTubDp3MqtldsmhHJB13RKOQvNC+8LtBaTFjPwzVkWMXQmnKUj5NbLAp6LkBxBJnp4w/8W/lOJIcL8KpLWYZchpU5kzAcJ/iT4DV2UQ72BkhLZbcc+NlwWT1dR5WQQHveYntfBdwRE=
Received: by 10.115.92.2 with SMTP id u2mr4734296wal.1180961466116;
        Mon, 04 Jun 2007 05:51:06 -0700 (PDT)
Received: by 10.114.37.11 with HTTP; Mon, 4 Jun 2007 05:51:06 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49098>

Hi,

I used to pull using version 1.4.x from Linus tree but with version
1.5.x I can't get
it upp and running in the same way.

git-pull complains about:
'No merge candidate founde because value of config option" branch.my.merge
I tried git-config --add ... with orgin and master but no luck.

I also seems to be stuck on version 2.6.21 on my branch. First pull
picked up a lot of changes but did no merge it into my tree.
What should I do to get git-pull working and at the same time merge
the stuff and roll my branch forward to the latest version?

git-pull  -> Warns about merge candidate
git-pull . master -> Says up to date
git-status -> Only list 3 files not commited due to changes I did.

/Pelle
