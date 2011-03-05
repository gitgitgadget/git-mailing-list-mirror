From: Lars Hjemli <hjemli@gmail.com>
Subject: [ANNOUNCE] CGIT 0.8.3.5
Date: Sat, 5 Mar 2011 14:43:14 +0100
Message-ID: <AANLkTi=QjgcYRqJ_dY1zjUfz1TQCQz9Eo5Wi2fEJJfWC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 05 14:43:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pvrlb-0005Y5-0T
	for gcvg-git-2@lo.gmane.org; Sat, 05 Mar 2011 14:43:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008Ab1CENnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2011 08:43:16 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:58745 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853Ab1CENnP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2011 08:43:15 -0500
Received: by vxi39 with SMTP id 39so2743365vxi.19
        for <git@vger.kernel.org>; Sat, 05 Mar 2011 05:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=Xbi8AN2xo4sbqM8UZU5g+BlEsSBVjQbJ55E5NFy9ALM=;
        b=Z5110RZOv/tIbtKvp2FHYrCJ59VnDmSTWQRtjDTAnEKhG2DheuTo5ogztkwR7zQ6gf
         0rRTwysBEV+6uKdAGTGDsi+cJrQEwsbe2Oat4QN8g0AafZXRUoPbkdL9r/t4rPyi+q0Y
         pogPrUhAFjzQsFfsIfwU/gJO469vXtwtHmDf0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=xVFtEPajZMVmFVp4Lj8LXJpg3Wdp4Zp3yi0JnJkoWamQv3y01Rd7V355b6lw8T5y1G
         5JlJrHZyN5YntKo7bHWKNrZBkh+i1h5SKjw6DQ1H0HJo4psjBp0VFldvnrTVQa8SpW6s
         6TZLl782N0uJ+BWDO+mLwsSeHQZaVOtfH5mcI=
Received: by 10.52.71.35 with SMTP id r3mr2582078vdu.232.1299332594218; Sat,
 05 Mar 2011 05:43:14 -0800 (PST)
Received: by 10.52.160.130 with HTTP; Sat, 5 Mar 2011 05:43:14 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168493>

A bugfix relase of cgit, a web interface to git repositories, is now
available at http://hjemli.net/git/cgit. This release removes a DoS
possibility, and as such is highly recommended (the fix is also
included in the latest master-branch in the same repo, which will
become cgit-0.9 today).

Thanks to everyone who contributed:

Bernhard Reutner-Fischer (1):
      ui-shared: silence warning

Dean Scarff (1):
      Use absolute path for scanned repo readme

Jim Meyering (1):
      do not infloop on a query ending in %XY, for invalid hex X or Y

Lars Hjemli (2):
      Avoid trailing slash in virtual-root
      CGIT 0.8.3.5

Lukas Fleischer (1):
      Makefile: Make `make get-git` work under OpenBSD.
