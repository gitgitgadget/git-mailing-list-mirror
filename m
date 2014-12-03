From: Cody Goodman <codygman.consulting@gmail.com>
Subject: Problems cloning existing (probably old) svn repo
Date: Wed, 3 Dec 2014 11:51:13 -0600
Message-ID: <CADq_+R2t+ZprZj83TKJaWDpTtF+LwSZPTPc8vOYuDz9gkLDS-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 03 18:51:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwE59-0007OF-0I
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 18:51:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbaLCRvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 12:51:15 -0500
Received: from mail-ig0-f182.google.com ([209.85.213.182]:42708 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbaLCRvO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 12:51:14 -0500
Received: by mail-ig0-f182.google.com with SMTP id hn15so13165766igb.15
        for <git@vger.kernel.org>; Wed, 03 Dec 2014 09:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Ru8Suo3/35U16UtvLZUr2QQJqY115x6bECw9L/N7QPU=;
        b=Wuxd4GdptXcKaCqYRMh3MoFJYUp8E7P8+5Iz0cAmZ4R3KuXKj0xNI5O9DITI7grXrV
         kIXw/Zr2er3fceDZQAll+40nrvECD0g76Mlkt2Nwm/dC2EgvfC0kgjSGGp8wkazi6K0R
         sfL+PiwMfwMf5huXI7U19c5tANbASD7U2oLbYFDhGlce7Wah2J9e+fwnMRfZHlOJcCXG
         18AgN00jeVG0yjCNkyhWivD/nC25dyrYdPjTJhbjigWLkJJ1ucw53c9me7Zst0dEcxvX
         qO4Gp6au4faijTRyLBE02B0MCLel8dLiBdVOcEbGMT3FjVl9VgYFTsZn3b7+LiR77HxG
         kvEQ==
X-Received: by 10.42.253.195 with SMTP id nb3mr8227832icb.34.1417629073854;
 Wed, 03 Dec 2014 09:51:13 -0800 (PST)
Received: by 10.107.34.6 with HTTP; Wed, 3 Dec 2014 09:51:13 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260671>

I recently got this error when trying to git svn clone an existing repo:

Couldn't open a repository: Unable to connect to a repository at URL
'file:///home/cody/work/SmartPay': Unable to open an ra_local session
to URL: Unable to open repository 'file:///home/cody/work/SmartPay' at
/usr/share/perl5/Git/SVN.pm line


Then I created my own new svn repo to ensure my install of svn-git was working:

cody@cody-XPS-L521X:~/svn-repos$ svnadmin create testrepo
cody@cody-XPS-L521X:~/svn-repos$ svnserve -d -r /home/cody/svn-repos
cody@cody-XPS-L521X:~/svn-repos$ cd /tmp
cody@cody-XPS-L521X:/tmp$ git svn clone svn://localhost/testrepo
Initialized empty Git repository in /tmp/testrepo/.git/

So I've verified my install is working and I understand how to clone a
local repo.

What svn repo versions is git-svn compatible with? If the svnadmin
version used to create the existing repo I want to clone was very old
is that what is giving me the error? Is there a workaround?

How should I proceed?
