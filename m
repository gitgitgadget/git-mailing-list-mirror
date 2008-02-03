From: "Guilhem Bonnefille" <guilhem.bonnefille@gmail.com>
Subject: Tips for different workflows/use cases
Date: Sun, 3 Feb 2008 16:08:07 +0100
Message-ID: <8b65902a0802030708i204d1714od850a59d9d25d0c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 03 16:08:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLgSY-0001ZX-Hv
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 16:08:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbYBCPIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 10:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751832AbYBCPIJ
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 10:08:09 -0500
Received: from an-out-0708.google.com ([209.85.132.241]:48211 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbYBCPII (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 10:08:08 -0500
Received: by an-out-0708.google.com with SMTP id d31so436929and.103
        for <git@vger.kernel.org>; Sun, 03 Feb 2008 07:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=s6BVGqUl93W7ud7pPfKO8efwMkDRPGTuyDETNFqACCE=;
        b=Hgy1RD1dx7YZpAzIw3nyr9sYBvtTJLIHD3K2OMxYtJQINv9LMKIJXhjSut8uXHw7Iuj0ohr7iUkT+6mcX2cwih0iMBrSeibO1kXa6Fxc9D7Fktnf5dR4KbKnIrxDcVKi4gLCAmzVk/GYl0GmWcCx4CTw5g3aoEmxMBO9w6WVYwc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=WgrZYBgthfugeITU/Ii7ndyFFZMBzdcAzAfPEiUQsCxk1u27gr4Ahb9w/gxQpiIuAqXfnqpm0Y37lsBOgzGL0wc9hNGoeT8dnYy8jHJN2Aq0lnxRuKlY6IegPlnZkzR1AHWfRw+dFQrke3CUIRPabW/pvK13/UOImAzeHqL+0hY=
Received: by 10.100.249.9 with SMTP id w9mr12677727anh.105.1202051287137;
        Sun, 03 Feb 2008 07:08:07 -0800 (PST)
Received: by 10.100.247.15 with HTTP; Sun, 3 Feb 2008 07:08:07 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72359>

Hi,

<my_life>
Up to recently, I used Git as a frontend to many SVN repo. The
workflow is simple: a central SVN and a single "client" desktop.
Now, I started to use Git at office. So I "discover" new problems and
my actual experience is not enougth.
</my_life>

Actually, I discovered two(/three) use cases for which I'm looking the
best (recommended) workflows. My idea is to identify the best
practices to avoid (as possible) complex situations.
1- The same developer uses two repo on two network connected computers.
For any reason, a developer has to work on two computers for the same
project. He sometimes hack on both computers. He uses two git
repositories to keep it work in sync. Note: the two computers are
connected, and the developer can pull/push via ssh.
So, what is the best practices:
- should he decide to push/pull every time from the same repo or
should he only use the "pull" command on each repo (and never push)
- should he decide to create a third repo and use it as central repo.

2- It's a variation of the previous one. Now, one of the two computers
is a laptop. Is there any recommended practices to work with laptop?

3- Now, the two computer are not connected via network. Two possible
solutions to sync our both computers: USB disk and e-mail.
Any recommendation in this context?


I think that such recommendations must be shared on the wiki, for
example on GitWorkflows or GitFaq pages.
-- 
Guilhem BONNEFILLE
-=- #UIN: 15146515 JID: guyou@im.apinc.org MSN: guilhem_bonnefille@hotmail.com
-=- mailto:guilhem.bonnefille@gmail.com
-=- http://nathguil.free.fr/
