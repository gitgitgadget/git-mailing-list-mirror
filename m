From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [GSoC update] git-remote-svn: Week 4
Date: Tue, 25 May 2010 19:11:01 +0200
Message-ID: <AANLkTimFqlbYz6BL02N7UiAsGDpspFJTrLwQYWOMi-vS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 25 19:11:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGxf6-00032C-0g
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 19:11:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754168Ab0EYRLX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 13:11:23 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:34487 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800Ab0EYRLW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 13:11:22 -0400
Received: by qyk13 with SMTP id 13so7564892qyk.1
        for <git@vger.kernel.org>; Tue, 25 May 2010 10:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:cc:content-type;
        bh=H/sdXZGBWJp1BU1iFs24SUYG45E+PkG/jSWIQ4YFrAg=;
        b=W+HhdXhuuftJMZjsigkDutbyRBuXvfBBIYK9ux/BdCenfV64SF1sn2uu/QLpQvbAyW
         g19T8qz7qEcsjS25GvPM9XkDuFHwuBkP0vuUFVuqhaIOA8A08y7MDdnqLMXAGhDqMukP
         tWmgXHdNfCOC8wxWdIgfH1qRh6Mfux73hgLjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=Wy47YJa9YRiqrL7998PM2r5JswuqIyqe//iUYnzMIhhVHz5N5LE7TfxIaGHuCTrJq6
         aQoLpie++IgFzZeFMGxk+VHmXJXDkUoz8+7Or9j8C21M10lN4MIKp2QxJ/gaTbVOKVhU
         Bs5kBf4WxF8XkstHcHNWoEXCMUZUr1bYYldmI=
Received: by 10.224.87.83 with SMTP id v19mr4197113qal.392.1274807481369; Tue, 
	25 May 2010 10:11:21 -0700 (PDT)
Received: by 10.229.50.3 with HTTP; Tue, 25 May 2010 10:11:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147717>

Hi,

This comes a day late, owing to the fact that we've been working on a
new optimization branch of the SVN exporter [1]. The remote helper now
has an import capability which invokes svn-dump-fast-export with a
dump file. I'm maintaining a branch of svn-dump-fast-export [2] that I
intend to merge into git.git soon- I've already sent some patches from
there to the list. I'd appreciate it if someone could review this
series (or the corresponding code on GitHub). David and I will
hopefully finish "memory" this week, and I'll start writing an SVN
client that's able to dump a remote repository to a file (sort of a
stripped down version of `svnsync` + `svnadmin dump`) towards the
later half of this week.

-- Ram

[1]: Branch "memory" of http://github.com/barrbrain/svn-dump-fast-export
[2]: Branch "git-merge" of http://github.com/artagnon/svn-dump-fast-export
