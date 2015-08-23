From: Anish Athalye <anish.athalye@gmail.com>
Subject: git-remote-helper behavior on Windows, not recognizing blank line as terminator
Date: Sun, 23 Aug 2015 11:40:17 -0700
Message-ID: <CAFQ6zU1bdUwn+P3=1v2DoyVubMFz29ZuxHmnZ0pfezA-0MB+mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 23 20:40:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTaBu-0006kB-8H
	for gcvg-git-2@plane.gmane.org; Sun, 23 Aug 2015 20:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752728AbbHWSkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2015 14:40:19 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:35682 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752389AbbHWSkS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2015 14:40:18 -0400
Received: by iodt126 with SMTP id t126so127842539iod.2
        for <git@vger.kernel.org>; Sun, 23 Aug 2015 11:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Ipudc1GWZ1eKZSyJc4iAz+Bvj4SpK8Zpzo5dFvaNOps=;
        b=Y6F4k548lHctkvwg7sgyXNNylr5zl5rqTtCTdXTpTySkBdKP31A2SWAXoTkcEy84vL
         IypNeCDX5+ti/almbq7Rz1ln+Bbm1d8ZjVEb3bJAhcDnUmzxDprMKZHgb84Rtc9D0c7J
         PDSLwy3u6tdBx8RTsOX4KSCTRqOJKN0lYAJ2PXP8PauIKtB9E1wAXPe1TfuKMn3L1mVd
         OrcGkwQ0tS89I6042yKIxSsmmDQaqSFBS0zP9FtHZoId+s43UzBMOpP0nw9JWiRnNY1h
         5iF+lQuHUBXfn59T+0KedzJc6Gs7+MHv3Z+abaLwcfzebXBz2AVDCEJtNc4lQb7dgVrv
         wdeg==
X-Received: by 10.107.158.16 with SMTP id h16mr18944990ioe.52.1440355217341;
 Sun, 23 Aug 2015 11:40:17 -0700 (PDT)
Received: by 10.79.12.196 with HTTP; Sun, 23 Aug 2015 11:40:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276420>

Hello,

I'm having some issues with git remote helper behavior on Windows.

According to the protocol
(https://www.kernel.org/pub/software/scm/git/docs/gitremote-helpers.html),
when doing things like listing capabilities, git expects the remote
helper to send back a blank line when it's done.

I'm having trouble having git recognize the blank line (see
https://github.com/anishathalye/git-remote-dropbox/issues/13#issuecomment-133894730
for details).

Has anyone come across this behavior before? Am I doing something
wrong, or could there be a bug in git? What's the best way to proceed?


Any help or suggestions would be greatly appreciated!

Regards,
Anish
