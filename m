From: Zachary Rodriguez <zmrodriguez91@gmail.com>
Subject: Git clone from ftp issue
Date: Sun, 17 Nov 2013 13:22:40 -0700
Message-ID: <CAFVLdUm=Jz5t=f+tZvDKGWAFoGi40oV_aLb_qoxrsreTrGTK=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 17 21:22:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vi8rm-0003eo-RV
	for gcvg-git-2@plane.gmane.org; Sun, 17 Nov 2013 21:22:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754078Ab3KQUWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Nov 2013 15:22:42 -0500
Received: from mail-vc0-f169.google.com ([209.85.220.169]:48759 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754015Ab3KQUWl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Nov 2013 15:22:41 -0500
Received: by mail-vc0-f169.google.com with SMTP id hu8so3082837vcb.14
        for <git@vger.kernel.org>; Sun, 17 Nov 2013 12:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=PgiFB9106gLF9kOKmSpdqDup0gIfBUm781VHbqGWmEk=;
        b=0kl3EsYB2ILKIwI1aDHVeLk8BQrOJjxOjYw8RdISirJeaKETQtRHvh6GlZZJJaBBCX
         i9Vbnb09TJU/1yn+7UP4lFO7mQDH56m9pgbUB0XwhoPip3hNL4gULjWh50okM/s40ynm
         Gj4E67szMozQY/py4DO/zxlQRuDnfL/p0+2VvKXUkU12j4LDVboMhCSYz1sKOPitKZZu
         V+8nT9lkVGzEeoP226UeOxBFZrdSpl5/OMEvz+SR7d7G5ctS5vuBeb7Aqnk9e3ezJdYz
         OVvputmLH4/+gkYs3H65n9zs3eDfBCgrWxg14nMJOEvN2c8QKJPOa7zYPMDLsdRG65Yr
         cktg==
X-Received: by 10.52.28.6 with SMTP id x6mr9603383vdg.3.1384719760198; Sun, 17
 Nov 2013 12:22:40 -0800 (PST)
Received: by 10.58.220.135 with HTTP; Sun, 17 Nov 2013 12:22:40 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237961>

Hello. I am having trouble setting up a git repository on an ftp
server. The repository is bare and has had several commits made before
being moved to the ftp server. I am attempting to clone from my ftp
server, but git fails with the ftp error code 550. Inspection of the
ftp packets via wireshark reveals that git is successfully changing to
its desired working directory on the ftp server, but then it attempts
to execute the 'size' command on the refs directory which generates
the error code 550. Is this normal behavior or is it a bug?
