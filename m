From: Ramana Kumar <ramana.kumar@gmail.com>
Subject: svn propset
Date: Wed, 15 Sep 2010 11:00:21 +1000
Message-ID: <AANLkTikm8Cgo7uYWey18yWsbHB4xDaJod99itv1oXn3f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 15 03:00:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvgMk-0003gn-CY
	for gcvg-git-2@lo.gmane.org; Wed, 15 Sep 2010 03:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753562Ab0IOBAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Sep 2010 21:00:43 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:35395 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421Ab0IOBAm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Sep 2010 21:00:42 -0400
Received: by wyf22 with SMTP id 22so8056404wyf.19
        for <git@vger.kernel.org>; Tue, 14 Sep 2010 18:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=Xsep2iqVCgKOKoSaCoGe9VkbfFPcL01nwxgpTyIJVeg=;
        b=oMLekc8ryijSO50SIDQlINVYu5RhxECojUkS5ErTe1hJdb1WChJw8xThF5JxPQrwzG
         ZieOFx18zzWALyObsXsOmhSlAxv+1bHwHeLgyfC6s/b4arOOayvDfOxi7UiPuy79z8rg
         yPnkBUGVFok50lS0iRYmjEyxtBWqDt8aqxfbY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=G6Lm4tMtWG9rsE/m3P0SERcDaWNa12m+8gEO2ddE3TnJ5L474i0t/rFcHM8uKcmPXW
         K2miBL40rQFQ7zbJ5GefAwBT0CXgxr3aITrdHr7J1M7Kg4HuWZ5yBNvo6S/bo3x34cqC
         2lPp+MrXLaIHWpei1OBilXFCqEBvUzpf/h8yU=
Received: by 10.216.203.71 with SMTP id e49mr605710weo.60.1284512441248; Tue,
 14 Sep 2010 18:00:41 -0700 (PDT)
Received: by 10.216.25.9 with HTTP; Tue, 14 Sep 2010 18:00:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156220>

Whatever happened to manually setting properties with git svn?
I couldn't find any replies to David Fraser's patch
(http://marc.info/?l=git&m=125259772625008)

In line with the current special treatment of certain properties
(ignore, externals, and executable), perhaps we could have a command
just for setting svn:ignore appropriately. Automatically keeping the
svn:ignores in sync with .git/info/exclude would be _very_ helpful for
me, but I imagine that would be a lot of work to code up (and I
wouldn't want to do that, not knowing perl very well). Simply
extending the svn:ignore property manually on some paths would also be
quite helpful, and may be doable working from the patch above.

Is there any interest or further information from the list readers on this?
