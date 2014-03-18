From: Ray Hengst <rkhengst@gmail.com>
Subject: Bug report -- "Illegal instruction" on Mac 10.6.8 without XCode installed
Date: Tue, 18 Mar 2014 01:33:25 -0700
Message-ID: <CAJjOWVqtWMrexdDyfVWY4=s=XT28RfD5Mbi9j1rdasU9v_rYAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 18 09:33:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPpSr-0008JI-Dh
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 09:33:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754612AbaCRIda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 04:33:30 -0400
Received: from mail-qa0-f48.google.com ([209.85.216.48]:64578 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754118AbaCRId0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 04:33:26 -0400
Received: by mail-qa0-f48.google.com with SMTP id m5so6491225qaj.7
        for <git@vger.kernel.org>; Tue, 18 Mar 2014 01:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=oqZrWMv7D+LwqDTKGNNsz1VY79ypT6W00/+mLIpEvGw=;
        b=I+Srt0W2jIbKOclnNUdpnEn1a1Nfm1E9GPJbSorRqG08otjHcRTFtW82s1BFyFG+v7
         1BTkR+1BWk7D+ousHy2po2ydmWdlNbpR3ZKDnbseIldatI5+DYSb2NUpkRppRnFpahYD
         2IqcVP00Qte9g0WJAQ/3BY4jbEXrgbLWvyRZ2DL50SqyEbEgFxcA8Fx+T+FSqCSZXKyy
         zdLK4YQQvn5hXjus6YdTzwVE1K4epVrYPxfXVHLBz2ZCPyGblXpBK++kLgcVBt9yA8cF
         Rr6DvY3/I/LvlZM4hvh1LjoeO2Wn/gbVSVOhFLQ5hX3fP29y8Ea6P4vbiZH9/oaKy75z
         pY1A==
X-Received: by 10.224.123.212 with SMTP id q20mr824024qar.95.1395131605540;
 Tue, 18 Mar 2014 01:33:25 -0700 (PDT)
Received: by 10.140.42.228 with HTTP; Tue, 18 Mar 2014 01:33:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244339>

Hi,
I am running a Mac 10.6.8 and tried to install git-1.9.0 off of the
installer (git-1.9.0-intel-universal-snow-leopard.dmg). The
installation worked fine and gave no error messages. But whenever I
type in a git command (see below for some I tried), it gives me this
error message:
Illegal instruction

I am completely new to git and mostly new of Unix, but here are some
commands I tried:
git
git help
git config
git init
git clean
git config --global user.name "John Doe"
git status

However, typing "man git" displays typical man pages.
I do not have Xcode installed. (it's very hard to find a legacy copy);
the "make" command also is not present, so I can't use any of the
workarounds I saw listed.
I uninstalled git-1.9.0 successfully using the provided script, then
downloaded the same file again (and installed it) to make sure I
didn't get a corrupt copy. I had the same problem, however.
If I can provide any more information just let me know.
Thanks for any help you can provide.
-Ray
