From: Chris Packham <judge.packham@gmail.com>
Subject: git gui error with relocated repository
Date: Tue, 29 Apr 2014 14:56:16 +1200
Message-ID: <CAFOYHZBPLZhVuf=bO0hPcUH2_0WXFSqk=_CqoUWBRixQc0L==Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: GIT <git@vger.kernel.org>, patthoyts@users.sourceforge.net
X-From: git-owner@vger.kernel.org Tue Apr 29 04:56:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeyDV-0006P0-Q2
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 04:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870AbaD2C4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 22:56:18 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:43417 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694AbaD2C4R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 22:56:17 -0400
Received: by mail-pb0-f50.google.com with SMTP id md12so6570172pbc.23
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 19:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=lZ0FolfRRQDBaWdKA90JAOkJVguWaa1vkWDEPWl78wE=;
        b=Qf9yii1uV9zsU336G5cBoXh3g9VRPK4s3G6Su57BUi1YuJgoE5rhaayl66Io/AI9f6
         intU9TW3Kmm7P5E7tqtgzzZqs5Qz14tZyrjs8sw+X62pMuG5GIldfd2yCTo+IjLjDbgz
         SUoSIZc/EJ94sdGdL/tSAPeb8bN97XZrye65noyt4t4A3Bl88h8hsYMlDdxhjCbjsXNc
         YBHpwOBHsC09ygldJcla5TTUHhpQ2h6lCWEHBLEp6fnCmY4kuQt1vZhFljwVMrwYJY0B
         bEVp6xIBUgoQNUtjRvZ3+h5Q/x4HC/GyNJu1545xXdCxfX/UbFpMrTraKqtqx08Sddm4
         8kJw==
X-Received: by 10.66.253.33 with SMTP id zx1mr29721048pac.28.1398740177014;
 Mon, 28 Apr 2014 19:56:17 -0700 (PDT)
Received: by 10.70.46.38 with HTTP; Mon, 28 Apr 2014 19:56:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247511>

Hi Pat,

I'm running git 2.0.0-rc0 (haven't got round to pulling down rc1 yet)
which includes gitgui-0.19.0 and I'm getting a new error when I run
'git gui' in a repository with a .git file (created by git submodule).

I can send you a screencap of the error message off list if you want
but the text is

"No working directory ../../../<repo>

couldn't change working directory to ../../../<repo>: no such file or directory"

Here's some other info that might help

  $ git --version
  git version 2.0.0.rc0

  $ cat .git
  gitdir: ../.git/modules/<repo>

  $ git rev-parse --git-dir
  /home/chris/src/<super>/.git/modules/<repo>

  $ git config core.worktree
  ../../../<repo>

Thanks,
Chris
