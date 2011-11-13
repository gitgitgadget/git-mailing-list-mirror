From: vinassa vinassa <vinassa.vinassa@gmail.com>
Subject: git behaviour question regarding SHA-1 and commits
Date: Sun, 13 Nov 2011 18:04:17 +0100
Message-ID: <CAJuRt+r9BjYcead6hgzdUT0Bisz1D48cegqkoJ0S537VMYBy_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 13 18:04:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPdU4-0003NV-QA
	for gcvg-git-2@lo.gmane.org; Sun, 13 Nov 2011 18:04:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753803Ab1KMREk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Nov 2011 12:04:40 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54878 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753432Ab1KMREj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2011 12:04:39 -0500
Received: by bke11 with SMTP id 11so5044010bke.19
        for <git@vger.kernel.org>; Sun, 13 Nov 2011 09:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        bh=+KfYf3MbJ3yn98lDEc9McAtvwKQx/Qajn64nAp++Qng=;
        b=g6KnyoMEkNslqThDRrF11VPx0GhvqgjtaW4wqKIqVAfF+EvQDpIedQwsW/rsYtdQmU
         NVwsQSEgxsoIsZPfyIv4hGaft7fp9z3L1XaG24vP+xx/J8XxDfnvscePxGh6kmJBTVEu
         NuALay5TJcmCyNyhjK1+kqaAfNwGZ3nNXTRmA=
Received: by 10.205.112.6 with SMTP id eq6mr16057170bkc.16.1321203878172; Sun,
 13 Nov 2011 09:04:38 -0800 (PST)
Received: by 10.223.97.67 with HTTP; Sun, 13 Nov 2011 09:04:17 -0800 (PST)
X-Google-Sender-Auth: azAYGgZs61lV53uVm28HLcpxoAU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185343>

Hello,

I am relatively new to git; I have only used it to track other git
projects, and sometimes to format and send patches to them, but never
to handle my own projects.

Now I am considering using git for my next task at work.

I am wondering about how git behaves currently, if I kinda win the
lottery of the universe, and happen to create a commit with a SHA-1
that is already the SHA-1 of another commit in the previous history.
However improbable.

Would that be detected, so that I could just add a newline, and then
commit with a different resulting SHA-1,
would I just lose one of those commits (hopefully the new one), would
I end up with a corrupted repository?

I found some mention of this in the archive, more about SHA-1 security
implications, that were dismissed, but here I am looking at just a
random, very unfortunate case, and just wondering if in this case I
would end up in a FUBAR situation.

Thank you,

Vinassa
