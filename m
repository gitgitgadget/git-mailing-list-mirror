From: Tyler Freeman <shkkmo@gmail.com>
Subject: Changing filename case causes inability to merge branch on OSX
Date: Thu, 14 Jan 2016 14:04:16 -0800
Message-ID: <CANOVqrZmeD7+yoGVNfsL8W2pM2iWurxRo_1umQnu+-LkRb4Vmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 23:04:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJq0l-0000ul-Bw
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 23:04:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754755AbcANWEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 17:04:46 -0500
Received: from mail-oi0-f46.google.com ([209.85.218.46]:35590 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbcANWEq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 17:04:46 -0500
Received: by mail-oi0-f46.google.com with SMTP id p187so106413825oia.2
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 14:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=8yom4EqycT7pjLlvxnSJcD7vL2AF86yG/c6WhZju3rg=;
        b=Vu8wCkSomKKdmIun2xMOi+LDr0STGQiOAMPMpEiH/4dvdVk3XChyE7vmEVM1NV2Hw9
         PUYEx75bz3wIqHG1or88+nKcMKGNem2CMvDcYPorSyS/69N4TY8/FXdLZiCQ8tDZ1eAf
         Xn/pCZStclOvTwV5otJ2ax2TozKqdvXtr62YWUjlPex1uk2I+zwLr/P1vsOdrdrhWEWm
         ouytdtkkz4gH42/ORjd1+j6GqkhYM30fHkh+Oq+oiC0LEd940OLwtWcanKwnx8tZa7Ry
         oiRnW8CS8ytk1z6OoUFcBXbBmwsRxYab1Mf5UbJdiE65pOuiOqTD+K4SMdZ4Fb6k0GPO
         8kiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=8yom4EqycT7pjLlvxnSJcD7vL2AF86yG/c6WhZju3rg=;
        b=jBLnMf+MFk7d6qOaOhx4bQDbiiAaNZwQ5jDPh2YXddlitv2AlVWpmGgzcO32IUF+pp
         K5jcZeZRAuMrox2XnHVJsgW5BIqIABau0gfWNIPI1MMEFRaPRYZeAZtgAE7HdMo/9gqz
         Qw1VcfvELrU624oAxq7kEHEQU2K9bM7ypVLTRP8AEarqmtKIeoJqpsCI+b93RwjWbng6
         GmS0cyvhwBrlLB0N7jw1+52+MzT4qDc7To50D8bnA+u7aUbip5HvRwHy9tHAk0mixPQU
         26oBnehtQk5BYuDNB6u/LkaiM0fByWCeRS4ZjId1nA0d59+2MFWAIzwB+lL6EFrKf7MY
         5/uQ==
X-Gm-Message-State: ALoCoQm5y0aMO3j0eOZnXJwKx8m85Z0Dgp0p5ZZNL96RcO7XUEE7HA91tah1B8T8j8rGbzp4dldpQ0fWGwozb2yw4TCMHyv9Lw==
X-Received: by 10.202.73.69 with SMTP id w66mr5088647oia.85.1452809085596;
 Thu, 14 Jan 2016 14:04:45 -0800 (PST)
Received: by 10.76.169.163 with HTTP; Thu, 14 Jan 2016 14:04:16 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284098>

Hi,

I am struggling with changing the case of a filename on OSX:

http://stackoverflow.com/questions/34799472/how-to-correctly-change-filename-case-in-git-on-osx

I found this thread which seems related, but don't seem to see any resolution:

http://thread.gmane.org/gmane.comp.version-control.git/188469

Let me know if there is any additional information that I can provide
or if there is a known way to change the case of the filename without
breaking the ability to merge branches that contain that change.

Thanks,
Tyler
