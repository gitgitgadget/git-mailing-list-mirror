From: Jon Seymour <jon.seymour@gmail.com>
Subject: questions about git-mktree
Date: Sun, 10 May 2009 23:41:17 +1000
Message-ID: <2cfc40320905100641v3e8742c4v1d0e1091a730970b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Sun May 10 15:41:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M39HU-0006hM-0j
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 15:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762AbZEJNlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 09:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752509AbZEJNlS
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 09:41:18 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:44872 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335AbZEJNlS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 09:41:18 -0400
Received: by gxk10 with SMTP id 10so1661292gxk.13
        for <git@vger.kernel.org>; Sun, 10 May 2009 06:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=JXHENIyqS1bUc6hQqfyMIUa3qd4opKi6wFk3eb5g6X4=;
        b=OLeVAsi/c/RkxhpV8hxbNwiK1FBGZdzE7yngwDM5PRn9YKAMFctdeAOTRq0hga4BVN
         Fe5RlYoNh78uoVmKU9x/GJNJf+Ujh63ltCyCUSeRi10LAqXjckWZG4TgbFgKaiTZNeS8
         WH2yqaLIwx2H5PL9mrMd0U6n+VMxpupy0AOY4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=oWZ8IN+YSy5rJy2YZU53VD1UPpvgERAK0eMITAqF6LrxZ3BflDeR57EqwfNrGQdavp
         4XUJymouRFpwmtXvZu0EQY0o96L0ZCE+6OLdYMxnH4W/gDaUBrCfqx+p3Tk8R9sUECDX
         YxXbRdM/DznzLQn3BuDTla5U3NkFi8hyp5I6Q=
Received: by 10.151.135.3 with SMTP id m3mr10938461ybn.55.1241962877608; Sun, 
	10 May 2009 06:41:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118718>

Uwe,

Thanks for your explanation.

Does git-mktree normalize the sort order of the input or take it as it
is? I can see  a case for having it do normalization, if it doesn't
already and probably for this to be the default behaviour.

Also, I have a need for something like git-mktree that takes a
recursive git-lstree output as input.

Junio:  assuming these features don't exist already, are you open to
the idea of accepting patches that add them?

Regards,

jon.
