From: Frank Li <lznuaa@gmail.com>
Subject: Possible git status problem at case insensitive file system
Date: Mon, 9 Aug 2010 12:22:47 +0800
Message-ID: <AANLkTi=87fUaOH3Y0PVeeH5N7oCVVJyKY3jsf93jw-t7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
X-From: git-owner@vger.kernel.org Mon Aug 09 06:23:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiJt0-0004G3-R1
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 06:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781Ab0HIEWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 00:22:50 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41542 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755Ab0HIEWt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 00:22:49 -0400
Received: by wyb39 with SMTP id 39so9508335wyb.19
        for <git@vger.kernel.org>; Sun, 08 Aug 2010 21:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=Gp6bFOdIz3JTaicaSkvHvt0KIML/leVEcITSaSrO9dQ=;
        b=qlMMEmZiXK8tcPve07xjt89BTNaswaFQ/GDvzNqzON2iFK03lMXAmcSqd9HtSqGKJd
         jSc4L7i0/m9DRanGtlE+ILWCu5J4Jd+t3+5iLPhtTBG8HsUuhqQ8evYkKc4C5RnLrakZ
         FmS+SAH/tCfMBCc6eVuH2NFdkh1+w3wxT/v2U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=GkEmdHhZ5NITkIOHHZQHcPM6AiqMc86QEukwkAGI6UA1u6Tw08Dbop2szT6Ml7ITR/
         927Gb1oFi6aUyWJhhg20tWLjSpVJzdmtSnmMKd3q0ynXZ/1aJU1VZY8cikve1xe2xr1h
         56f3XewnQSG2qmtfRi4NZ9g/ChAND/y3T9eH8=
Received: by 10.216.169.136 with SMTP id n8mr2160890wel.65.1281327767979; Sun,
 08 Aug 2010 21:22:47 -0700 (PDT)
Received: by 10.216.158.21 with HTTP; Sun, 8 Aug 2010 21:22:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152949>

All:
        I use msysgit 1.7.0.2 at windows xp.
        Problem: git status will list tracked directory as untracked dir.
        Duplicate:
        1. mkdir test, cd test
        2. git init-db
        3. mkdir d, cd d
        4. touch a.c
        5. git add a.c
        6. git commit -a -m "test"
        7. cd ..
        8.  mv d d1
        9.  mv d1 D
       10. git status


# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       D/
nothing added to commit but untracked files present (use "git add" to track)

        D/ should be same as d/ at case insensitive file system.
        D/ should not listed by git status.

best regards
Frank Li
