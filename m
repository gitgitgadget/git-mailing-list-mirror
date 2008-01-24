From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: stgit: premerge hooks and preventing errors
Date: Thu, 24 Jan 2008 15:32:40 -0500
Message-ID: <9e4733910801241232j58974193i5ec0a618376c2415@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 24 21:33:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI8l6-0000b6-AV
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 21:33:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754343AbYAXUcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 15:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754203AbYAXUcm
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 15:32:42 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:41875 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754169AbYAXUcl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 15:32:41 -0500
Received: by wa-out-1112.google.com with SMTP id v27so597741wah.23
        for <git@vger.kernel.org>; Thu, 24 Jan 2008 12:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=LYx1DgIn+/Pf4Pke+Me6LJTCNCvplvxSGkUp//hccfw=;
        b=jUWANl04+ENrZUzUArazFil8NxM3pR0y9LnPBcXm+UyEx4d7KSHO+rvkgWit+BjfO9JnIJyGUpz+8wLNnPVuDkUT97ykA2Fm8Kkw0AdSIdHmv95ffRnD49/stGQHbyMQXealj91+h+5p1wVlfiVn6ClN5InyTpq1xhJLQbsMDVc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=G3a4ZF0MNOf1kuu5fcliPgRlcCslLb/cMm2qtcmTcrUjCR65gJRHOQXmAs/GQdaj46nRuxBQ75WPRC2woz+uocyxYdTJMPdzAGaX6OIO90ux1cROntSSEDcckQp0zDDA3ScIISvc+/jglKDpWrqFKQ7QkxTQomdgo51FTi2ipog=
Received: by 10.114.80.4 with SMTP id d4mr1298710wab.44.1201206760751;
        Thu, 24 Jan 2008 12:32:40 -0800 (PST)
Received: by 10.114.93.14 with HTTP; Thu, 24 Jan 2008 12:32:40 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71659>

What's the status of using premerge hooks to stop git merge/pull from
messing up stgit? I just messed up another stgit tree by doing git
pull on it. I've learned how to fix this by rolling back the head, but
this mistake is way too easy to make.

Even though I'm aware that this mistake is possible and I'm still
making it. When you have a mix of git and stgit trees it is very easy
to forget which one you are on.

-- 
Jon Smirl
jonsmirl@gmail.com
