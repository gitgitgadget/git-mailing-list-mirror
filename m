From: Alex MDC <alex.mdc@gmail.com>
Subject: Unhappy git in a jailshell?
Date: Mon, 2 Nov 2009 23:16:43 +1100
Message-ID: <130714cd0911020416r6a686026q697d843f47b68692@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 02 13:16:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4vq6-0007BZ-6f
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 13:16:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754685AbZKBMQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2009 07:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754636AbZKBMQi
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 07:16:38 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:47769 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754464AbZKBMQi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2009 07:16:38 -0500
Received: by pwj9 with SMTP id 9so1817644pwj.21
        for <git@vger.kernel.org>; Mon, 02 Nov 2009 04:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=fs9bvP930539UOR3dXGMLv82R14TVmZPx+VyASzT6uY=;
        b=tX4tYrnjGDlYwwRvESFYai1nQMqdwYCOGPO4v52ZwoBFJL1p/4CQGWLnnPjx2QT82Q
         1Wm/yaRe+FLEdvW4PEIMssMHdiTkyBM0qnV5FLw410L7L7pMOPOggYx0qmBfU/3fG1r0
         +4bZJ76w2b/+RQ/Qf2X7cpLdtwxKWi174h8kE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=ZuH97PxQMaIQotHieAB2P2kUeUV5L+kUCY0vHTQXVQYbHnz/cwsDaHjbjvIjlUC/e9
         QUD/CSBSG+NyNxkpK+VtTmesT3zVL+5C7b3utFkffqCUJnzKKNz6z562QQWZE+uYa7xJ
         SmXT7m2nvI7JJbzYNO+9pPTja1RJevPDs1Z0g=
Received: by 10.142.9.16 with SMTP id 16mr695528wfi.92.1257164203169; Mon, 02 
	Nov 2009 04:16:43 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131901>

Hello,

I'm trying to use git on a linux server, but unfortunately I've only
been granted jailshelled access. Most of git works, but some commands
just fail to run, e.g.
git repack
git rebase
git index-pack

All these commands fail with the error "git: git-xxx is not a
git-command. See git --help". However most other every-day commands
work just fine (add, status, commit...)

I've been in contact with the server admins and they kindly upgraded
git to the latest 1.6.5.2 release but that didn't help. I enquired
about the contents of `git --exec-path` (as I don't have access from
the jailshell) and they said that all the "missing" commands are
present in that directory.

I also tried "git --help -all" but that doesn't show any commands in
the output! In a way I'm wondering how it is working at all...

So I guess my question is, why are some commands working but not
others? If all commands are treated uniformly by using the command
binary from the libexec dir it would seem as though all commands
should work or all should be "missing".

Also, are they any ideas on how to get the missing commands to work?

Thanks for your help,
Alex MDC
