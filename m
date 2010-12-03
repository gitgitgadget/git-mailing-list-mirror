From: Patrick Doyle <wpdster@gmail.com>
Subject: How to "pre-populate" a git message
Date: Fri, 3 Dec 2010 12:51:52 -0500
Message-ID: <AANLkTim=dVxVLL31aEBrjw7OhXpdYOjAO9Sk16gGP3zJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 03 18:52:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POZnx-0003aX-Ik
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 18:52:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753489Ab0LCRwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 12:52:14 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44433 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224Ab0LCRwN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 12:52:13 -0500
Received: by fxm20 with SMTP id 20so2439194fxm.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 09:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=athmr559UsTJlzjIke0RMgoyI4TIhFsD/ZcB2HhEY40=;
        b=wmeWayV5AFMO2uW/314ZQSlV18Ym3U7X/7aCcbHVfJtFpr47e32NJEBRsmuEKG5kP9
         eIlQ86VYMKuBMfzNRr6kDvSMbFUW4UJ8KaB4FS1+Rd3KazMVRdhNR/6oSzoViiSMZ8LK
         va3TZkrIy7aD0PgkxjLEqr+RGl8rReH9wHNnY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=KjkcpF0F3K65Ve5SM+eV7krlLEzYEM+EX7G2rOKs7qcp90SJsCjA6pV0/JLaXI/QBF
         HtKX8RP5IIXG0jWw5Z7+93tLHecRdzFQW2Ke9i8P3iXqCj86Gddru2FTjIJq0amZ7Ddx
         eSyUdoDlxW3lhm3E2jnuqqLRBoOIUNE2S+x9E=
Received: by 10.223.72.198 with SMTP id n6mr2437657faj.125.1291398732739; Fri,
 03 Dec 2010 09:52:12 -0800 (PST)
Received: by 10.223.115.17 with HTTP; Fri, 3 Dec 2010 09:51:52 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162818>

Once in a while, I would like to run some scripts that will
automatically generate some files that I keep maintained in my
repository.  (Yes, I know that I shouldn't have to keep them version
controlled if I can regenerate them, but it's easier to check out old
versions of the files than it is to check out old versions of the
repository, wait 1/2 hour to regenerate the files, and then look at
them).

I also like to review the files before they get committed.

Is there any way I can "pre-populate" the commit message so that I can
run my "regenerate" command, review the differences, and then commit
the changes with my prewritten message?

--wpd
