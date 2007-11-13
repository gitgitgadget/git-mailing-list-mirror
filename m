From: "shunichi fuji" <palglowr@gmail.com>
Subject: git-clean won't read global ignore
Date: Wed, 14 Nov 2007 06:49:00 +0900
Message-ID: <30046e3b0711131349h51d253d5n4e5649bde36dc36f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 13 22:49:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is3dg-00075T-4w
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 22:49:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760800AbXKMVtH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 16:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760716AbXKMVtG
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 16:49:06 -0500
Received: from mu-out-0910.google.com ([209.85.134.186]:45458 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760679AbXKMVtD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 16:49:03 -0500
Received: by mu-out-0910.google.com with SMTP id i10so1948377mue
        for <git@vger.kernel.org>; Tue, 13 Nov 2007 13:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=UvsvJ9IwLiEBp6AowzvmhiwT/gMAUdLYjzVdo0//45A=;
        b=IyUZBtRuEVRHWUlsH6PAJnNb+GdlhjQSd5C5N1FOHQb9sIjJQAuPFMd3y/xctNb35UGTkbrBOOQeIoiCE2Fn/H2w//G8x+EoP92fz+JjSRbNH5RtyOn6JF7uEpd44tPDN3MUmIhUmixwmB3q8s/w32xQgKK1j9rzOMIoyg6szMo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=GyRJlegkIFfv7wecdCePZ1ehY1q+mH4HAGEtbPMvCL+hyheNj564SswBsy3FtqTM59TCzwNfTjoKIO/zStacUispkg16piOyhmhM+zu7d6zcHrqmjbSdCSzh8lLB6Aaod5wa/EgqUSUk95QaIZGBdqmfJynnFqWVOw2gnpYguGg=
Received: by 10.86.50.8 with SMTP id x8mr6194536fgx.1194990540998;
        Tue, 13 Nov 2007 13:49:00 -0800 (PST)
Received: by 10.86.51.7 with HTTP; Tue, 13 Nov 2007 13:49:00 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64883>

hi, i setup git to use with eclipse through global excludesfile config.
git-status report just ignore files, but git-clean deleted ignore files.

----
$ git-config -l
core.excludesfile=/home/pal/.gitignore

$ cat /home/pal/.gitignore
# ignore for eclipse
.project
.cproject

 $ git-status
# On branch master
nothing to commit (working directory clean)

$ git-clean
Removing .project
