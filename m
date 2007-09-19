From: "Jason Sewall" <jasonsewall@gmail.com>
Subject: Repository backups
Date: Wed, 19 Sep 2007 11:14:43 -0400
Message-ID: <31e9dd080709190814t6ef8b725w8a8320685e70578b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 19 17:16:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IY1GL-0000lZ-IC
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 17:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755564AbXISPOp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 11:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754560AbXISPOo
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 11:14:44 -0400
Received: from wx-out-0506.google.com ([66.249.82.232]:51100 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755263AbXISPOo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 11:14:44 -0400
Received: by wx-out-0506.google.com with SMTP id h31so178986wxd
        for <git@vger.kernel.org>; Wed, 19 Sep 2007 08:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=PP8hMVA7bWIfIDb3+zO/EWqtlH7Uti3M/Su6izNhGmI=;
        b=r2B9jkNLTbhem08IgkjMxyOCxXDB0oj6cd0ToSGYo7mZByvJrNAXjM1enCwgzHeqibw9Q3quVQkTarmLTJx0IBEyi/eJkkokhKKtN217gGm4g/+kSfRWPY6GVz3beTd60DWjSefraVh+v/yEu43xyOxUdOSOjfNL4TIZ3L12RoE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=a8b581XozU7v5pIKL7ic7Qa/h1nar5U7sf2DWDGCX4y9ATEpPw3tfr1As688ZuLkiSoJhdpS6Sty6YunYbAIXT74+EJK4bXhGx9TSE6SBRW9eeCrLkCe+D/TtkcFgX6DK8XVNSWoI4bjNUcdcVXWKSkfr4YIf4b+9fnjE2lQnVk=
Received: by 10.90.100.2 with SMTP id x2mr681697agb.1190214883482;
        Wed, 19 Sep 2007 08:14:43 -0700 (PDT)
Received: by 10.90.36.19 with HTTP; Wed, 19 Sep 2007 08:14:43 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58713>

I'd like to build a modest safety net for my various git repositories
in case of catastrophic failure. Currently, everything is backed up on
machines in the same building. I'm not expecting the Computer Science
building to get hit by terrorists and we're in a seismically stable
place, but there *is* construction nearby...

Anyway, my university offers a "mass storage" tape-based service that
is supposedly very safe. We are encouraged to give them single big
files for backups.

The temptation to just make bundles of all branch heads is great but
probably not what I really want - things like reflogs don't get handed
off with those, if I understand correctly.

Is there any argument against just making a tar of a bare clone of the
repo? Any other ideas? I'm reluctant to actually clone into the tape
(SAM-FS, which I know nothing about) because of the number of files it
would create and the lack of git tools on the machines with access to
this machine.

Thanks,
Jason
