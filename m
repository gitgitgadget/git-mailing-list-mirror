From: Thiago Farina <tfransosi@gmail.com>
Subject: git 'new' alias
Date: Thu, 1 Sep 2011 16:30:16 -0300
Message-ID: <CACnwZYfo2E0SFfFrYzUktAZYwqgyX_J4KgFQD5kqXToGmip3Lg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 01 21:30:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzCy0-0003VK-Ey
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 21:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757572Ab1IATaS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 15:30:18 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54540 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756087Ab1IATaR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 15:30:17 -0400
Received: by yxj19 with SMTP id 19so629375yxj.19
        for <git@vger.kernel.org>; Thu, 01 Sep 2011 12:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Q3hll1sJhxG0tWrkvpYkOetacW9TW4Tg4WrMZOwrmUo=;
        b=UFpmaPUZXwcq1g/2rn5n7wV6UaY+AuBb34bgMQa695Y4JohyNLEPdRePZn9Ht3KQJK
         MOpsvN7Km8Ersd9aX5xLL4H6RD1GDLbAkneLTtmmW/3pyOuWDWLra5gcGd8qwWhJ4qFZ
         ibaCriyZy9kGpYii7PBq+4UmxSIdoBJZPvyJc=
Received: by 10.150.131.3 with SMTP id e3mr377636ybd.432.1314905417006; Thu,
 01 Sep 2011 12:30:17 -0700 (PDT)
Received: by 10.150.135.17 with HTTP; Thu, 1 Sep 2011 12:30:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180566>

Hi,

Could we change the 'new' alias in the wiki page,

from:
new = !sh -c 'git log $1@{1}..$1@{0} "$@"'

to:
new = !git log $1@{1}..$1@{0} "$@"

?

The former doesn't get auto-completion, while the second yes.

https://git.wiki.kernel.org/index.php/Aliases#What.27s_new.3F
