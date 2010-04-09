From: Aghiles <aghilesk@gmail.com>
Subject: potential improvement to 'git log' with a range
Date: Fri, 9 Apr 2010 19:24:30 -0400
Message-ID: <w2j3abd05a91004091624mb2836ff4v118a1ae9ac5ca6e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 10 01:24:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0NZI-0003zf-Ey
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 01:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754283Ab0DIXYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 19:24:52 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:61298 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243Ab0DIXYv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 19:24:51 -0400
Received: by wwi17 with SMTP id 17so1188277wwi.19
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 16:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:received
         :message-id:subject:to:content-type;
        bh=Zbjfhej8TzRJ4gne+n3G8MVagRi6nyDrjoG2edC9phI=;
        b=KbseF46zvrWAeNLZ6325RHjgTxyWM4ZcTKCxdNpAfwK7Qtul43UiFqgEqHzoHwZ1dK
         8Ov3eOtJeNrU3jc1vEJ5D10g6mMeMyFIIOGnCIxIfXw5juAfRU8bYE1yHtvfp+s70SHQ
         +tDHvFcdcXW83Njg7kiWE/ikMlcgn+mo0lrkw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=cjmhN7px7UktoSJmlFo+nf9yFd5HrrKj8EllqaNBjNqjqpkgAmSV+HUGycl5Pmg7GV
         l9YMp6riCk/qpCfObrURB1dPewBLP0aq85I0EUWZfBhpBrkgEb7zRyhGK8i/FvSu+ldW
         TKFOissB6qVgiu1b3LnL3oT86x0tTLnZdTPh0=
Received: by 10.216.170.8 with HTTP; Fri, 9 Apr 2010 16:24:30 -0700 (PDT)
Received: by 10.216.156.209 with SMTP id m59mr430186wek.105.1270855490242; 
	Fri, 09 Apr 2010 16:24:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144485>

If I type:

    git log FETCH_HEAD~4..HEAD

I get something. But if I type:

    git log HEAD..FETCH_HEAD~4

I get nothing. Is there a good reason for that ?

  -- aghiles
