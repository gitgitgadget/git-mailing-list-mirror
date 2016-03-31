From: Zachary Turner <zturner@google.com>
Subject: Problem with Integrated Vim Editor on Win 10
Date: Wed, 30 Mar 2016 17:07:27 -0700
Message-ID: <CAAErz9i1=EOemq2qNijRwgY6MNmPJRhV+mFfeD1FZa5uPwvCJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 31 02:07:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alQ98-0002H6-Hv
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 02:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbcCaAH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 20:07:29 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:35551 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbcCaAH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 20:07:28 -0400
Received: by mail-yw0-f180.google.com with SMTP id g127so78441846ywf.2
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 17:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=z3ELDK4nF6zLCQdliEumOKwkeafyaikRtHKH5O+mAT8=;
        b=fzrq4Omye7UzZTGapXX4DEd9upH4mA743RhiWxk5enRrSgi3wymsoiiKhmbCWO66VL
         tMzEM2XMFvLheLDN9IQzvE2oEj9dvY73FygFmodD1N3AVwS7SNdJZAetktGX/whpLhxY
         IAwKioe/nwzxeQ2huoGFdo+jneTv0Wdw+x7KpXIlcIKlYLO7/C9UbyWQVUnAbuzHOZzk
         /2ZdvDaM4dxZ2tigysZWFkPKJT3eATlmUc9rA12qOMPO+6tZxv9mOKA+4oUIcz4IjK9Q
         11cidOgZr96B39mEgZbDr6n06mUlpxVALfag3SkgcvoK0KGQ5Y5/5P8M6iH4GM+w8cwa
         NxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=z3ELDK4nF6zLCQdliEumOKwkeafyaikRtHKH5O+mAT8=;
        b=i5KV/rSVN9YKFd6hAv2hPM7DDXKXrSQ4BhA5L0l6jUjJEe0YpAPcmDfoLye7FvEiIi
         9d/ly3xZ75/F8e3mm8/hgiCKJkYp7RvY9+ydCDXwU4zto6dK1D3IBhipoL9TaCaWWaQA
         VVoTtaaIN37bMNB/Zg5ZZnVpfN2QBwU1gY82PmWdActLn/Jaj40MkeuFAnlne+IvaCq6
         odVEeepdsi4tBaIAz+rzU0q+DaSqfLAbifwsOGPvkHO+//3cYAeZb8FChDo8a3c27MPG
         IdiUEK5N2ORkZv3pjVmyxBchMcxCsLxJZlYXnZFzgrvlO4gzLHOfk1EQe/FDYaUlbi3T
         6+mA==
X-Gm-Message-State: AD7BkJIscSX7X2UHhU+P5F73l0Xi88me1m1DOsKtMeWN1fK4W9Lhyd1PzY6qG/3oWPk1pwQv8iGqSfcf6kOYperd
X-Received: by 10.13.202.195 with SMTP id m186mr5714519ywd.151.1459382847351;
 Wed, 30 Mar 2016 17:07:27 -0700 (PDT)
Received: by 10.37.113.133 with HTTP; Wed, 30 Mar 2016 17:07:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290357>

Hi, just recently I installed the latest build of Windows 10 of my
machine. This is my second Win10 machine. On the other I am using git
2.7.0.windows.1 and everything is working just fine.

On the second machine I am using git 2.8.0.windows.1 and vim does not
work. I sent a bug report to bugs@vim.org, but frankly I don't know whose
bug this is, so I'm including it here as well.

The problem is that vim is just a black screen when git launches it. If I
mash enough keys eventually I see something that resembles vim output at
the bottom, but I can't actually use it.

I tried going into program files\git\usr\bin and just running vim.exe.
Again, black screen. If I press enter about 10 times I can see the
introduction screen. Then if I press : about 10-20 times it will go into
command mode and a single : appears. after pressing a few more keys all
the rest of the :s appear. Basically, everything is completely unusable.

I tried downloading vim 7.4 from www.vim.org, and low and behold, it
works. For now I've replaced the copy of vim.exe that ships with git with
the copy from www.vim.org. But this leaves me nervous that something is
seriously wrong.

Has anyone seen anything like this before, or have any ideas how I might
better diagnose this?
